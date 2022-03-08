<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="selfevaluationApplications.aspx.cs" Inherits="kasnebAccreditation.selfevaluationApplications" %>
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="content">
        
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">Self Evaluation Applications</h3>
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">

                        <div class="panel-body">
                            <div id="feedback" runat="server"></div>
                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>No</th>
                                        <th>Application No</th>
                                        <th>Max Score score</th>
                                        <th>Verdict</th>
                                        <th>Document Type</th>
                                        <th>Detailed Report</th>
                                        <th>Summery score report</th>



                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        var nav = Config.ReturnNav();
                                        string university = Convert.ToString(Session["UniversityCode"]);

                                        var details = nav.EvaluationApplications.Where(r => r.Insitution_Code == university && r.Type == "Self-Evaluation");

                                        int programesCounter = 0;
                                        foreach (var detail in details)
                                        {
                                            programesCounter++;
                                    %>
                                    <tr>
                                        <td><%=programesCounter %></td>
                                        <td><%=detail.Code %></td>
                                        <td><%=detail.Application_No %></td>
                                        <td><%=detail.Maximum_Aggregate_Score %></td>
                                        <td><%=detail.Verdict_Description %></td>
                                        <td><%=detail.Document_Type %></td>
                                        <td><a href="detailedReport.aspx?applicationNo=<%=detail.Code%>" class="btn btn-success">Detailed Report</a></td>
                                        <td><a href="summeryScore.aspx?applicationNo=<%=detail.Code%>" class="btn btn-success">Summery score Report</a></td>



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
