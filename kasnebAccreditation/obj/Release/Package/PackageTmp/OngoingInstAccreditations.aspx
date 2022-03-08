
<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="OngoingInstAccreditations.aspx.cs" Inherits="kasnebAccreditation.OngoingInstAccreditations" %>

<%@ Import Namespace="kasnebAccreditation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <%
       string status = "";
       var nav = Config.ReturnNav();
       string university = Convert.ToString(Session["UniversityCode"]);
       var awaitingP = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Payment Processing").ToList();
       var Cmpleteness = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Completeness Checks").ToList();
       var peerReview = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Peer Review").ToList();
       var boardApp = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Board Approval").ToList();
       var completed = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Completed").ToList();

       //if (awaitingP.Count > 0)
       //{
       //    status = "active";
       //}
       //else if (Cmpleteness.Count > 0)
       //{
       //    status = "active";
       //}
       //else if (peerReview.Count > 0)
       //{
       //    status = "active";
       //}
       //else if (boardApp.Count > 0)
       //{
       //    status = "active";
       //}
       //else if (completed.Count > 0)
       //{
       //  status = "active";
       //}

        %>
            <div class="panel panel-primary">
                <div class="panel-heading"><strong>Training Institution Accreditation Progress</strong> </div>
                <div class="board">
                    <div class="board-inner">
                        <ul class="nav nav-tabs" id="myTab">
                            <div class="liner"></div>
                            <%if (awaitingP.Count > 0)
                                {
                                    status = "active"; }
                                else {
                                    status = "";
                                }
                                     %>
                            <li class="<%=status%>">
                                <a href="#home" data-toggle="tab" title="Step 1">

                                    <span class="round-tabs one">
                                        <i class="fa fa-home"></i>
                                        <strong>Stage1:</strong>
                                    </span>
                                </a></li>
                          <%
                              if (Cmpleteness.Count > 0) {
                                  status = "active";
                              }
                              else {
                                  status = "";
                              }
                                     %>
                            <li class="<%=status%>"><a href="#profile" data-toggle="tab" title="Step 2">
                                <span class="round-tabs two">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage2:</strong>
                                </span>
                            </a>
                            </li>
                        <%  if (peerReview.Count > 0)
                            { 
                             status = "active";
                              }
                              else {
                                  status = "";
                              }
                                     %>

                            <li class="<%=status%>"><a href="#messages" data-toggle="tab" title="Step 3">
                                <span class="round-tabs three">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage3:</strong>
                                </span></a>
                            </li>
                            <%

                                 if (boardApp.Count > 0)
                                {
                                     status = "active";
                              }
                              else {
                                  status = "";
                              }
                            %>


                            <li class="<%=status%>"><a href="#settings" data-toggle="tab" title="Step 4">
                                <span class="round-tabs four">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage4:</strong>
                                </span>
                            </a></li>
                            <% if (completed.Count > 0)
                            {
                                  status = "active";
                              }
                              else {
                                  status = "";
                              }   
                                    %>

                            <li class="<%=status%>"><a href="#doner" data-toggle="tab" title="completed">
                                <span class="round-tabs five">
                                    <i class="fa fa-chevron-right"></i>
                                    <strong>Stage5:</strong>
                                </span></a>
                            </li>
                          
                        </ul>

                    </div>
                    <div class="tab-content">
                         <%if (awaitingP.Count > 0)
                                {
                                    status = "active"; }
                                else {
                                    status = "";
                                }
                                     %>
                         <div class="tab-pane fade in <%=status %>" id="home">
                            <div>
                                <div class="container">
                                    <h2>Accreditation Progress</h2>
                                    <p>Current Institution Accreditation Awaiting Payments</p>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">
                                            20%
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><strong>Accreditations Awaiting Finance Processing</strong> </div>
                                            <div class="panel-body">
                                                <div id="Div1" runat="server"></div>
                                                <table class="table table-bordered table-striped dataTable table-hover" id="example4">
                                                    <thead>
                                                        <tr>
                                                            <th>Accreditation No:</th>
                                                            <th>Institution Name</th>
                                                            <th>Institution type</th>
                                                            <th>Application type name</th>
                                                            <th>Status</th>
                                                           <%-- <th>Confirm Payment</th>--%>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav2 = Config.ReturnNav();
                                                           
                                                            var programs2 = nav2.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Payment Processing");
                                                            foreach (var program2 in programs2)
                                                            {
                                                        %>
                                                        <tr>
                                                            <td><%=program2.Application_No %></td>
                                                            <td><%=program2.Name %></td>
                                                            <td><%=program2.Institution_Type %></td>
                                                            <td><%=program2.Application_Type_Name %></td>
                                                            <td><%=program2.Status %></td>
                                                          <%--  <td><label class="btn btn-success" onclick="makePayments('<%=program2.Application_No %>', '<%=program2.Name %>')"><i class="fa fa-edit"></i>Make Payment</label></td>--%>


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
                        </div>
                         <%
                              if (Cmpleteness.Count > 0) {
                                  status = "active";
                              }
                              else {
                                  status = "";
                              }
                                     %>
                        <div class="tab-pane fade  in <%=status %> " id="profile">
                            <div>
                                <div class="container">
                                    <h2>Accreditation Progress</h2>
                                    <p>Current Institution Accreditation Awaiting Completeness Check</p>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                            40%
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><strong>Accreditations Awaiting Completeness Check</strong> </div>
                                            <div class="panel-body">
                                                <table class="table table-bordered table-striped table-hover" id="example5">
                                                    <thead>
                                                        <tr>
                                                           <th>Accreditation No:</th>
                                                            <th>Institution Name</th>
                                                            <th>Institution type</th>
                                                            <th>Application type name</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            
                                                            string univ = Convert.ToString(Session["UniversityCode"]);
                                                            var programs = nav.applicationAccreditation.Where(r => r.No == univ && r.Status == "Awaiting Completeness Checks");
                                                            foreach (var program in programs)
                                                            {
                                                        %>
                                                        <tr>
                                                            <td><%=program.Application_No %></td>
                                                            <td><%=program.Name %></td>
                                                            <td><%=program.Institution_Type %></td>
                                                            <td><%=program.Application_Type_Name %></td>
                                                            <td><%=program.Status %></td>
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
                        </div>
                          <%  if (peerReview.Count > 0)
                            { 
                             status = "active";
                              }
                              else {
                                  status = "";
                              }
                                     %>
                       
                        <div class="tab-pane fade in <%=status %>" id="messages">
                            <div>
                                <div class="container">
                                    <h2>Accreditation Progress</h2>
                                    <p>Current Institution Accreditation Awaiting Assessment Review</p>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                            60%
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><strong>Accreditations Awaiting Assessment Review</strong> </div>
                                            <div class="panel-body">
                                                <div id="Div2" runat="server"></div>
                                                <table class="table table-bordered table-striped table-hover" id="example6">
                                                    <thead>
                                                        <tr>
                                                           <th>Accreditation No:</th>
                                                            <th>Institution Name</th>
                                                            <th>Institution type</th>
                                                            <th>Application type name</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav3 = Config.ReturnNav();
                                                             string institution = Convert.ToString(Session["UniversityCode"]);
                                                            var programs3 = nav3.applicationAccreditation.Where(r => r.No == institution && r.Status == "Awaiting Peer Review");
                                                            foreach (var program3 in programs3)
                                                            {
                                                        %>
                                                        <tr>
                                                            <td><%=program3.Application_No %></td>
                                                            <td><%=program3.Name %></td>
                                                            <td><%=program3.Institution_Type %></td>
                                                            <td><%=program3.Application_Type_Name %></td>
                                                            <td><%=program3.Status %></td>
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
                        </div>
                         <%

                                 if (boardApp.Count > 0)
                                {
                                     status = "active";
                              }
                              else {
                                  status = "";
                              }
                            %>

                        <div class="tab-pane fade in <%=status %>" id="settings">
                            <div>
                                <div class="container">
                                    <h2>Accreditation Progress</h2>
                                    <p>Current Institution Accreditation Awaiting Board Approval</p>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                                            80%
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><strong>Accreditations Awaiting Board Approval</strong> </div>
                                            <div class="panel-body">
                                                <div id="Div3" runat="server"></div>
                                                <table class="table table-bordered table-striped table-hover" id="example7">
                                                    <thead>
                                                        <tr>
                                                           <th>Accreditation No:</th>
                                                            <th>Institution Name</th>
                                                            <th>Institution type</th>
                                                            <th>Application type name</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav4 = Config.ReturnNav();
                                                            string approval = Convert.ToString(Session["UniversityCode"]);
                                                            var programs4 = nav.applicationAccreditation.Where(r => r.No == approval && r.Status == "Awaiting Board Approval");
                                                            foreach (var program4 in programs4)
                                                            {
                                                        %>
                                                        <tr>
                                                            <td><%=program4.Application_No %></td>
                                                            <td><%=program4.Name %></td>
                                                            <td><%=program4.Institution_Type %></td>
                                                            <td><%=program4.Application_Type_Name %></td>
                                                            <td><%=program4.Status %></td>
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
                        </div>
                          <% if (completed.Count > 0)
                            {
                                  status = "active";
                              }
                              else {
                                  status = "";
                              }   
                                    %>
                        <div class="tab-pane fade in <%=status %> " id="doner">
                            <div>
                                <div class="container">
                                    <h2>Accreditation Progress</h2>
                                    <p>Awaiting certification</p>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                                            100%
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12 col-lg-12">
                                        <div class="panel panel-default">
                                            <div class="panel-heading"><strong>Awaiting Certification</strong> </div>
                                            <div class="panel-body">
                                                <div id="Div4" runat="server"></div>
                                                <table class="table table-bordered table-striped table-hover" id="example1">
                                                    <thead>
                                                        <tr>
                                                             <th>Accreditation No:</th>
                                                            <th>Institution Name</th>
                                                            <th>Institution type</th>
                                                            <th>Application type name</th>
                                                            <th>Status</th>
                                                            <th>Generate Certificate</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            var nav5 = Config.ReturnNav();
                                                            string cert = Convert.ToString(Session["UniversityCode"]);
                                                            var programs5 = nav.applicationAccreditation.Where(r => r.No == cert && r.Status == "Completed");
                                                            foreach (var program5 in programs5)
                                                            {
                                                        %>
                                                        <tr>
                                                            <td><%=program5.Application_No %></td>
                                                            <td><%=program5.Name %></td>
                                                            <td><%=program5.Institution_Type %></td>
                                                            <td><%=program5.Application_Type_Name %></td>
                                                              <td><%=program5.Status %></td>
                                                           <th><a href="certificate.aspx?applicationNo=<%=program5.Application_No %>" class="btn btn-success">View certificate</a></th>
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
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>

            </div>
        
    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Institution Accreditation Payments</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Accreditation Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" placeholder="Institution Accreditation Number" />

                    </div>
                    <div class="form-group">
                        <strong>Institution Name:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="programmeName" placeholder="Institution Name" ReadOnly="true" />
                    </div>
                    <div class="form-group">
                        <strong>Payment Document:</strong>
                        <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                        <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />
                        <div class="form-group">
                            <strong>Payment Reference Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="ConfirmPayments_Click" />
                </div>
            </div>

        </div>
    </div>
    <script>
        function makePayments(no, name) {
            document.getElementById("MainContent_accreditationnumber").value = no;
            document.getElementById("MainContent_programmeName").value = name;
            $("#MakepaymentsModal").modal();
        }
    </script>
  
 

</asp:Content>