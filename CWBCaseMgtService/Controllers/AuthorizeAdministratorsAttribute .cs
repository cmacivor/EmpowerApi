using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Http;

namespace DJSCaseMgtService.Controllers
{

    /// <summary>
    /// Provides an MVC Authorize attribute that applies authorization to controllers and controller actions for a Viewer role configured in the application.
    /// </summary>
    /// <remarks>To use this attribute in a Windows authenticated application, specify an AppSetting in the web.config with a key of 'ViewerRole'. Set the key value to an AD Group authorized as Viewers in your application. Then apply the attribute to your controllers and actions that require this role.</remarks>
    public class AuthorizeViewersAttribute : AuthorizeAttribute
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="T:SecurityTest.Authorization.AuthorizeViewersAttribute"/> class.
        /// </summary>
        public AuthorizeViewersAttribute()
        {
            Roles = ConfigurationManager.AppSettings["ViewerRole"];
        }
    }


    /// <summary>
    /// Provides an MVC Authorize attribute that applies authorization to controllers and controller actions for an Editor role configured in the application.
    /// </summary>
    /// <remarks>To use this attribute in a Windows authenticated application, specify an AppSetting in the web.config with a key of 'EditorRole'. Set the key value to an AD Group authorized as Editors in your application. Then apply the attribute to your controllers and actions that require this role.</remarks>
    public class AuthorizeEditorsAttribute : AuthorizeAttribute
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="T:SecurityTest.Authorization.AuthorizeEditorsAttribute"/> class.
        /// </summary>
        public AuthorizeEditorsAttribute()
        {
            Roles = ConfigurationManager.AppSettings["EditorRole"];
        }
    }

    /// <summary>
    /// Provides an MVC Authorize attribute that applies authorization to controllers and controller actions for an Administrator role configured in the application.
    /// </summary>
    /// <remarks>To use this attribute in a Windows authenticated application, specify an AppSetting in the web.config with a key of 'AdministratorRole'. Set the key value to an AD Group authorized as Administrators in your application. Then apply the attribute to your controllers and actions that require this role.</remarks>

    public class AuthorizeAdministratorsAttribute : AuthorizeAttribute
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="T:SecurityTest.Authorization.AuthorizeAdministratorsAttribute"/> class.
        /// </summary>
        public AuthorizeAdministratorsAttribute()
        {
            Roles = ConfigurationManager.AppSettings["AdministratorRole"];
        }

    }
}