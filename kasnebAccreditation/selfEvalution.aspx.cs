using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.IO;
using System.Configuration;

namespace kasnebAccreditation
{
    public partial class selfEvalution : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }
        }
        protected void nextstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            string tcode;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["applicationNo"].Trim();
                tcode = Request.QueryString["code"];
            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
                tcode = "";
            }
            int num2 = num1 + 1;
            Response.Redirect("selfEvalution.aspx?applicationNo="+str+"&&step=" +num2+"&&code="+tcode);
        }
        protected void previous_Click(object sender, EventArgs e)
        {

            int num1;
            string str;
            string code;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["applicationNo"].Trim();
                code = Request.QueryString["code"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
                code = "";
            }
            int num2 = num1 - 1;
            Response.Redirect("selfEvalution.aspx?applicationNo=" + str + "&&step=" + num2 + "&&code=" + code);
        }

        protected void deleteDeclaration_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = fileName.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "University Application/";
                String applicationNo = Request.QueryString["applicationNo"];
                applicationNo = applicationNo.Replace('/', '_');
                applicationNo = applicationNo.Replace(':', '_');
                String documentDirectory = filesFolder + applicationNo + "/";
                String myFile = documentDirectory + tFileName;
                if (File.Exists(myFile))
                {
                    File.Delete(myFile);
                    if (File.Exists(myFile))
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
           
        
    }

        

        protected void uploaddeclaration_Click1(object sender, EventArgs e)
        {
            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "declaration/";

            if (declaration.HasFile)
            {
                try
                {
                    if (Directory.Exists(filesFolder))
                    {
                        String extension = System.IO.Path.GetExtension(declaration.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            String applicationNo = Request.QueryString["applicationNo"];
                            applicationNo = applicationNo.Replace('/', '_');
                            applicationNo = applicationNo.Replace(':', '_');
                            String documentDirectory = filesFolder + applicationNo + "/";
                            Boolean createDirectory = true;
                            try
                            {
                                if (!Directory.Exists(documentDirectory))
                                {
                                    Directory.CreateDirectory(documentDirectory);
                                }
                            }
                            catch (Exception)
                            {
                                createDirectory = false;
                                linesFeedback.InnerHtml =
                                                                "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
                                                                "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            if (createDirectory)
                            {
                                string filename = documentDirectory + declaration.FileName;
                                if (File.Exists(filename))
                                {
                                    linesFeedback.InnerHtml =
                                                                       "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }
                                else
                                {
                                    declaration.SaveAs(filename);
                                    if (File.Exists(filename))
                                    {
                                        linesFeedback.InnerHtml =
                                            "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        linesFeedback.InnerHtml =
                                            "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                }
                            }
                        }
                        else
                        {
                            linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
                catch (Exception ex)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            else
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }

        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<QuestionsModel> cmpitems)
        {
            string componentCode = "", tqnCode = "", tapplicationNo = "",tcomment="", tevaluationHeader="";
            decimal tScore = 0;
           

            //decimal tMaxscore = 0;
            //int jobCode = 0;
            //bool error = false;
            //string message = "";
            string results_0 = (dynamic)null;
            //string results_1 = (dynamic)null;

            try
            {

                //Check for NULL.
                if (cmpitems == null)
                    cmpitems = new List<QuestionsModel>();

                //Loop and insert records.
                foreach (QuestionsModel oneitem in cmpitems)
                {
                    tqnCode = oneitem.QuestionCode;
                    // tattachment = oneitem.Attachment;
                 tScore= String.IsNullOrEmpty(oneitem.response) ? 0M : Convert.ToDecimal(oneitem.response);

                    //tScore = Convert.ToDecimal(oneitem.response);

                    componentCode = oneitem.ComponentCode;
                    tcomment = oneitem.comment;
                    tevaluationHeader = oneitem.evaluationHeader;
                   
                    tapplicationNo = oneitem.applicationNo;
                    //check for nulls
                    if (string.IsNullOrWhiteSpace(tapplicationNo.ToString()))
                    {
                        results_0 = "applicationnull";
                        return results_0;
                    }

                 

                  

                    if (string.IsNullOrWhiteSpace(componentCode))
                    {
                        results_0 = "componentcodenull";
                        return results_0;
                    }

                   


                    string status = new Config().ObjNav().SelfEvaluationResponce(tapplicationNo, componentCode, tqnCode, tScore,tcomment, tevaluationHeader);
                    string[] info = status.Split('*');
                    results_0 = info[0];
                    //results_1 = info[1];

                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }

        protected void Unnamed_Click1(object sender, EventArgs e)
        {

        }

        protected void Unnamed_Click2(object sender, EventArgs e)
        {
            string ApplicationNo = Request.QueryString["code"];
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "success();window.location ='PendingPayments.aspx';", true);

            Response.Redirect("summeryScore.aspx?applicationNo=" + ApplicationNo);
        }
    }

}