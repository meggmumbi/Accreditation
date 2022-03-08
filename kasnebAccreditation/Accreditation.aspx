<%@ Page Title="" Language="C#" MasterPageFile="~/test.Master" AutoEventWireup="true" CodeBehind="Accreditation.aspx.cs" Inherits="kasnebAccreditation.Accreditation" %>

<%@ Import Namespace="kasnebAccreditation" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">

    <!-- page script -->

    <script src="Adminlte/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>

    <script src="Adminlte/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

    <script>
        $(function () {
            $('#example1').DataTable()
            $('#example2').DataTable({
                'paging': true,
                'lengthChange': true,
                'searching': true,
                'ordering': true,
                'info': true,
                'autoWidth': true
            })
        })
</script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%
        var nav = Config.ReturnNav();
        string percentange = "";
        string pendingAction = "";
        int count = 0;
        string university = Convert.ToString(Session["UniversityCode"]);
        var evaluationApplications = nav.EvaluationApplications.Where(r =>r.Insitution_Code == university && r.Status=="Open" && r.Type=="Self-Evaluation").ToList();
        var programs2 = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Payment Processing").ToList();
        var programs = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Completeness Checks").ToList();
        var programs3 = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Peer Review").ToList();
        var programs4 = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Awaiting Board Approval").ToList();
        var programs5 = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Completed").ToList();
        var inst = nav.applicationAccreditation.Where(r =>r.No  == university && r.Status == "Awaiting Closure").ToList();
        var inst1 = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Peer Review Ongoing").ToList();
        var inst3 = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Site Inspection Ongoing").ToList();
        var pendPayment = nav.applicationAccreditation.Where(r => r.No == university && r.Status == "Open" && r.Payment_Document==false).ToList();

        if (programs2.Count > 0)
        {
            percentange = "20%";
        }
        else if (programs.Count > 0)
        {
            percentange = "40%";
        }
        else if (programs3.Count > 0)
        {
            percentange = "60%";
        }
        else if (programs4.Count > 0)
        {
            percentange = "80%";
        }
        else if (programs5.Count > 0)
        {
            percentange = "100%";
        }

        if (inst.Count > 0)
        {
            count = inst.Count;
            pendingAction = "Awaiting Closure";
        }
        else if (inst1.Count > 0)
        {
            count = inst1.Count;
             pendingAction = "Peer Review Ongoing";
        }
        else   if (inst3.Count > 0)
        {
            count = inst3.Count;
             pendingAction = "Site Inspection Ongoing";
        }



         %>
    <!-- Content Header (Page header) -->


    <ol class="breadcrumb">
        <li><a href="Accreditation.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
        <li class="active">Dashboard</li>
    </ol>

    <!-- Main content -->
    <section class="content">
        <!-- Small boxes (Stat box) -->
        <div class="row">
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-aqua">
                    <div class="inner">

                        <h3><sup style="font-size: 20px"><%=percentange %></sup></h3>
                        <p>Status Of Application</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-bag"></i>
                    </div>
                    <a href="OngoingInstAccreditations.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-green">
                    <div class="inner">
                        <h3><%=pendPayment.Count %></h3>

                        <p>Application Pending Payment</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-stats-bars"></i>
                    </div>
                    <a href="PendingPayments.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-yellow">
                    <div class="inner">
                        <h3><%=count %></h3>

                        <p>Pending Action - <%=pendingAction %></p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-person-add"></i>
                    </div>
                    <a href="InstitutionPendingActions.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
            <div class="col-lg-3 col-xs-6">
                <!-- small box -->
                <div class="small-box bg-red">
                    <div class="inner">
                        <h3><%=evaluationApplications.Count %></h3>

                        <p>Self Evaluation Form</p>
                    </div>
                    <div class="icon">
                        <i class="ion ion-pie-graph"></i>
                    </div>
                    <a href="OpenSelfEvaluation.aspx" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                </div>
            </div>
            <!-- ./col -->
        </div>
        <!-- /.row -->
        <!-- Main row -->

        <div class="box">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#activity" data-toggle="tab">Institution</a></li>
                 <%--   <li><a href="#timeline" data-toggle="tab">Interim Accredited Institutions</a></li>--%>

                </ul>
                <div class="tab-content">
                    <div class="active tab-pane" id="activity">
                      <%--  <div class="box-header">
                            <h3 class="box-title">Institutions</h3>
                        </div>--%>
                        <!-- /.box-header -->
                        <div class="box-body">

                            <div class="panel-body">
                                <div id="feedback" runat="server"></div>
                                <table id="example1" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>No</th>
                                            <th>Name</th>
                                            <th>Institution Code</th>
                                          




                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            
                                           

                                            var details = nav.customer.Where(r => r.Customer_Type == "Institution" && r.No==university);

                                            int programesCounter = 0;
                                            foreach (var detail in details)
                                            {
                                                programesCounter++;
                                        %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.No %></td>
                                            <td><%=detail.Name %></td>
                                            <td><%=detail.University_Code %></td>
                                            




                                        </tr>
                                        <%  
                                            }

                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="timeline">
                        <div class="box-header">
                            <h3 class="box-title">Interim Accredited Institutions</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">

                            <div class="panel-body">
                                <div id="Div1" runat="server"></div>
                                <table id="example2" class="table table-bordered table-striped">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>No</th>
                                            <th>Name</th>
                                            <th>Institution Code</th>




                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            var nav1 = Config.ReturnNav();
                                            string universitys = Convert.ToString(Session["UniversityCode"]);

                                            var detailss = nav.customer.Where(r => r.Customer_Type == "Institution" && r.University_Code==university);

                                            int programesCounters = 0;
                                            foreach (var detail in details)
                                            {
                                                programesCounters++;
                                        %>
                                        <tr>
                                            <td><%=programesCounters %></td>
                                            <td><%=detail.No %></td>
                                            <td><%=detail.Name %></td>
                                            <td><%=detail.University_Code %></td>




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

    </section>




    <!-- /.content -->


</asp:Content>
