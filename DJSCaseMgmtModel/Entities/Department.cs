using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace DJSCaseMgtModel.Entities
{
    public class Department : EntityBase
    {
        public int? AgencyID { get; set; }
        [Required, StringLength(100)]
        public string Name { get; set; }

        #region Set Relationships/Constraints
        public virtual Agency Agency { get; set; }
        public virtual IEnumerable<OfficeLocation> OfficeLocation { get; set; }
        #endregion
    }
}