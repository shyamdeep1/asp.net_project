<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="manage_job.aspx.cs" Inherits="Job_Portal.manage_job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>JobBoard - Manage Jobs</title>
    <style>
        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            border-left: 5px solid #dc3545;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .stat-card {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
        }
        
        .stat-card.blue {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }
        
        .stat-card.green {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .stat-card.orange {
            background: linear-gradient(135deg, #ff9800 0%, #e68900 100%);
            box-shadow: 0 4px 15px rgba(255, 152, 0, 0.3);
        }
        
        .stat-card.purple {
            background: linear-gradient(135deg, #9c27b0 0%, #7b1fa2 100%);
            box-shadow: 0 4px 15px rgba(156, 39, 176, 0.3);
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            margin: 10px 0;
        }
        
        .stat-label {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .action-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        
        .action-btn:hover {
            background: #c82333;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            color: white;
            text-decoration: none;
        }
        
        .action-btn.success {
            background: #28a745;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .action-btn.success:hover {
            background: #218838;
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }
        
        .action-btn.warning {
            background: #ffc107;
            color: #212529;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }
        
        .action-btn.warning:hover {
            background: #e0a800;
            color: #212529;
            box-shadow: 0 6px 20px rgba(255, 193, 7, 0.4);
        }
        
        .badge-status {
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .badge-pending {
            background: #ffc107;
            color: #212529;
        }
        
        .badge-active {
            background: #28a745;
            color: white;
        }
        
        .badge-expired {
            background: #6c757d;
            color: white;
        }
        
        .badge-closed {
            background: #dc3545;
            color: white;
        }
        
        .admin-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .admin-table th {
            background: #dc3545;
            color: white;
            font-weight: 600;
            padding: 15px;
            border: none;
        }
        
        .admin-table td {
            padding: 12px 15px;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
        }
        
        .admin-table tr:hover {
            background: #f8f9fa;
        }
        
        .job-actions {
            white-space: nowrap;
        }
        
        .job-actions .action-btn {
            padding: 5px 12px;
            font-size: 0.8rem;
            margin: 2px;
        }
        
        .search-form {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        
        .form-control {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }
        
        .btn-search {
            background: #dc3545;
            border: 2px solid #dc3545;
            color: white;
            padding: 10px 30px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-search:hover {
            background: #c82333;
            border-color: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }
        
        .filter-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .quick-stats {
            display: flex;
            justify-content: space-around;
            align-items: center;
            padding: 20px;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .quick-stat-item {
            text-align: center;
        }
        
        .quick-stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #dc3545;
            margin-bottom: 5px;
        }
        
        .quick-stat-label {
            color: #6c757d;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .auto-style1 {
            position: relative;
            width: 100%;
            -webkit-box-flex: 0;
            -ms-flex: 0 0 100%;
            flex: 0 0 100%;
            max-width: 100%;
            left: 0px;
            top: 0px;
            padding-left: 15px;
            padding-right: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- NAVBAR -->
    <header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-6 col-xl-2">
                    <h1 class="mb-0 site-logo">
                        <a href="admin_dashboard.aspx" class="mb-0">JobBoard Admin</a>
                    </h1>
                </div>

                <div class="col-12 col-md-10 d-none d-xl-block">
                    <nav class="site-navigation position-relative text-right" role="navigation">
                        <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
                            <li><a href="admin_dashboard.aspx" class="nav-link">Dashboard</a></li>
                            <li><a href="manage_users.aspx" class="nav-link">Manage Users</a></li>
                            <li><a href="manage_job.aspx" class="nav-link active">Manage Jobs</a></li>
                           
                            <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>

    <!-- Job Management Hero Section -->
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg'); padding: 100px 0 80px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="text-white font-weight-bold mb-3" style="font-size: 2.5rem;">
                        Job Management Center 💼
                    </h1>
                    <p class="text-white lead">
                        Monitor, approve, and manage all job postings across the platform. Ensure quality control and maintain standards.
                    </p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="text-white mt-3">
                        <p class="mb-1"><i class="icon-calendar mr-2"></i><asp:Label ID="lblCurrentDate" runat="server"></asp:Label></p>
                        <p class="mb-0"><i class="icon-briefcase mr-2"></i>Job Administrator</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Job Statistics Cards -->
    <section class="site-section" style="padding: 50px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="icon-briefcase" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblTotalJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Jobs</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card green">
                        <i class="icon-check" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Active Jobs</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card orange">
                        <i class="icon-clock" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblPendingJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Pending Approval</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card purple">
                        <i class="icon-heart" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblTotalApplications" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Applications</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-flash mr-2" style="color: #dc3545;"></i>Quick Job Actions</h3>
                        <div class="text-center">
                            <asp:Button ID="btnBulkApprove" runat="server" CssClass="action-btn success" OnClick="btnBulkApprove_Click" Text="Bulk Approve Pending" />
                            <asp:Button ID="btnExpireOld" runat="server" CssClass="action-btn warning" OnClick="btnExpireOld_Click" Text="Expire Old Jobs" />
                            <asp:Button ID="btnRefresh" runat="server" CssClass="action-btn" OnClick="btnRefresh_Click" Text="Refresh Data" />
                            <asp:Button ID="btnExportReport" runat="server" Text="Print Report" class="action-btn" OnClick="btnExportReport_Click"/>
                           <%-- <a href="#" class="action-btn" onclick="exportJobs()">
                                <i class="icon-download mr-2"></i>Export Jobs--%>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Section -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="search-form">
                        <h4 class="mb-3"><i class="icon-search mr-2"></i>Search & Filter Jobs</h4>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label>Job Title/Company</label>
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Enter job title or company name"></asp:TextBox>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label>Status</label>
                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">All Status</asp:ListItem>
                                    <asp:ListItem Value="Active">Active</asp:ListItem>
                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                    <asp:ListItem Value="Expired">Expired</asp:ListItem>
                                    <asp:ListItem Value="Closed">Closed</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label>Posted Date</label>
                                <asp:DropDownList ID="ddlDateRange" runat="server" CssClass="form-control">
                                    <asp:ListItem Value="">All Time</asp:ListItem>
                                    <asp:ListItem Value="7">Last 7 Days</asp:ListItem>
                                    <asp:ListItem Value="30">Last 30 Days</asp:ListItem>
                                    <asp:ListItem Value="90">Last 3 Months</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2 mb-3">
                                <label>Location</label>
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="City or State"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label>&nbsp;</label>
                                <div>
                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn-search" OnClick="btnSearch_Click" Text="Search Jobs" />
                                    <asp:Button ID="btnClear" runat="server" CssClass="btn btn-outline-secondary ml-2" OnClick="btnClear_Click" Text="Clear" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Today's Statistics -->
            <div class="row mt-4">
            </div>

            <!-- Jobs Management Table -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3><i class="icon-list mr-2" style="color: #dc3545;"></i>All Jobs Management</h3>
                            <div>
                                <asp:Label ID="lblResultsInfo" runat="server" CssClass="text-muted mr-3"></asp:Label>
                                <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="form-control" style="display: inline-block; width: auto;" AutoPostBack="true" OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
                                    <asp:ListItem Value="10">10 per page</asp:ListItem>
                                    <asp:ListItem Value="25" Selected="True">25 per page</asp:ListItem>
                                    <asp:ListItem Value="50">50 per page</asp:ListItem>
                                    <asp:ListItem Value="100">100 per page</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="admin-table">
                            <asp:GridView ID="gvJobs" runat="server" CssClass="table table-hover mb-0" 
                                AutoGenerateColumns="false" GridLines="None" AllowPaging="true" PageSize="25"
                                OnPageIndexChanging="gvJobs_PageIndexChanging" OnRowCommand="gvJobs_RowCommand"
                                DataKeyNames="JobID">
                                <HeaderStyle CssClass="thead-dark" />
                                <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" NextPageText="Next" PreviousPageText="Previous" />
                                <PagerStyle CssClass="pagination justify-content-center mt-3" />
                                <Columns>
                                    <asp:BoundField DataField="JobID" HeaderText="ID" />
                                    <asp:TemplateField HeaderText="Job Details">
                                        <ItemTemplate>
                                            <div>
                                                <strong><%# Eval("JobTitle") %></strong><br/>
                                                <small class="text-muted"><%# Eval("CompanyName") %></small><br/>
                                                <small><i class="icon-room mr-1"></i><%# Eval("Location") %></small>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Posted Date">
                                        <ItemTemplate>
                                            <%# Convert.ToDateTime(Eval("PostedDate")).ToString("MMM dd, yyyy") %><br/>
                                            <small class="text-muted"><%# GetTimeDifference(Convert.ToDateTime(Eval("PostedDate"))) %></small>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Salary">
                                        <ItemTemplate>
                                            <strong>$<%# Eval("Salary") != DBNull.Value ? string.Format("{0:N0}", Eval("Salary")) : "Not Specified" %></strong>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Applications">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <strong><%# Eval("ApplicationCount") %></strong>
                                                <br/><small class="text-muted">applicants</small>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='badge-status badge-<%# Eval("Status").ToString().ToLower() %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="job-actions">
                                                <asp:Button ID="btnView" runat="server" CssClass="action-btn" 
                                                    CommandName="ViewJob" CommandArgument='<%# Eval("JobID") %>' 
                                                    Text="View" ToolTip="View Job Details" />
                                                <asp:Button ID="btnApprove" runat="server" CssClass="action-btn success" 
                                                    CommandName="ApproveJob" CommandArgument='<%# Eval("JobID") %>' 
                                                    Text="Approve" ToolTip="Approve Job" 
                                                    Visible='<%# Eval("Status").ToString() == "Pending" %>' />
                                                <asp:Button ID="btnReject" runat="server" CssClass="action-btn" 
                                                    CommandName="RejectJob" CommandArgument='<%# Eval("JobID") %>' 
                                                    Text="Reject" ToolTip="Reject Job" 
                                                    Visible='<%# Eval("Status").ToString() == "Pending" %>' />
                                                <asp:Button ID="btnDeactivate" runat="server" CssClass="action-btn warning" 
                                                    CommandName="DeactivateJob" CommandArgument='<%# Eval("JobID") %>' 
                                                    Text="Deactivate" ToolTip="Deactivate Job" 
                                                    Visible='<%# Eval("Status").ToString() == "Active" %>' />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center py-4">
                                        <i class="icon-briefcase" style="font-size: 3rem; color: #ccc;"></i>
                                        <h4 class="mt-3 text-muted">No Jobs Found</h4>
                                        <p class="text-muted">No jobs match your current search criteria.</p>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activity Feed -->
            <div class="row mt-4">

                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-trending-up mr-2" style="color: #dc3545;"></i>Job Performance Metrics</h3>
                        <div class="mb-4">
                            <h5>Most Applied Jobs This Week</h5>
                            <asp:Repeater ID="rptTopJobs" runat="server">
                                <ItemTemplate>
                                    <div class="d-flex justify-content-between align-items-center mb-3 p-3" style="background: #f8f9fa; border-radius: 8px;">
                                        <div>
                                            <strong><%# Eval("JobTitle") %></strong><br/>
                                            <small class="text-muted"><%# Eval("CompanyName") %></small>
                                        </div>
                                        <div class="text-center">
                                            <span class="badge badge-primary"><%# Eval("ApplicationCount") %> apps</span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        
                        <div class="mt-4">
                            <h5>Quick Stats</h5>
                            <div class="row">
                                <div class="col-6">
                                    <div class="text-center p-2" style="background: #e8f5e8; border-radius: 8px;">
                                        <strong class="text-success"><asp:Label ID="lblWeeklyApprovalRate" runat="server" Text="0%"></asp:Label></strong><br/>
                                        <small>Approval Rate</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="text-center p-2" style="background: #fff3cd; border-radius: 8px;">
                                        <strong class="text-warning"><asp:Label ID="lblAvgTimeToApprove" runat="server" Text="0 hrs"></asp:Label></strong><br/>
                                        <small>Avg. Approval Time</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <footer class="site-footer">
        <a href="#top" class="smoothscroll scroll-top"><span class="icon-keyboard_arrow_up"></span></a>
        <div class="container">
            <div class="row mb-5">
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Job Management</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">View All Jobs</a></li>
                        <li><a href="#">Pending Approvals</a></li>
                        <li><a href="#">Active Jobs</a></li>
                        <li><a href="#">Job Analytics</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Quick Actions</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Bulk Approve</a></li>
                        <li><a href="#">Export Data</a></li>
                        <li><a href="#">Job Categories</a></li>
                        <li><a href="#">Salary Insights</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Reports</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Job Performance</a></li>
                        <li><a href="#">Application Trends</a></li>
                        <li><a href="#">Company Rankings</a></li>
                        <li><a href="#">Salary Reports</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Settings</h3>
                    <ul class="list-unstyled">
                        <li><a href="admin_dashboard.aspx">Back to Dashboard</a></li>
                        <li><a href="#">Job Policies</a></li>
                        <li><a href="logout.aspx">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <p class="copyright">
                        <small>
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | JobBoard Job Management Portal
                        </small>
                    </p>
                </div>
            </div>
        </div>
    </footer>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.bundle.min.js"></script>
    <script src="js/isotope.pkgd.min.js"></script>
    <script src="js/stickyfill.min.js"></script>
    <script src="js/jquery.fancybox.min.js"></script>
    <script src="js/jquery.easing.1.3.js"></script>
    <script src="js/jquery.waypoints.min.js"></script>
    <script src="js/jquery.animateNumber.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/bootstrap-select.min.js"></script>
    <script src="js/custom.js"></script>

    <script>
        function exportJobs() {
            alert('Export functionality would be implemented here. This would generate an Excel/CSV file with job data.');
        }
        
        function confirmAction(action, jobTitle) {
            return confirm('Are you sure you want to ' + action + ' the job: "' + jobTitle + '"?');
        }
    </script>
</body>
</html>
</asp:Content>

