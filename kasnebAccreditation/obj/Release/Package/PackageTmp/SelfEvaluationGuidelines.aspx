<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="SelfEvaluationGuidelines.aspx.cs" Inherits="kasnebAccreditation.SelfEvaluationGuidelines" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <div class="panel panel-default">
       <div class="row" style="background-color: #f5f5f5;">
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                   
                      
                  <h3 style="color:Highlight"><b>Self Evalution</b></h3>
                </div>
                <hr />
            </div> <hr/>
   
   <div class="panel-heading">
    <div class="row" >
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
        <p>
            Self Evaluation Form</p>
            </div>
         <div runat="server" id="linesFeedback"></div>
        <div class="panel-body">
        <div class="row">
             <table class="table table-bordered table-striped dataTable" id="example1">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Acccreditation No</th>
                    <th>Institution Name</th>
                    <th>Address</th>
                    <th>Contact</th>                    
                    <th>Proceed</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    var nav = Config.ReturnNav();
                    string university = Convert.ToString(Session["UniversityCode"]);
                    var details = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Completed");
                    //string university = Convert.ToString(Session["UniversityCode"]);
                    int programesCounter = 0;
                    foreach (var detail in details)
                    {
                        programesCounter++;
                %>
                <tr>
                    <td><%=programesCounter %></td>
                    <td><%=detail.Application_No %></td>
                    <td><%=detail.Name %></td>
                    <td><%=detail.Address %></td>
                    <td><%=detail.Contact %></td>
                     <td><label  class="btn btn-success" onclick="createApplication('<% =detail.Application_No %>');"><i class="fa fa-eye"></i> Self Evaluation</label></td>
                   
                 <%--   <td><%--<a href="selfEvalution.aspx?step=1&&applicationNo=<%=detail.Application_No%>" class="btn btn-success"><i class="fa fa-eye">--%><%--<asp:Button runat="server" CssClass="btn btn success" Text="Self Evaluation" OnClick="Unnamed_Click"/></td>--%>
                </tr>
                <%  
                    } %>
            </tbody>
        </table>
        </div>

            </div>
        
      </div>
     </div>
   </div>

    <script>
        function createApplication(ApplicationNo) {            
            document.getElementById("MainContent_ApplicationNo").value = ApplicationNo;
            $("#removeLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Confirm Application</h4>
      </div>
       <div class="modal-body">
        <p>Proceed to self evalution Form for Application :</p>
          <asp:TextBox runat="server" ID="ApplicationNo"/>
      </div>
     
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Unnamed_Click1"/>
      </div>
    </div>

  </div>
</div>
 
      <div class="clearfix"></div>
</asp:Content>
