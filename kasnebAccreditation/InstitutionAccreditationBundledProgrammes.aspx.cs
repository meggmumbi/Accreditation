using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class InstitutionAccreditationBundledProgrammes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var nav = Config.ReturnNav();
            var categores = nav.postcodes;
            item.DataSource = categores;
            item.DataTextField = "Code";
            item.DataValueField = "Code";
            item.DataBind();

            var countrys = nav.countries;
            country.DataSource = countrys;
            country.DataTextField = "Name";
            country.DataValueField = "Code";
            country.DataBind();

            var counties = nav.countys;
            county.DataSource = counties;
            county.DataTextField = "Description";
            county.DataValueField = "Code";
            county.DataBind();



        }

        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
                var tItemCategory = Convert.ToInt32(itemCategory.SelectedValue.Trim());
                String tname = String.IsNullOrEmpty(item.Text.Trim()) ? "" : TextBox1.Text.Trim();
                String tcity = String.IsNullOrEmpty(City.Text.Trim()) ? "" : City.Text.Trim();
                String tcounty = String.IsNullOrEmpty(county.SelectedValue.Trim()) ? "" : county.SelectedValue.Trim(); 
                string tcountry = String.IsNullOrEmpty(country.SelectedValue.Trim()) ? "" : country.SelectedValue.Trim();
                string tphone = String.IsNullOrEmpty(phone.Text.Trim()) ? "" : phone.Text.Trim();
                string temail = String.IsNullOrEmpty(email.Text.Trim()) ? "" : email.Text.Trim();
                String tpostCode = String.IsNullOrEmpty(item.SelectedValue.Trim()) ? "" : item.SelectedValue.Trim();
                String taddress = String.IsNullOrEmpty(address.Text.Trim()) ? "" : address.Text.Trim();
                String tcontact = String.IsNullOrEmpty(contact.Text.Trim()) ? "" : contact.Text.Trim();

                Boolean error = false;
            

                if (!error)
                {
                    String applicationNo = Request.QueryString["applicationNo"];
                    // Convert.ToString(Session["employeeNo"]),
                    //Nav Funtion

                    String status =new  Config().ObjNav().CreateCampus(tname, tcity, tpostCode, taddress, tcontact, tItemCategory,applicationNo, tcountry, tphone,tcounty,temail);
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

        protected void previous_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Institution.aspx?step=1&&applicationNo=" + applicationNo);
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {

            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("AccreditationSections.aspx?applicationNo=" + applicationNo);
        }

        protected void item_SelectedIndexChanged(object sender, EventArgs e)
        {
            UpdateCity();
        }

        public void UpdateCity()
        {
            var nav = Config.ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == item.SelectedValue);
            foreach (var myCity in cities)
            {
                City.Text = myCity.City;
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
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
                    String status =  new Config().ObjNav().DeleteCampusLine(applicationNo, tLineNo);
                    String[] info = status.Split('*');
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception t)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
    }
}