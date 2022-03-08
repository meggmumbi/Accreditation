using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class InstitutionPendingActions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void GenerateFeedbackVoucher_Click(object sender, EventArgs e)
        {
            try
            {
                documentsFeedback.InnerHtml = "";
                var userCode = Convert.ToInt32(Session["Code"].ToString());
                string password = Session["Password"].ToString();
                string university = Session["UniversityCode"].ToString();
                string tAccreditationNo = txtprogrammeNumbers.Text.Trim();
                string univerNo1 = tAccreditationNo.Replace("-", "_");
                string univerNo2 = univerNo1.Replace(":", "_");
                string univerNo3 = univerNo2.Replace("-", "_");
                string status = new Config().ObjNav().FnGenerateProgrammeFeedbackVoucher(tAccreditationNo, university);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"1000px\" height=\"300px\">";
                    embed += "If you were unable to view file, you can download from <a href = \"{0}\">Here</a>";
                    embed += " or Download <a target = \"_blank\" href = \"~/Downloads/FeeedbackVoucher\">Completeness Feedback Report</a> to view the Report File.";
                    embed += "</object>";
                    ltEmbed.Text = string.Format(embed, ResolveUrl("~/Downloads/FeeedbackVoucher/" + univerNo3 + ".pdf"));
                }
                else
                {
                    documentsFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
                }

            }
            catch (Exception t)
            {
                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        protected void GenerateEvaluationReport_Click(object sender, EventArgs e)
        {
            try
            {
                documentsFeedback.InnerHtml = "";
                var userCode = Convert.ToInt32(Session["Code"].ToString());
                string password = Session["Password"].ToString();
                string university = Session["UniversityCode"].ToString();
                string tAccreditationNo = txtprogramsnumbers.Text.Trim();
                string univerNo1 = tAccreditationNo.Replace("-", "_");
                string univerNo2 = univerNo1.Replace(":", "_");
                string univerNo3 = univerNo2.Replace("-", "_");
                string status = new Config().ObjNav().FnGenerateProgrammeEvaluationToool(tAccreditationNo, university);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"1000px\" height=\"300px\">";
                    embed += "If you were unable to view file, you can download from <a href = \"{0}\">Here</a>";
                    embed += " or Download <a target = \"_blank\" href = \"~/Downloads/EvaluationTool\">Evaluation Report</a> to view the Report File.";
                    embed += "</object>";
                    ltEmbed.Text = string.Format(embed, ResolveUrl("~/Downloads/EvaluationTool/" + univerNo3 + ".pdf"));
                }
                else
                {
                    documentsFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
                }

            }
            catch (Exception t)
            {
                documentsFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }
        protected void GenerateExitReport_Click(object sender, EventArgs e)
        {
            try
            {
                exitreportfeedback.InnerHtml = "";
                var userCode = Convert.ToInt32(Session["Code"].ToString());
                string password = Session["Password"].ToString();
                string university = Session["UniversityCode"].ToString();
                string tAccreditationNo = txtexitprogramnumbers.Text.Trim();
                string univerNo1 = tAccreditationNo.Replace("-", "_");
                string univerNo2 = univerNo1.Replace(":", "_");
                string univerNo3 = univerNo2.Replace("-", "_");
                string status = new Config().ObjNav().FnGenerateExitReport(tAccreditationNo, university);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    string embed = "<object data=\"{0}\" type=\"application/pdf\" width=\"1000px\" height=\"300px\">";
                    embed += "If you were unable to view file, you can download from <a href = \"{0}\">Here</a>";
                    embed += " or Download <a target = \"_blank\" href = \"~/Downloads/Exit Report\">Exit Report</a> to view the Report File.";
                    embed += "</object>";
                    ltEmbed.Text = string.Format(embed, ResolveUrl("~/Downloads/Exit Report/" + univerNo3 + ".pdf"));
                }
                else
                {
                    exitreportfeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "</div>";
                }

            }
            catch (Exception t)
            {
                exitreportfeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                     "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }

        }

    }
}