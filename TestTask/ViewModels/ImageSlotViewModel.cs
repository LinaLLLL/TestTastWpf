using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Media.Imaging;
using TestTask.Models;

namespace TestTask.ViewModels
{
    public partial class ImageSlotViewModel : ObservableObject
    {
        //экземпляр модели загрузки изображения, которая содержит асинхронный метод скачивания с прогрессом
        private readonly ImageDownloadModel downloader = new();
        //переменная для отмены загрузки
        private CancellationTokenSource? cts;

        //поле для сохранения URL изображения
        [ObservableProperty]
        private string url = string.Empty;
        //поле для хранения загруженного изображения 
        [ObservableProperty]
        private BitmapImage? image;
        //поле для хранения прогресса загрузки
        [ObservableProperty]
        private int progress;
        //флаг, показывает, идет ли загрузка
        [ObservableProperty]
        private bool isDownloading;
        //общее количество байтов, которое нужно скачать
        private long totalBytes = 1; // если не известно =1, для расчёта прогресса, чтобы избежать деления на 0

        // команда запуска загрузки
        [RelayCommand]
        public async Task StartAsync()
        {
            //MessageBox.Show("Кнопка работает!");
            if (!Uri.TryCreate(Url, UriKind.Absolute, out var uriResult) ||
               (uriResult.Scheme != Uri.UriSchemeHttp && uriResult.Scheme != Uri.UriSchemeHttps))
            {
                MessageBox.Show("Введите корректный URL (начинается с http или https).");
                return;
            }

            //url не пустой или загрузка идет -> выходим
            if (string.IsNullOrWhiteSpace(Url) || IsDownloading)
                return;
            
            //новый токен отмены загрузки
            cts = new CancellationTokenSource();
            //устанавливаем флаг загрузки
            IsDownloading = true;
            //обнуляем прогресс
            Progress = 0;
            //очищаем текущую картинку, тк загружаем новую
            Image = null;

            try
            {
                //объект принимает коллбэк, когда модель сообщит сколько байт скачано -> перерасчет progress
                var progressReporter = new Progress<long>(bytesReceived =>
                {
                    Progress = totalBytes > 0 ? (int)(bytesReceived * 100 / totalBytes) : 0;
                });
                //запускаем метод загрузки
                var (imageData, contentLength) = await downloader.DownloadImageAsync(Url, progressReporter, cts.Token);
                //полный размер
                totalBytes = contentLength > 0 ? contentLength : imageData.Length;

                // создаём BitmapImage из массива байт
                using var ms = new MemoryStream(imageData);
                var bmp = new BitmapImage();
                bmp.BeginInit();
                bmp.CacheOption = BitmapCacheOption.OnLoad;
                bmp.StreamSource = ms;
                bmp.EndInit();
                bmp.Freeze(); // для потокобезопасности
                //присваиваем изображение
                Image = bmp;
            }
            catch (OperationCanceledException)
            {
                // Загрузка была отменена — можно проигнорировать
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки: {ex.Message}");
            }
            finally
            {
                IsDownloading = false;
            }
        }

        partial void OnImageChanged(BitmapImage? oldValue, BitmapImage? newValue)
        {
            System.Diagnostics.Debug.WriteLine("Image property changed!");
        }

        // Команда остановки загрузки
        [RelayCommand]
        public void Stop()
        {
            //MessageBox.Show("Кнопка работает!");
            
            if (IsDownloading)
            {
                cts?.Cancel();
                IsDownloading = false;
            }
        }
    }
}
