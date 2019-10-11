using DJSCaseMgmtModel.Entities;
using DJSCaseMgtService.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace DJSCaseMgtService.DataAccess.Repositories
{
    public class ProgressNoteRepository : BaseRepository<ProgressNote>, IProgressNoteRepository
    {
        private DJSCaseMgtContext context;

        public ProgressNoteRepository(DJSCaseMgtContext context) : base(context) 
        {
            this.context = context;
        }

        public IEnumerable<ProgressNote> GetProgressNotesForEnrollment(int enrollmentID)
        { 
            var progressNotes = (from pn in context.ProgressNote
                                 where pn.EnrollmentID == enrollmentID && pn.Active==true
                                 select pn).AsEnumerable();

            return progressNotes;
        }
        public string DeleteProgressNote(int id)
        {
            string output = "";
            var req = context.ProgressNote.Where(x => x.ID == id).ToList();
            if (req.Count == 0)
                return null;
            else
                req.ForEach(x =>
                {
                    context.ProgressNote.Remove(x);
                });
            try
            {
                context.SaveChanges();
                output = "Success";
            }
            catch (Exception ex)
            {
                output = "Failed";
            }
            return output;
        }
    
    }

    public interface IProgressNoteRepository
    {
        IEnumerable<ProgressNote> GetProgressNotesForEnrollment(int enrollmentID);

        string DeleteProgressNote(int id);
    }
}