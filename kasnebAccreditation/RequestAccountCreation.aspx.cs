using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class RequestAccountCreation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

           

                var nav = Config.ReturnNav();
                var countr = nav.countries;
                country.DataSource = countr;
                country.DataValueField = "Code";
                country.DataTextField = "Name";
                country.DataBind();
                country.Items.Insert(0, new ListItem("--select--", ""));

                var postCodes = nav.postcodes;
                postcode.DataSource = postCodes;
                postcode.DataValueField = "Code";
                postcode.DataTextField = "Code";
                postcode.DataBind();
                postcode.Items.Insert(0, new ListItem("--select--", ""));

                var applicationType = nav.applicationTypes;
                ApplicationTypes.DataSource = applicationType;
                ApplicationTypes.DataValueField = "Code";
                ApplicationTypes.DataTextField = "Description";
                ApplicationTypes.DataBind();
                ApplicationTypes.Items.Insert(0, new ListItem("--select--", ""));


                var InstitutionTypess = nav.institutionTypes;
                institutiontype.DataSource = InstitutionTypess;
                institutiontype.DataValueField = "Code";
                institutiontype.DataTextField = "Description";
                institutiontype.DataBind();
                institutiontype.Items.Insert(0, new ListItem("--select--", ""));

                var counties = nav.counties;
                county.DataSource = counties;
                county.DataTextField = "Description";
                county.DataValueField = "Code";
                county.DataBind();
                county.Items.Insert(0, new ListItem("--select--", ""));









            }
        }
        
        protected void postCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateCity();
        }

        public void UpdateCity()
        {
            var nav = Config.ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postcode.SelectedValue);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
            }
        }
        //[System.Web.Services.WebMethod(EnableSession = true)]
        //public static string RequesttoCreateAccount(int tinsttype, string taddnumber, string tfirstname, string tmiddlname, string tlastname, string tphonenumber, string temailaddress, string taddress, string tpostcode, string tcity, string tcountry, string tuniversityname)
        //{
        //    var results = (dynamic)null;
        //    try
        //    {
        //        var validateUniversityName = "";

        //        validateUniversityName = tuniversityname;
        //        var validatetemailaddress = temailaddress.Trim();
        //        string[] EmailContents = validatetemailaddress.Split('@');
        //        string Useremaildomain = EmailContents[1];
        //        var nav = Config.ReturnNav();
               
                
                
        //        tuniversityname = "";
        //        // txtproposedname.Text.Trim();
        //        var addr = new System.Net.Mail.MailAddress(temailaddress);
        //        string status = new Config().ObjNav().Fnuseraccountcreation(taddnumber, tfirstname, tmiddlname, tlastname, tphonenumber, temailaddress, taddress, tpostcode, tcity, tcountry, tuniversityname);
        //        string[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            results = info[0];
        //        }
        //        else
        //        {
        //            results = info[1];
        //        }


        //    }
        //    catch (Exception ex)
        //    {
        //        results = ex.Message;
        //    }
        //    return results;
        //}

        protected void btn_accountcreation_Click(object sender, EventArgs e)
        {
            //var no = idnumber.Text.Trim();
            //var firstName = firstname.Text.Trim();
            //var MiddleName = middlname.Text.Trim();
            //var LasName = lastname.Text.Trim();
            //var phone = phonenumber.Text.Trim();
            //var UniversityName = universityname.SelectedValue.Trim();
            //var Address = address.Text.Trim();
            //var PostCode = postcode.SelectedValue.Trim();
            //var City = city.Text.Trim();
            //var Country = country.SelectedValue.Trim();
            //var email = emailaddress.Text.Trim();

            //var results = "";
            //try
            //{


            //    var nav = Config.ReturnNav();

            //    string status = new Config().ObjNav().Fnuseraccountcreation(no, firstName, MiddleName, LasName, phone, email, Address, PostCode, City, Country, UniversityName);
            //    string[] info = status.Split('*');
            //    if (info[0] == "success")
            //    {
            //        results = info[0];

            //    }
            //    else
            //    {
            //        results = info[1];
            //    }


            //}
            //catch (Exception ex)
            //{
            //    results = ex.Message;
            //}

           
        }


       

        protected void register_Click1(object sender, EventArgs e)
        {
            addUser();

        }

        void addUser()
        {
            Boolean error = false;
            string message = "";
          
            var firstName = firstname.Text.Trim();
            var MiddleName = middlname.Text.Trim();
            var LasName = lastname.Text.Trim();
            var phone = phonenumber.Text.Trim();
            var UniversityName = versityName.Text.Trim();
            var Address = address.Text.Trim();
            var PostCode = postcode.SelectedValue.Trim();
            var City = city.Text.Trim();
            var Country = country.SelectedValue.Trim();
            var email = emailaddress.Text.Trim();
            var tapplicationtype = ApplicationTypes.SelectedValue.Trim();
            var tinstitutionType = institutiontype.SelectedValue.Trim();
            var tcounty = county.SelectedValue.Trim();
            var taddress2 = address2.Text.Trim();

            if (string.IsNullOrEmpty(Convert.ToString(firstName)))
            {
                error = true;
                message = "Please input your name";

            }
            if (string.IsNullOrEmpty(Convert.ToString(LasName)))
            {
                error = true;
                message = "Please input your name";

            }
            if (string.IsNullOrEmpty(Convert.ToString(UniversityName)))
            {
                error = true;
                message = "Please input the name of the institution";

            }
            if (string.IsNullOrEmpty(Convert.ToString(Address)))
            {
                error = true;
                message = "Please input the address of the univesrity";

            }
            if (string.IsNullOrEmpty(Convert.ToString(tinstitutionType)))
            {
                error = true;
                message = "Select the institution type";

            }
            if (string.IsNullOrEmpty(Convert.ToString(tapplicationtype)))
            {
                error = true;
                message = "Select the application Type";

            }
            if (string.IsNullOrEmpty(Convert.ToString(email)))
            {
                error = true;
                message = "Please input the official address of the institution";

            }
            if (string.IsNullOrEmpty(Convert.ToString(Country)))
            {
                error = true;
                message = "Select hte country of the institution";

            }
            if (string.IsNullOrEmpty(Convert.ToString(PostCode)))
            {
                error = true;
                message = "Select the country institution";

            }
            
            if (string.IsNullOrEmpty(Convert.ToString(phone)))
            {
                error = true;
                message = "Please enter the phone number";

            }
       





            if (error == true)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'> '" + message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
            else
            {
                try
                {


                    string status = new Config().ObjNav().Fnuseraccountcreation("",firstName, MiddleName, LasName, phone, email, Address, PostCode, City, Country, UniversityName,tapplicationtype,tinstitutionType,tcounty,taddress2);

                    string[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                      //  ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "success();", true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "success();", true);
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Login.aspx') }, 5000);", true);
                        //  Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }



                }
                catch (Exception ex)
                {

                    generalFeedback.InnerHtml = "<div class='alert alert-danger'> '" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }



            }

        }

        protected void login_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }
    }
}
