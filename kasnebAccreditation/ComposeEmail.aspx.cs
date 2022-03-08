using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class ComposeEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string AssitanceRequest(string tuseremailaddress, string tcueemailaddress, string temailsubject, string temailassistance)
        {

            var results = (dynamic)null;
            try
            {

                var userCode = HttpContext.Current.Session["Code"].ToString();
                var password = HttpContext.Current.Session["Password"].ToString();
                string status = new Config().ObjNav().FnUserHelpEmaiRequest(userCode, password, tuseremailaddress, temailsubject, temailassistance);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    results = info[0];
                }
                else
                {
                    results = info[1];
                }

            }
            catch (Exception ex)
            {
                results = ex.Message;
            }
            return results;
        }
    }
}