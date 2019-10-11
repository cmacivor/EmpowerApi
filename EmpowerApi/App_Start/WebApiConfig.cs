using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using System.Web.Http.Routing;
using System.Web.Http.Controllers;
using System.Web.Http.Cors;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;

namespace EmpowerApi
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            // Web API configuration and services
            config.EnableCors();

            //TODO: figure out what this does exactly
            config.MapHttpAttributeRoutes(new CustomDirectRouteProvider());

            //TODO: research this
            config.Filters.Add(new HostAuthenticationAttribute("bearer")); 
            config.Filters.Add(new AuthorizeAttribute());
            config.EnableCors(new EnableCorsAttribute("*", "*", "*", "*"));

            // Web API routes- *note: this is replaced by the CustomDirectRouteProvider. TODO: figure out why.
            //config.MapHttpAttributeRoutes();

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

    }
}
