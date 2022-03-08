using Microsoft.SharePoint.Client;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class Institution : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var Applicationtyp = nav.applicationTypes;
                accreditationType.DataSource = Applicationtyp;
                accreditationType.DataTextField = "Description";
                accreditationType.DataValueField = "Code";
                accreditationType.DataBind();
                accreditationType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                institutName.Text= Convert.ToString(Session["UniversityName"]);
                emailAddress.Text = Convert.ToString(Session["EmailAddress"]);
                phoneNumber.Text = Convert.ToString(Session["phoneNumber"]);
                postAddress.Text= Convert.ToString(Session["address"]);


                //var InstitutionName = nav.traininginstitutions;
                //instName.DataSource = InstitutionName;
                //instName.DataTextField = "Name";
                //instName.DataValueField = "No";
                //instName.DataBind();
                //instName.Items.Insert(0, new ListItem("--select--", ""));

                var instType = nav.institutionTypes;
                institutionType.DataSource = instType;
                institutionType.DataTextField = "Description";
                institutionType.DataValueField = "Code";
                institutionType.DataBind();
                institutionType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));



                var courses = nav.course;
                course.DataSource = courses;
                course.DataTextField = "Description";
                course.DataValueField = "Code";
                course.DataBind();
                course.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                var domain = nav.DomainAreas;
                refdomain.DataSource = domain;
                refdomain.DataTextField = "Description";
                refdomain.DataValueField = "Code";
                refdomain.DataBind();
                refdomain.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));



                var courzes = nav.course;
                profExamination.DataSource = courzes;
                profExamination.DataTextField = "Description";
                profExamination.DataValueField = "Code";
                profExamination.DataBind();
                profExamination.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var qualifications = nav.qualification;
                HighestQ.DataSource = qualifications;
                HighestQ.DataTextField = "Description";
                HighestQ.DataValueField = "Code";
                HighestQ.DataBind();
                HighestQ.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var qual = nav.qualification;
                lowestQ.DataSource = qual;
                lowestQ.DataTextField = "Description";
                lowestQ.DataValueField = "Code";
                lowestQ.DataBind();
                lowestQ.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var qualific = nav.qualification;
                HTQT.DataSource = qualific;
                HTQT.DataTextField = "Description";
                HTQT.DataValueField = "Code";
                HTQT.DataBind();
                HTQT.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var qualificat = nav.qualification;
                LTQT.DataSource = qualificat;
                LTQT.DataTextField = "Description";
                LTQT.DataValueField = "Code";
                LTQT.DataBind();
                LTQT.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                string applicationNo = Request.QueryString["applicationNo"];
                string code = Request.QueryString["code"];
                if (code == "001")
                {
                    Response.Redirect("Institution.aspx?step=2&&applicationNo="+applicationNo);
                }
                else if (code == "002")
                {
                    Response.Redirect("Institution.aspx?step=11&&applicationNo=" + applicationNo);
                }
                else if (code == "003")
                {
                    Response.Redirect("Institution.aspx?step=16&&applicationNo=" + applicationNo);
                }
                else if (code == "004")
                {
                    Response.Redirect("Institution.aspx?step=25&&applicationNo=" + applicationNo);
                }
                //else if (code == "005")
                //{
                //    Response.Redirect("Institution.aspx?step=2");
                //}
                //else if (code == "006")
                //{
                //    Response.Redirect("Institution.aspx?step=2");
                //}
                else if (code == "007")
                {
                    Response.Redirect("Institution.aspx?step=27&&applicationNo=" + applicationNo);
                }
                else if (code == "008")
                {
                    Response.Redirect("Institution.aspx?step=28&&applicationNo=" + applicationNo);
                }
                else if (code == "009")
                {
                    Response.Redirect("Institution.aspx?step=29&&applicationNo=" + applicationNo);
                }
                string university = Convert.ToString(Session["UniversityCode"]);
                var AccreditationApplication = nav.applicationAccreditation.Where(r => r.No == university && r.Application_No== applicationNo && r.Payment_Document==false).ToList();
                if (AccreditationApplication.Count > 0)
                {
                    foreach (var descript in AccreditationApplication)
                    {
                        Amount.Text = Convert.ToString(descript.Application_Fee_LCY);
                        AmountInstructions.InnerText = Convert.ToString(descript.Application_Fee_LCY);
                        AmountInstructionsManual.InnerText = Convert.ToString(descript.Application_Fee_LCY);
                    }
                }
            }
        }

        protected void apply_Click(object sender, EventArgs e)
        {

        //    int step = 0;
        //    step += 1;

        //    try
        //    {
        //        String AccreditationType = accreditationType.SelectedValue.Trim();
        //        String Name = instName.SelectedValue.Trim();
        //        String InstitutionType = institutionType.SelectedValue.Trim();
        //        String phone = phoneNumber.Text.Trim();
        //        String Email = emailAddress.Text.Trim();
        //        Boolean error = false;
        //        String message = "";

        //        if (error)
        //        {
        //            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }
        //        else
        //        {
                    
        //            String applicationNo = "";
        //            Boolean newapplicationNo = false;
        //            try
        //            {

        //                applicationNo = Request.QueryString["applicationNo"];
        //                if (String.IsNullOrEmpty(applicationNo))
        //                {
        //                    applicationNo = "";
        //                    newapplicationNo = true;
        //                }
        //            }
        //            catch (Exception)
        //            {

        //                applicationNo = "";
        //                newapplicationNo = true;
        //            }
        //            string userCode = Convert.ToString(Session["Code"]);
        //            string password = Convert.ToString(Session["Password"]);
        //            string response = new Config().ObjNav().AccreditationApplication(AccreditationType, Name, InstitutionType, Email, phone, applicationNo);

        //            String[] info = response.Split('*');
        //            if (info[0] == "success")
        //            {
        //                if (newapplicationNo)
        //                {
        //                    applicationNo = info[2];

        //                }

        //                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('success');", true);
        //            }
        //            else
        //            {
        //                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }

        //        }
        //    }
        //    catch (Exception m)
        //    {
        //        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }


        }
        protected void previousstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["applicationNo"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
            }
            int num2 = num1 - 1;
            Response.Redirect("Institution.aspx?applicationNo="+str +"&step="+num2);
        }
        protected void nextstep_Click(object sender, EventArgs e)
        {
            int num1;
            string str;
            try
            {
                num1 = Convert.ToInt32(Request.QueryString["step"].Trim());
                str = Request.QueryString["applicationNo"].Trim();

            }
            catch (Exception ex)
            {
                num1 = 0;
                str = "";
            }
            int num2 = num1 + 1;
            Response.Redirect("Institution.aspx?applicationNo="+str+"&step="+num2);
        }
        protected void previous_Click(object sender, EventArgs e)
        {

            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Institution.aspx?step=1"+applicationNo);
        }

        protected void ValidateExpectedLearningOutcomes_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=3");
        }

        protected void pQ2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=2");
        }

        protected void Qn2_Click(object sender, EventArgs e)
        {
           
        }

        

        protected void pQ5_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=3");
        }

      

        protected void Trainees_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=6");
        }

        protected void pQ7_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=4");
        }

        protected void step5_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=5");
        }

        protected void step7_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=7");
        }

        protected void AddTrainers_Click(object sender, EventArgs e)
        {
            try
            {
                String courses = course.SelectedValue.Trim();
                String Sections = Section.SelectedValue.Trim();
                int Pstudents = Convert.ToInt32(partStudents.Text.Trim());
                int Fstudents = Convert.ToInt32(Fullstudents.Text.Trim());
                int Ptrainers = Convert.ToInt32(parttrainers.Text.Trim());
                int Ftrainers = Convert.ToInt32(fulltrainers.Text.Trim());
                String THrainerQ = HTQT.Text.Trim();
                String LTrainerQ = LTQT.Text.Trim();
                int mxHrsCourse = Convert.ToInt32(MXCH.Text.Trim());
                int minHrsCourse = Convert.ToInt32(MNCH.Text.Trim());
                int MxlecHrs = Convert.ToInt32(MLH.Text.Trim());
                int minLecHrs = Convert.ToInt32(MXLH.Text.Trim());


                Boolean error = false;


                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().CreateTrainers(courses, Sections, Pstudents, Fstudents, Ptrainers, Ftrainers, THrainerQ, LTrainerQ, minLecHrs, MxlecHrs, mxHrsCourse, minHrsCourse, applicationNo);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }


            }
            catch
            {

            }



        }


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {


            //    try
            //    {
            //        var nav = Config.ReturnNav();
            //        string course2 = DropDownList1.SelectedValue.Trim();

            //        var sections = nav.course.Where(r => (r.Course == course2));
            //        DropDownList2.DataSource = sections;
            //        DropDownList2.DataTextField = "Section";
            //        DropDownList2.DataValueField = "Code";
            //        DropDownList2.DataBind();


            //        var parts = nav.course.Where(r => (r.Course == course2));
            //        DropDownList3.DataSource = parts;
            //        DropDownList3.DataTextField = "Part";
            //        DropDownList3.DataValueField = "Code";
            //        DropDownList3.DataBind();


            //        var desc = nav.course.Where(r => (r.Course == course2));
            //        DropDownList4.DataSource = desc;
            //        DropDownList4.DataTextField = "Description";
            //        DropDownList4.DataValueField = "Code";
            //        DropDownList4.DataBind();



            //    }
            //    catch (Exception ex)
            //    {
            //        Response.Write("<script>alert('" + ex.Message + "');</script>");

            //    }


        }

        protected void step6_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=6");
        }

        protected void step8_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=8");
        }

        protected void step9_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=9");
        }

        protected void step7back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=7");
        }

        protected void step10_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=10");
        }

        protected void step8back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=8");
        }

        protected void step12_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=12");
        }

        protected void step10back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=10");
        }

        protected void step11_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=11");
        }

        protected void addComputerLibrary_Click(object sender, EventArgs e)
        {

        }

        protected void addSpecifications_Click(object sender, EventArgs e)
        {

        }

        protected void step11back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=11");
        }

        protected void step13_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=13");
        }

        protected void addLAN_Click(object sender, EventArgs e)
        {

        }

        protected void step14_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=14");
        }

        protected void step12back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=12");
        }

        protected void step15_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=15");
        }

        protected void step13back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=13");
        }

        protected void step16_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=16");
        }

        protected void step14back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=14");
        }

        protected void step17_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=17");
        }

        protected void step15back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=15");
        }

        protected void step16back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=15");
        }

        protected void Application_Click(object sender, EventArgs e)
        {
            if (CheckBoxdeclaration.Checked == true)
            {

                try
                {


                    String applicationNo = Request.QueryString["applicationNo"];
                    string university = Convert.ToString(Session["UniversityCode"]);



                    string response = new Config().ObjNav().SubmitApplication(applicationNo);

                    String[] info = response.Split('*');
                    if (info[0] == "success")
                    {

                        declarations.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Accreditation.aspx') }, 5000);", true);

                    }
                }

                catch (Exception m)
                {
                    declarations.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            else if (CheckBoxdeclaration.Checked == false)
            {

                var message = "Please accept our Terms and Conditions";
                declarations.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }



        }

        protected void step9back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Institution.aspx?step=9");
        }

        protected void addAccessories_Click(object sender, EventArgs e)
        {

        }

        protected void addAcademicSoftware_Click(object sender, EventArgs e)
        {

        }

        protected void step2_Click(object sender, EventArgs e)
        {

            int step = 0;
            step += 1;

            try
            {
                String AccreditationType = accreditationType.SelectedValue.Trim();
                String Name = institutName.Text.Trim();
                String InstitutionType = institutionType.SelectedValue.Trim();
                String phone = phoneNumber.Text.Trim();
                String Email = emailAddress.Text.Trim();
                string university = Convert.ToString(Session["UniversityCode"]);
                Boolean error = false;
                String message = "";

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    /*
                    Session["UniversityCode"]);
                    Session["employeeNo"] = user.employeeNo;
                    */
                    String applicationNo = "";
                    Boolean newapplicationNo = false;
                    try
                    {

                        applicationNo = Request.QueryString["applicationNo"];
                        if (String.IsNullOrEmpty(applicationNo))
                        {
                            applicationNo = "";
                            newapplicationNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        applicationNo = "";
                        newapplicationNo = true;
                    }
                    string userCode = Convert.ToString(Session["Code"]);
                    string password = Convert.ToString(Session["Password"]);
                    //string response = new Config().ObjNav().ApplyForAccreditation(AccreditationType, InstitutionName, Country, Town, Street, building, County, Constituency, PostAddress, PostCode, City, InstitutionWebsite, PhoneNumber, Email);
                    string response = new Config().ObjNav().AccreditationApplication(AccreditationType, university, InstitutionType, Email, phone, applicationNo);

                    String[] info = response.Split('*');
                    if (info[0] == "success")
                    {
                        if (newapplicationNo)
                        {
                            applicationNo = info[2];

                        }
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Response.Redirect("InstitutionAccreditationBundledProgrammes.aspx?&&applicationNo=" + applicationNo);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }

        protected void step3_Click(object sender, EventArgs e)
        {
            try
            {

                var nav = Config.ReturnNav();
                String applicationNo = Request.QueryString["applicationNo"];
                string qns = "009";
                string respText = "";

                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, "", respText);
                string[] info = status.Split('*');
                if (info[0] == "success")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('proceed');", true);
                      Response.Redirect("Institution.aspx?step=3&&applicationNo"+applicationNo);
                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            catch
            {

            }
        }
        protected void staff_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string qns = "002";
           
            var responce = "";
            if (responce == "01")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo,responce,"");
               
                
            }
            else if (responce == "02")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo,responce,"");
                
            }
        }

        protected void management_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string qns = "001";

            var responce = "";
            if (responce == "01")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            }
            else if (responce == "02")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            }
        }

        protected void trainers_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string qns = "003";

            var responce = "";
            if (responce == "01")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            }
            else if (responce == "02")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            }
        }

        protected void NonDiscrimination_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "004";

            //var responce = "";
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void DECISION3_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "005";

            //var responce = "";
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void DECISION1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string qns = "006";

            var responce = "";
            if (responce == "01")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            }
            else if (responce == "02")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            }
        }

        protected void DECISION2_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string qns = "007";

            var responce = "";
            if (responce == "01")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            }
            else if (responce == "02")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            }
        }

        protected void DECISION4_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            String applicationNo = Request.QueryString["applicationNo"];
            string qns = "008";

            var responce ="";
            if (responce == "01")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            }
            else if (responce == "02")
            {
                String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            }
        }

        protected void Bran_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "015";

            //var responce = Bran.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void relationship_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "016";

            //var responce = relationship.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void stdEthics_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "017";

            //var responce = stdEthics.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void staffEthics_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "018";

            //var responce = staffEthics.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void trainersEthics_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "019";

            //var responce = trainersEthics.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void studentethics_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "020";

            //var responce = studentethics.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void QAdropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "022";

            //var responce = QAdropdown.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void invest_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "023";

            //var responce = invest.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void moneyC_SelectedIndexChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "024";

            //var responce = moneyC.SelectedValue;
            //if (responce == "01")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");


            //}
            //else if (responce == "02")
            //{
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, responce, "");

            //}
        }

        protected void addstaff_Click(object sender, EventArgs e)
        {
            try
            {
                // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
                var tstaffCategory = Convert.ToInt32(staffCategory.SelectedValue.Trim());
                String tdescription = String.IsNullOrEmpty(staffdescription.Text.Trim()) ? "" : staffdescription.Text.Trim();
                int tstaff = Convert.ToInt32(NofStaff.Text.Trim());

                String thighestq = String.IsNullOrEmpty(HighestQ.SelectedValue.Trim()) ? "" : HighestQ.SelectedValue.Trim();
                String tlowestq = String.IsNullOrEmpty(lowestQ.Text.Trim()) ? "" : lowestQ.Text.Trim();


                Boolean error = false;


                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().CreateStaff(tdescription, tstaff, thighestq, tlowestq, tstaffCategory, applicationNo);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void trainersCom_TextChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "010";           
            
            //    string com = trainersCom.Text;
            //    String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, "", com);


            
        }

        protected void mngt_TextChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "011";

            //string com = mngt.Text;
            //String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, "", com);


        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            //var nav = Config.ReturnNav();
            //String applicationNo = Request.QueryString["applicationNo"];
            //string qns = "012";

            //string com = TextBox1.Text;
            //String status = new Config().ObjNav().FnceateapplicationLines(qns, applicationNo, "", com);
        }

        protected void Add_Class(object sender, EventArgs e)
        {
            try
            {
                String exam = profExamination.SelectedValue;
                int ClassRoom = Convert.ToInt32(classroom.Text.Trim());
                decimal sitting = Convert.ToDecimal(seating.Text.Trim());
                int LClass = Convert.ToInt32(largeClass.Text);
                int Sclass = Convert.ToInt32(smallClass.Text);
                int total = Convert.ToInt32(totalCapacity.Text);
                Boolean error = false;


                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().SittingCapacity(applicationNo, exam, ClassRoom, sitting, LClass, Sclass, total);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void course_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                var nav = Config.ReturnNav();
                var courses = course.SelectedValue;

                var section = nav.sections.Where(r => r.Course == courses);
                Section.DataSource = section;
                Section.DataTextField = "Description";
                Section.DataValueField = "Code";
                Section.DataBind();
            }
            catch
            {

            }

        }

        protected void refbk_Click(object sender, EventArgs e)
        {
            try
            {
                String domain = refdomain.SelectedValue;
                int EstNumber = Convert.ToInt32(EstNo.Text.Trim());
                decimal EstValue = Convert.ToDecimal(EstTotalValue.Text.Trim());
                int recomBooks = Convert.ToInt32(recommBooks.Text);

                Boolean error = false;


                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().CreateRecomBooks(applicationNo, domain, EstNumber, EstValue, recomBooks);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void compLab_Click(object sender, EventArgs e)
        {
            try
            {
                String compLab = computerLab.Text;
                int availableForTraining = Convert.ToInt32(trainingAvail.Text.Trim());
                decimal sittingCapacity = Convert.ToDecimal(sittn.Text.Trim());
                int Adapter = Convert.ToInt32(withAdapter.Text);
                int TotalS = Convert.ToInt32(TotalSpace.Text);
                Boolean error = false;


                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().CreateComputerLab(applicationNo, compLab, sittingCapacity,availableForTraining, Adapter, TotalS);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void ictEquipmentDetails_Click(object sender, EventArgs e)
        {

           
            try
            {
                int cat = Convert.ToInt32(ictAccessories.SelectedValue.Trim());

                String typeAcad = typeName.SelectedValue;
                String typeAvail = typeavailable.Text.Trim();
                int No = Convert.ToInt32(Number.Text.Trim());
                Boolean error = false;

                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().CreateICTAccessory(applicationNo,  typeAcad, typeAvail,cat,No);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        public void LoadictEquipments()
        {
            try
            {
                var nav = Config.ReturnNav();

                var category = "";
                var typ = Convert.ToInt32(ictAccessories.SelectedValue);

                switch (typ)
                {

                    case 0:
                        category = "Item/Accessory";
                        var accessory = nav.IctEquipmentTypes.Where(r => r.Category == "Item/Accessory").ToList();
                        typeName.DataSource = accessory;
                        typeName.DataTextField = "Description";
                        typeName.DataValueField = "Code";
                        typeName.DataBind();

                      
                        return;

                    case 1:


                        category = "Connected to the LAN";
                        var accessorys = nav.IctEquipmentTypes.Where(r => r.Category == "Connected to the LAN").ToList();
                        typeName.DataSource = accessorys;
                        typeName.DataTextField = "Description";
                        typeName.DataValueField = "Code";
                        typeName.DataBind();

                       
                        return;

                    case 2:
                        category = "Academic software";
                        var accessoryz = nav.IctEquipmentTypes.Where(r => r.Category == "Academic software").ToList();
                        typeName.DataSource = accessoryz;
                        typeName.DataTextField = "Description";
                        typeName.DataValueField = "Code";
                        typeName.DataBind();

                        
                        return;


                    default:
                        break;
                }





            }
            catch (Exception)
            {

            }
        
    }

        protected void ictAccessories_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadictEquipments();
            

               

        }

        protected void ictEquipmentDetailz_Click(object sender, EventArgs e)
        {
            try
            {
                int Comps = Convert.ToInt32(NoOFComputers.Text.Trim());
                String Ptype = processorType.Text.Trim();
                String Pspeed = Speed.Text.Trim();
                String RamCapacity = RAM.Text.Trim();
                String harddisk = HD.Text.Trim();
                Boolean error = false;

                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status = new Config().ObjNav().CreateCompDetails(applicationNo, Comps, Ptype, Pspeed, RamCapacity, harddisk);
                    String[] info = status.Split('*');
                    //try adding the line
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception n)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteStaff_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeletestaffLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deletetrainer_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeletetrainerLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteclass_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeleteclassLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteRefBook_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeleteRefBookLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteComp_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeleteCompLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deletecompdetails_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeleteCompDetailsLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteadditionaldetails_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeleteCompDetailsLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

      
     

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertComponentItems(List<QuestionsModel> cmpitems)
        {
            string tattachment = "", tqnCode = "", tAccreditationAnswer = "", tresponse = "", tapplicationNo="",tchildqn="",tchildresp="", tparentcode="";
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
                    tqnCode= oneitem.QuestionCode;                   
                    tresponse = oneitem.response;                  
                    tapplicationNo = oneitem.applicationNo;
                    tchildqn = oneitem.childquestionCode;
                    tparentcode = oneitem.subquestionCode;
                    tchildresp = oneitem.childResponse;
                    //check for nulls
                    //if (string.IsNullOrWhiteSpace(tqnCode.ToString()))
                    //{
                    //    results_0 = "jobcodenull";
                    //    return results_0;
                    //}

                    //if (string.IsNullOrWhiteSpace(tresponse))
                    //{
                    //    results_0 = "componentnull";
                    //    return results_0;
                    //}

                    if (string.IsNullOrWhiteSpace(tapplicationNo))
                    {
                        results_0 = "strengthnull";
                        return results_0;
                    }

                   


                    string status = new Config().ObjNav().CreatAccreditationResponce(tqnCode, tresponse, tapplicationNo);
                    
                    string[] info = status.Split('*');
                    results_0 = info[0];
                    if (tparentcode == tqnCode )
                    {
                        string results_1 = new Config().ObjNav().CreatAccreditationSubQResponce(tqnCode, tchildresp, tapplicationNo, tchildqn);
                    }
                  

                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            return results_0;
        }

        protected void deleteictdetails_Click(object sender, EventArgs e)
        {
            try
            {
                int tLineNo = 0;
                Boolean hasError = false;
                try
                {
                    tLineNo = Convert.ToInt32(lineNo.Text.Trim());
                }
                catch (Exception)
                {
                    hasError = true;
                }
                if (hasError)
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>We encountered an error while processing your request. Please try again later <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    // String employeeName = Convert.ToString(Session["employeeNo"]);
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().DeleteICTLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }




        private void paymentFile_Click()
        {
            try
            {
                string ApplicationNo = Request.QueryString["applicationNo"].Trim();
                bool fileuploadSuccess = false;
                string sUrl = ConfigurationManager.AppSettings["S_URL"];
                // string serverName = ConfigurationManager.AppSettings["S_URL"];
                string defaultlibraryname = "KASNEB%20ESS/";
                string customlibraryname = "Accreditation/AccreditationDocuments";
                string sharepointLibrary = defaultlibraryname + customlibraryname;
                String leaveNo = ApplicationNo;
                Boolean error = false;
                String message = "";
                string username = ConfigurationManager.AppSettings["S_USERNAME"];
                string password = ConfigurationManager.AppSettings["S_PWD"];
                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                bool bbConnected = Config.Connect(sUrl, username, password, domainname);
                try
                {
                    if (bbConnected)
                    {
                        Path.GetExtension(paymenId.FileName);
                        string extension = Path.GetExtension(paymenId.FileName);
                        string fileName0 = paymenId.FileName;
                        string ext0 = Path.GetExtension(paymenId.FileName);
                        if (extension == ".png" || extension == ".PNG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }
                        if (extension == ".jpeg" || extension == ".JPEG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }
                        if (extension == ".jplg" || extension == ".JPLG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }

                        if (error)
                        {
                            attach.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {

                            string savedF0 = leaveNo + "_" + fileName0;


                            Uri uri = new Uri(sUrl);
                            string sSpSiteRelativeUrl = uri.AbsolutePath;
                            string uploadfilename = leaveNo + "_" + fileName0;
                            Stream uploadfileContent = paymenId.FileContent;

                            var sDocName = UploadAccreditationDocuments(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                            string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                            if (!string.IsNullOrEmpty(sDocName))
                            {
                                var status = new Config().ObjNav().AddAccreditationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                string[] info = status.Split('*');
                                if (info[0] == "success")
                                {
                                    attach.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    attach.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            else
                            {
                                attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                    }
                    else
                    {
                        attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                catch (Exception ex)
                {
                    attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

   
        public void UploadDocuments_Click(object sender, EventArgs e)
        {

            try
            {
                string ApplicationNo = Request.QueryString["applicationNo"].Trim();
                bool fileuploadSuccess = false;
                string sUrl = ConfigurationManager.AppSettings["S_URL"];
                // string serverName = ConfigurationManager.AppSettings["S_URL"];
                string defaultlibraryname = "KASNEB%20ESS/";
                string customlibraryname = "Accreditation/AccreditationDocuments";
                string sharepointLibrary = defaultlibraryname + customlibraryname;
                String leaveNo = ApplicationNo;
                Boolean error = false;
                String message = "";
                string username = ConfigurationManager.AppSettings["S_USERNAME"];
                string password = ConfigurationManager.AppSettings["S_PWD"];
                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                bool bbConnected = Config.Connect(sUrl, username, password, domainname);
                try
                {
                    if (bbConnected)
                    {
                        Path.GetExtension(uploadfile.FileName);
                        string extension = Path.GetExtension(uploadfile.FileName);
                        string fileName0 = uploadfile.FileName;
                        string ext0 = Path.GetExtension(uploadfile.FileName);
                        if (extension == ".png" || extension == ".PNG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }
                        if (extension == ".jpeg" || extension == ".JPEG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }
                        if (extension == ".jplg" || extension == ".JPLG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }

                        if (error)
                        {
                            attach.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {

                            string savedF0 = leaveNo + "_" + fileName0;


                            Uri uri = new Uri(sUrl);
                            string sSpSiteRelativeUrl = uri.AbsolutePath;
                            string uploadfilename = leaveNo + "_" + fileName0;
                            Stream uploadfileContent = uploadfile.FileContent;

                            var sDocName = UploadAccreditationDocuments(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                            string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                            if (!string.IsNullOrEmpty(sDocName))
                            {
                                var status = new Config().ObjNav().AddAccreditationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                string[] info = status.Split('*');
                                if (info[0] == "success")
                                {
                                    attach.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    attach.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            else
                            {
                                attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                    }
                    else
                    {
                        attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                catch (Exception ex)
                {
                    attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public static string UploadAccreditationDocuments(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            // leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "Accreditation/AccreditationDocuments";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "KASNEB ESS";
                if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
                    CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

                if (Config.SPWeb != null)
                {
                    var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);

                    Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
                    Config.SPClientContext.ExecuteQuery();
                    sDocName = sFileName;
                }
            }

            catch (Exception)
            {
                sDocName = string.Empty;
            }
            return sDocName;
        }

        public static bool FolderExists(Web web, string listTitle, string folderUrl)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folders = list.GetItems(CamlQuery.CreateAllFoldersQuery());
            web.Context.Load(list.RootFolder);
            web.Context.Load(folders);
            web.Context.ExecuteQuery();
            var folderRelativeUrl = string.Format("{0}/{1}", list.RootFolder.ServerRelativeUrl, folderUrl);
            return Enumerable.Any(folders, folderItem => (string)folderItem["FileRef"] == folderRelativeUrl);
        }

        private static void CreateFolder(Web web, string listTitle, string folderName)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folderCreateInfo = new ListItemCreationInformation
            {
                UnderlyingObjectType = FileSystemObjectType.Folder,
                LeafName = folderName
            };
            var folderItem = list.AddItem(folderCreateInfo);
            folderItem.Update();
            web.Context.ExecuteQuery();
        }

        protected void nextSection_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("AccreditationSections.aspx?applicationNo=" + applicationNo);
        }
        protected void deleteFile_Click(object sender, EventArgs e)
        {

            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"KASNEB%20ESS/Accreditation/AccreditationDocuments/";
                    var leaveNo = Request.QueryString["applicationNo"];

                    foreach (char c in password)
                    { secret.AppendChar(c); }
                    try
                    {
                        ctx.Credentials = new NetworkCredential(account, secret, domainname);
                        ctx.Load(ctx.Web);
                        ctx.ExecuteQuery();

                        Uri uri = new Uri(sharepointUrl);
                        string sSpSiteRelativeUrl = uri.AbsolutePath;

                        string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileName.Text;

                        var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
                        ctx.Load(file, f => f.Exists);
                        file.DeleteObject();
                        ctx.ExecuteQuery();

                        if (!file.Exists)
                            throw new FileNotFoundException();
                        attach.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }



        }

        protected void payment_Click(object sender, EventArgs e)
        {
            try
            {
                string tReferenceNumber = bankslip.Text.Trim();
                string message = "";

                // ConfirmAccreditationPayment
                Boolean hasError = false;
                if (string.IsNullOrEmpty(tReferenceNumber))
                {
                    hasError = true;
                    message = "Select Education Level";
                }
             
                if (paymenId.HasFile)
                {

                    paymentFile_Click();
                }
                else
                {
                    hasError = true;
                    message = "Please attach  a payment evidence.";
                  
                }
                if (hasError)
                {
                    paymentDoc.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

                else
                {
                    
                    String applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().ConfirmAccreditationPayment(applicationNo, tReferenceNumber);
                    String[] info = status.Split('*');
                    paymentDoc.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                
                    
                }
            }
            catch (Exception t)
            {
                paymentDoc.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void uploaddeclaration_Click(object sender, EventArgs e)
        {
            try
            {
                string ApplicationNo = Request.QueryString["applicationNo"].Trim();
                bool fileuploadSuccess = false;
                string sUrl = ConfigurationManager.AppSettings["S_URL"];
                // string serverName = ConfigurationManager.AppSettings["S_URL"];
                string defaultlibraryname = "KASNEB%20ESS/";
                string customlibraryname = "Accreditation/Declaration";
                string sharepointLibrary = defaultlibraryname + customlibraryname;
                String leaveNo = ApplicationNo;
                Boolean error = false;
                String message = "";
                string username = ConfigurationManager.AppSettings["S_USERNAME"];
                string password = ConfigurationManager.AppSettings["S_PWD"];
                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                bool bbConnected = Config.Connect(sUrl, username, password, domainname);
                try
                {
                    if (bbConnected)
                    {
                        Path.GetExtension(declaration.FileName);
                        string extension = Path.GetExtension(declaration.FileName);
                        string fileName0 = declaration.FileName;
                        string ext0 = Path.GetExtension(declaration.FileName);
                        if (extension == ".png" || extension == ".PNG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }
                        if (extension == ".jpeg" || extension == ".JPEG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }
                        if (extension == ".jplg" || extension == ".JPLG")
                        {
                            error = true;
                            message = "Please attach a pdf document only";

                        }

                        if (error)
                        {
                            attach.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {

                            string savedF0 = leaveNo + "_" + fileName0;


                            Uri uri = new Uri(sUrl);
                            string sSpSiteRelativeUrl = uri.AbsolutePath;
                            string uploadfilename = leaveNo + "_" + fileName0;
                            Stream uploadfileContent = declaration.FileContent;

                            var sDocName = UploadDeclaration(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                            string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                            if (!string.IsNullOrEmpty(sDocName))
                            {
                                var status = new Config().ObjNav().AddAccreditationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                string[] info = status.Split('*');
                                if (info[0] == "success")
                                {
                                    attach.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    attach.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            else
                            {
                                attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                    }
                    else
                    {
                        attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                catch (Exception ex)
                {
                    attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        public static string UploadDeclaration(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            // leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "Accreditation/Declaration";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "KASNEB ESS";
                if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
                    CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

                if (Config.SPWeb != null)
                {
                    var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);

                    Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
                    Config.SPClientContext.ExecuteQuery();
                    sDocName = sFileName;
                }
            }

            catch (Exception)
            {
                sDocName = string.Empty;
            }
            return sDocName;
        }

        protected void deleteDeclarationForm_Click(object sender, EventArgs e)
        {
            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"KASNEB%20ESS/Accreditation/Declaration/";
                    var leaveNo = Request.QueryString["applicationNo"];

                    foreach (char c in password)
                    { secret.AppendChar(c); }
                    try
                    {
                        ctx.Credentials = new NetworkCredential(account, secret, domainname);
                        ctx.Load(ctx.Web);
                        ctx.ExecuteQuery();

                        Uri uri = new Uri(sharepointUrl);
                        string sSpSiteRelativeUrl = uri.AbsolutePath;

                        string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileNames.Text;

                        var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
                        ctx.Load(file, f => f.Exists);
                        file.DeleteObject();
                        ctx.ExecuteQuery();

                        if (!file.Exists)
                            throw new FileNotFoundException();
                        attach.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }
        }

        protected void paymentmode_SelectedIndexChanged(object sender, EventArgs e)
        {
            modeofpayment.Visible = false;
            mpesaPayment.Visible = false;

            switch (paymentmode.SelectedValue)
            {
                case  "1":
                    modeofpayment.Visible = true;
                    break;
                case  "2":
                    modeofpayment.Visible = true;
                    break;
                case "3":
                    mpesaPayment.Visible = true;
                    break;

            }

        }
        protected void SubmitPayment_Click(object sender, EventArgs e)
        {
            var response = "";
            try
            {
                using (var client = new WebClient())
                {

                    EnableTrustedHosts();

                    client.Headers.Add("Content-Type", "application/json");

                    string tphoneNumber = PhoneNumberPay.Text.Trim();
                    decimal tAmount = Convert.ToDecimal(Amount.Text.Trim());
                    String applicationNo = Request.QueryString["applicationNo"];
                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tphoneNumber))
                    {
                        error = true;
                        message = "Please enter Phone Number used to pay";
                    }

                    string _mobileNumber = CleanNumber(tphoneNumber);

                    // trim any leading zeros
                    _mobileNumber = _mobileNumber.TrimStart(new char[] { '0' });


                    // add country code if they haven't entered it
                    //If we need to handle with multiple Country codes we have to place a list here,Currently added +64 as per document.
                    if (!_mobileNumber.StartsWith("254"))
                    {
                        _mobileNumber = "254" + _mobileNumber;
                    }
                    if (_mobileNumber.Length != 10)
                    {
                        error = true;
                        message = "Please enter A valid Phone Number Number";


                    }

                    if (error)
                    {
                        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                   
                    //var nav = Config.ReturnNav();

                    //var detailz = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == applicationNo).ToList();
                    //if (detailz.Count > 0)
                    //{

                    //    response = ("You have already paid for the Registartion. please wait for the processing of your application.");
                    //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        
                    //}

                    else
                    {
                        var vm = new { accountnumber = applicationNo, transactionreference = applicationNo, amount = tAmount, transactiondescription = "Paybill Deposit", businessnumber = "204777", Telephone = _mobileNumber };



                        var dataString = JsonConvert.SerializeObject(vm);

                        try
                        {
                            string result = "";
                            result = client.UploadString("https://mobile.kasneb.or.ke:8222/api/stkpush", "POST", dataString);



                            Stkresult details = null;

                            details = JsonConvert.DeserializeObject<Stkresult>(result.ToString());

                            if (details.ResponseCode == "0")
                            {

                                response = (details.ResponseDescription + "." + " " + "You have initiated payment using MPESA. Please enter your MPESA PIN when prompted");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                                //string responses = new Config().ObjNav().FnConfirmPayments(applicationNo);
                                ////string response = "";

                                //String[] info = responses.Split('*');
                                //if (info[0] == "success")
                                //{

                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                                //    // Response.Redirect("Dashboard.aspx");

                                //}
                                //else
                                //{
                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //}


                            }
                            else
                            {
                                response = (details.ResponseDescription + "." + "" + "Please Use the Manual Mpesa Payment Process");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                        }
                        catch (Exception ex)
                        {
                            response = ex.Message;
                            PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                }


            }
            catch (Exception ex)
            {
                response = ex.Message;
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }


        }
        public static void EnableTrustedHosts()
        {
            System.Net.ServicePointManager.ServerCertificateValidationCallback =
                 ((sender, certificate, chain, sslPolicyErrors) => true);
        }
        public partial class Stkresult
        {
            public string MerchantRequestID { get; set; }
            public string CheckoutRequestID { get; set; }
            public string ResponseCode { get; set; }
            public string ResponseDescription { get; set; }
            public string CustomerMessage { get; set; }
        }

        public string CleanNumber(string phone)
        {
            Regex digitsOnly = new Regex(@"[^\d]");
            return digitsOnly.Replace(phone, "");
        }
    }
    }
    