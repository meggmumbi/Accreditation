<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="selfEvalution.aspx.cs" Inherits="kasnebAccreditation.selfEvalution" %>

<%@ Import Namespace="System.IO" %>
    <%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
    <script src="css/sweetalert2.all.js"></script>

    <script>
        function success() {
            Swal.fire(
                'successful'

            )
        }
    </script>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        const int maxStep = 12;
        var nav = Config.ReturnNav();
        String accreditationNo = "";
        String applicationNo = "";
        try
        {
            accreditationNo = Request.QueryString["accreditationNo"].Trim();
            applicationNo = Request.QueryString["applicationNo"].Trim();
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
       <div runat="server" id="linesFeedback"></div>
        <div id="Div19" runat="server"></div>
     
        <div class="panel-body">
              
    <%
         
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "001" &&r.Code=="001");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionCode = subtopic.Code;
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.response = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
                  <div class="form-group">
                     
                           
                      <div class="row">
                          <div class="col-md-8 col-lg-8">
                              <p>
                                  <label id="topicdescription"><%=TopicDescription %></label>
                                 
                              </p>
                          </div>
                          <div class="col-md-2 col-lg-2">
                              <label>Max score</label>
                          </div>
                          <div class="col-md-2 col-lg-2">
                              <label>Score</label>
                          </div>
                      </div>

                      <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>
                         
                    <div class="txtstep1">
                      <div class="row">
                          <div class="col-md-8 col-lg-8">
                              <div class="form-group">
                                    <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                                   <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                                   <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                                  <p><%=NumberofQuestions%>.<%=item.QuestionDescription %></p>
                                   <input type="hidden" class="qncd"  value="<%=item.QuestionCode%>"/><br />
                              </div>
                          </div>

                          <div class="col-md-2 col-lg-2">
                              <div class="form-group">

                                  <p><%=item.maxscore%></p>
                              </div>
                          </div>
                          <div class="col-md-2 col-lg-2">
                              <p>
                                  <input type="number" runat="server" class="form-control respn" font-bold="true" /> 
                                  
                              </p>

                              <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                          </div>
                      </div>





                      <%
            }
          %>
           </div>
                      </div>
            <%
           }

            %>

         
           
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "001" &&r.Code=="002");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionCode = subtopic.Code;
                         list.QuestionDescription = subtopic.Description;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                <div class="txtstep1">

                    <div class="row">
                        <div class="col-md-8 col-lg-8">
                            <div class="form-group">
                                <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                                 <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                                <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>" />
                                <p><%=NumberofQuestion%>.<%=item.QuestionDescription %></p>
                                <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                            </div>
                        </div>

                        <div class="col-md-2 col-lg-2">
                            <div class="form-group">

                                <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                       <input type="number" runat="server" class="form-control respn" font-bold="true" /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
        var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "001" &&r.Code=="003");
        int NumberofQuestionz = 0;
        var TopicDescriptionz = "";
        var TopicNumberz = "";
        foreach (var topic in Questionz)
        {
            TopicDescriptionz = topic.Description;
            TopicNumberz = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
            <div class="form-group">
             
                   
                <p>
                 <label id="topicdescription"><%=TopicDescriptionz %></label>
                   
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                   
                <div class="txtstep1">
                    <div class="row">
                        <div class="col-md-8 col-lg-8">
                            <div class="form-group">
                                <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                                 <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                                <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>" />
                                <p><%=NumberofQuestionz%>.<%=item.QuestionDescription %></p>
                                <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                            </div>
                        </div>

                        <div class="col-md-2 col-lg-2">
                            <div class="form-group">

                                <p><%=item.maxscore%></p>
                            </div>
                        </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea> 
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
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
        else if (myStep == 2)
        {
    %>
   
     <div class="panel panel-default" style="width:80%; margin: 0 auto" >
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
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "001" &&r.Code=="004");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
    %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <p>
                            <label id="topicdescription"><%=TopicDescription %></label>
                        </p>
                    </div>
                    <div class="col-md-2 col-lg-2">
                        <label>Max score</label>
                    </div>
                    <div class="col-md-2 col-lg-2">
                        <label>Score</label>
                    </div>
                </div>

                <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>

                  <div class="txtstep1">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <div class="form-group">
                              <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                             <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                             <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                            <p><%=NumberofQuestions%>.<%=item.QuestionDescription %></p>
                        </div>
                    </div>

                    <div class="col-md-2 col-lg-2">
                        <div class="form-group">

                            <p><%=item.maxscore%></p>
                        </div>
                    </div>
                    <div class="col-md-2 col-lg-2">
                        <p>
                            <input type="number" runat="server" class="form-control respn" font-bold="true" /> 
                        </p>

                        <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                    </div>
                </div>





                <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "001" &&r.Code=="005");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                   
                <div class="txtstep1">
               <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                          <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>"/>
                     <p> <%=NumberofQuestion%>.<%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true"  /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "001" &&r.Code=="006");
                 int NumberofQuestionz = 0;
                 var TopicDescriptionz = "";
                 var TopicNumberz = "";
                 foreach (var topic in Questionz)
                 {
                     TopicDescriptionz = topic.Description;
                     TopicNumberz = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                         QuestionsModellist.Add(list);
                     }
                 %>
            <div class="form-group">
             
                <p>
                 <label id="topicdescription"><%=TopicDescriptionz %></label>
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                   
                <div class="txtstep1">
          <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                          <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>"/>
                     <p> <%=NumberofQuestionz%>.<%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true"  /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>

             <center> <asp:Button runat="server" CssClass="btn btn-success saveresponce" Text="Save" OnClick="Unnamed_Click1"/><%-- <input type="submit" class="btn btn-success saveresponce" value="Save"/>--%></center>
         </div>
             <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

       <%
        }
        else if (myStep == 3)
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
        <div id="Div2" runat="server"></div>
        <div class="panel-body">
            <%
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" &&r.Code=="007");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
            %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                        <p>
                            <label id="topicdescription"><%=TopicDescription %></label>
                        </p>
                    </div>
                    <div class="col-md-2 col-lg-2">
                        <label>Max score</label>
                    </div>
                    <div class="col-md-2 col-lg-2">
                        <label>Score</label>
                    </div>
                </div>

                <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                %>
                <div class="txtstep1">

                    <div class="row">
                        <div class="col-md-8 col-lg-8">
                            <div class="form-group">
                                <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                                <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                                 <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                                <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>" />
                                <p><%=NumberofQuestions%>.<%=item.QuestionDescription %></p>
                            </div>
                        </div>

                        <div class="col-md-2 col-lg-2">
                            <div class="form-group">

                                <p><%=item.maxscore%></p>
                            </div>
                        </div>
                        <div class="col-md-2 col-lg-2">
                            <p>
                                <input type="number" runat="server" class="form-control respn" font-bold="true"  /></p>
                            <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                        </div>
                    </div>





                    <%
            }
                    %>
                </div>
                </div>
                <%
           }

                %>
                <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" &&r.Code=="008");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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

                    <div class="txtstep1">
                        <div class="row">
                            <div class="col-md-8 col-lg-8">
                                <div class="form-group">
                                    <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                                    <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                                     <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                                    <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>" />
                                    <p><%=NumberofQuestion%>.<%=item.QuestionDescription %></p>
                                </div>
                            </div>

                            <div class="col-md-2 col-lg-2">
                                <div class="form-group">

                                    <p><%=item.maxscore%></p>
                                </div>
                            </div>
                            <div class="col-md-2 col-lg-2">
                                <p>
                                    <input type="number" runat="server" class="form-control respn" font-bold="true"   /></p>
                                <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                            </div>
                        </div>





                        <%
            }
                        %>
                    </div>
                    </div>
                    <%
           }

                    %>
                    <%
                 var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" &&r.Code=="009");
                 int NumberofQuestionz = 0;
                 var TopicDescriptionz = "";
                 var TopicNumberz = "";
                 foreach (var topic in Questionz)
                 {
                     TopicDescriptionz = topic.Description;
                     TopicNumberz = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionCode = subtopic.Code;
                         list.QuestionDescription = subtopic.Description;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                         QuestionsModellist.Add(list);
                     }
                    %>
                    <div class="form-group">

                        <p>
                            <label id="topicdescription"><%=TopicDescriptionz %></label>
                        </p>

                        <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                        %>

                        <div class="txtstep1">
                            <div class="row">
                                <div class="col-md-8 col-lg-8">
                                    <div class="form-group">
                                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                                        <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>" />
                                        <p><%=NumberofQuestionz%>.<%=item.QuestionDescription %></p>
                                    </div>
                                </div>

                                <div class="col-md-2 col-lg-2">
                                    <div class="form-group">

                                        <p><%=item.maxscore%></p>
                                    </div>
                                </div>
                                <div class="col-md-2 col-lg-2">
                                    <p>
                                        <input type="number" runat="server" class="form-control respn" font-bold="true"  /></p>
                                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                                </div>
                            </div>





                            <%
            }
                            %>
                        </div>
                        </div>
                        <%
           }

                        %>
                        <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
                    </div>
                    <div class="panel-footer">
                        <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right  btn2" style="display:none;" Text="Next" OnClick="nextstep_Click" />
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
        <div id="Div3" runat="server"></div>
        <div class="panel-body">
    <%
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" &&r.Code=="010");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
             
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                <p>
                 <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                        </div>
               <div class="col-md-2 col-lg-2">
                 <label>Max score</label>
                   </div>
                      <div class="col-md-2 col-lg-2">
                <label>Score</label>
                     </div>
            </div>

            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>
                   
               <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                            <p> <%=NumberofQuestions%>.<%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true"   /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" &&r.Code=="011");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionCode = subtopic.Code;
                         list.QuestionDescription = subtopic.Description;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                    <div class="txtstep1">
              
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                          <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>"/>
                     <p> <%=NumberofQuestion%>.<%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true"  /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" &&r.Code=="012");
                 int NumberofQuestionz = 0;
                 var TopicDescriptionz = "";
                 var TopicNumberz = "";
                 foreach (var topic in Questionz)
                 {
                     TopicDescriptionz = topic.Description;
                     TopicNumberz = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                         QuestionsModellist.Add(list);
                     }
                 %>
            <div class="form-group">
             
                <p>
                 <label id="topicdescription"><%=TopicDescriptionz %></label>
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                    <div class="txtstep1">
              
                  <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                          <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>"/>
                     <p> <%=NumberofQuestionz%>.<%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true"  /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>

            <center> <button type="submit" class="btn btn-success saveresponce">Save</button> </center>
         </div>
             <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div> 
    
       <%
        }
        else if (myStep == 5)
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
                    <div id="Div4" runat="server"></div>
                    <div class="panel-body">
    <%
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" && r.Code == "013");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore = 0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                <p>
                 <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                        </div>
               <div class="col-md-2 col-lg-2">
                 <label>Max score</label>
                   </div>
                      <div class="col-md-2 col-lg-2">
                <label>Score</label>
                     </div>
            </div>

            <% 
                foreach (var item in QuestionsModellist)
                {
                    NumberofQuestions += 1;
                    %>
                   
              <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                            <p> <%=NumberofQuestions%>.<%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true" /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
                }
          %>
           </div>
                </div>
            <%
                }

            %>
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "002" && r.Code == "014");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore = 0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                   
              <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>"/>
                     <p> <%=NumberofQuestion%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
                }
          %>
           </div>
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
        <div id="Div5" runat="server"></div>
        <div class="panel-body">
    <%
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="015");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                <p>
                 <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                        </div>
               <div class="col-md-2 col-lg-2">
                 <label>Max score</label>
                   </div>
                      <div class="col-md-2 col-lg-2">
                <label>Score</label>
                     </div>
            </div>

            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>
                   
               <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                            <p> <%=NumberofQuestions%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true" /> </p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="016");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionCode = subtopic.Code;
                         list.QuestionDescription = subtopic.Description;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                   
               <div class="txtstep1">

             <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>"/>
                     <p> <%=NumberofQuestion%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                      <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="017");
                 int NumberofQuestionz = 0;
                 var TopicDescriptionz = "";
                 var TopicNumberz = "";
                 foreach (var topic in Questionz)
                 {
                     TopicDescriptionz = topic.Description;
                     TopicNumberz = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                         QuestionsModellist.Add(list);
                     }
                 %>
            <div class="form-group">
             
                <p>
                 <label id="topicdescription"><%=TopicDescriptionz %></label>
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                   
               <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>"/>
                     <p> <%=NumberofQuestionz%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true"  /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
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
        <div id="Div6" runat="server"></div>
        <div class="panel-body">
    <%
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="018");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                <p>
                 <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                        </div>
               <div class="col-md-2 col-lg-2">
                 <label>Max score</label>
                   </div>
                      <div class="col-md-2 col-lg-2">
                <label>Score</label>
                     </div>
            </div>

            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>
                   <div class="txtstep1">
              
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                       <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                         <p> <%=NumberofQuestions%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="019");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                   
              <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>"/>
                     <p> <%=NumberofQuestion%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                        <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="020");
                 int NumberofQuestionz = 0;
                 var TopicDescriptionz = "";
                 var TopicNumberz = "";
                 foreach (var topic in Questionz)
                 {
                     TopicDescriptionz = topic.Description;
                     TopicNumberz = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                         QuestionsModellist.Add(list);
                     }
                 %>
            <div class="form-group">
             
                <p>
                 <label id="topicdescription"><%=TopicDescriptionz %></label>
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                   
              <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>"/>
                     <p> <%=NumberofQuestionz%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                     </div>
            </div>
  
            <%
            }
          %>
           </div>
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
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "003" &&r.Code=="021");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                <p>
                 <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                        </div>
               <div class="col-md-2 col-lg-2">
                 <label>Max score</label>
                   </div>
                      <div class="col-md-2 col-lg-2">
                <label>Score</label>
                     </div>
            </div>

            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>
                   
              <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                            <p> <%=NumberofQuestions%> ) <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                        <input type="number" runat="server" class="form-control respn" font-bold="true"  /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
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
        <div id="Div8" runat="server"></div>
        <div class="panel-body">
    <%
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "004" &&r.Code=="022");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            var maxscore=0;
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                list.QuestionCode = subtopic.Code;
                list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                QuestionsModellist.Add(list);
            }
                 %>
            <div class="form-group">
                <div class="row">
                    <div class="col-md-8 col-lg-8">
                <p>
                 <label id="topicdescription"><%=TopicDescription %></label>
                </p>
                        </div>
               <div class="col-md-2 col-lg-2">
                 <label>Max score</label>
                   </div>
                      <div class="col-md-2 col-lg-2">
                <label>Score</label>
                     </div>
            </div>

            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestions += 1;
                    %>
                   
                <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                                               <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                            <p> <%=NumberofQuestions%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Question = nav.selfEvaluation.Where(r => r.Chapter_Code == "004" &&r.Code=="023");
                 int NumberofQuestion = 0;
                 var TopicDescriptions = "";
                 var TopicNumbers = "";
                 foreach (var topic in Question)
                 {
                     TopicDescriptions = topic.Description;
                     TopicNumbers = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionDescription = subtopic.Description;
                         list.QuestionCode = subtopic.Code;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
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
                     <div class="txtstep1">
              
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbers%>"/>
                     <p> <%=NumberofQuestion%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true"/></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
             <%
                 var Questionz = nav.selfEvaluation.Where(r => r.Chapter_Code == "004" &&r.Code=="024");
                 int NumberofQuestionz = 0;
                 var TopicDescriptionz = "";
                 var TopicNumberz = "";
                 foreach (var topic in Questionz)
                 {
                     TopicDescriptionz = topic.Description;
                     TopicNumberz = topic.Code;

                     var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                     var subtopicdescription = "";
                     var maxscore=0;
                     List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                     QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                     foreach (var subtopic in SubQuestions)
                     {
                         QuestionsModel list = new QuestionsModel();
                         list.QuestionNumber = subtopic.Component_Code;
                         list.QuestionCode = subtopic.Code;
                         list.QuestionDescription = subtopic.Description;
                         list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                         QuestionsModellist.Add(list);
                     }
                 %>
            <div class="form-group">
             
                <p>
                 <label id="topicdescription"><%=TopicDescriptionz %></label>
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                   
              <div class="txtstep1">
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumberz%>"/>
                     <p> <%=NumberofQuestionz%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
                </div>
            <%
           }

            %>
              <%
                  var Questio = nav.selfEvaluation.Where(r => r.Chapter_Code == "004" &&r.Code=="025");
                  int NumberofQuestio = 0;
                  var TopicDescriptio = "";
                  var TopicNumbe = "";
                  foreach (var topic in Questio)
                  {
                      TopicDescriptio = topic.Description;
                      TopicNumbe = topic.Code;

                      var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
                      var subtopicdescription = "";
                      var maxscore=0;
                      List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
                      QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
                      foreach (var subtopic in SubQuestions)
                      {
                          QuestionsModel list = new QuestionsModel();
                          list.QuestionNumber = subtopic.Component_Code;
                          list.QuestionDescription = subtopic.Description;
                          list.QuestionCode = subtopic.Code;
                          list.maxscore = Convert.ToDecimal(subtopic.Maximum_Score);
                          QuestionsModellist.Add(list);
                      }
                 %>
            <div class="form-group">
             
                <p>
                 <label id="topicdescription"><%=TopicDescriptio %></label>
                </p>
                        
            <% 
                    foreach (var item in QuestionsModellist) 
                     {
                       NumberofQuestionz += 1;
                    %>
                   
                   <div class="txtstep1">
              
                         <div class="row">
                <div class="col-md-8 col-lg-8">
                    <div class="form-group">
                         <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                         <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumbe%>"/>
                     <p> <%=NumberofQuestionz%>. <%=item.QuestionDescription %></p>
                    </div>
                </div>
               
                  <div class="col-md-2 col-lg-2">
                    <div class="form-group">
                        
               <p><%=item.maxscore%></p>
                    </div>
                </div>
                <div class="col-md-2 col-lg-2">
                    <p>
                         <input type="number" runat="server" class="form-control respn" font-bold="true" /></p>
                    <textarea Class="form-control textrespn" rows="2" style="display:none"></textarea>
                
                     </div>
            </div>
                
               
                           
                   
               
            <%
            }
          %>
           </div>
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
      <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "005");
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
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "005" &&r.Code=="026");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
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
                        <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                        <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                             <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                        <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>"/>
                   <%=NumberofQuestions%>.<label id="subtopicdescription"><%=item.QuestionDescription %></label>
                   
                   
                       <p><input type="number" runat="server" class="form-control respn" font-bold="true" style="display:none"/></p>
                           <textarea Class="form-control textrespn" ></textarea>
                         
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
          
             else if (myStep == 11)
        {
    %>
      <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "005");
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
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "005" &&r.Code=="027");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionCode = subtopic.Code;
                list.QuestionDescription = subtopic.Description;
                

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
                            <input type="hidden" class="qncd" value="<%=item.QuestionCode%>" /><br />
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" class="txtapplicationNo" />
                            <input type="hidden" value="<% =Request.QueryString["code"] %>" class="txtcode" />
                            <input hidden="hidden" class="componentCode" value="<%=TopicNumber%>" />
                            <%=NumberofQuestions%>.<label id="subtopicdescription"><%=item.QuestionDescription %></label>
                           

                            
                                <input type="number" runat="server" class="form-control respn" font-bold="true" style="display:none" />
                    <p>
                        <textarea class="form-control textrespn" ></textarea></p>

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
            <asp:Button runat="server" CssClass="btn btn-success pull-right btn2" style="display:none;"  Text="Next" OnClick="nextstep_Click" />
            <div class="clearfix"></div>
        </div>
    </div>

        <%

        }  
              else if (myStep == 12)
        {
    %>
      <div class="panel panel-default" style="width:80%; margin: 0 auto">
        <div class="panel-heading" id="institutional">
            <%
                var headers1 = nav.applicationChapter.Where(r => r.Code == "006");
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
        var Questions = nav.selfEvaluation.Where(r => r.Chapter_Code == "006" &&r.Code=="028");
        int NumberofQuestions = 0;
        var TopicDescription = "";
        var TopicNumber = "";
        foreach (var topic in Questions)
        {
            TopicDescription = topic.Description;
            TopicNumber = topic.Code;

            var SubQuestions = nav.EvaluationSubtopic.Where(r => r.Component_Code == topic.Code);
            var subtopicdescription = "";
            List<QuestionsModel> QuestionsModellist = new List<QuestionsModel>();
            QuestionsModel[] QuestionsArray = QuestionsModellist.ToArray();
            foreach (var subtopic in SubQuestions)
            {
                QuestionsModel list = new QuestionsModel();
                list.QuestionNumber = subtopic.Component_Code;
                list.QuestionDescription = subtopic.Description;
                
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
                   <%=NumberofQuestions%>.<label id="subtopicdescription"><%=item.QuestionDescription %></label>
                    <br />
                   
                       
                          <asp:TextBox runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                         
                 </div>
           
            <%
            }
          %>
           </div>
            <%
           }

            %>

            
            <label>DECLARATION</label>
            <p>
                I declare that, to the best of my knowledge and belief, the information provided in this form is
true and correct.
            </p>
            <label>Scoring was undertaken by
            </label>

            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <strong>Select file to upload:</strong>
                        <asp:FileUpload runat="server" CssClass="form-control" ID="declaration"></asp:FileUpload>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                    <div class="form-group">
                        <br />
                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploaddeclaration" OnClick="uploaddeclaration_Click1"/>
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
                           string university = Convert.ToString(Session["UniversityCode"]);
                       String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                           String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "University Application/";
                        
                            String documentDirectory = filesFolder + applicationNo+"/";
                            if (Directory.Exists(documentDirectory))
                            {
                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                {
                                    String url = documentDirectory;
                   %>
                   <tr>
                       <td><% =file.Replace(documentDirectory, "") %></td>

                       <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo+"\\"+file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                       <td>
                           <label class="btn btn-danger" onclick="deleteDeclaration('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
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

        </div>


        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="View score" OnClick="Unnamed_Click2" />

            <div class="clearfix"></div>
        </div>
    </div>

         

        <%

        }  
            
            
            %>


        <script>
        
           function deleteDeclaration(fileName) {
               document.getElementById("filetoDelete").innerText = fileName;
               document.getElementById("MainContent_fileName").value = fileName;
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
        <p>Are you sure you want to delete the file <strong id="filetoDelete"></strong> ?</p>
          <asp:TextBox runat="server" ID="fileName" type="hidden"/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
          <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteDeclaration" OnClick="deleteDeclaration_Click" />
      </div>
    </div>

  </div>
</div>

     <script src="Adminlte/bower_components/jquery/dist/jquery.min.js"></script>
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

                onerfqitem.evaluationHeader = row.attr("id", "txtcode" + i).find(".txtcode").val();
              
                onerfqitem.questionCode = row.attr("id", "qncd" + i).find(".qncd").val();

                onerfqitem.ComponentCode = row.attr("id", "componentCode" + i).find(".componentCode").val();
              
                onerfqitem.response = row.attr("id", "respn" + i).find(".respn").val();

                onerfqitem.comment = row.attr("id", "textrespn" + i).find(".textrespn").val();
                  
                allrfqitems.push(onerfqitem);
                
            });

         


            $.ajax({
                type: "POST",
                url: "selfEvalution.aspx/InsertComponentItems",
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
                                text: "Score should not exceed the maximum score",
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
