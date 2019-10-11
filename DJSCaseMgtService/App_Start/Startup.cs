using DJSCaseMgtService.Models;
using DJSCaseMgtService.Providers;
using Microsoft.AspNet.Identity;
using Microsoft.Owin;
using Microsoft.Owin.Cors;
using Microsoft.Owin.Security.Facebook;
using Microsoft.Owin.Security.Google;
using Microsoft.Owin.Security.OAuth;
using Owin;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Http;

using SimpleInjector.Integration.WebApi;

using SimpleInjector;
using System.Web.Mvc;
using DJSCaseMgtService.App_Start;
using SimpleInjector.Extensions.ExecutionContextScoping;
using DJSCaseMgtService;
using SimpleInjector.Extensions;
using DJSCaseMgtService.DataAccess.Repositories;
using Swashbuckle.Application;
using System.Web.Http.Cors;

[assembly: OwinStartup(typeof(DJSCaseMgtService.Startup))]

namespace DJSCaseMgtService
{
    public class Startup
    {
        public static OAuthBearerAuthenticationOptions OAuthBearerOptions { get; private set; }
        public static GoogleOAuth2AuthenticationOptions googleAuthOptions { get; private set; }
        public static FacebookAuthenticationOptions facebookAuthOptions { get; private set; }
        public static HttpConfiguration HttpConfiguration { get; private set; }

        public void Configuration(IAppBuilder app)
        {
            var container = new Container();
            HttpConfiguration config = new HttpConfiguration();

            //  config.DependencyResolver = new SimpleInjectorWebApiDependencyResolver(container);
            ConfigureOAuth(app);
            AreaRegistration.RegisterAllAreas();
            WebApiConfig.Register(config);
            app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);
            app.UseWebApi(config);
            // Swagger
           // SwaggerConfig.Register(config);

           // config.EnableCors(new EnableCorsAttribute("*", "*", "*"));

            //app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);

          

            //  Swashbuckle.Bootstrapper.Init(config);
            // app.UseOwinContextInjector(container );
            InitializeContainer(container);
            container.RegisterWebApiControllers(config);
            container.Verify();
            GlobalConfiguration.Configuration.DependencyResolver =
            new SimpleInjectorWebApiDependencyResolver(container);

            config.DependencyResolver = new SimpleInjectorWebApiDependencyResolver(container);
            Database.SetInitializer<DJSCaseMgtContext>(null);
            //Database.SetInitializer(new MigrateDatabaseToLatestVersion<AuthRepository, DJSCaseMgtService.Migrations.Configuration>()); 
            //private DJSCaseMgtContext context = new DJSCaseMgtContext();
        }

        private static void InitializeContainer(Container container)
        {
            container.RegisterManyForOpenGeneric(typeof(IBaseRepository<>), typeof(BaseRepository<>).Assembly);
            container.RegisterWebApiRequest<IClientProfileRepository, ClientProfileRepository>();
            container.RegisterWebApiRequest<IPersonRepository, PersonRepository>();
            container.RegisterWebApiRequest<IPersonSupplementalRepository, PersonSupplementalRepository>();
            container.RegisterWebApiRequest<IPersonAddressRepository, PersonAddressRepository>();
            container.RegisterWebApiRequest<IFamilyProfileRepository, FamilyProfileRepository>();
            container.RegisterWebApiRequest<IAssessmentRepository, AssessmentRepository>();
            container.RegisterWebApiRequest<IPlacementRepository, PlacementRepository>();
            container.RegisterWebApiRequest<IPlacementOffenseRepository, PlacementOffenseRepository>();
            container.RegisterWebApiRequest<IEnrollmentRepository, EnrollmentRepository>();
            container.RegisterWebApiRequest<IProgressNoteRepository, ProgressNoteRepository>();
            container.RegisterWebApiRequest<IServiceUnitRepository, ServiceUnitRepository>();
        }

        //public class SwaggerConfig
        //{
        //    public static void Register(HttpConfiguration config)
        //    {
        //        config.EnableSwagger(c =>
        //        {
        //            c.SingleApiVersion("v1", "DJSCaseMgtService");
        //        })
        //    .EnableSwaggerUi(c =>
        //    {
        //    });
        //    }
        //}


        public void ConfigureOAuth(IAppBuilder app)
        {

            //use a cookie to temporarily store information about a user logging in with a third party login provider
            app.UseExternalSignInCookie(Microsoft.AspNet.Identity.DefaultAuthenticationTypes.ExternalCookie);
            OAuthBearerOptions = new OAuthBearerAuthenticationOptions();

            OAuthAuthorizationServerOptions OAuthServerOptions = new OAuthAuthorizationServerOptions()
            {

                AllowInsecureHttp = true,
                TokenEndpointPath = new PathString("/token"),
                AccessTokenExpireTimeSpan = TimeSpan.FromMinutes(30000),
                Provider = new SimpleAuthorizationServerProvider(),
                RefreshTokenProvider = new SimpleRefreshTokenProvider()
            };

            // Token Generation
            app.UseOAuthAuthorizationServer(OAuthServerOptions);
            app.UseOAuthBearerAuthentication(OAuthBearerOptions);





        }
    }

}