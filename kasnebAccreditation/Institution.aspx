<%@ Page Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="Institution.aspx.cs" Inherits="kasnebAccreditation.Institution" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="css/sweetalert2.all.js"></script>
  
    <script>
        function success() {
            Swal.fire(
                'Application Sent Successful'

            )
        }

      
    </script>

    <script src="Adminlte/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
   
<script src="Adminlte/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    


</asp:Content>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <%
        const int maxStep = 29;
        var nav = Config.ReturnNav();
        String accreditationNo = "";
        string code = Request.QueryString["code"];
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();

        }
        catch (Exception)
        {

        }
        int myStep = 1;
        try
        {
            myStep = Convert.ToInt32(Request.QueryString["step"]);
            if (myStep > maxStep || myStep < 1)
            {
                myStep = 1;
            }
        }
        catch (Exception)
        {
            myStep = 1;
        }
    %>
    <%
        if (myStep == 1)

        {
    %>


    <div class="panel panel-primary">
        <div class="panel-heading">
            Institution Accreditation<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>
            <div class="row">

                   <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Institution Name:</label>
                        <asp:Textbox CssClass="form-control" runat="server" ID="institutName" Placeholder="Name" required />
                        <asp:RequiredFieldValidator runat="server" ID="instuName" ControlToValidate="institutName" ErrorMessage="Please enter the Proposed Name!" ForeColor="Red" />

                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Institution Type:</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="institutionType" Placeholder="Name" required />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="institutionType" ErrorMessage="Please enter the Proposed Name!" ForeColor="Red" />

                    </div>
                </div>
             
            </div>
            <div class="row">
                  <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Application type:</label>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="accreditationType" />
                        <asp:RequiredFieldValidator runat="server" ID="university" ControlToValidate="accreditationType" ErrorMessage="Please select the Type of University!" ForeColor="Red" />

                    </div>
                </div>

              

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Postal Address:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="postAddress" Placeholder="Post Address" required />
                        <asp:RequiredFieldValidator runat="server" ID="postiaddress" ControlToValidate="postAddress" ErrorMessage="Please select the PostAddress!" ForeColor="Red" />
                    </div>
                </div>
            </div>

            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Phone Number:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="phoneNumber" Placeholder="Phone Number" required />
                        <asp:RequiredFieldValidator runat="server" ID="phone" ControlToValidate="phoneNumber" ErrorMessage="Please enter the Phone Number!" ForeColor="Red" />

                    </div>
                </div>


                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Email Address:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="emailAddress" Placeholder="Email Address" required type="Email" />
                        <asp:RequiredFieldValidator runat="server" ID="email" ControlToValidate="emailAddress" ErrorMessage="Please enter the Email Address!" ForeColor="Red" />

                    </div>
                </div>
                  <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Alternative Email Address:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="AltEmailAddress" Placeholder="Email Address" required type="Email" />                      
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" ID="gendetails" CssClass="btn btn-success btn-block" Text="Submit General Details" OnClick="step2_Click" />
            </div>
      
        <table class="table table-bordered table-striped dataTable" id="institution">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Acccreditation No</th>
                    <th>Institution Name</th>
                    <th>Intitution type</th>
                    <th>Application Type</th>                    
                    <th>Proceed</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    string university = Convert.ToString(Session["UniversityCode"]);
                    var details = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Open");
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

                   
                    <td><a href="InstitutionAccreditationBundledProgrammes.aspx?applicationNo=<%=detail.Application_No%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>
                </tr>
                <%  
                    } %>
            </tbody>
        </table>
    </div>
    </div>




    <%
        }
      
            else if (myStep == 2)
            {
    %>

    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="basicinformations" runat="server"></div>

        <div class="panel-body">



            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "001");

                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);

                    var subtopicdescription = "";


                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    List<QuestionsModel> subQnModel = new List<QuestionsModel>();
                    QuestionsModel[] SubQuestionsArray = subQnModel.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {

                        QuestionsModel list = new QuestionsModel();
                        list.QuestionCode = subtopic.Code;
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);

                    }

            %>
            <div class="form-group">
                <p><label id="topicdescription"><%=TopicDescription %></label></p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {

                        NumberofQuestions += 1;%>
                    <div class="form-group ">
                    <div class="txtstep1">

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />

                            <%if (item.QuestionType == "Option Text")
                                { %>

                        <select class="form-control qnParent respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                      
                       
                        <%}
                            else
                            {%>
                       <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">                                    
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button11"/>
                                </div>
                            </div>
                        </div>

                        <%}%>
          
              

                       
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>                       
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />
                         <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control childResponce" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}
                            else
                            {%>
                       <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">                                  
                                    <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button7"  />
                                </div>
                            </div>
                        </div>
                              <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Document Title</th>
                                            <th>Download</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try
                                            {
                                                String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "accreditation/";
                                                String applicationNo = Request.QueryString["applicationNo"];
                                                applicationNo = applicationNo.Replace('/', '_');
                                                applicationNo = applicationNo.Replace(':', '_');
                                                String documentDirectory = filesFolder + applicationNo + "/";
                                                if (Directory.Exists(documentDirectory))
                                                {
                                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                    {
                                                        String url = documentDirectory;
                                        %>
                                        <tr>
                                            <td><% =file.Replace(documentDirectory, "") %></td>

                                            <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                        </tr>
                                        <%
                                                    }
                                                }
                                            }
                                            catch (Exception)
                                            {

                                            }%>
                                    </tbody>
                                </table>

                        <%}%>
          




                  

                <%} %>
                         </div>

                        <%}%>
               </div>
            
            <%}%>

                  <%
                      var Question = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "002");

                      int NumberofQuestion = 0;
                      var TopicDescriptions = "";
                      var TopicNumbers = "";
                      foreach (var topic in Question)
                      {
                          TopicDescriptions = topic.No_Description;
                          TopicNumbers = topic.Code;

                          var SubQuestion = nav.accreditationQns.Where(r => r.Question_No == topic.Code);

                          var subtopicdescription = "";


                          List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                          QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                          List<QuestionsModel> subQnModel = new List<QuestionsModel>();
                          QuestionsModel[] SubQuestionsArray = subQnModel.ToArray();
                          foreach (var subtopic in SubQuestion)
                          {

                              QuestionsModel list = new QuestionsModel();
                              list.QuestionCode = subtopic.Code;
                              list.QuestionNumber = subtopic.Question_No;
                              list.QuestionDescription = subtopic.Description;
                              list.QuestionType = subtopic.Question_Type;
                              QuestionsModellist.Add(list);

                          }

            %>
            <div class="form-group">
                <p><label id="topicdescription"><%=TopicDescriptions %></label></p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {

                        NumberofQuestions += 1;%>
                     <div class="form-group ">
                    <div class="txtstep1">

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />


                            <%if (item.QuestionType == "Option Text")
                                { %>

                        <select class="form-control qnParent respn" onchange="Showsubquestion()" aria-required="true">
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>
                       <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                   
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button16" />
                                </div>
                            </div>
                        </div>

                        <%}%>
          
              

                       
                          <% var childQuestions = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestions)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                          <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}
                            else
                            {%>
                      <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                   
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button17"/>
                                </div>
                            </div>
                        </div>
                              <table class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>Document Title</th>
                                            <th>Download</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try
                                            {
                                                String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "accreditation/";
                                                String applicationNo = Request.QueryString["applicationNo"];
                                                applicationNo = applicationNo.Replace('/', '_');
                                                applicationNo = applicationNo.Replace(':', '_');
                                                String documentDirectory = filesFolder + applicationNo + "/";
                                                if (Directory.Exists(documentDirectory))
                                                {
                                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                    {
                                                        String url = documentDirectory;
                                        %>
                                        <tr>
                                            <td><% =file.Replace(documentDirectory, "") %></td>

                                            <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                        </tr>
                                        <%
                                                    }
                                                }
                                            }
                                            catch (Exception)
                                            {

                                            }%>
                                    </tbody>
                                </table>

                        <%}%>
          
                <%} %>
                         </div>

                        <%}%>
               </div>
                </div>
            
            <%}%>
                   </div>
            <center> <button type="submit"class="btn btn-success saveresponce" required="true">Save</button> </center>
     
</div>
        <div class="panel-footer" id="myDIV">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left"  Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click"/>
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (myStep == 3)
        {
    %>
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div1" runat="server"></div>
        <div class="panel-body">

            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "003");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionCode = subtopic.Code;
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">

                <p>

                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                          <p id="subtopicdescription"><%=item.QuestionDescription %></p>                        

                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required="required">
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else if (item.QuestionType == "Label")
                                {%>
                            <Label></Label>
                            <%}
                                else
                                {%>
                            <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                            <%}%>
                    
                          <% var childQuestions = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestions)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                         <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control  childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server"  ID="FileUpload5" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                        <%}%>
                    </div>
            </div>
            <%}%>

               <%
                   var Question = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "004");
                   int NumberofQuestion = 0;
                   var TopicDescriptions = "";
                   var TopicNumbers = "";
                   foreach (var topic in Question)
                   {
                       TopicDescriptions = topic.No_Description;
                       TopicNumbers = topic.Code;

                       var SubQuestion = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                       var subtopicdescription = "";
                       List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                       QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                       foreach (var subtopic in SubQuestion)
                       {
                           QuestionsModel list = new QuestionsModel();
                           list.QuestionCode = subtopic.Code;
                           list.QuestionNumber = subtopic.Question_No;
                           list.QuestionDescription = subtopic.Description;
                           list.QuestionType = subtopic.Question_Type;
                           QuestionsModellist.Add(list);
                       }
            %>
            <div class="form-group">

                <p>

                    <label id="topicdescription"><%=TopicDescriptions%></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %></p>                          

                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required="required" data-width="50%">
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else if (item.QuestionType == "Label")
                                {%>
                            <Label></Label>
                            <%}
                                else
                                {%>
                            <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                            <%}%>
                       
                          <% var childQuestions = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestions)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>                        
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" /><br />
                        <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>"

                            <%if (childQ.Question_Type == "Option Text")
                            { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload6" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                        <%}%>
                    </div>
            </div>
            <%}%>


            <center> <button type="submit" class="btn btn-success saveresponce" aria-required="true">Save</button> </center>

        </div>

        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (myStep == 4)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div2" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "010");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
               
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %></p>                          

                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                       
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <asp:DropDownList runat="server" CssClass="form-control respn" ID="DropDownList8" OnSelectedIndexChanged="management_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem Text="--select--"></asp:ListItem>
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="2"></asp:ListItem>
                        </asp:DropDownList>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <asp:TextBox runat="server" CssClass="form-control respn" TextMode="MultiLine" required></asp:TextBox>
                        <%}
                            else
                            {%>

                                    <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button3" />
                                    </div>
                                </div>
                            </div>

                        <%}
                        %>
                    </div>
                        </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>

             <center> <button type="submit" class="btn btn-success saveresponce" aria-required="true">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (myStep == 5)
        {
    %>
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div3" runat="server"></div>
        <div class="panel-body">
            <label>6. (a)Indicate the following details regarding the administrative staff that provide services to kasneb students:</label>
              <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Division/Department:</strong>
                                <asp:DropDownList runat="server" ID="staffCategory" CssClass="form-control">
                                    <asp:ListItem>--select--</asp:ListItem>
                                    <asp:ListItem Text="Division" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Department" Value="2"></asp:ListItem>
                                </asp:DropDownList>

                            </div>
                        </div>

                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Description:</strong>
                                <asp:TextBox runat="server" ID="staffdescription" CssClass="form-control" placeholder="Name" />
                            </div>
                        </div>


                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>No of Staff:</strong>
                                <asp:TextBox runat="server" ID="NofStaff" CssClass="form-control" TextMode="Number" placeholder="No Of Staff" />
                            </div>
                        </div>

                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <strong>Highest Qualification:</strong>
                                <asp:DropDownList runat="server" ID="HighestQ" CssClass="form-control" />

                            </div>
                        </div>


                        <div class="col-md-6 col-lf-6">
                            <div class="formGroup">
                                <strong>Lowest Qualification</strong>
                                <asp:DropDownList runat="server" ID="lowestQ" CssClass="form-control" />
                            </div>
                        </div>

                        <div class="col-lg-6 col-sm-6">
                            <div class="form-group">
                                <br />
                                <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add Division/Department" ID="addItem" OnClick="addstaff_Click" />
                            </div>
                        </div>

                        <table id="example1" class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Category</th>
                                    <th>Description </th>
                                    <th>No.Of Staff</th>
                                    <th>Highest Academic Qualification</th>
                                    <th>Lowest Academic qualification</th>

                                    <th>Remove </th>
                                </tr>
                            </thead>
                            <tbody>
                                <%

                                    String applicationNo = Request.QueryString["applicationNo"].Trim();
                                    var application = nav.universitystaff.Where(r => r.Application_No == applicationNo);
                                    foreach (var line in application)
                                    {
                                %>
                                <tr>

                                    <td><% =line.Category %></td>
                                    <td><% =line.Description %></td>
                                    <td><% =line.Highest_Academic_Qualification %></td>
                                    <td><%=line.Lowest_Academic_Qualification %></td>
                                    <td><%=line.No_of_Staff %></td>


                                    <td>
                                        <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                </tr>
                                <% 
                                    }
                                %>
                            </tbody>
                        </table>

            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "011");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <label id="subtopicdescription"><%=item.QuestionDescription %></label>                            
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>

                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>

                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}

                                else if (item.QuestionType == "Label")
                                {%>
                            <label></label>
                            <%}

                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button8" />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                       
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                        <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>"
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload2" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (myStep == 6)
        {
    %>
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div4" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "013");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <p id="topicdescription"><%=TopicDescription %></p>
                </p>
              
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                          <label id="subtopicdescription"><%=item.QuestionDescription %></label>
                          
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button9" />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                       
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                        <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>"
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload7" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (myStep == 7)
        {
    %>
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div5" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "014");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button1"  />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>
                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }


        else if (myStep == 8)
        {
    %>
     <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div9" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "015");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button4"  />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
            
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                        <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload8" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
 
    <%
        }
        else if (myStep == 9)
        {
    %>
            <br />
     <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div24" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "016");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>"/>
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"  />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
               
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                         <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
 
    <%
        }
        else if (myStep == 10)
        {
    %>
            <br />
     <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "001");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div25" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "001" && r.Code == "018");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"  />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                        <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
               <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" id="nextSection" Text="Next" OnClick="nextSection_Click"/>
          <%--  <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />--%>
            <div class="clearfix"></div>
        </div>
    </div>
 
    <%
            }


       



        else if (myStep == 11)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "002");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div19" runat="server"></div>
       
        <div class="panel-body">
           <%-- <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "019");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>--%>
<%--                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <label id="subtopicdescription"><%=item.QuestionDescription %></label>
                        <br />
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                              else if (item.QuestionType == "Table")
                            {%>--%>
            <label>Provide the following information relating to the trainers of kasneb courses in the institution:</label>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Course</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" TextMode="Number" ID="course" OnSelectedIndexChanged="course_SelectedIndexChanged" AutoPostBack="true" />

                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Section</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" TextMode="Number" ID="Section">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>


                        </div>
                        <div class="row">

                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Parttime students</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="partStudents"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Full students</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="Fullstudents"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Parttime trainers</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="parttrainers"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Full trainers</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="fulltrainers"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">

                            <div class="col-md-6 col-lg-6">

                                <div class="form-group">
                                    <label>Highest trainers qualification</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="HTQT"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>lowest trainers qualification</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="LTQT"></asp:DropDownList>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Minimum Lecture hours per week per trainer</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="MLH"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>maximum Lecture hours per week per trainer</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="MXLH"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Maximum Course hours per paper per semester</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="MXCH"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6">
                                <div class="form-group">
                                    <label>Minimum Course hours per paper per semester</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="MNCH"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    
                    <div class="row">
                        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                            <br />
                            <asp:Button runat="server" ID="AddTrainers" CssClass="btn btn-success btn-block" Text="Save Trainer" OnClick="AddTrainers_Click" />

                        </div>
                    </div>
                    <br />
                    <table class="table table-bordered table-striped dataTable" id="example1">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Course Title</th>
                                <th>Course Section</th>
                                <th>Fulltime students</th>
                                <th>min hours</th>
                                <th>max course hrs</th>
                                <th>min coursehrs</th>
                                <th>Edit</th>

                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                String applicationNo = Request.QueryString["applicationNo"].Trim();
                                var application = nav.trainers.Where(r => r.Application_No == applicationNo);

                                string university = Convert.ToString(Session["UniversityCode"]);
                                int programesCounter = 0;
                                foreach (var detail in application)
                                {
                                    programesCounter++;
                            %>
                            <tr>
                                <td><%=programesCounter %></td>
                                <td><%=detail.Course_Code %></td>
                                <td><%=detail.Course_Section %></td>
                                <td><%=detail.No_of_Fulltime_Students %></td>
                                <td><%=detail.Min_Lec_Hrs_Per_Week_Trainer %></td>
                                <td><%=detail.Min_Course_Hrs_Per_Week_Sem %></td>
                                <td><%=detail.Max_Course_Hrs_Per_Week_Sem %></td>

                                <td>
                                    <label class="btn btn-danger" onclick="removeTrainer('<% =detail.Course_Code %>','<%=detail.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>

                            </tr>
                            <%  
                                } %>
                        </tbody>
                    </table>
        <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>Select file to upload:</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="document"></asp:FileUpload>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"  />
                                        </div>
                                    </div>
                                </div>
                                <table class="table table-bordered table-striped" id="institution">
                                    <thead>
                                        <tr>
                                            <th>Document Title</th>
                                            <th>Download</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try
                                            {
                                                String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "University Application/";
                                                // String applicationNo = Request.QueryString["applicationNo"].Trim();
                                                applicationNo = applicationNo.Replace('/', '_');
                                                applicationNo = applicationNo.Replace(':', '_');
                                                String documentDirectory = filesFolder + "Accreditation" + "/";
                                                if (Directory.Exists(documentDirectory))
                                                {
                                                    foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                    {
                                                        String url = documentDirectory;
                                        %>
                                        <tr>
                                            <td><% =file.Replace(documentDirectory, "") %></td>

                                            <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                        </tr>
                                        <%
                                                    }
                                                }
                                            }
                                            catch (Exception)
                                            {

                                            }%>
                                    </tbody>
                                </table>
                       <%-- <%}--%>

                           <%-- else--%>
                        <%--    {%>

                      

                        <%}
                        %>--%>
                  <%--  </div>
                </div>--%>

<%--                <%
                    }
                %>--%>
           <%-- </div>--%>
         <%--   <%
                }

            %>--%>
       
    </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }

        else if (myStep == 12)
        {
    %>

    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "002");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div17" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "020");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <p id="subtopicdescription"><%=item.QuestionDescription %></p>                           
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button12"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                      
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                      <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>



                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>


            <%
                var Question = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "021");
                int NumberofQuestion = 0;
                var TopicDescriptions = "";
                var TopicNumbers = "";
                foreach (var topic in Question)
                {
                    TopicDescriptions = topic.No_Description;
                    TopicNumbers = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescriptions = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestion += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <p id="subtopicdescriptions"><%=item.QuestionDescription %></p>
                          
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button13"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                      
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                         <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>"/>

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                    </div>
                    <%
                        }
                    %>
            </div>
            <%
                }

            %>

            <%
                var Questionz = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "022");
                int NumberofQuestionz = 0;
                var TopicDescriptionz = "";
                var TopicNumberz = "";
                foreach (var topic in Questionz)
                {
                    TopicDescriptionz = topic.No_Description;
                    TopicNumberz = topic.Code;

                    var SubQuestionz = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescriptionz = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestionz)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptionz %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestionz += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                          <p id="subtopicdescriptions"><%=item.QuestionDescription %></p>
                          
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button14" />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                   
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                          <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }

        else if (myStep == 13)
        {
    %>
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "002");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div18" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "023");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %>
                           
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button15" />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                      
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                       <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%
        }
        else if (myStep == 14)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "002");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div33" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "024");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>"/>
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control respn"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                      
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label class="qnchild" id="subtopicdescription"><%=childQ.Description %></label>
                          <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
            <%
                var Question = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "025");
                int NumberofQuestion = 0;
                var TopicDescriptions = "";
                var TopicNumbers = "";
                foreach (var topic in Question)
                {
                    TopicDescriptions = topic.No_Description;
                    TopicNumbers = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestion += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button23"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                    
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                        <input type="hidden" class="parentqn" value="<%=childQ.Question_Code%>" />
                        <input type="hidden" class="childqncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild childResponce"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control childResponce" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control childResponce" ></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }

        else if (myStep == 15)
        {
    %>
            <br />
     <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "002");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
       
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "002" && r.Code == "026");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionCode = subtopic.Code;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <p id="topicdescription"><%=TopicDescription %></p>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="4" required></textarea>
                        <%}
                            else if (item.QuestionType == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"/>
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>


                      <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" id="nextsection2" Text="Next" OnClick="nextSection_Click"/>
        <%--    <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />--%>
            <div class="clearfix"></div>
        </div>
    </div>
 
    <%
        }

        else if (myStep == 16)
        {
    %>
            <br />
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
                  <%
                      var Questions = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "027");
                      int NumberofQuestions = 0;
                      var TopicDescription = "";
                      var TopicNumber = "";
                      foreach (var topic in Questions)
                      {
                          TopicDescription = topic.No_Description;
                          TopicNumber = topic.Code;

                          var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                          var subtopicdescription = "";
                          List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                          QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                          foreach (var subtopic in SubQuestions)
                          {
                              QuestionsModel list = new QuestionsModel();
                              list.QuestionNumber = subtopic.Question_No;
                              list.QuestionCode = subtopic.Code;
                              list.QuestionDescription = subtopic.Description;
                              list.QuestionType = subtopic.Question_Type;
                              QuestionsModellist.Add(list);
                          }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"/>
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>


                      <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                          <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" />
                                </div>
                            </div>
                        </div>
                        <%}%>
          




                  

                <%} %>
                         </div>

                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

               <%
                   var Question = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "028");
                   int NumberofQuestion = 0;
                   var TopicDescriptions = "";
                   var TopicNumbers = "";
                   foreach (var topic in Question)
                   {
                       TopicDescriptions = topic.No_Description;
                       TopicNumbers = topic.Code;

                       var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                       var subtopicdescription = "";
                       List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                       QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                       foreach (var subtopic in SubQuestions)
                       {
                           QuestionsModel list = new QuestionsModel();
                           list.QuestionNumber = subtopic.Question_No;
                           list.QuestionCode = subtopic.Code;
                           list.QuestionDescription = subtopic.Description;
                           list.QuestionType = subtopic.Question_Type;
                           QuestionsModellist.Add(list);
                       }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescriptions"><%=TopicDescriptions %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                       <p id="subtopicdescription"><%=item.QuestionDescription %></p>                       
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>


                      <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>

                </div>


                <%
                    }
                %>
            </div>
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
   </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }




        else if (myStep == 17)
        {
    %>
    <div class="panel panel-default"   style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div6" runat="server"></div>

        <div class="panel-body">
            <label>1.(a) Classrooms/Lecture theatres</label>
                                   <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Professional Examinations</label>
                        <asp:DropDownList runat="server" ID="profExamination" CssClass="form-control">
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Number of classrooms/lecture theatres allocated (including common facilities)</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="classroom"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Estimated seating space in square metres</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="seating"></asp:TextBox>
                    </div>
                </div>


                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Largest class</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="largeClass"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Smallest Class</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="smallClass"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Total Capacity</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="totalCapacity"></asp:TextBox>
                    </div>
                </div>

            </div>
       
        <div class="row">
            <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
                <br />
                <asp:Button runat="server" ID="Button2" CssClass="btn btn-success btn-block" Text="Submit class/room Details" OnClick="Add_Class" />
            </div>
        </div>
        <br />
        <table class="table table-bordered table-striped dataTable" id="institution">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Application No</th>
                    <th>Exam Description</th>
                    <th>No of classrooms</th>
                    <th>Estimated Sitting Space</th>
                    <th>TotaL Capacity</th>

                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String applicationNo = Request.QueryString["applicationNo"];
                    var sittings = nav.sittingcapacity.Where(r => r.Application_No == applicationNo);

                    int programesCounter = 0;
                    foreach (var sitting in sittings)
                    {
                        programesCounter++;
                %>
                <tr>
                    <td><%=programesCounter %></td>
                    <td><%=sitting.Application_No%></td>
                    <td><%=sitting.Exam_Description %></td>
                    <td><%=sitting.No_of_Classrooms %></td>
                    <td><%=sitting.Estimated_Seating_Space %></td>
                    <td><%=sitting.Total_Seating_capacity %></td>

                    <td>
                        <%-- <label class="btn btn-success" onclick="editGeneralDetails('<%=sitting.Application_No %>');"><i class="fa fa-pencil"></i>Edit</label></td>--%>
                        <label class="btn btn-danger" onclick="removeClass('<% =sitting.Exam_Description %>','<%=sitting.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                </tr>
                <%  
                    } %>
            </tbody>
        </table>
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "029");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <%=NumberofQuestions%>.<label id="subtopicdescription"><%=item.QuestionDescription %></label>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else if (item.QuestionType == "Table")
                            {%>

                        <%}
                        %>
                    </div>
                                      <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" /><br />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                </div>

                <%
                    }
                %>
          
            <%
                }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (myStep == 18)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div7" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "030");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                      <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}


                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button6"/>
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>
                </div>

                <%
                    }
                %>
            </div>
            <%
                }

            %>
             <%
                 var Question = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "039");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.No_Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                     var subtopicdescription = "";
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Question_No;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionType = subtopic.Question_Type;
                         list.QuestionCode = subtopic.Code;
                         QuestionsModellist.Add(list);
                     }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestions += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                      <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}


                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button5"  />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>
                </div>

                <%
                    }
                %>
            </div>
            <%
                }

            %>
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }

        else if (myStep == 19)
        {
    %>
            <br />
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
       
        <div class="panel-body">
            <label>Estimated total number of books and reference materials categorised into the main subject areas; </label>
                            <div class="row">
<div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Domain Area</label>
                        <asp:DropDownList runat="server" ID="refdomain" CssClass="form-control">
                        </asp:DropDownList>

                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Estimated Number</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="EstNo"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Estimated Total Value</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="EstTotalValue"></asp:TextBox>
                    </div>
                </div>


                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>No. of Recommended Books </label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="recommBooks"></asp:TextBox>
                    </div>
                </div>

            </div>



    


        <div class="col-md-6 col-lg-6 col-sm-6 col-xs-12 form-group">
            <br />
            <asp:Button runat="server" ID="refbk" CssClass="btn btn-success btn-block" Text="Submit refBooks" OnClick="refbk_Click" />
        </div>

        <br />
        <table class="table table-bordered table-striped dataTable" id="institution">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Application No</th>
                    <th>Domain Area</th>
                    <th>Estimated No</th>
                    <th>Estimate Total Value</th>
                    <th>No of Recommended Books</th>

                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String applicationNo = Request.QueryString["applicationNo"];
                    var refBook = nav.refbooks.Where(r => r.Application_No == applicationNo);

                    int programesCounter = 0;
                    foreach (var refB in refBook)
                    {
                        programesCounter++;
                %>
                <tr>
                    <td><%=programesCounter %></td>
                    <td><%=refB.Application_No%></td>
                    <td><%=refB.Domain_Area %></td>
                    <td><%=refB.Estimated_number %></td>
                    <td><%=refB.Estimated_total_value %></td>
                    <td><%=refB.No_of_Recomm_books %></td>

                    <td>
                        <label class="btn btn-danger" onclick="removeRefBook('<% =refB.Domain_Area %>','<%=refB.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>

                </tr>
                <%  
                    } %>
            </tbody>
        </table>
           
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }

        else if (myStep == 20)
        {
    %>
        <br />
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <asp:Label runat="server">For institutions offering or intending to offer CICT and DICT courses, the
                                 following additional details should be provided: </asp:Label><br />
            <label>(i) Computer laboratories</label>

            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Computer Lab</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="computerLab"></asp:TextBox>

                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Sitting Capacity</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="sittn"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>No available for Training</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="trainingAvail"></asp:TextBox>
                    </div>
                </div>


                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>No with Adapter </label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="withAdapter"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Total Space </label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="TotalSpace"></asp:TextBox>
                    </div>
                </div>








                <div class="col-md-6 col-lg-6">
                    <br />
                    <asp:Button runat="server" ID="compLab" CssClass="btn btn-success btn-block" Text="Submit Computer Lab details" OnClick="compLab_Click" />
                </div>
            </div>
            <br />
            <table class="table table-bordered table-striped dataTable" id="example1">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Computer Lab</th>
                        <th>Sitting Capacity</th>
                        <th>No available for training</th>
                        <th>No with adapter</th>
                        <th>Total Space</th>

                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String applicationNo = Request.QueryString["applicationNo"];
                        var compLab = nav.compLab.Where(r => r.Application_No == applicationNo);

                        int programesCounter = 0;
                        foreach (var comp in compLab)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=comp.Application_No%></td>
                        <td><%=comp.Computer_Laboratory%></td>
                        <td><%=comp.Seating_capacity %></td>
                        <td><%=comp.No_available_for_training%></td>
                        <td><%=comp.No_with_Adapter_Cards %></td>
                        <td><%=comp.Total_space %></td>

                        <td>
                            <label class="btn btn-danger" onclick="removeComp('<% =comp.Computer_Laboratory %>','<%=comp.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>

                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }


        else if (myStep == 21)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <asp:Label runat="server">For institutions offering or intending to offer CICT and DICT courses, the following additional details should be provided: </asp:Label><br />
            <label>(i) Specifications of the computers:</label>

            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>No of Computers</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="NoOFComputers"></asp:TextBox>

                    </div>
                </div>

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Processor Type</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="processorType"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Processor Speed</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Speed"></asp:TextBox>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 col-lg-6">
                        <div class="form-group">
                            <label>RAM Capacity</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="RAM"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="col-md-12 col-lg-12">
                    <div class="form-group">
                        <label>Hard Disk</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="HD"></asp:TextBox>
                    </div>
                </div>


            </div>






            <div class="col-md-6 col-lg-6">
                <br />
                <asp:Button runat="server" ID="ictEquipmentDetailz" CssClass="btn btn-success btn-block" Text="Submit Computer Details" OnClick="ictEquipmentDetailz_Click" />
            </div>
       
        <br />
        <table class="table table-bordered table-striped dataTable" id="institution">
            <thead>
                <tr>
                    <th>#</th>
                    <th>ApplicationNo</th>
                    <th>No Of Computers</th>
                    <th>Processor Type</th>
                    <th>Processor Speed</th>
                    <th>RAM Capacity</th>
                    <th>Hard Disk</th>

                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String applicationNo = Request.QueryString["applicationNo"];
                    var compDetails = nav.computer_Details.Where(r => r.Application_No == applicationNo);

                    int programesCounter = 0;
                    foreach (var compdetail in compDetails)
                    {
                        programesCounter++;
                %>
                <tr>
                    <td><%=programesCounter %></td>
                    <td><%=compdetail.Application_No%></td>
                    <td><%=compdetail.No_of_Computers%></td>
                    <td><%=compdetail.Processor_type %></td>
                    <td><%=compdetail.Processor_speed%></td>
                    <td><%=compdetail.RAM_Capacity %></td>
                    <td><%=compdetail.Hard_disk_capacity %></td>


                    <td>
                        <label class="btn btn-danger" onclick="removeAdditionalDetails('<% =compdetail.Processor_type %>','<%=compdetail.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>

                </tr>
                <%  
                    } %>
            </tbody>
        </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }

        else if (myStep == 22)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
              <h4 style="color:red"><u>Note:</u></h4>
          <p>Institutions Required to fill in details for all the ICT category types .</p>
            <asp:Label runat="server">For institutions offering or intending to offer CICT and DICT courses, the following additional details should be provided: </asp:Label><br />
            <label>(i) Computer Specification,Accessories</label>

            <div class="row">

                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Academic Ict Type</label>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="ictAccessories" OnSelectedIndexChanged="ictAccessories_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>--select--</asp:ListItem>
                            <asp:ListItem Value="0">Item /Accessory</asp:ListItem>
                            <asp:ListItem Value="1">Connected To LAN</asp:ListItem>
                            <asp:ListItem Value="2">Academic Software</asp:ListItem>
                        </asp:DropDownList>

                    </div>
                </div>




                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Academic Type Name</label>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="typeName" />
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Type Available</label>
                        <asp:TextBox runat="server" CssClass="form-control" ID="typeavailable"></asp:TextBox>
                    </div>
                </div>


                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <label>Number Available</label>
                        <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="Number"></asp:TextBox>
                    </div>
                </div>


            </div>





            <div class="col-md-6 col-lg-6">
                <br />
                <asp:Button runat="server" ID="ictEquipmentDetails" CssClass="btn btn-success btn-block" Text="Submit ICT Details" OnClick="ictEquipmentDetails_Click" />
            </div>
            <br />
            <br />
            <table class="table table-bordered table-striped dataTable" id="institution">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>ApplicationNo</th>
                        <th>Category</th>

                        <th>Academic type Name</th>
                        <th>Type Available</th>
                        <th>Number</th>

                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        String applicationNo = Request.QueryString["applicationNo"];
                        var icts = nav.ICT.Where(r => r.Application_No == applicationNo);

                        int programesCounter = 0;
                        foreach (var ICT in icts)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=ICT.Application_No%></td>
                        <td><%=ICT.Category%></td>
                        <td><%=ICT.Academic_Type_Name%></td>
                        <td><%=ICT.Type_Available %></td>
                        <td><%=ICT.Number %></td>


                        <td>
                            <label class="btn btn-danger" onclick="removeIctDetails('<% =ICT.Academic_Type_Name %>','<%=ICT.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>

                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }

        else if (myStep == 23)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div20" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "032");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <P id="subtopicdescription"><%=item.QuestionDescription %></P>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else if (item.QuestionType == "Label")
                                {%>
                            
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="upload" />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                        </div>
                         <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload9" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
              <%
                  var Question = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "040");
                  int NumberofQuestion = 0;
                  var TopicDescriptions = "";
                  var TopicNumbers = "";
                  foreach (var topic in Question)
                  {
                      TopicDescriptions = topic.No_Description;
                      TopicNumbers = topic.Code;

                      var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                      var subtopicdescription = "";
                      List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                      QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                      foreach (var subtopic in SubQuestions)
                      {
                          QuestionsModel list = new QuestionsModel();
                          list.QuestionNumber = subtopic.Question_No;
                          list.QuestionDescription = subtopic.Description;
                          list.QuestionType = subtopic.Question_Type;
                          list.QuestionCode = subtopic.Code;
                          QuestionsModellist.Add(list);
                      }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <P id="subtopicdescription"><%=item.QuestionDescription %></P>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else if (item.QuestionType == "Label")
                                {%>
                            
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button18"  />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                        </div>
                         <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload1" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
         
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%

        }

        else if (myStep == 24)
        {
    %>
    <div class="panel panel-default"  style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "003");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div27" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "003" && r.Code == "033");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <label id="subtopicdescription"><%=item.QuestionDescription %></label>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Buttonclick"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                        </div>
                                        <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload10" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          




                  

                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
          
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" Text="Next" OnClick="nextSection_Click"/>
           <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />--%>
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }

        else if (myStep == 25)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "004");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div28" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "004" && r.Code == "034");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Buttonclick1"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                        </div>
                         <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload11" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          


                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
             <%
                 var Question = nav.questionSetup.Where(r => r.Chapter == "004" && r.Code == "035");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.No_Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                     var subtopicdescription = "";
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Question_No;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionType = subtopic.Question_Type;
                         list.QuestionCode = subtopic.Code;
                         QuestionsModellist.Add(list);
                     }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestion += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label id="subtopicdescription"><%=item.QuestionDescription %></label>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>
                     <div id="children">
                          <% var childQuestions = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestions)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload12" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          


                <%} %>
                         </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }

            %>
        
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (myStep == 26)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "004");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "004" && r.Code == "036");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document"/>
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                        </div>
                         <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server"  CssClass="form-control"></asp:FileUpload>
                        <%}%>
          


                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
             <%
                 var Question = nav.questionSetup.Where(r => r.Chapter == "004" && r.Code == "037");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.No_Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                     var subtopicdescription = "";
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Question_No;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionType = subtopic.Question_Type;
                         list.QuestionCode = subtopic.Code;
                         QuestionsModellist.Add(list);
                     }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestion += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label id="subtopicdescription"><%=item.QuestionDescription %></label>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>
                     <div id="children">
                          <% var childQuestions = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestions)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server"  CssClass="form-control"></asp:FileUpload>
                        <%}%>
          


                <%} %>
                         </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }

            %>
        
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" Text="Next" OnClick="nextSection_Click"/>
          <%--  <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />--%>
            <div class="clearfix"></div>
        </div>
    </div>



    <%
        }

        else if (myStep == 26)
        {
    %>
    <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "004");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="Div10" runat="server"></div>
        <div class="panel-body">
            <%
                var Questions = nav.questionSetup.Where(r => r.Chapter == "004" && r.Code == "036");
                int NumberofQuestions = 0;
                var TopicDescription = "";
                var TopicNumber = "";
                foreach (var topic in Questions)
                {
                    TopicDescription = topic.No_Description;
                    TopicNumber = topic.Code;

                    var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                    var subtopicdescription = "";
                    List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                    QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                    foreach (var subtopic in SubQuestions)
                    {
                        QuestionsModel list = new QuestionsModel();
                        list.QuestionNumber = subtopic.Question_No;
                        list.QuestionDescription = subtopic.Description;
                        list.QuestionType = subtopic.Question_Type;
                        list.QuestionCode = subtopic.Code;
                        QuestionsModellist.Add(list);
                    }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                <p>
                    <% 
                        foreach (var item in QuestionsModellist)
                        {
                            NumberofQuestions += 1;
                    %>
                    <div class="form-group">
                        <div class="txtstep1">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                           <p id="subtopicdescription"><%=item.QuestionDescription %></p>
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                            <%
                                if (item.QuestionType == "Option Text")
                                { %>
                            <select class="form-control respn" required>
                                <option>--select--</option>
                                <option value="Yes">Yes</option>
                                <option value="No">No</option>

                            </select>
                            <%}
                                else if (item.QuestionType == "Text")
                                {%>
                            <textarea class="form-control respn" rows="2" required></textarea>
                            <%}
                                else
                                {%>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" />
                                    </div>
                                </div>
                            </div>


                            <%}
                            %>
                        </div>
                         <div id="children">
                          <% var childQuestion = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestion)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload13" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          


                <%} %>
                         </div>
                    </div>

                    <%
                        }
                    %>
            </div>
            <%
                }

            %>
             <%
                 var Question = nav.questionSetup.Where(r => r.Chapter == "004" && r.Code == "037");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.No_Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.accreditationQns.Where(r => r.Question_No == topic.Code);
                     var subtopicdescription = "";
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Question_No;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionType = subtopic.Question_Type;
                         list.QuestionCode = subtopic.Code;
                         QuestionsModellist.Add(list);
                     }
            %>
            <div class="form-group">
                <p>
                    <label id="topicdescription"><%=TopicDescriptions %></label>
                </p>

                <% 
                    foreach (var item in QuestionsModellist)
                    {
                        NumberofQuestion += 1;
                %>
                <div class="form-group">
                    <div class="txtstep1">
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <label id="subtopicdescription"><%=item.QuestionDescription %></label>
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <%
                            if (item.QuestionType == "Option Text")
                            { %>
                        <select class="form-control respn" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                        <%}
                            else if (item.QuestionType == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}
                            else
                            {%>

                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <strong>Select file to upload:</strong>
                                    <asp:FileUpload runat="server" CssClass="form-control"></asp:FileUpload>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" />
                                </div>
                            </div>
                        </div>


                        <%}
                        %>
                    </div>
                     <div id="children">
                          <% var childQuestions = nav.subQuestions.Where(r => r.Question_Code == item.QuestionCode);
                              foreach (var childQ in childQuestions)
                              {%>

                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                        <p class="qnchild" id="subtopicdescription"><%=childQ.Description %></p>
                         <%--<input type="hidden" class="qncd" value="<%=%>" /><br />--%>
                        <input type="hidden" class="qncd" value="<%=childQ.Code%>" />

                            <%if (childQ.Question_Type == "Option Text")
                                { %>

                        <select class="form-control qnchild respn"onchange="Showsubquestion()" required>
                            <option>--select--</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>

                        </select>
                         
                 

                        <%}
                            else if (childQ.Question_Type == "Text")
                            {%>
                        <textarea class="form-control respn" rows="2" required></textarea>
                        <%}

                            else if (childQ.Question_Type == "Label")
                            {%>
                       
                        <%}
                            else
                            {%>
                        <asp:FileUpload runat="server" ID="FileUpload14" CssClass="form-control"></asp:FileUpload>
                        <%}%>
          


                <%} %>
                         </div>
                </div>
                <%
                    }
                %>
            </div>
            <%
                }

            %>
        
            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>



    <%
        }

        else if (myStep == 27)
        {
    %>


    <div class="row">
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-default">
                      <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "009");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
                <div class="panel-body">
                  
                        <ul class="nav nav-pills" style="background-color: 	#D3D3D3">
                             <li class="nav-item">
                                <a class="nav-link active" data-toggle="pill" href="#peers">Attachments</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="pill" href="#feedback">Required Documents</a>
                            </li>
                           
                        </ul>
                        <div class="form-group">
                            <hr />
                            <div runat="server" id="Div11"></div>
                            <asp:Literal ID="ltEmbed" runat="server" />
                        </div>
              
                <div class="tab-content">

                    <div runat="server" id="documentsFeedback"></div>
                         <div class="tab-pane active" id="peers">
                              <div id="attach" runat="server"></div>
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Required Documents For Attachment</div>

                                    <div class="panel-body">
                                        <div id="Div13" runat="server"></div>
                                         <table class="table table-bordered table-striped datatable" id="example1">
                                             <tr>
                                                 <th style="width: 10px">#</th>
                                                 <th>Document</th>
                                                 <th></th>
                                                
                                             </tr>
                                             <tr>
                                                 <td>1.</td>
                                                 <td>A copy Of Registration certificate the given by the Ministry which the institution is registered under</td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td>
                                              
                                             </tr>                                         
                                       
                                                 <tr><td>2</td><td>A certified copy of the institutional organisation structure</td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td></tr>
                                                 <tr><td>3</td><td>A certified list indicating the names, designations and qualifications of key management staff </td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td></tr>
                                                 <tr><td>4</td><td>A certified list showing the names, qualifications, subjects taught and nature of contract for each trainer of kasneb courses. The curriculum vitae and certified copies of relevant certificates for each trainer MUST also be attached</td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td></tr>
                                                 <tr><td>5</td><td>A certified copy of evaluation form used by students to regularly evaluate the trainers</td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td></tr>
                                                 <tr><td>6</td><td>A certified evidence document of the premise/ building owned or leased</td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td><tr>
                                                 <tr><td>7</td><td>A certified copy of evaluation form used by students to evaluate the performance of management,trainers and staff</td><td>  <label class="btn btn-success" onclick="Accreditationttachdocuments();">Attach Document</label></td>
                                                   
                                                    </tr>
                                               
                                             </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                               <div class="box-header">
                                <h3 class="box-title">Attached Documents</h3>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped" id="example7">
                                    <thead>
                                        <tr>
                                            <th>Document Title</th>
                                         
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%
                                            List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                            try
                                            {%>
                                        <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                            {
                                                // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                                String leaveNo = Request.QueryString["applicationNo"];
                                                string password = ConfigurationManager.AppSettings["S_PWD"];
                                                string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                                var secret = new SecureString();



                                                foreach (char c in password)
                                                {
                                                    secret.AppendChar(c);
                                                }

                                                ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                                ctx.Load(ctx.Web);
                                                ctx.ExecuteQuery();
                                                List list = ctx.Web.Lists.GetByTitle("KASNEB ESS");

                                                //Get Unique rfiNumber
                                                string uniqueLeaveNumber = leaveNo;

                                                ctx.Load(list);
                                                ctx.Load(list.RootFolder);
                                                ctx.Load(list.RootFolder.Folders);
                                                ctx.Load(list.RootFolder.Files);
                                                ctx.ExecuteQuery();

                                                FolderCollection allFolders = list.RootFolder.Folders;
                                                foreach (Folder folder in allFolders)
                                                {
                                                    if (folder.Name == "Accreditation")
                                                    {
                                                        ctx.Load(folder.Folders);
                                                        ctx.ExecuteQuery();
                                                        var uniquerfiNumberFolders = folder.Folders;

                                                        foreach (Folder folders in uniquerfiNumberFolders)
                                                        {
                                                            if (folders.Name == "AccreditationDocuments")
                                                            {
                                                                ctx.Load(folders.Folders);
                                                                ctx.ExecuteQuery();
                                                                var uniquevendorNumberSubFolders = folders.Folders;

                                                                foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                                {
                                                                    if (vendornumber.Name == uniqueLeaveNumber)
                                                                    {
                                                                        ctx.Load(vendornumber.Files);
                                                                        ctx.ExecuteQuery();

                                                                        FileCollection vendornumberFiles = vendornumber.Files;
                                                                        foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                        {%>
                                        <% ctx.ExecuteQuery();
                                            alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                            alldocuments.ToList();
                                        %>


                                        <% }%>

                                        <%
                                            foreach (var item in alldocuments)
                                            {%>
                                        <tr>
                                            <td><% =item.FileName %></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                        </tr>
                                        <% }
                                        %>

                                        <%  }

                                                                    }


                                                                }
                                                            }

                                                        }
                                                    }

                                                }

                                            }
                                            catch (Exception t)
                                            {

                                                attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                                  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }

                                        %>
                                    </tbody>

                                </table>
                            </div>
                                </div>
                    </div>
                    </div>
                <div class="panel-footer">
                            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                    <%if (alldocuments.Count >= 7)
                        { %>
                                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextSection_Click"/>
                    <%} %>
                           <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />--%>
                            <div class="clearfix"></div>
                        </div>
                   <%-- <div class="tab-pane active" id="peers">
                        <div class="row">
                            <div class="col-md-12 col-lg-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">Attachments</div>

                                    <div class="panel-body col-lg-6">
                                        <div id="attach" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>Registration Certificate:</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload3"></asp:FileUpload>
                                        </div>
                                    </div>
                                  
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" OnClick="Unnamed_Click"/>
                                        </div>
                                    
                                </div>
                          
                            
                                    </div>
                                     <div class="panel-body col-lg-6">
                                        <div id="Div14" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>Organizational Structure:</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload4"></asp:FileUpload>
                                        </div>
                                    </div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="organizationStructure" OnClick="organizationStructure_Click" />
                                        </div>
                                    </div>
                                </div>
                        
                            
                                    </div>
                                     <div class="panel-body col-lg-6">
                                        <div id="Div15" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong> Management staff :</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload15"></asp:FileUpload>
                                        </div>
                                    </div>
                                   
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" id="staffUpload" OnClick="staffUpload_Click" />
                                        </div>
                                    
                                </div>
                              
                            
                                    </div>
                                     <div class="panel-body col-lg-6">
                                        <div id="Div16" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>A list of trainers:</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload16"></asp:FileUpload>
                                        </div>
                                    </div>
                                    
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" id="trainersUpload" OnClick="trainersUpload_Click" />
                                        </div>
                                   
                                </div>
                             
                            
                                    </div>
                                     <div class="panel-body col-lg-6">
                                        <div id="Div21" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>Evaluation form :</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload17"></asp:FileUpload>
                                        </div>
                                    </div>
                                    
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="evaluateTrainers" OnClick="evaluateTrainers_Click"/>
                                        </div>
                                  
                                </div>
                           
                            
                                    </div>
                                     <div class="panel-body col-lg-6">
                                        <div id="Div22" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>An evidence of the premise/ building :</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload18"></asp:FileUpload>
                                        </div>
                                    </div>
                                    
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="buildingUpload" />
                                        </div>
                                    
                                </div>
                         
                            
                                    </div>
                                     <div class="panel-body col-lg-6">
                                        <div id="Div23" runat="server"></div>
                                         <div class="row">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                        <div class="form-group">
                                            <strong>A copy of evaluation form used by students to evaluate the performance of management,trainers and staff:</strong>
                                            <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload19"></asp:FileUpload>
                                        </div>
                                    </div>
                                  
                                        <div class="form-group">
                                            <br />
                                            <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" id="evaluateManagement" />
                                        </div>
                                   
                                </div>
                          

                                     </div>
                                     <div class="box-header">
                                <h3 class="box-title">Attached Documents</h3>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped" id="example7">
                                    <thead>
                                        <tr>
                                            <th>Document Title</th>
                                            <%--<th>Download</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%
                                            List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                            try
                                            {%>
                                        <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                            {
                                                // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                                String leaveNo = Request.QueryString["applicationNo"];
                                                string password = ConfigurationManager.AppSettings["S_PWD"];
                                                string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                                var secret = new SecureString();



                                                foreach (char c in password)
                                                {
                                                    secret.AppendChar(c);
                                                }

                                                ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                                ctx.Load(ctx.Web);
                                                ctx.ExecuteQuery();
                                                List list = ctx.Web.Lists.GetByTitle("KASNEB ESS");

                                                //Get Unique rfiNumber
                                                string uniqueLeaveNumber = leaveNo;

                                                ctx.Load(list);
                                                ctx.Load(list.RootFolder);
                                                ctx.Load(list.RootFolder.Folders);
                                                ctx.Load(list.RootFolder.Files);
                                                ctx.ExecuteQuery();

                                                FolderCollection allFolders = list.RootFolder.Folders;
                                                foreach (Folder folder in allFolders)
                                                {
                                                    if (folder.Name == "Accreditation")
                                                    {
                                                        ctx.Load(folder.Folders);
                                                        ctx.ExecuteQuery();
                                                        var uniquerfiNumberFolders = folder.Folders;

                                                        foreach (Folder folders in uniquerfiNumberFolders)
                                                        {
                                                            if (folders.Name == "AccreditationDocuments")
                                                            {
                                                                ctx.Load(folders.Folders);
                                                                ctx.ExecuteQuery();
                                                                var uniquevendorNumberSubFolders = folders.Folders;

                                                                foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                                {
                                                                    if (vendornumber.Name == uniqueLeaveNumber)
                                                                    {
                                                                        ctx.Load(vendornumber.Files);
                                                                        ctx.ExecuteQuery();

                                                                        FileCollection vendornumberFiles = vendornumber.Files;
                                                                        foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                        {%>
                                        <% ctx.ExecuteQuery();
                                            alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                            alldocuments.ToList();
                                        %>


                                        <% }%>

                                        <%
                                            foreach (var item in alldocuments)
                                            {%>
                                        <tr>
                                            <td><% =item.FileName %></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                        </tr>
                                        <% }
                                        %>

                                        <%  }

                                                                    }


                                                                }
                                                            }

                                                        }
                                                    }

                                                }

                                            }
                                            catch (Exception t)
                                            {

                                                attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                                  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }

                                        %>
                                    </tbody>

                                </table>
                            </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                                <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" id="Button19" Text="Next" OnClick="nextSection_Click"/>
                           <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />--%>
                            <div class="clearfix"></div>
                        </div>
                    </div>--%>
                
                  
                </div>

            </div>
      


    <%}



        else if (myStep == 28)
        {
    %>

    <div class="panel panel-default" style="width:80%; margin: 0 auto">
          <div class="row">
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                            <li class="breadcrumb-item active">Payment </li>
                        </ol>
                    </div>
                </div>
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "008");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
            <div id="paymentDoc" runat="server"></div>
        </div>
        <div class="panel-body">

             <div class="panel panel-primary">
                                    <p>Institution Accreditation Fee Schedule</p>
                                    <div class="panel-heading">Institution Accreditation Fee Schedule</div>
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable" id="example1">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Accreditation Type</th>
                                                    <th>Accreditation Fee Amount</th>
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
                                                    <td><%=fees.Currency %></td>

                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                    </div>
             </div>
            <h4 style="color: red"><u>Note:</u></h4>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Select mode of payment</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="paymentmode" OnSelectedIndexChanged="paymentmode_SelectedIndexChanged" AutoPostBack="true">
                            <asp:ListItem>--select--</asp:ListItem>
                            <asp:ListItem Value="1">BankSlip. (preferably KCB Bank)</asp:ListItem>
                            <asp:ListItem Value="2">Bank Check</asp:ListItem>
                            <asp:ListItem Value="3">Mpesa</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                </div>
                <div id="modeofpayment" runat="server" visible="false">
             
           

            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Amount</strong>
                        <asp:TextBox runat="server" ID="appFee" CssClass="form-control" TextMode="Number"></asp:TextBox>
                    </div>
                </div>
                   <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Bank slipNo/Check No/ KCb ref No</strong>
                        <asp:TextBox runat="server" ID="bankslip" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

               
            </div>
                  <div class="row">
                       <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Date:</strong>
                        <asp:TextBox runat="server" ID="appdate" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Attach Payment:</strong>
                        <asp:FileUpload runat="server" CssClass="form-control" ID="paymenId"></asp:FileUpload>
                    </div>
                </div>
                <div class="col-md-6 col-lg-6" style="display:none">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="paymentFile" />
                    </div>
                </div>


            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <asp:Button runat="server" ID="payment" CssClass="btn btn-success btn-block" Text="Submit payment" OnClick="payment_Click"  />
                    </div>
                </div>
                </div>
            </div>
            <div id="mpesaPayment" runat="server" visible="false">
                 <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
                Payment
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
              
                <div id="PaymentsMpesa" runat="server"></div>

                <br />
                <div class="row">

                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="tab_1_1" style="width: 100%">
                            <div class="row">
                                <div id="openTenderfeedback" runat="server"></div>
                                <div class="col-md-12">

                                    <section class="accordion-section clearfix mt-3" aria-label="Question Accordions">
                                        <div class="container">

                                            <h3>Payment </h3>
                                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading p-3 mb-3" role="tab" id="heading0">
                                                        <h3 class="panel-title">
                                                            <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse0" aria-expanded="true" aria-controls="collapse0">Mpesa
                                                            </a>
                                                        </h3>
                                                    </div>
                                                    <div role="tabpanel" aria-labelledby="heading0">
                                                        <div class="panel-body px-3 mb4">
                                                        <div class="container">
                                                            <div class="row">
                                                                <div class="col-xs-12">                                                                    
                                                                   <h3><strong>Payment Instructions</strong></h3>                                                                        
                                                                                
                                                                  
                                                                        <div>
                                                                            <div class="panel-body">
                                                                                <div class="panel-body px-3 mb-4">
                                                                                   
                                                                                   <center><img class="imgMpesa" src="images/stkMpesa.png" />
                                                                                     <p></p><h4><strong>Please ensure you have the following ready to make payment</strong></h4></center> 
                                                                                    <ol type="1">
                                                                                       <li>Enough funds in your Mpesa account.</li>
                                                                                        <li>The Correct Mpesa pin code.</li>
                                                                                        <li>Use a Safaricom sim not older than 3 years</li>
                                                                                        <li>Account No. <strong><%=Request.QueryString["applicationNo"] %> </strong></li>
                                                                                        <li>Amount <strong>
                                                                                            <p runat="server" style="display: inline" id="AmountInstructions"></p>
                                                                                        </strong></li>
                                                                                        <li>Make sure you have the phone you are making payment with.</li>
                                                                                        <li>You will be prompted to enter your Mpesa Pin to complete the payment</li>
                                                                                    </ol>
                                                                                    <p style="text-align:center">NB: You have to wait for the Mpesa Pop Up message to confirm your payment. Should you wish to retry your transaction please wait for a period of 3 minutes.
                                                                                    </p>
                                                                                    <div class="panel-footer">
                                                                                        <label class="btn btn-success" onclick="makePayments('<%=Request.QueryString["applicationNo"]%>')"><i class="fa fa-money"></i>Pay Now</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                                    <div class="panel panel-default">
                                                                        <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                                                                            <h3 class="panel-title">
                                                                                <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">Manual Payment Instructions (Pay Later)
                                                                                </a>
                                                                            </h3>
                                                                        </div>
                                                                        <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                                                                            <div class="panel-body px-3 mb-4">
                                                                                <div>
                                                                                    <div class="panel-body">
                                                                                 <div class="panel-body px-3 mb-4">
                                                                                    
                                                                                     <img src="images/paybill-number.jpg" style="width: 150px; height: 90px" />
                                                                                     <div class="col-lg-12">
                                                                                         <div class="form-group">                                                                                                                                                                                       <br />
                                                                                             <asp:CheckBox runat="server" ID="CheckBox1" />
                                                                                             <label class="font-noraml" for="acceptTerms">Pay Later.</label>
                                                                                         </div>
                                                                                     </div>
                                                                                     <ol type="1">
                                                                                         <li>Go to MPESA</li>
                                                                                         <li>Lipa na Mpesa</li>
                                                                                         <li>Paybill Option</li>
                                                                                         <li>Paybill No: <strong>204777</strong></li>
                                                                                         <li>Account No. <strong><%=Request.QueryString["applicationNo"] %> </strong></li>
                                                                                         <li>Amount <strong>
                                                                                             <p runat="server" style="display: inline" id="AmountInstructionsManual"></p>
                                                                                         </strong></li>
                                                                                         <li>Make sure you have the phone you are making payment with.</li>
                                                                                         <li>You will be prompted to enter your Mpesa Pin to complete the payment</li>
                                                                                     </ol>

                                                                                 </div>
                                                                             </div>
                                                                         </div>


                                                                </div>
                                                            </div>
                                                        </div>
                                                                   
                                                           
                                                <div class="panel panel-default" style="display: none">
                                                    <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                                                        <h3 class="panel-title">
                                                            <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">Other Modes of Payment

                                                            </a>
                                                        </h3>
                                                    </div>
                                                    <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                                                        <div class="panel-body px-3 mb-4">
                                                            <div id="modalPay" role="dialog">

                                                                <div class="row">
                                                                    <div class="panel-heading">
                                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                        <h4 class="modal-title">Confirm Examination registration Payment</h4>
                                                                    </div>
                                                                    <div class="panel-body">

                                                                        <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                                                                        <div class="form-group">
                                                                            <strong>Application Number:</strong>
                                                                            <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" />

                                                                        </div>

                                                                        <div class="form-group">
                                                                            <strong>Payment Mode:</strong>
                                                                            <asp:DropDownList runat="server" CssClass="form-control" ID="paymentsM" />
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <strong>Payment Document:</strong>
                                                                            <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                                                                            <%-- <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />--%>
                                                                            <div class="form-group">
                                                                                <strong>Payment Reference Number:</strong>
                                                                                <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                    <div class="panel-footer">
                                                                        <%-- <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>--%>
                                                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" EnableViewState="true" />
                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                </div>
                                            </div>
                 
                                    </section>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>



        </div>
    </div>
            </div>

                <%--     <table class="table table-bordered table-striped dataTable" id="institution">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Course Title</th>
                                <th>Course Section</th>
                                <th>Fulltime students</th>
                                <th>min hours</th>
                                <th>max course hrs</th>
                                <th>min coursehrs</th>
                                <th>Edit</th>

                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                String applicationNo = Request.QueryString["applicationNo"].Trim();
                                var application = nav.trainers.Where(r => r.Application_No == applicationNo);

                                string university = Convert.ToString(Session["UniversityCode"]);
                                int programesCounter = 0;
                                foreach (var detail in application)
                                {
                                    programesCounter++;
                            %>
                            <tr>
                                <td><%=programesCounter %></td>
                                <td><%=detail.Course_Code %></td>
                                <td><%=detail.Course_Section %></td>
                                <td><%=detail.No_of_Fulltime_Students %></td>
                                <td><%=detail.Min_Lec_Hrs_Per_Week_Trainer %></td>
                                <td><%=detail.Min_Course_Hrs_Per_Week_Sem %></td>
                                <td><%=detail.Max_Course_Hrs_Per_Week_Sem %></td>

                                <td>
                                    <label class="btn btn-danger" onclick="removeTrainer('<% =detail.Course_Code %>','<%=detail.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>

                            </tr>
                            <%  
                                } %>
                        </tbody>
                    </table>
                --%>

            </div>
             <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextSection_Click"/>
               <%-- <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="nextstep_Click" />--%>
                <div class="clearfix"></div>

            </div>
        </div>
         
     

        <%}
            else if (myStep == 29)
            {
    %>


    <div class="panel panel-default" style="width: 80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "007");
                var chapter1 = "";
                foreach (var header in headers1)
                {
                    chapter1 = header.Component_Description;
                }
            %>
            <p><%=chapter1 %></p>
            <label class="pull-right">Step <%=myStep %> of <%=maxStep %></label>
            <div class="clearfix"></div>
        </div>
        <div id="declarations" runat="server"></div>
        <div class="panel-body">
            <label>DECLARATION</label>
            <p>
                I declare that, to the best of my knowledge and belief, the information provided in this form is
                true and correct.
            </p>
            <div class="col-lg-12">
                <div class="form-group">

                    <asp:CheckBox runat="server" ID="CheckBoxdeclaration" />
                    <label class="font-noraml" for="acceptTerms">I agree with the Terms and Conditions.</label>
              
                    
                </div>

            </div>
            <div class="row">
                <div class="col-md-6 col-lg-6">
                    <div class="form-group">
                        <strong>Full Name:</strong>
                        <asp:TextBox runat="server" ID="name" placeholder="Full Name" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <label>
                Attach declaration from Director/ Principal with name, signature
                date and rubber stamp.
            </label>
              <div class="panel-body">
            <div class="row">
                <table class="table table-bordered table-striped datatable" id="example1">
                    <tr>
                        <th style="width: 10px">#</th>
                        <th>Document</th>
                        <th></th>

                    </tr>
                

                    <tr>
                        <td>1</td>
                        <td>Upload Signature</td>
                        <td>
                            <label class="btn btn-success" onclick="AccreditationDeclaration();">Attach Document</label></td>
                        <tr>
                    <tr>
                        <td>2</td>
                        <td>Upload Rubber Stamp</td>
                        <td>
                            <label class="btn btn-success" onclick="AccreditationDeclaration();">Attach Document</label></td>

                    </tr>

                </table>
            </div>
                  </div>
  
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Document Title</th>

                        <th>Delete</th>
                    </tr>
                </thead>
                <tbody>

                    <%
                        List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                        try
                        {%>
                    <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                        {
                            // var vendorNo = Convert.ToString(Session["vendorNo"]);
                            String leaveNo = Request.QueryString["applicationNo"];
                            string password = ConfigurationManager.AppSettings["S_PWD"];
                            string account = ConfigurationManager.AppSettings["S_USERNAME"];
                            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                            var secret = new SecureString();



                            foreach (char c in password)
                            {
                                secret.AppendChar(c);
                            }

                            ctx.Credentials = new NetworkCredential(account, secret, domainname);
                            ctx.Load(ctx.Web);
                            ctx.ExecuteQuery();
                            List list = ctx.Web.Lists.GetByTitle("KASNEB ESS");

                            //Get Unique rfiNumber
                            string uniqueLeaveNumber = leaveNo;

                            ctx.Load(list);
                            ctx.Load(list.RootFolder);
                            ctx.Load(list.RootFolder.Folders);
                            ctx.Load(list.RootFolder.Files);
                            ctx.ExecuteQuery();

                            FolderCollection allFolders = list.RootFolder.Folders;
                            foreach (Folder folder in allFolders)
                            {
                                if (folder.Name == "Accreditation")
                                {
                                    ctx.Load(folder.Folders);
                                    ctx.ExecuteQuery();
                                    var uniquerfiNumberFolders = folder.Folders;

                                    foreach (Folder folders in uniquerfiNumberFolders)
                                    {
                                        if (folders.Name == "Declaration")
                                        {
                                            ctx.Load(folders.Folders);
                                            ctx.ExecuteQuery();
                                            var uniquevendorNumberSubFolders = folders.Folders;

                                            foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                            {
                                                if (vendornumber.Name == uniqueLeaveNumber)
                                                {
                                                    ctx.Load(vendornumber.Files);
                                                    ctx.ExecuteQuery();

                                                    FileCollection vendornumberFiles = vendornumber.Files;
                                                    foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                    {%>
                    <% ctx.ExecuteQuery();
                        alldocuments.Add(new SharePointTModel { FileName = file.Name });
                        alldocuments.ToList();
                    %>


                    <% }%>

                    <%
                        foreach (var item in alldocuments)
                        {%>
                    <tr>
                        <td><% =item.FileName %></td>
                        <td>
                            <label class="btn btn-danger" onclick="deletedeclarationFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                    </tr>
                    <% }
                    %>

                    <%  }

                                                }


                                            }
                                        }

                                    }
                                }

                            }

                        }
                        catch (Exception t)
                        {

                            attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }

                    %>
                </tbody>
            </table>

        </div>


        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previousstep_Click" />
            <%if (alldocuments.Count > 0)
                { %>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="submit Application" OnClick="Application_Click" />
            <%} %>
            <div class="clearfix"></div>
        </div>
    </div>
   
    <%
        }%>

    <script>

        function deleteDeclaration(fileName8) {
            document.getElementById("filetoDelete").innerText = fileName;
            document.getElementById("MainContent_fileName8").value = fileName8;
            $("#deleteDeclarationModal").modal();
        }
    </script>

    <div id="deleteDeclarationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDelete"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName8" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteDeclaration" />
                </div>
            </div>

        </div>
    </div>



    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
        
    <script>

        function deleteRegistrationFile(filename1) {
            document.getElementById("filetoDeleteName").innerText = filename1;
            document.getElementById("MainContent_filename1").value = filename1;
            $("#deleteRegistrationFileModal").modal();
        }
    </script>
      
         <script>

             function deleteOrganizationFile(filename2) {
                 document.getElementById("filetoDeleteName").innerText = filename2;
                 document.getElementById("MainContent_filename2").value = filename2;
            $("#deleteOrganizationFileModal").modal();
        }
    </script>

         <script>

             function deleteStaffFile(filename3) {
                 document.getElementById("filetoDeleteName").innerText = filename3;
                 document.getElementById("MainContent_filename3").value = filename3;
            $("#deleteStaffFileModal").modal();
        }
    </script>
         <script>

             function deleteTrainersFile(filename4) {
                 document.getElementById("filetoDeleteName").innerText = filename4;
                 document.getElementById("MainContent_filename4").value = filename4;
            $("#deleteTrainersFileModal").modal();
        }
    </script>
         <script>

             function deleteEvaluationFile(filename5) {
                 document.getElementById("filetoDeleteName").innerText = filename5;
                 document.getElementById("MainContent_filename5").value = filename5;
            $("#deleteEvaluationFileModal").modal();
        }
    </script>
         <script>

             function deleteBuildingFile(filename6) {
                 document.getElementById("filetoDeleteName").innerText = filename6;
                 document.getElementById("MainContent_filename6").value = filename6;
            $("#deleteBuildingFileModal").modal();
        }
    </script>
         <script>

             function deleteEvaluationManagementFile(filename7) {
                 document.getElementById("filetoDeleteName").innerText = filename7;
                 document.getElementById("MainContent_filename7").value = filename7;
            $("#deleteEvaluationManagementFileModal").modal();
        }
    </script>

       


    <script>
        function removeLine(itemName, lineNo) {
            document.getElementById("itemName").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removeLineModal").modal();
        }
    </script>
    <script>
        function removeTrainer(itemName, lineNo) {
            document.getElementById("trainer").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removetrainer").modal();
        }
    </script>
    <script>
        function removeClass(itemName, lineNo) {
            document.getElementById("class").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removeclass").modal();
        }
    </script>
    <script>
        function removeRefBook(itemName, lineNo) {
            document.getElementById("refbook").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removerefbk").modal();
        }
    </script>
    <script>
        function removeComp(itemName, lineNo) {
            document.getElementById("comp").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removeComp").modal();
        }
    </script>
    <script>
        function removeCompDetails(itemName, lineNo) {
            document.getElementById("compDetails").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removecompdetails").modal();
        }
    </script>
      <script>
          function removeIctDetails(itemName, lineNo) {
            document.getElementById("compDetails").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removeIctdetails").modal();
        }
    </script>

    <script>
        function removeAdditionalDetails(itemName, lineNo) {
            document.getElementById("compAdditionalDetails").innerText = itemName;
            document.getElementById("MainContent_lineNo").value = lineNo;
            $("#removecompadditionaldetails").modal();
        }
    </script>
    <script>

        function deletedeclarationFile(fileName) {
            document.getElementById("filetoDeleteNames").innerText = fileName;
            document.getElementById("MainContent_fileNames").value = fileName;
            $("#deletedeclarationFileModal").modal();
        }
    </script>
    <script>
        function makePayments(no) {
            document.getElementById("MainContent_ApplicationNo").value = no;

            $("#MakepaymentsModal").modal();
        }
    </script>
          <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Registration Payments</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox7" type="hidden" />
                    <div class="form-group">
                        <strong>Invoice Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="ApplicationNo" placeholder="Invoice Number" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Amount"  ReadOnly="true"/>
                    </div>
                    <div class="form-group">
                        <strong>Phone Number:</strong>
                        <asp:TextBox runat="server" TextMode="Number" CssClass="form-control" ID="PhoneNumberPay" />
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payment" ID="SubmitPayment" OnClick="SubmitPayment_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteFile" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>
        <div id="deletedeclarationFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteNames"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileNames" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteDeclarationForm" OnClick="deleteDeclarationForm_Click" />
                </div>
            </div>

        </div>
    </div>   


       
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="itemName"></strong></p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteStaff" OnClick="deleteStaff_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removetrainer" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="trainer"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox1" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deletetrainer" OnClick="deletetrainer_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removeclass" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="class"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox2" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteclass" OnClick="deleteclass_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removerefbk" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="refbook"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox3" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteRefBook" OnClick="deleteRefBook_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removeComp" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="comp"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox4" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteComp" OnClick="deleteComp_Click" />
                </div>
            </div>

        </div>
    </div>
    <div id="removeIctdetails" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="ictDetails"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox5" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteictdetails" OnClick="deleteictdetails_Click"/>
                </div>
            </div>

        </div>
    </div>
    <div id="removecompdetails" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="compDetails"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox8" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="Button10" OnClick="deletecompdetails_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="removecompadditionaldetails" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Remove Line</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete <strong id="compAdditionalDetails"></strong></p>
                    <asp:TextBox runat="server" ID="TextBox6" type="hidden" />
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Line" ID="deleteadditionaldetails" OnClick="deleteadditionaldetails_Click" />
                </div>
            </div>

        </div>
    </div>
        <div id="DocumentsAttach" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Attach the Document</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <strong>Upload Document</strong><span class="text-danger" style="font-size: 25px">*</span>
                            <asp:FileUpload runat="server" CssClass="form-control" ID="uploadfile" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button21" OnClick="UploadDocuments_Click" />
                    </div>
                </div>

            </div>
        </div>
     <div id="DocumentsAttachDeclaration" class="modal fade" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Attach the Document</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <strong>Upload Document</strong><span class="text-danger" style="font-size: 25px">*</span>
                          <asp:FileUpload runat="server" CssClass="form-control" ID="declaration"></asp:FileUpload>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploaddeclaration" OnClick="uploaddeclaration_Click" />
                    </div>
                </div>

            </div>
        </div>
        <script type="text/javascript">
            function Accreditationttachdocuments() {
                $("#DocumentsAttach").modal();
            }
        </script>
         <script type="text/javascript">
             function AccreditationDeclaration() {
                $("#DocumentsAttachDeclaration").modal();
            }
        </script>
    <script>


        $("body").delegate(" .saveresponce", "click", function (event) {
            //To prevent form submit after ajax call

            event.preventDefault();

           
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            //declare an array
            var i = 0;


            $(".txtstep1").each(function () {
                var row = $(this);
                var onerfqitem = {};
                i++;

                onerfqitem.applicationNo = row.attr("id", "txtapplicationNo" + i).find(".txtapplicationNo").val();

                onerfqitem.questionCode = row.attr("id", "qncd" + i).find(".qncd").val();

                onerfqitem.response = row.attr("id", "respn" + i).find(".respn").val();

                onerfqitem.childquestionCode = row.attr("id", "childqncd" + i).find(".childqncd").val();

                onerfqitem.subquestionCode = row.attr("id", "parentqn" + i).find(".parentqn").val();

                onerfqitem.childResponse = row.attr("id", "childResponce" + i).find(".childResponce").val();

                allrfqitems.push(onerfqitem);

            });




            $.ajax({
                type: "POST",
                url: "Institution.aspx/InsertComponentItems",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Response Added!",
                                text: "Response saved successfully!",
                                type: "success"

                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Response saved successfully!");
                            });
                            break;

                        case "componentnull":
                            Swal.fire
                            ({
                                title: "Component not filled!",
                                text: "Component field empty!",
                                type: "danger"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').attr("class", "alert alert-danger");
                                $("#feedback").html("Component field empty!");
                            });
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Error!!!",
                                text: "Error Occured",
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html(status.d);
                            });

                            break;
                    }
                    document.querySelector('.btn2').style.display = 'block';
                    e.preventDefault();
                },
                error: function (err) {
                    console.log(err.statusText);
                    console.log(status.d);
                }

            });

           

          
                

                console.log(allrfqitems);

        });

        
        


    </script>

   
  
</asp:Content>
