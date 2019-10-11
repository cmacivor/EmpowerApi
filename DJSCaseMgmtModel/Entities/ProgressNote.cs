using System;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgmtModel.Entities
{
    public class ProgressNote : EntityBase
    {
        [Required]
        public int EnrollmentID { get; set; }
        public virtual Enrollment Enrollment { get; set; }

        public DateTime CommentDate { get; set; }

        public string Comment { get; set; }

        public int? ContactTypeID { get; set; }
        public virtual ContactType ContactType { get; set; }
        public int? SubContactTypeID { get; set; }
        public virtual SubContactType SubContactType { get; set; }

        [Required]
        public DateTime Duration { get; set; }

        [Required]
        public bool Active { get; set; }
    }
}