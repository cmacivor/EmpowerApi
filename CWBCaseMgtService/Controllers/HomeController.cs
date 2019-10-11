using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace DJSCaseMgtService.Controllers
{
    public class HomeController : Controller
    {
        // GET: Home
        [AuthorizeViewers()]
        public ActionResult Index()
        {
            return View();
        }





        [AuthorizeEditors()]
        public ActionResult Edit()
        {
            ViewBag.Message = "Use this view to edit application data.";
            return View();
        }

        [AuthorizeAdministrators()]
        public ActionResult Administer()
        {
            ViewBag.Message = "Use this view to administer the application.";
            return View();
        }

        private class AuthorizeAdministratorsAttribute : Attribute
        {

            Roles = ConfigurationManager.AppSettings["AdministratorRole"];
        }

        private class AuthorizeEditorsAttribute : Attribute
        {

            Roles = ConfigurationManager.AppSettings["EditorRole"];
        }

        private class AuthorizeViewersAttribute : Attribute
        {
        }
    } }


