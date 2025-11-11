<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin_dashboard.aspx.cs" Inherits="Job_Portal.admin_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>JobBoard - Admin Dashboard</title>
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
        
        .stat-card.teal {
            background: linear-gradient(135deg, #20c997 0%, #17a2b8 100%);
            box-shadow: 0 4px 15px rgba(32, 201, 151, 0.3);
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
        
        .quick-action-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        
        .quick-action-btn:hover {
            background: #c82333;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
            color: white;
            text-decoration: none;
        }
        
        .activity-item {
            padding: 15px;
            border-left: 3px solid #dc3545;
            margin-bottom: 15px;
            background: #f8f9fa;
            border-radius: 5px;
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
        
        .badge-inactive {
            background: #6c757d;
            color: white;
        }
        
        .badge-high {
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
        }
        
        .admin-table tr:hover {
            background: #f8f9fa;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            margin: 20px 0;
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
                        <a href="admin_dashboard.aspx" class="mb-0">Admin Panel</a>
                    </h1>
                </div>

                <div class="col-12 col-md-10 d-none d-xl-block">
                    <nav class="site-navigation position-relative text-right" role="navigation">
                        <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
                            <li><a href="admin_dashboard.aspx" class="nav-link active">Dashboard</a></li>
                            <li><a href="manage_users.aspx" class="nav-link">Manage Users</a></li>
                            <li><a href="manage_job.aspx" class="nav-link">Manage Jobs</a></li>
                            
                            <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>

    <!-- Dashboard Hero Section -->
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg'); padding: 100px 0 80px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="text-white font-weight-bold mb-3" style="font-size: 2.5rem;">
                        Admin Dashboard 🛡️
                    </h1>
                    <p class="text-white lead">
                        Manage the entire job portal system, monitor activities, and ensure smooth operations.
                    </p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="text-white mt-3">
                        <p class="mb-1"><i class="icon-calendar mr-2"></i><asp:Label ID="lblCurrentDate" runat="server"></asp:Label></p>
                        <p class="mb-0"><i class="icon-user mr-2"></i>Administrator</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Cards -->
    <section class="site-section" style="padding: 50px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <div class="stat-card">
                        <i class="icon-users" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Users</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card blue">
                        <i class="icon-briefcase" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblTotalJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Jobs</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card green">
                        <i class="icon-heart" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblJobSeekers" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Job Seekers</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card orange">
                        <i class="icon-bag" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblRecruiters" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Recruiters</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card purple">
                        <i class="icon-paper-plane" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblApplications" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Applications</div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="stat-card teal">
                        <i class="icon-list" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblCategories" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Categories</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row mt-5">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-flash mr-2" style="color: #dc3545;"></i>Quick Actions</h3>
                        <div class="text-center">
                            <a href="manage_users.aspx" class="quick-action-btn">
                                <i class="icon-user mr-2"></i>Manage Users
                            </a>
                            <a href="manage_jobs.aspx" class="quick-action-btn">
                                <i class="icon-briefcase mr-2"></i>Manage Jobs
                            </a>
                            <a href="#" class="quick-action-btn">
                                <i class="icon-list mr-2"></i>Categories
                            </a>
                            <a href="#" class="quick-action-btn">
                                <i class="icon-bar-chart mr-2"></i>View Reports
                            </a>
                            <a href="#" class="quick-action-btn">
                                <i class="icon-settings mr-2"></i>System Settings
                            </a>
                            <a href="#" class="quick-action-btn">
                                <i class="icon-shield mr-2"></i>Security
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activities and System Overview -->
            <div class="row mt-4">
                <!-- Recent Users -->
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-user-plus mr-2" style="color: #dc3545;"></i>Recent User Registrations</h3>
                        <asp:Panel ID="pnlRecentUsers" runat="server">
                            <asp:Repeater ID="rptRecentUsers" runat="server">
                                <ItemTemplate>
                                    <div class="activity-item">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <strong><%# Eval("FullName") %></strong>
                                                <p class="mb-1 text-muted"><%# Eval("Email") %></p>
                                                <small class="text-muted">
                                                    <i class="icon-calendar mr-1"></i><%# Convert.ToDateTime(Eval("RegistrationDate")).ToString("MMM dd, yyyy") %>
                                                </small>
                                            </div>
                                            <span class='badge-status badge-<%# Eval("Role").ToString().ToLower() == "jobseeker" ? "active" : "high" %>'>
                                                <%# Eval("Role") %>
                                            </span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                        <asp:Panel ID="pnlNoUsers" runat="server" Visible="false" CssClass="text-center py-4">
                            <i class="icon-users" style="font-size: 3rem; color: #ccc;"></i>
                            <p class="text-muted mt-2">No recent registrations</p>
                        </asp:Panel>
                    </div>
                </div>

                <!-- Recent Jobs -->
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-briefcase mr-2" style="color: #dc3545;"></i>Recently Posted Jobs</h3>
                        <asp:Panel ID="pnlRecentJobs" runat="server">
                            <asp:Repeater ID="rptRecentJobs" runat="server">
                                <ItemTemplate>
                                    <div class="activity-item">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <strong><%# Eval("JobTitle") %></strong>
                                                <p class="mb-1 text-muted">
                                                    <i class="icon-room mr-1"></i><%# Eval("Location") %>
                                                </p>
                                                <small class="text-muted">
                                                    Posted: <%# Convert.ToDateTime(Eval("PostedDate")).ToString("MMM dd, yyyy") %>
                                                </small>
                                            </div>
                                            <div class="text-center">
                                                <span class='badge-status badge-<%# Eval("Status").ToString().ToLower() %>'>
                                                    <%# Eval("Status") %>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                        <asp:Panel ID="pnlNoJobs" runat="server" Visible="false" CssClass="text-center py-4">
                            <i class="icon-briefcase" style="font-size: 3rem; color: #ccc;"></i>
                            <p class="text-muted mt-2">No recent jobs posted</p>
                        </asp:Panel>
                    </div>
                </div>
            </div>

            <!-- System Stats and Analytics -->
            <div class="row mt-4">
                <div class="col-md-8">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-bar-chart mr-2" style="color: #dc3545;"></i>System Analytics</h3>
                        <div class="row">
                            <div class="col-md-6">
                                <h5>Registration Trends</h5>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>This Month</span>
                                        <strong><asp:Label ID="lblThisMonthRegistrations" runat="server" Text="0"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="progressThisMonth"></div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>This Week</span>
                                        <strong><asp:Label ID="lblThisWeekRegistrations" runat="server" Text="0"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 0%" id="progressThisWeek"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h5>Job Posting Activity</h5>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Active Jobs</span>
                                        <strong><asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 0%" id="progressActiveJobs"></div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Application Rate</span>
                                        <strong><asp:Label ID="lblApplicationRate" runat="server" Text="0%"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 0%" id="progressApplications"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="dashboard-card" style="border-left-color: #007bff;">
                        <h3 class="mb-4"><i class="icon-alert-circle mr-2" style="color: #007bff;"></i>System Alerts</h3>
                        <div class="activity-item" style="border-left-color: #ffc107; background: #fff3cd;">
                            <i class="icon-info text-warning mr-2"></i>
                            <strong>Pending Approval:</strong> <asp:Label ID="lblPendingJobs" runat="server" Text="0"></asp:Label> jobs waiting for review
                        </div>
                        <div class="activity-item" style="border-left-color: #dc3545; background: #f8d7da;">
                            <i class="icon-exclamation text-danger mr-2"></i>
                            <strong>Flagged Content:</strong> <asp:Label ID="lblFlaggedContent" runat="server" Text="0"></asp:Label> items need attention
                        </div>
                        <div class="activity-item" style="border-left-color: #28a745; background: #d4edda;">
                            <i class="icon-check text-success mr-2"></i>
                            <strong>System Health:</strong> All services running smoothly
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top Performers Table -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-trophy mr-2" style="color: #dc3545;"></i>Top Recruiters</h3>
                        <div class="admin-table">
                            <asp:GridView ID="gvTopRecruiters" runat="server" CssClass="table table-hover mb-0" 
                                AutoGenerateColumns="false" GridLines="None">
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField DataField="CompanyName" HeaderText="Company" />
                                    <asp:BoundField DataField="JobsPosted" HeaderText="Jobs Posted" />
                                    <asp:BoundField DataField="TotalApplications" HeaderText="Applications" />
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-star mr-2" style="color: #dc3545;"></i>Popular Job Categories</h3>
                        <div class="admin-table">
                            <asp:GridView ID="gvTopCategories" runat="server" CssClass="table table-hover mb-0" 
                                AutoGenerateColumns="false" GridLines="None">
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:BoundField DataField="CategoryName" HeaderText="Category" />
                                    <asp:BoundField DataField="JobCount" HeaderText="Jobs" />
                                    <asp:BoundField DataField="ApplicationCount" HeaderText="Applications" />
                                </Columns>
                            </asp:GridView>
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
                    <h3>Admin Tools</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">User Management</a></li>
                        <li><a href="#">Job Management</a></li>
                        <li><a href="#">Category Management</a></li>
                        <li><a href="#">System Reports</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Settings</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">System Configuration</a></li>
                        <li><a href="#">Security Settings</a></li>
                        <li><a href="#">Email Templates</a></li>
                        <li><a href="#">Backup & Restore</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Support</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Help Center</a></li>
                        <li><a href="#">System Logs</a></li>
                        <li><a href="#">Documentation</a></li>
                        <li><a href="#">Contact Support</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Account</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Admin Profile</a></li>
                        <li><a href="#">Change Password</a></li>
                        <li><a href="logout.aspx">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <p class="copyright">
                        <small>
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | JobBoard Admin Portal
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
</body>
</html>
</asp:Content>

