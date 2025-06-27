using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace TestTask.Models
{
    public partial class ImageDownloadModel
    {
        //создание экземпляра HttpClient
        private static readonly HttpClient httpClient = new HttpClient(); 

        //асинхронный метод, возвращающий кортеж
        public async Task<(byte[] ImageData, long TotalBytes)> DownloadImageAsync(
            string url, IProgress<long>? progress, CancellationToken cancellationToken)
        {
            //get запрос на url
            using var response = await httpClient.GetAsync(url, HttpCompletionOption.ResponseHeadersRead, cancellationToken);
            //проверка статуса ответа
            response.EnsureSuccessStatusCode();

            //переменная для байт в изображении
            var contentLength = response.Content.Headers.ContentLength ?? -1L;

            //отслеживает, сколько байт прочитано
            long totalRead = 0;
            //хранилище для байтов изображения
            using var memoryStream = new MemoryStream();
            //поток данных (картинка)
            using var stream = await response.Content.ReadAsStreamAsync(cancellationToken);

            //буфер(8кб), через который читаем данные порциями
            var buffer = new byte[8192];
            int bytesRead;

            //чтение данных из потока
            while ((bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length, cancellationToken)) > 0)
            {
                //сохраняем полученные данные
                await memoryStream.WriteAsync(buffer.AsMemory(0, bytesRead), cancellationToken);
                //обновляем счетчик загруженных данных
                totalRead += bytesRead;
                //если передан объект IProgress<long> вызываем .Report, чтобы сообщить о прогрессе загрузки
                progress?.Report(totalRead);
            }
            //возвращаем готовый массив байтов и общий размер, если известен
            return (memoryStream.ToArray(), contentLength);
        }
    }
}
