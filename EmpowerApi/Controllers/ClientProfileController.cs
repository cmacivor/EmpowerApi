using DJSCaseMgmtModel.ViewModels;
using DJSCaseMgtService.DataAccess.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace EmpowerApi.Controllers
{
    [RoutePrefix("api/ClientProfile")]
    public class ClientProfileController : ApiController
    {
        private IClientProfileRepository _clientProfileRepository;

        public ClientProfileController(IClientProfileRepository clientProfileRepository)
        {
            _clientProfileRepository = clientProfileRepository;
        }


        [System.Web.Http.HttpPost, Route("Search")]
        public IEnumerable<ClientSearchResults> Search(ClientName name)
        {
            var retVal = _clientProfileRepository.Search(name.LastName, name.FirstName);
            return retVal;
        }
    }
}
