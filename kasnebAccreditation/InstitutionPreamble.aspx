<%@ Page Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="InstitutionPreamble.aspx.cs" Inherits="kasnebAccreditation.InstitutionPreamble" %>
       
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


        <%
        const int maxStep = 11;
        var nav = Config.ReturnNav();
        String accreditationNo = "";
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();
        }
        catch (Exception)
        {

        }
        int currentStep = 1;
        try
        {
            currentStep = Convert.ToInt32(Request.QueryString["step"]);
            if (currentStep > maxStep || currentStep < 1)
            {
                currentStep = 1;
            }
        }
        catch (Exception)
        {
            currentStep = 1;
        }
    %>
    <%
        if (currentStep == 1)
        {
    %> 

     <div class="row" style="background-color: #f5f5f5;">
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p class="pull-left" style="font-size: 15px"><a href=""><i class="fa fa-file-pdf-o"></i>Portal User Guide</a></p>
                  <h3 style="color:Highlight"><b>Application For Accreditation(ACF-001)</b></h3>
                </div>
                <hr />
            </div> <hr/>
   <div class="panel-heading">
    <div class="row" >
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
        <p>In order to enable kasneb evaluate your institution for purposes of accreditation, you are
            required to complete this application form and submit it together with all supporting documents. Read the following guidelines carefully.</p>

             <p class="pull-left" style="font-size: 20px"><a href="Downloads/Revised-Guidelines-for-Accreditation.pdf"><i class="fa fa-file-pdf-o"></i>Accreditation GuideLines</a></p><br/><br />
               <ol type="1">
                 <li>An institution is required to complete the application (ACF 001)</li>
                 <li>An institution is required to attach all relevant documents required..</li>
                 <li>An institution is required to attach a payment receipt (Evidence of payment)</li>
                 <%--<li>Proof of Payment of evaluation fee.</li>--%>
             </ol>
           
               <%-- <div class="panel panel-primary">
                                    <p>Institution Accreditation Fee Schedule</p>
                                    <div class="panel-heading">Institution Accreditation Fee Schedule</div>
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Accreditation Type</th>
                                                    <th>Accreditation Fee Amount($)</th>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var acrefees = nav.feeschedules;
                                                    int counter = 0;
                                                    foreach (var fees in acrefees)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
                                                    <td><%=fees.Description %></td>
                                                     <td><%=fees.Amount %></td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>--%>
    <%--       <h4 style="color:red"><u>Note:</u></h4>
          <p>Timelines for required responses are inbuilt, and the system will automatically terminate evaluation at the expiry of the given response period; if this happens, you will be required to make a fresh application for accreditation and make requisite payment.</p>--%>
        </div>
         <asp:Button runat="server" CssClass="btn btn-primary pull-right fa fa-arrow-right"  style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Proceed_Onclick" />
      </div>
     </div>
    <%} %>
            

</asp:Content>
