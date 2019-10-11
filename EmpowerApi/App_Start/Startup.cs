using DJSCaseMgtService.Models;
using DJSCaseMgtService.Providers;
using Microsoft.AspNet.Identity;
using Microsoft.Owin;

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
//using DJSCaseMgtService.App_Start;
//using SimpleInjector.Extensions.ExecutionContextScoping;
using DJSCaseMgtService;
//using SimpleInjector.Extensions;
using DJSCaseMgtService.DataAccess.Repositories;
//using Swashbuckle.Application;
using System.Web.Http.Cors;
using EmpowerApi;
using EmpowerApi.oAuth;

[assembly: OwinStartup(typeof(DJSCaseMgtService.Startup))]

namespace DJSCaseMgtService
{
    public class Startup
    {
        public static OAuthBearerAuthenticationOptions OAuthBearerOptions { get; private set; }

        //public static HttpConfiguration HttpConfiguration { get; private set; }

        public void Configuration(IAppBuilder app)
        {
            var container = new Container();
            container.Options.DefaultScopedLifestyle = new SimpleInjector.Lifestyles.AsyncScopedLifestyle();
            HttpConfiguration config = new HttpConfiguration();

            ConfigureOAuth(app);
            AreaRegistration.RegisterAllAreas();
            WebApiConfig.Register(config);
            app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);

          
            app.UseWebApi(config);

            InitializeContainer(container);
            container.RegisterWebApiControllers(config);
            container.Verify();
            GlobalConfiguration.Configuration.DependencyResolver =
            new SimpleInjectorWebApiDependencyResolver(container);

            config.DependencyResolver = new SimpleInjectorWebApiDependencyResolver(container);
            Database.SetInitializer<DJSCaseMgtContext>(null);
        }

        private static void InitializeContainer(Container container)
        {
            //TODO: research this: https://stackoverflow.com/questions/32082996/simpleinjector-3-0-not-supporting-registermanyforopengeneric
            container.Register(typeof(IBaseRepository<>), typeof(BaseRepository<>).Assembly);

            //doing this because of error described here: https://stackoverflow.com/questions/42591234/simple-injector-diagnostic-warning-disposable-transient
            //TODO: research more and double check. see this as well: https://simpleinjector.readthedocs.io/en/latest/disposabletransientcomponent.html
            //TODO: find out why or if it's necessary for these registrations to appear both here and in SimpleInjectorWebApiInitializer
            container.Register<DJSCaseMgtContext>(Lifestyle.Scoped);


            container.Register<IClientProfileRepository, ClientProfileRepository>();
            container.Register<IPersonRepository, PersonRepository>();
            container.Register<IPersonSupplementalRepository, PersonSupplementalRepository>();
            container.Register<IPersonAddressRepository, PersonAddressRepository>();
            container.Register<IFamilyProfileRepository, FamilyProfileRepository>();
            container.Register<IAssessmentRepository, AssessmentRepository>();
            container.Register<IPlacementRepository, PlacementRepository>();
            container.Register<IPlacementOffenseRepository, PlacementOffenseRepository>();
            container.Register<IEnrollmentRepository, EnrollmentRepository>();
            container.Register<IEmploymentPlanRepository, EmploymentPlanRepository>();
            container.Register<IProgressNoteRepository, ProgressNoteRepository>();
            container.Register<IServiceUnitRepository, ServiceUnitRepository>();
            container.Register<IActionPlanRepository, ActionPlanRepository>();
        }


        public void ConfigureOAuth(IAppBuilder app)
        {
            //implemented from this example: https://stackoverflow.com/questions/25032513/how-to-get-error-message-returned-by-dotnetopenauth-oauth2-on-client-side
            app.Use<InvalidAuthenticationMiddleware>();

            //use a cookie to temporarily store information about a user logging in with a third party login provider
            app.UseExternalSignInCookie(Microsoft.AspNet.Identity.DefaultAuthenticationTypes.ExternalCookie);
            OAuthBearerOptions = new OAuthBearerAuthenticationOptions();

            OAuthAuthorizationServerOptions OAuthServerOptions = new OAuthAuthorizationServerOptions()
            {

                AllowInsecureHttp = true,
                TokenEndpointPath = new PathString("/token"),
                AccessTokenExpireTimeSpan = TimeSpan.FromMinutes(30000),
                Provider = new SimpleAuthorizationServerProvider(),
            };

            // Token Generation
            app.UseOAuthAuthorizationServer(OAuthServerOptions);
            app.UseOAuthBearerAuthentication(OAuthBearerOptions);
        }
    }

}