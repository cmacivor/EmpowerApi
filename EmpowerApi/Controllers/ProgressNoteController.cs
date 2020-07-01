using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using DJSCaseMgtService.DataAccess.Repositories;
using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using EmpowerApi.Controllers;

namespace DJSCaseMgtService.Controllers
{
    [RoutePrefix("api/ProgressNote")]
    public class ProgressNoteController : BaseController<ProgressNote>
    {
        private IProgressNoteRepository progressnoreRepository;
        private DJSCaseMgtContext context = new DJSCaseMgtContext();
        public ProgressNoteController(IBaseRepository<ProgressNote> baseRepository, IProgressNoteRepository progressnoreRepository) : base(baseRepository)
        {

            this.progressnoreRepository = progressnoreRepository;
        }


        [System.Web.Http.HttpPut, Route("UpdateProgresnote/{id:int}")]
        public int UpdateProgressNote(ProgressNote progressNote)
        {
            var original = context.ProgressNote.Find(progressNote.ID);
            try
            {
                if (original != null)
                {
                    context.Entry(original).CurrentValues.SetValues(progressNote);
                    context.SaveChanges();
                }
            }
            catch (Exception e)
            {
                throw e;
            }

            return progressNote.ID;

        }

        [System.Web.Http.HttpGet, Route("GetByEnrollmentID/{id:int}")]
        public IHttpActionResult GetByEnrollmentID(int id)
        {
            var progressNotes = context.ProgressNote.Where(x => x.Active == true && x.EnrollmentID == id);

            return Ok(progressNotes);
        }

    }
}
