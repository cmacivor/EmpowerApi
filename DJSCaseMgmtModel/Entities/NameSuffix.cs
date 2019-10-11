using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgtModel.Entities
{
    public class NameSuffix : EntityBase
    {
        [Required, StringLength(25)]
        public string Name { get; set; }
        [StringLength(50)]
        public string Description { get; set; }

        #region Set Relationships/Constraints
        public virtual IEnumerable<Person> Person { get; set; }
        #endregion
    }
}