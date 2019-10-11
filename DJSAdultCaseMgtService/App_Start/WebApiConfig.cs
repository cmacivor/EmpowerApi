using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Routing;
using System.Web.Http.Controllers;
using System.Net.Http.Headers;
using System.Net.Http.Formatting;
using Elmah.Contrib.Mvc;
using System.Web.Http.Filters;
using Elmah.Contrib.WebApi;
using System.Web.Http.ExceptionHandling;
using Newtonsoft.Json.Serialization;
using System.Web.Http.Cors;
using DJSCaseMgtService.Models;

namespace DJSCaseMgtService
{
    
   

    public static class WebApiConfig
    {
      
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services

            // Web API routes
            //config.MapHttpAttributeRoutes();

            config.EnableCors();
            SwaggerConfig.Register(config);

            config.Services.Add(typeof(IExceptionLogger), new ElmahExceptionLogger());
            config.MapHttpAttributeRoutes(new CustomDirectRouteProvider());
            // Create the depenedency resolver.
        
            config.Filters.Add(new HostAuthenticationAttribute("bearer")); //added this
            config.Filters.Add(new AuthorizeAttribute());
            config.EnableCors(new EnableCorsAttribute("*", "*", "*", "*"));
          

            // Configure Web API with the dependency resolver.;


            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );
           

            config.Routes.MapHttpRoute(
    name: "NotFound",
    routeTemplate: "{*path}",
    defaults: new { controller = "Error", action = "NotFound" }
);

            config.Formatters.Add(new BrowserJsonFormatter());
            config.Filters.Add(new ElmahHandleWebApiErrorAttribute());
            //config.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));
            //config.Formatters.JsonFormatter.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/xml"));

            //config.Formatters.Remove(config.Formatters.XmlFormatter);
            //config.Formatters.Remove(config.Formatters.JsonFormatter);
            //config.Formatters.Add(new MyJsonMediaTypeFormatter());
        }

        public class CustomDirectRouteProvider : DefaultDirectRouteProvider
        {
            protected override IReadOnlyList<IDirectRouteFactory> GetActionRouteFactories(HttpActionDescriptor actionDescriptor)
            {
                return actionDescriptor.GetCustomAttributes<IDirectRouteFactory>(inherit: true);
            }
        }

        public class BrowserJsonFormatter : JsonMediaTypeFormatter
        {
            public BrowserJsonFormatter()
            {
                this.SupportedMediaTypes.Add(new MediaTypeHeaderValue("text/html"));
                this.SerializerSettings.Formatting = Newtonsoft.Json.Formatting.Indented;
            }

            public override void SetDefaultContentHeaders(Type type, HttpContentHeaders headers, MediaTypeHeaderValue mediaType)
            {
                base.SetDefaultContentHeaders(type, headers, mediaType);
                headers.ContentType = new MediaTypeHeaderValue("application/json");
            }
        }

        public class MyJsonMediaTypeFormatter : JsonMediaTypeFormatter
        {
            public override System.Threading.Tasks.Task WriteToStreamAsync(System.Type type, object value, System.IO.Stream writeStream, System.Net.Http.HttpContent content, System.Net.TransportContext transportContext)
            {
                var obj = new { Person = value };
                return base.WriteToStreamAsync(type, obj, writeStream, content, transportContext);
            }
        }

        //private class ElmahHandleWebApiErrorAttribute : IFilter
        //{
        //    public bool AllowMultiple
        //    {
        //        get
        //        {
        //            throw new NotImplementedException();
        //        }
        //    }
        //}
    }
}
