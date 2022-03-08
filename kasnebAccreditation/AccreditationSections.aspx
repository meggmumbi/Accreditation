<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="AccreditationSections.aspx.cs" Inherits="kasnebAccreditation.AccreditationSections" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="kasnebAccreditation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="card">
            <div class="card-header text-center" data-background-color="darkgreen">
                <h3 class="title"><strong>Welcome to Accreditation Portal</strong></h3>
            </div>
        </div>
    </div>
    <center class="center-item">
            <p style="color:black"><strong>Please Complete all sections.</strong></p></center>
    <h5><u>All Sections</u></h5>

    <div class="row">
        <%   var nav = Config.ReturnNav();
            var accreditationQuestions = (dynamic)null;
            var applicationResponse = (dynamic)null;
        %>
        <div class="col-md-12 col-lg-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    Application Chapters
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped datatable" id="institution">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Fill Details</th>
                        </thead>
                        <tbody>
                            <%
                                string course = Request.QueryString["courseId"];
                                string applicationNo = Request.QueryString["applicationNo"];
                                var AccreditationResonce = nav.applicationResponce.Where(r => r.Application_No == applicationNo);
                                var applicationChapters = nav.applicationChapter;
                                int counter = 0;
                                foreach (var applicationChapter in applicationChapters)
                                {
                                    counter++;
                            %>
                            <tr>
                                <td><%=counter %></td>
                                <td><%=applicationChapter.Component_Description %></td>

                                <%if (applicationChapter.Code == "001")
                                    {
                                        //Chapters
                                        var Questions = nav.questionSetup.Where(r => r.Chapter == "001").ToList();

                                        List<QuestionsModel> QuestionSetup = new List<QuestionsModel>();
                                        QuestionsModel list1 = new QuestionsModel();
                                        List<QuestionsModel> AccredQuestions = new List<QuestionsModel>();
                                        List<QuestionsModel> ResponseQuestions01 = new List<QuestionsModel>();
                                        foreach (var questionSetp in Questions)
                                        {


                                            list1.chapter = questionSetp.Chapter;
                                            list1.topic = questionSetp.Code;
                                            QuestionSetup.Add(list1);

                                            //Accreditation Questions
                                            accreditationQuestions = nav.accreditationQns.Where(r => r.Question_No == list1.topic).ToList();
                                            QuestionsModel list = new QuestionsModel();
                                            QuestionsModel reponse01 = new QuestionsModel();
                                            foreach (var subtopic in accreditationQuestions)
                                            {
                                                list.QuestionCode = subtopic.Code;
                                                AccredQuestions.Add(list);


                                                //Application Response 
                                                applicationResponse = nav.applicationResponce.Where(r => r.Application_No == applicationNo && r.Question_Code == list.QuestionCode).ToList();
                                                foreach (var Responsesubtopic in applicationResponse)
                                                {
                                                    reponse01.QuestionCode = Responsesubtopic.Question_Code;
                                                    ResponseQuestions01.Add(reponse01);
                                                }
                                            }
                                        }
                                        if (ResponseQuestions01.Count < AccredQuestions.Count)
                                        {%>
                                <td><strong style="color: red"><%="Section Incomplete!" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa fa-arrow-circle-o-right"></i>Fill Form</a></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: green"><%="Complete!. Please proceed to the next section." %></strong></td>
                                <td></td>
                                <%}  %>

                                <%  }

                                    else if (applicationChapter.Code == "002")
                                    {
                                        //Chapters
                                        var Questions = nav.questionSetup.Where(r => r.Chapter == "002").ToList();
                                        List<QuestionsModel> QuestionSetup02 = new List<QuestionsModel>();
                                        QuestionsModel list2 = new QuestionsModel();
                                        List<QuestionsModel> AccredQuestions = new List<QuestionsModel>();
                                        List<QuestionsModel> ResponseQuestions = new List<QuestionsModel>();
                                        foreach (var questionSetp in Questions)
                                        {


                                            list2.chapter = questionSetp.Chapter;
                                            list2.topic = questionSetp.Code;
                                            QuestionSetup02.Add(list2);

                                            //Accreditation Questions
                                            accreditationQuestions = nav.accreditationQns.Where(r => r.Question_No == list2.topic && r.Question_Type != "Table" && r.Question_Type != "Label" && r.Question_Type != "Attachment").ToList();
                                            QuestionsModel list = new QuestionsModel();
                                            QuestionsModel reponse = new QuestionsModel();
                                            foreach (var subtopic in accreditationQuestions)
                                            {
                                                list.QuestionCode = subtopic.Code;
                                                AccredQuestions.Add(list);


                                                //Application Response 
                                                applicationResponse = nav.applicationResponce.Where(r => r.Application_No == applicationNo && r.Question_Code == list.QuestionCode).ToList();
                                                foreach (var Responsesubtopic in applicationResponse)
                                                {
                                                    reponse.QuestionCode = Responsesubtopic.Question_Code;
                                                    ResponseQuestions.Add(reponse);
                                                }


                                            }
                                        }
                                        if (ResponseQuestions.Count < AccredQuestions.Count)
                                        {%>
                                <td><strong style="color: red"><%="Section Incomplete" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa fa-arrow-circle-o-right"></i>Fill Form</a></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: green"><%="Complete!. Please proceed to the next section." %></strong></td>
                                <td></td>
                                <%}  %>


                                <%  }

                                    else if (applicationChapter.Code == "003")
                                    {
                                        //Chapters
                                        var Questions = nav.questionSetup.Where(r => r.Chapter == "003").ToList();
                                        List<QuestionsModel> QuestionSetup02 = new List<QuestionsModel>();
                                        QuestionsModel list2 = new QuestionsModel();
                                        List<QuestionsModel> AccredQuestions = new List<QuestionsModel>();
                                        List<QuestionsModel> ResponseQuestions = new List<QuestionsModel>();
                                        foreach (var questionSetp in Questions)
                                        {


                                            list2.chapter = questionSetp.Chapter;
                                            list2.topic = questionSetp.Code;
                                            QuestionSetup02.Add(list2);

                                            //Accreditation Questions
                                            accreditationQuestions = nav.accreditationQns.Where(r => r.Question_No == list2.topic && r.Question_Type != "Table" && r.Question_Type != "Label" && r.Question_Type != "Attachment").ToList();
                                            QuestionsModel list = new QuestionsModel();
                                            QuestionsModel reponse = new QuestionsModel();
                                            foreach (var subtopic in accreditationQuestions)
                                            {
                                                list.QuestionCode = subtopic.Code;
                                                AccredQuestions.Add(list);


                                                //Application Response 
                                                applicationResponse = nav.applicationResponce.Where(r => r.Application_No == applicationNo && r.Question_Code == list.QuestionCode).ToList();
                                                foreach (var Responsesubtopic in applicationResponse)
                                                {
                                                    reponse.QuestionCode = Responsesubtopic.Question_Code;
                                                    ResponseQuestions.Add(reponse);
                                                }


                                            }
                                        }
                                        if (ResponseQuestions.Count < AccredQuestions.Count)
                                        {%>
                                <td><strong style="color: red"><%="Section Incomplete" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa fa-arrow-circle-o-right"></i>Fill Form</a></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: green"><%="Complete!. Please proceed to the next section." %></strong></td>
                                <td></td>
                                <%}  %>

                                <%  }

                                    else if (applicationChapter.Code == "004")
                                    {
                                        //Chapters
                                        var Questions = nav.questionSetup.Where(r => r.Chapter == "004").ToList();
                                        List<QuestionsModel> QuestionSetup02 = new List<QuestionsModel>();
                                        QuestionsModel list2 = new QuestionsModel();
                                        List<QuestionsModel> AccredQuestions = new List<QuestionsModel>();
                                        List<QuestionsModel> ResponseQuestions = new List<QuestionsModel>();
                                        foreach (var questionSetp in Questions)
                                        {


                                            list2.chapter = questionSetp.Chapter;
                                            list2.topic = questionSetp.Code;
                                            QuestionSetup02.Add(list2);

                                            //Accreditation Questions
                                            accreditationQuestions = nav.accreditationQns.Where(r => r.Question_No == list2.topic && r.Question_Type != "Table" && r.Question_Type != "Label" && r.Question_Type != "Attachment").ToList();
                                            QuestionsModel list = new QuestionsModel();
                                            QuestionsModel reponse = new QuestionsModel();
                                            foreach (var subtopic in accreditationQuestions)
                                            {
                                                list.QuestionCode = subtopic.Code;
                                                AccredQuestions.Add(list);


                                                //Application Response 
                                                applicationResponse = nav.applicationResponce.Where(r => r.Application_No == applicationNo && r.Question_Code == list.QuestionCode).ToList();
                                                foreach (var Responsesubtopic in applicationResponse)
                                                {
                                                    reponse.QuestionCode = Responsesubtopic.Question_Code;
                                                    ResponseQuestions.Add(reponse);
                                                }


                                            }
                                        }
                                        if (ResponseQuestions.Count < AccredQuestions.Count)
                                        {%>
                                <td><strong style="color: red"><%="Section Incomplete" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa fa-arrow-circle-o-right"></i>Fill Form</a></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: green"><%="Complete!. Please proceed to the next section" %></strong></td>
                                <td></td>
                                <%}  %>


                                <%  }
                                    else if (applicationChapter.Code == "007")
                                    {

                                        List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                        try
                                        {

                                            using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
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
                                                                        {
                                                                            ctx.ExecuteQuery();
                                                                            alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                                                            alldocuments.ToList();

                                                                        }

                                                                    }


                                                                }
                                                            }

                                                        }
                                                    }

                                                }
                                            }
                                        }
                                        catch (Exception t)
                                        {


                                        }

                                        if (alldocuments.Count < 7)
                                        {%>
                                <td><strong style="color: red"><%="Section Incomplete" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa-file-pdf-o"></i>Attach Documents</a></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: green"><%="Complete!. Please proceed to the next section" %></strong></td>
                                <td></td>
                                <%}
                                    } 
                                         else if (applicationChapter.Code == "008")
                                         {

                                             var applicationAccreditation = nav.applicationAccreditation.Where(r => r.Application_No == applicationNo && r.Payment_Document == false).ToList();




                                             if (applicationAccreditation.Count > 0)
                                             {%>
                                <td><strong style="color: red"><%="Section Incomplete" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa-money"></i>Fill Form</a></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: green"><%="Payment attached!. Please proceed." %></strong></td>
                                <td></td>
                                <%}  %>

                                <%  }
                                    else if (applicationChapter.Code == "009")
                                    {

                                        var applicationAccreditation = nav.applicationAccreditation.Where(r => r.Application_No == applicationNo && r.Payment_Document == true && r.Submitted == true).ToList();




                                        if (applicationAccreditation.Count > 0)
                                        {%>
                                <td><strong style="color: green"><%="Application Submitted. Please wait while it is being processed." %></strong></td>
                                <td></td>
                                <%}
                                    else
                                    { %>
                                <td><strong style="color: red"><%="Section Incomplete" %></strong></td>
                                <td><a href="Institution.aspx?code=<%=applicationChapter.Code%>&&applicationNo=<%=applicationNo %>" class="btn btn-default"><i class="fa fa-file"></i>Fill Form</a></td>
                                <%}  %>

                                <%  }
                                    else
                                    {%>
                                <td></td>
                                <td></td>
                                <%} %>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <div class="clearfix"></div>
    </div>
</asp:Content>
