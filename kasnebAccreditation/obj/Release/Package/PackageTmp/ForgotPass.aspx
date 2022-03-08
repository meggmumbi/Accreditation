<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPass.aspx.cs" Inherits="kasnebAccreditation.ForgotPass" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - kasneb</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <link href="images/logo.png" rel="shortcut icon" type="image/x-icon" />
   <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css"/>
    <!-- Bootstrap Core CSS -->
    <link href="../vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    

    <!-- MetisMenu CSS -->
    <link href="../vendor/metisMenu/metisMenu.min.css" rel="stylesheet"/>

    <!-- Custom CSS -->
    <link href="../dist/css/sb-admin-2.css" rel="stylesheet"/>

    <script type="text/javascript" src="js/jquery-1.8.2.js"></script> 
    <!-- Morris Charts CSS -->
    <link href="../vendor/morrisjs/morris.css" rel="stylesheet"/>

    <script src="js/http_ajax.googleapis.com_ajax_libs_jquery_3.2.1_jquery.min.js"></script>
    <!-- Custom Fonts -->
    <link href="../vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <form id="form1" runat="server">
        <div class="row" style="width: 100%; display: block; margin: auto;">
            <div class="panel col-md-10 col-lg-10 col-sm-10 col-xs-12 col-md-offset-1 col-lg-offset-1 col-sm-offset-1" style="margin-top: 20px; border: 1px solid #d0dada; border-radius: 4px; padding-top: 5px; padding-bottom: 10px;">
              <div class="row" style="width: 100%; margin: 5px;">
                    <div>
                      <img src="images/kasneb.jpeg" width="100%" height="100%" />
                        <h3 style="width: 100%; text-align: center;">kasneb</h3>
                        <hr />
                    </div>
                        <div class="panel panel-default">
                             <div class="overlay" id="overlay"></div>
                            <div class="panel-heading">Please Fill in all the Details to Reset your  Account Password</div>
                            <div class="panel-body">
                                <div class="panel">
                                    <div id="feedbacks" runat="server"></div>
                                    <div style="padding: 20px;"> 
                                         <div id="feedback" style="display: none"></div>
                                         <div class="row">
                                            <div class="col-md-6 col-lg-6">
                                                <div class="form-group">
                                                    <label>Email Address(Official Email Address)</label>
                                                    <input type="email" class="form-control" id="emailid" placeholder="xxxxxx@kasneb.or.ke" />
<%--                                                    <asp:TextBox CssClass="form-control" runat="server" ID="emailaddress" Placeholder="Email Address" type="text"  required  Style="height: 42px;" />--%>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="field">
                                            Prove that you are not a robot <sup>*</sup>
                                            <div class="g-recaptcha" data-sitekey="6Ld4LScUAAAAADuGShD198FZNCL8FSzwqw8arOSC" style="display: block; margin: auto;"></div>
                                        </div>  --%>    

                                    </div>
                                        <a href="Login.aspx" class="pull-right">Back to Login</a>
                                    </div>
                                    </div>
                                    </div>
                                  </div>
                                    <div style="background-color: #ececec; padding: 30px;">
                                           <input type="button" id="btn_password_resetrequest" class="btn btn-success btn-block btn_password_resetrequest"  value="Reset Password" style="padding: 10px 39px;"/>
                                        <%--<asp:Button runat="server" CssClass="btn btn-success btn-block btn_js_passc" ID="resetpassword" Text="Reset Password" Style="border-radius: 2px; font-size: 17px; line-height: 1.471; padding: 10px 19px;" />--%>
                                    </div>
                               <div class="col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                             Copyright  &copy; <%: DateTime.Now.Year %>  Terms and Conditions Apply | <a href="https://kasneb.or.ke/">kasneb</a> 
                                </div>
                                </div>
                             
                             </div>
                           <div>
                        </div>
                  </form>
      <script type="text/javascript" src="js/CustomJs.js"></script>
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css"/>
      <script src="js/http_unpkg.com_sweetalert_dist_sweetalert.min.js"></script>
    <script src="https://www.google.com/recaptcha/api.js"></script>
    </body>

</html>

