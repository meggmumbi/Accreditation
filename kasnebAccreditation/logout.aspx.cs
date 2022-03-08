using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["UniversityCode"] = "";
            Session["UniversityName"] = "";
            Session["EmailAddress"] = "";
            Session.Clear();
            Response.Redirect("Login.aspx");
           
        }
    }
}