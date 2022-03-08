<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="InstitutionsDraftApplications.aspx.cs" Inherits="kasnebAccreditation.InstitutionsDraftApplications" %>


  

   <%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                  <div class="panel panel-default">
            <div class="panel-heading">Unsubmitted Applications</div>
   
                <div class="panel-body">
                    <div id ="feedback" runat="server"></div>
                    <table class="table table-bordered table-striped dataTable" id="example1">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Acccreditation No</th>
                     <th>Institution Name</th>
                    <th>Institution Type</th>
                    <th>Application Type</th>                   
                    <th>Email Address</th>
                    
                   
                    <th>Complete</th>
                </tr>
                </thead>
                <tbody>
                <%
                     var nav = Config.ReturnNav();
                    string university = Convert.ToString(Session["UniversityCode"]);
                   
                    var details = nav.applicationAccreditation.Where(r => r.No == university && r.Status=="Open" && r.Submitted==false);
                    
                    int programesCounter = 0;
                    foreach (var detail in details)
                    {
                        programesCounter++;
                     %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Application_No %></td>
                         <td><%=detail.Name %></td>
                        <td><%=detail.Institution_Type %></td>
                        <td><%=detail.Application_Type_Name %></td>
                        <td><%=detail.Email%></td>
                       
                        
                        <td><a href="Institution.aspx" class="btn btn-success"><i class="fa fa-eye"></i>Complete</a></td>
                    </tr>
                    <%  
                   } 
                        
                        %>
                </tbody>
                </table>  
                </div>   
                </div>
            </div>
       
            </div>
        
        </div>
 


</asp:Content>
