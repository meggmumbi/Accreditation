<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="CompletedAccreditationApplication.aspx.cs" Inherits="kasnebAccreditation.CompletedAccreditationApplication" %>
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section>
            <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Data Table With Full Features</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="panel-body">
                            <div id="feedback" runat="server"></div>
                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Acccreditation No</th>
                                        <th>No</th>
                                        <th>Institution Name</th>
                                        <th>Address</th>
                                        <th>Contact</th>
                                        <th>Report</th>



                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                     var nav = Config.ReturnNav();
                    string university = Convert.ToString(Session["UniversityCode"]);
                   
                    var details = nav.applicationAccreditation.Where(r =>r.No == university && r.Status=="Awaiting Payment Processing");
                    
                    int programesCounter = 0;
                    foreach (var detail in details)
                    {
                        programesCounter++;
                                    %>
                                    <tr>
                                        <td><%=programesCounter %></td>
                                        <td><%=detail.Application_No %></td>
                                        <td><%=detail.No %></td>
                                        <td><%=detail.Name %></td>
                                        <td><%=detail.Address %></td>
                                        <td><%=detail.Contact %></td>
                                         <td><a href="ApplicationReport.aspx?code=<%=detail.No%>&&applicationNo=<%=detail.Application_No %>" class="btn btn-success">Detailed Report</a></td>


                                    </tr>
                                    <%  
                   } 
                        
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
       
    </section>

</asp:Content>
