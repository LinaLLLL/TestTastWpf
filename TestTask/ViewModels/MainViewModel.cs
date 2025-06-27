using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestTask.ViewModels
{
    public partial class MainViewModel : ObservableObject
    {
        //коллекция слотов
        public ObservableCollection<ImageSlotViewModel> ImageSlots { get; } = new();
        //общий прогресс
        [ObservableProperty]
        private int overallProgress;

        //конструктор
        public MainViewModel()
        {
            // создаём 3 слота загрузки
            for (int i = 0; i < 3; i++)
            {
                var slot = new ImageSlotViewModel();
                //подписка на событие
                slot.PropertyChanged += Slot_PropertyChanged;
                ImageSlots.Add(slot);
            }
        }
        //метод вызывается при изменении слотов
        private void Slot_PropertyChanged(object? sender, PropertyChangedEventArgs e)
        {
            //если изменился прогресс или IsDownloading -> перерасчет общего прогресса
            if (e.PropertyName == nameof(ImageSlotViewModel.Progress) || e.PropertyName == nameof(ImageSlotViewModel.IsDownloading))
            { 
                UpdateOverallProgress();
            }
        }
        //перерасчет общего прогресса
        private void UpdateOverallProgress()
        {
            //получаем список слотов, у которых идет загрузка
            var activeSlots = ImageSlots.Where(s => s.IsDownloading).ToList();
            //если слотов нет, общие прогресс =0
            if (activeSlots.Count == 0)
            {
                OverallProgress = 0;
                return;
            }

            // средний прогресс всех активных загрузок
            OverallProgress = (int)activeSlots.Average(s => s.Progress);
        }

        //команда для запуска загрузки всех слотов
        [RelayCommand]
        public async Task StartAllAsync()
        {
            var tasks = ImageSlots.Select(slot => slot.StartAsync());
            await Task.WhenAll(tasks);
        }

        //команда для остановки всех загрузок 
        [RelayCommand]
        public void StopAll()
        {
            foreach (var slot in ImageSlots)
            {
                slot.Stop();
            }
        }
    }
}
