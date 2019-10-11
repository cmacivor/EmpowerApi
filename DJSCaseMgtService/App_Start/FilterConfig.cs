using Elmah.Contrib.Mvc;
using System.Web;
using System.Web.Http.Filters;
using System.Web.Mvc;

namespace DJSCaseMgtService
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new ElmahHandleErrorAttribute());
        }


    }
}
