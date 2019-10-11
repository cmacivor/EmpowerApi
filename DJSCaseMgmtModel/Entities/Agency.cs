using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgtModel.Entities
{
    public class Agency : EntityBase
    {
        [Required, StringLength(50)]
        public string Name { get; set; }
        [StringLength(100)]
        public string Description { get; set; }

        #region Set Relationships/Constraints
        public virtual IEnumerable<Department> Department { get; set; }
        #endregion
    }
}