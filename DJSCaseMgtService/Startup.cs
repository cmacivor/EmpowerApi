using Microsoft.Owin;
using Microsoft.Owin.Extensions;
using Microsoft.Owin.Cors;
//using Microsoft.Owin.Security.Facebook;
//using Microsoft.Owin.Security.Google;
using Microsoft.Owin.Security.OAuth;
using Owin;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Http;
using DJSCaseMgtService.Models;
using DJSCaseMgtService.Providers;

//[assembly: OwinStartup(typeof(DJSCaseMgtService.Startup))]

namespace DJSCaseMgtService
{
    public class Startup
    {
    //    public static OAuthBearerAuthenticationOptions OAuthBearerOptions { get; private set; }
    //    //public static GoogleOAuth2AuthenticationOptions googleAuthOptions { get; private set; }
    //    //public static FacebookAuthenticationOptions facebookAuthOptions { get; private set; }

    //    public void Configuration(IAppBuilder app)
    //    {

    //        HttpConfiguration config = new HttpConfiguration();

    //         var webApiConfiguration = ConfigureWebApi();
    //        ConfigureOAuth(app);

    //        WebApiConfig.Register(config);
    //        app.UseCors(Microsoft.Owin.Cors.CorsOptions.AllowAll);
    //        app.UseWebApi(config);
    //        Database.SetInitializer<DJSCaseMgtContext>(null);

    //    }

    //    private HttpConfiguration ConfigureWebApi()
    //    {
    //        var config = new HttpConfiguration();
    //        config.Routes.MapHttpRoute(
    //            "DefaultApi",
    //            "api/{controller}/{id}",
    //            new { id = RouteParameter.Optional });
    //        return config;
    //    }


    //    public void ConfigureOAuth(IAppBuilder app)
    //    {
    //        //use a cookie to temporarily store information about a user logging in with a third party login provider
    //        app.UseExternalSignInCookie(Microsoft.AspNet.Identity.DefaultAuthenticationTypes.ExternalCookie);
    //        OAuthBearerOptions = new OAuthBearerAuthenticationOptions();

    //        OAuthAuthorizationServerOptions OAuthServerOptions = new OAuthAuthorizationServerOptions()
    //        {

    //            AllowInsecureHttp = true,
    //            TokenEndpointPath = new PathString("/token"),
    //            AccessTokenExpireTimeSpan = TimeSpan.FromMinutes(30),
    //            Provider = new SimpleAuthorizationServerProvider(),
    //            RefreshTokenProvider = new SimpleRefreshTokenProvider()
    //        };

    //        // Token Generation
    //        app.UseOAuthAuthorizationServer(OAuthServerOptions);
    //        app.UseOAuthBearerAuthentication(OAuthBearerOptions);

    //        //Configure Google External Login
    //        //googleAuthOptions = new GoogleOAuth2AuthenticationOptions()
    //        //{
    //        //    ClientId = "xxxxxx",
    //        //    ClientSecret = "xxxxxx",
    //        //    Provider = new GoogleAuthProvider()
    //        //};
    //        //app.UseGoogleAuthentication(googleAuthOptions);

    //        ////Configure Facebook External Login
    //        //facebookAuthOptions = new FacebookAuthenticationOptions()
    //        //{
    //        //    AppId = "xxxxxx",
    //        //    AppSecret = "xxxxxx",
    //        //    Provider = new FacebookAuthProvider()
    //        //};
    //        //app.UseFacebookAuthentication(facebookAuthOptions);

     //   }
    }

}