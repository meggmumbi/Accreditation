using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {



        }
        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                string mUsername = username.Text.Trim();
                string mPassword = password.Text.Trim();
                bool error = false;
                if (mUsername.Length < 1)
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please Email address cannot be Empty</div>";
                }
                if (mPassword.Length < 4)
                {
                    error = true;
                    feedback.InnerHtml = "<div class='alert alert-danger'>Please input a Correct Password to Access the System</div>";
                }
                if (!error)
                {
                    bool exists = false;
                    bool accountactivated = false;
                    var nav = Config.ReturnNav();
                    var users = nav.universityUsers.Where(r => r.Authentication_Email == mUsername && r.Password_Value == mPassword && r.State == "Enabled" && r.UniversityCode != "");
                    //var users = nav.portalusers.Where(r => r.Email == mUsername && r.Password == mPassword);

                    foreach (var user in users)
                    {
                        if (user.Change_Password == true)
                        {
                            exists = true;
                            accountactivated = true;
                            Session["Name"] = user.User_Name;
                            Session["EmailAddress"] = user.Authentication_Email;
                            Session["phoneNumber"] = user.Mobile_Phone_No;
                            Session["Code"] = user.Entry_No;
                            Session["Password"] = user.Password_Value;
                            Session["type"] = "old";
                            Session["UniversityCode"] = user.UniversityCode;
                            Session["UniversityName"] = user.University_Name;
                            Session["address"] = user.Address;



                            Response.Redirect("Accreditation.aspx");
                        }
                        else
                        {

                            exists = true;
                            accountactivated = true;
                            Session["Name"] = user.User_Name;
                            Session["EmailAddress"] = user.Authentication_Email;
                            Session["phoneNumber"] = user.Mobile_Phone_No;
                            Session["Code"] = user.Entry_No;
                            Session["Password"] = user.Password_Value;
                            Session["type"] = "old";
                            Session["UniversityCode"] = user.UniversityCode;
                            Session["UniversityName"] = user.University_Name;
                            Session["address"] = user.Address;


                            Response.Redirect("ChangePassword.aspx");
                        }
                    }
                    if (!exists)
                    {
                            // var users3 = nav.portalusers.Where(r => r.Email == mUsername && r.Password == mPassword);
                            var users3 = nav.universityUsers.Where(r => r.Authentication_Email == mUsername && r.Password_Value == mPassword && r.State == "Disabled" && r.UniversityCode != "");
                            foreach (var user in users3)
                            {
                                feedback.InnerHtml = "<div class='alert alert-danger'>The Training Institution with the given Credentials was Deactivated.</div>";

                            }
                        }
                        if (!exists && !accountactivated)
                        {
                            feedback.InnerHtml = "<div class='alert alert-danger'>The Training Institution with the given Credentials does not exist.Kindly Fill in all the details in the Account Request form to Request for your Account Creation</div>";
                        }
                    }

                }
            catch (Exception ex)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>We experienced an error while Login you in. Kindly try again Later.</div>";

            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string login(string temail)
        {
            var results = (dynamic)null;

            try
            {
                var nav = new Config().ObjNav();
                var status = nav.FnResetPassword(temail);
                var info = status.Split('*');
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
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string ChangePassword(string temailAddres, string tOldPassword, string tNewPassword, string tconfirmNewPassword)
        {
            var results = (dynamic)null;
            try
            {
                var nav = new Config().ObjNav();
                var status = nav.FnChangeStudentPassword(temailAddres, tOldPassword, tNewPassword, tconfirmNewPassword);
                var info = status.Split('*');
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