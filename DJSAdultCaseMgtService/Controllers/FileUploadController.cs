﻿using System;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Configuration;
using System.Collections.Generic;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgtModel.Entities;


namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/FileUpload")]
    public class FileUploadController : ApiController
    {
        //private static readonly string ServerUploadFolder = "C:\\FileUploads"; //Path.GetTempPath();

        //[Route(""), HttpPost]

        //public async Task<Document> Add(HttpRequestMessage request)
        //{
        //    var provider = new MultipartFormDataStreamProvider(ServerUploadFolder);

        //    var document = new Document();

        //    //foreach (var file in provider.FileData)
        //    //{
        //        var fileInfo = new FileInfo(request.LocalFileName);

        //        document.Add(new Document
        //        {
        //            Name = fileInfo.Name,
        //            Created = fileInfo.CreationTime,
        //            Modified = fileInfo.LastWriteTime,
        //            Size = fileInfo.Length / 1024
        //        });
        //    //}

        //    return document;
        //}

        //public class MultipartFormDataStreamProvider : MultipartFormDataStreamProvider
        //{

        //    public MultipartFormDataStreamProvider(string path)
        //        : base(path)
        //    {
        //    }

        //    public override string GetLocalFileName(System.Net.Http.Headers.HttpContentHeaders headers)
        //    {
        //        //Make the file name URL safe and then use it & is the only disallowed url character allowed in a windows filename 
        //        var name = !string.IsNullOrWhiteSpace(headers.ContentDisposition.FileName) ? headers.ContentDisposition.FileName : "NoName";
        //        return name.Trim(new char[] { '"' })
        //                    .Replace("&", "and");
        //    }
        //}


        //[ValidateMimeMultipartContentFilter]
        //public async Task<Document> UploadSingleFile()
        //{
        //    var streamProvider = new MultipartFormDataStreamProvider(ServerUploadFolder);
        //    await Request.Content.ReadAsMultipartAsync(streamProvider);

        //    return new Document
        //    {
        //        Name = streamProvider.FileData.Select(entry => entry.LocalFileName),
        //        Names = streamProvider.FileData.Select(entry => entry.Headers.ContentDisposition.FileName),
        //        ContentTypes = streamProvider.FileData.Select(entry => entry.Headers.ContentType.MediaType),
        //        Description = streamProvider.FormData["description"],
        //        //CreatedBy = DateTime.,
        //        UpdatedBy = DateTime.UtcNow

        //    };
        //}

        //[Route("filesNoContentType")]
        //[HttpPost]
        ////[ValidateMimeMultipartContentFilter]
        //public async Task<Document> UploadMultipleFiles()
        //{
        //    var provider = new MultipartFormDataStreamProvider(ServerUploadFolder);
        //    try
        //    {
        //        var streamProvider = StreamConversion();
        //        await streamProvider.ReadAsMultipartAsync(provider);
        //        return new Document
        //        {
        //            FileNames = provider.FileData.Select(entry => entry.LocalFileName),
        //            Names = provider.FileData.Select(entry => entry.Headers.ContentDisposition.FileName),
        //            Description = provider.FormData["description"],
        //            CreatedTimestamp = DateTime.UtcNow,
        //            UpdatedTimestamp = DateTime.UtcNow,
        //            DownloadLink = "TODO, will implement when file is persisited"
        //        };
        //    }
        //    catch (System.Exception e)
        //    {
        //        throw new HttpResponseException(HttpStatusCode.InternalServerError);
        //    }
        //}

        //private StreamContent StreamConversion()
        //{
        //    Stream reqStream = Request.Content.ReadAsStreamAsync().Result;
        //    var tempStream = new MemoryStream();
        //    reqStream.CopyTo(tempStream);

        //    tempStream.Seek(0, SeekOrigin.End);
        //    var writer = new StreamWriter(tempStream);
        //    writer.WriteLine();
        //    writer.Flush();
        //    tempStream.Position = 0;

        //    var streamContent = new StreamContent(tempStream);
        //    foreach (var header in Request.Content.Headers)
        //    {
        //        streamContent.Headers.Add(header.Key, header.Value);
        //    }
        //    return streamContent;
        //}

    }

}
