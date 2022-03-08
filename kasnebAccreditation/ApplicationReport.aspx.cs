using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class ApplicationReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                score.Text = Request.QueryString["applicationNo"];

                feedback.InnerHtml = "";

                Boolean Error = false;

                try
                {

                }

                catch (Exception)
                {
                    Error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                try
                {

                }
                catch (Exception)
                {
                    Error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                if (!Error)
                {
                    try
                    {
                        string code = Request.QueryString["code"];
                        string applicationNo = Request.QueryString["applicationNo"];
                        String status = new Config().ObjNav().PrintdApplicationReport(applicationNo,code);
                        String[] info = status.Split('*');
                        if (info[0] == "success")
                        {
                            p9form.Attributes.Add("src", ResolveUrl(info[1]));
                        }
                        else
                        {
                            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                    catch (Exception t)
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }

                }
            }
        }
    }
}