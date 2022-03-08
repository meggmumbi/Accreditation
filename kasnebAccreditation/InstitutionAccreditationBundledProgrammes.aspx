<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="InstitutionAccreditationBundledProgrammes.aspx.cs" Inherits="kasnebAccreditation.InstitutionAccreditationBundledProgrammes" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="panel panel-primary">
        <div class="panel-heading panel-default"> Campuses<span class="pull-right"></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="linesFeedback"></div>


            <div class="row">
                <div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>Campus/Branch:</strong>
                        <asp:DropDownList runat="server" ID="itemCategory" CssClass="form-control select2">
                            <asp:ListItem>--select--</asp:ListItem>
                            <asp:ListItem Text="Campus" Value ="1"></asp:ListItem>
                             <asp:ListItem Text="Branches" Value ="2"></asp:ListItem>
                        </asp:DropDownList>

                    </div>
                </div>

                <div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>Name:</strong>
                        <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control" placeholder="Name" />
                    </div>
                </div>
                     <div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>Email:</strong>
                        <asp:TextBox runat="server" ID="email" CssClass="form-control" placeholder="Email" />
                    </div>
                </div>
            </div>
            <div class="row">
                <<div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>Post Code:</strong>
                        <asp:DropDownList runat="server" ID="item" CssClass="form-control select2" OnSelectedIndexChanged="item_SelectedIndexChanged" AutoPostback="true"/>
                    </div>
                </div>

                <div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>City:</strong>
                        <asp:TextBox runat="server" ID="City" CssClass="form-control" placeholder="City" />
                    </div>
                </div>
                 <div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>Phone:</strong>
                        <asp:TextBox runat="server" ID="phone" CssClass="form-control" TextMode="Number" placeholder="phone" />
                    </div>
                </div>
            </div>
            <div class="row">
               <div class="col-md-4 col-md-4">
                    <div class="form-group">
                        <strong>Address</strong>
                        <asp:TextBox runat="server" ID="address" CssClass="form-control" placeholder="Address" />

                    </div>
                </div>

               <div class="col-md-4 col-md-4">
                    <div class="formGroup">
                        <strong>Contact</strong>
                        <asp:TextBox runat="server" ID="contact" CssClass="form-control" placeholder="Contact" />
                    </div>
                </div>
                    <div class="col-md-4 col-md-4">
                    <div class="formGroup">
                        <strong>Country </strong>
                        <asp:DropDownList runat="server" ID="country" CssClass="form-control" />
                    </div>
                </div>
                </div>
            <div class="row">
                    <div class="col-md-4 col-md-4">
                    <div class="formGroup">
                        <strong>County</strong>
                        <asp:DropdownList runat="server" ID="county" CssClass="form-control"  />
                    </div>
                </div>
            </div>
            <div class="row">

                <div class="col-lg-6 col-sm-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Campus" ID="addItem" OnClick="addItem_Click" />
                    </div>
                </div>
            </div>

            <table id="example1" class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Type</th>
                        <th>Name </th>
                        <th>Address </th>
                        <th>Contact</th>
                        <th>Postcode</th>
                        <th>City </th>
                        <th>Remove </th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        String applicationNo = Request.QueryString["applicationNo"];
                        int counter=0;
                        var nav = Config.ReturnNav();
                        var application = nav.branches.Where(r=>r.Application_No==applicationNo);
                        foreach (var line in application)
                        {
                            counter ++;
                    %>
                    <tr>
                        <td><%=counter %></td>
                        <td><% =line.Type %></td>
                        <td><% =line.Name %></td>
                        <td><% =line.Address %></td>
                        <td><%=line.Contact %></td>
                        <td><%=line.Post_Code %></td>                        
                        <td><%=line.City %></td>

                        <td><label  class="btn btn-danger" onclick="removeLine('<% =line.Name %>','<%=line.Entry_No %>');"><i class="fa fa-trash"></i> Delete</label></td>
                    </tr>
                    <% 
                        }
                    %>
                </tbody>
            </table>
        </div>
    <div class="panel-footer">
        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
        <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />

        <div class="clearfix"></div>
    </div>
    </div>
  

    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Remove Line</h4>
      </div>
       <div class="modal-body">
        <p>Are you sure you want to remove the <strong id="itemName"></strong> from the list of campuses?</p>
          <asp:TextBox runat="server" ID="lineNo" type="hidden"/>
      </div>
     
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" OnClick="Unnamed_Click"/>
      </div>
    </div>

  </div>
</div>
 
      <div class="clearfix"></div>
</asp:Content>
