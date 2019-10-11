//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Net;
//using System.Net.Http;
//using System.Web.Http;
//using DJSCaseMgtService.DataAccess.Repositories;
//using DJSCaseMgmtModel.Entities;
//using System.Security.Principal;
//using System.Web;
//using System.Security.Claims;
//using Microsoft.AspNet.Identity;
//using System.Threading.Tasks;
//using DJSCaseMgtService.Models;
//using Microsoft.AspNet.Identity.EntityFramework;
//using DJSCaseMgtService.oAuth;

//namespace DJSCaseMgtService.Controllers


//{


//    [RoutePrefix("api/Login")]
  
//    //public class LoginController : BaseController<Login>
//    //{

//    //    [System.Web.Http.HttpGet,Route("getuser")]

//    //    public async Task<IList<String>> Owinuser()
//    //    {


//    //        IList<String> result = await  AuthRepository.UserDetails.role;
           
//    //        return result;

//            // string id = HttpContext.Current.User.Identity.Name;
//            // var arr = id.Split('\\');
//            // string uname = arr[1].ToString();
//            // List<string> result = new List<string>();
//            // WindowsIdentity wi = new WindowsIdentity(uname);
//            //// wi.IsAuthenticated==false

//            // foreach (IdentityReference group in wi.Groups)
//            // {
//            //     try
//            //     {

//            //         result.Add(group.Translate(typeof(NTAccount)).ToString());
//            //     }
//            //     catch (Exception ex) { }
//            // }
//            // if (result.Contains("RICHVA\\DIT Services Team"))
//            //     return Ok(new { username = uname, group = "RICHVA\\DIT Services Team" });
//            // else if (result.Contains("RICHVA\\Empower_Admins"))
//            //     return Ok(new { username = uname, group = "RICHVA\\Empower_Admins" });
//            // else if
//            //     (result.Contains("RICHVA\\Empower_SuperUsers"))
//            //     return Ok(new { username = uname, group = "RICHVA\\Empower_SuperUsers" });

//            // else if (result.Contains("RICHVA\\Empower_DJS_Users"))
//            //     return Ok(new { username = uname, group = "RICHVA\\Empower_DJS_Users" });

//            // else { 
//            // return Ok(new { username = "InvalidUser", group = "InvalidGroup" });
//            // }
//      //  }
       

       


//    //    [System.Web.Http.HttpGet, Route("GetGroups")]
//    //    public List<string> GetGroups()
//    //{
//    //        string id = HttpContext.Current.User.Identity.Name;
//    //        var arr = id.Split('\\');
//    //        string uname = arr[1].ToString();
//    //        List<string> result = new List<string>();
//    //    WindowsIdentity wi = new WindowsIdentity(uname);

//    //    foreach (IdentityReference group in wi.Groups)
//    //    {
//    //        try
//    //        {

//    //            result.Add(group.Translate(typeof(NTAccount)).ToString());
//    //        }
//    //        catch (Exception ex) { }
//    //    }
//    //    result.Sort();
//    //    return result;
//    //}


       

//    public LoginController(IBaseRepository<Login> baseRepository) : base(baseRepository) { }
//    }

//}