[assembly: WebActivator.PostApplicationStartMethod(typeof(DJSCaseMgtService.App_Start.SimpleInjectorWebApiInitializer), "Initialize")]

namespace DJSCaseMgtService.App_Start
{
    using System.Web.Http;
    using SimpleInjector;
    using SimpleInjector.Extensions;
    using SimpleInjector.Integration.WebApi;
    using DJSCaseMgtService.DataAccess.Repositories;
    using Owin;
    using SimpleInjector.Extensions.ExecutionContextScoping;

    public static class SimpleInjectorWebApiInitializer
    {      
        public static void Initialize()
        {

            HttpConfiguration config = new HttpConfiguration();
            var container = new Container();
            InitializeContainer(container);
            container.RegisterWebApiControllers(config);
            container.Verify();
            GlobalConfiguration.Configuration.DependencyResolver =
            new SimpleInjectorWebApiDependencyResolver(container);

          config.DependencyResolver=new SimpleInjectorWebApiDependencyResolver(container);




            }

        public static void UseOwinContextInjector(this IAppBuilder app, Container container)
        {
            // Create an OWIN middleware to create an execution context scope
            app.Use(async (context, next) =>
            {
                using (var scope = container.BeginExecutionContextScope())
                {
                    await next.Invoke();
                }
            });

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
            container.RegisterWebApiRequest<IEmploymentPlanRepository, EmploymentPlanRepository>();
            container.RegisterWebApiRequest<IEnrollmentRepository, EnrollmentRepository>();
            container.RegisterWebApiRequest<IProgressNoteRepository, ProgressNoteRepository>();
            container.RegisterWebApiRequest<IServiceUnitRepository, ServiceUnitRepository>();
            container.RegisterWebApiRequest<IActionPlanRepository, ActionPlanRepository>();
        }
    }
}