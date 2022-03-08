using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class test : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["UniversityCode"]))
            {
                
                Response.Redirect("Login.aspx");


            }
        }
    }
}