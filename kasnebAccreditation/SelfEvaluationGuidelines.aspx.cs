using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class SelfEvaluationGuidelines : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            try
            {
               
                
                    string tApplicationNo = ApplicationNo.Text.Trim();
           
             
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                  //  String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().SelfEvalutionApplication(tApplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                          string  code = info[2];

                        
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("selfEvalution.aspx?step=1&&applicationNo=" + tApplicationNo + "&&code="+code);
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}