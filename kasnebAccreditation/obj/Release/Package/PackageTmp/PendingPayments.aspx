<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="PendingPayments.aspx.cs" Inherits="kasnebAccreditation.PendingPayments" %>

<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Applications(s) Pending Payments(Please make Payments per Application)</div>
                    <div class="panel-body">
                        <div id="feedback" runat="server"></div>
                        <table class="table table-striped table-bordered" id="example1">
                            <thead>
                                <tr>
                                    <th>Accreditation No:</th>
                                    <th>Institution No.</th>
                                    <th>Institution Name</th>
                                    <th>Institution Campus</th>
                                    <th>Application Date</th>
                                    <th>Status</th>
                                    <th>Confirm Payment</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav = Config.ReturnNav();
                                    string univ = Convert.ToString(Session["UniversityCode"]);
                                    var programs = nav.applicationAccreditation.Where(r => r.No == univ && r.Status == "Open");
                                    foreach (var program in programs)
                                    {
                                        var paids = "";
                                        if (program.Payment_Document == true)
                                        {
                                            paids = "Pending kasneb Confirmation";
                                        }
                                        else
                                        {
                                            paids = "Not Paid";
                                        }
                                %>
                                <tr>
                                    <td><%=program.Application_No %></td>
                                    <td><%=program.No %></td>
                                    <td><%=program.Name %></td>
                                    <td><%=program.Address %></td>
                                    <td><%=program.Contact %></td>
                                    <td><%=program.Status %></td>
                                    <td style="background-color: lightgray"><strong style="color: brown"><%=paids %></strong></td>
                                    <%
                                        if (paids == "Pending kasneb Confirmation")
                                        {  %>
                                    <td>
                                        <label class="btn btn-danger"><i class="fa fa-edit"></i>Confirmed</label></td>
                                    <% }
                                        if (paids == "Not Paid")
                                        {%>
                                    <td>
                                        <label class="btn btn-success" onclick="makePayments('<%=program.Application_No %>', '<%=program.Name %>')"><i class="fa fa-edit"></i>Make Payments</label></td>
                                    <%}%>
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
    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
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
