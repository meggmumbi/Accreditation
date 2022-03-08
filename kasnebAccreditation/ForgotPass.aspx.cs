using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace kasnebAccreditation
{
    public partial class ForgotPass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string Resetpassword(string temailaddress)
        {
            var results = (dynamic)null;


            try
            {

                string status = new Config().ObjNav().PortalResetPassword(temailaddress);
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

        // static bool IsValidCaptcha()
        //   {
        //    try
        //      {
        //        string resp = HttpContext.Current.Request["g-recaptcha-response"];
        //        var req = (HttpWebRequest)WebRequest.Create
        //            ("https://www.google.com/recaptcha/api/siteverify?secret=6Le1TaMZAAAAAL3GhqUzDC6ERYPjyxLpAMrh4qyQ=" +
        //             resp);
        //        using (WebResponse wResponse = req.GetResponse())
        //        {
        //            using (StreamReader readStream = new StreamReader(wResponse.GetResponseStream()))
        //            {
        //                string jsonResponse = readStream.ReadToEnd();
        //                JavaScriptSerializer js = new JavaScriptSerializer();
        //                // Deserialize Json
        //                CaptchaResult data = js.Deserialize<CaptchaResult>(jsonResponse);
        //                if (Convert.ToBoolean(data.success))
        //                {
        //                    return true;
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception)
        //    {

        //    }
        //    return false;
        //}

    }
}