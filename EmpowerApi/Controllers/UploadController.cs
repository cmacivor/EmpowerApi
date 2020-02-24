using System;
using System.Diagnostics;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Net.Http.Headers;
using DJSCaseMgmtModel.Entities;
using System.Web.Hosting;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/Upload")]

    public class UploadController : ApiController
    {
        private static readonly string ServerUploadFolder = HostingEnvironment.MapPath("~/casemgtuploads/");

        // [Route("Upload"), HttpPost]
        public async Task<HttpResponseMessage> PostFormData()
        {
            // Check if the request contains multipart/form-data.
            if (!Request.Content.IsMimeMultipartContent())
            {
                throw new HttpResponseException(HttpStatusCode.UnsupportedMediaType);
            }

            var provider = new SourceFileNameStreamProvider(ServerUploadFolder);

            try
            {
                // Read the form data.
                await Request.Content.ReadAsMultipartAsync(provider);

                // This illustrates how to get the file names.
                foreach (MultipartFileData file in provider.FileData)
                {
                    Trace.WriteLine(file.Headers.ContentDisposition.FileName);
                    Trace.WriteLine("Server file path: " + file.LocalFileName);



                }



                return Request.CreateResponse(HttpStatusCode.OK);
            }
            catch (System.Exception e)
            {
                return Request.CreateErrorResponse(HttpStatusCode.InternalServerError, e);
            }
        }

        public class SourceFileNameStreamProvider : MultipartFormDataStreamProvider
        {
            public SourceFileNameStreamProvider(string uploadPath)
                : base(uploadPath)
            {
            }

            public override string GetLocalFileName(HttpContentHeaders headers)
            {
                string fileName = headers.ContentDisposition.FileName;
                if (string.IsNullOrWhiteSpace(fileName))
                {
                    fileName = Guid.NewGuid().ToString() + ".data";
                }
                return fileName.Replace("\"", string.Empty);
            }
        }

    }
}
