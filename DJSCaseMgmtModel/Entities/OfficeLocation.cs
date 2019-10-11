using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgtModel.Entities
{
    public class OfficeLocation : EntityBase
    {
        [Required, StringLength(50)]
        public string Name { get; set; }
        public int? DepartmentID { get; set; }

        #region Set Relationships/Constraints
        public virtual Department Department { get; set; }
        public virtual IEnumerable<Login> Login { get; set; }
        #endregion
    }
}