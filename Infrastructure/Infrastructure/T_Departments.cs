//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Infrastructure
{
    using System;
    using System.Collections.Generic;
    
    public partial class T_Departments
    {
        public int DEPTId { get; set; }
        public string DEPTName { get; set; }
        public string Description { get; set; }
        public Nullable<int> GroupMasterId { get; set; }
        public Nullable<int> CreatedById { get; set; }
        public Nullable<System.DateTime> CreatedDate { get; set; }
        public Nullable<int> LastModifiedById { get; set; }
        public Nullable<System.DateTime> LastModifiedDate { get; set; }
        public Nullable<bool> IsEditedEmailId { get; set; }
        public Nullable<bool> StatusID { get; set; }
        public Nullable<int> ResourceBusinessUnit { get; set; }
        public Nullable<int> ProjectHeadId { get; set; }
    
        public virtual T_Master T_Master { get; set; }
    }
}
