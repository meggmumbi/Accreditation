<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="ApplicationReport.aspx.cs" Inherits="kasnebAccreditation.ApplicationReport" %>
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <ol class="breadcrumb">
        <li><a href="CompletedAccreditationApplication.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
        <li class="active">Report</li>
    </ol>
     <div class="row" style="width: 100%; margin: auto;">
    <div class="panel panel-primary">
        
            <div class="panel-heading"> <i class="icon-file"></i>
              Accreditation Report
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div id="feedback" runat="server"></div>
             <div class="com-md-4 col-lg-4">
                 <label><% =Session["UniversityName"] %></label>
                
             </div>
                <label>University No</label>
                <asp:TextBox ID="score" runat="server" CssClass="form-control" ReadOnly></asp:TextBox>
                 
               
                <div class="form-group">
                 <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" ID="p9form" style="margin-top: 10px;" ></iframe>
                    </div>
                </div>
               
            
         
          </div>
        </div>
    <div class="clearfix"></div>
     <script>
            
       
            $(document).ready(function () {
               

            });
        </script>

</asp:Content>
