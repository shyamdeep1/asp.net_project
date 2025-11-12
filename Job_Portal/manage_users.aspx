<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="manage_users.aspx.cs" Inherits="Job_Portal.manage_users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>JobBoard - Manage Users</title>
    <style>
        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            border-left: 5px solid #007bff;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .stat-card {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 123, 255, 0.4);
        }
        
        .stat-card.green {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .stat-card.orange {
            background: linear-gradient(135deg, #ff9800 0%, #e68900 100%);
            box-shadow: 0 4px 15px rgba(255, 152, 0, 0.3);
        }
        
        .stat-card.red {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
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
            background: #007bff;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        
        .action-btn:hover {
            background: #0056b3;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
            color: white;
            text-decoration: none;
        }
        
        .action-btn.success {
            background: #28a745;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .action-btn.success:hover {
            background: #1e7e34;
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }
        
        .action-btn.danger {
            background: #dc3545;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }
        
        .action-btn.danger:hover {
            background: #c82333;
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }
        
        .user-table {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .user-table th {
            background: #007bff;
            color: white;
            font-weight: 600;
            padding: 15px;
            border: none;
            text-align: center;
        }
        
        .user-table td {
            padding: 15px;
            border-bottom: 1px solid #dee2e6;
            vertical-align: middle;
            text-align: center;
        }
        
        .user-table tr:hover {
            background: #f8f9fa;
        }
        
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff, #28a745);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .user-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-inactive {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
        }
        
        .filter-section {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            border-left: 5px solid #28a745;
        }
        
        .search-box {
            border-radius: 30px;
            border: 2px solid #dee2e6;
            padding: 15px 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .search-box:focus {
            border-color: #007bff;
            box-shadow: 0 0 20px rgba(0, 123, 255, 0.2);
        }
        
        .dropdown-filter {
            border-radius: 30px;
            border: 2px solid #dee2e6;
            padding: 15px 20px;
            font-size: 1rem;
        }
        
        .activity-item {
            padding: 20px;
            border-left: 4px solid #007bff;
            margin-bottom: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .activity-item:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }
        
        .user-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 20px;
            border-left: 5px solid #007bff;
        }
        
        .user-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .quick-stats {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }
        
        .quick-stats .stat {
            text-align: center;
        }
        
        .quick-stats .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: #007bff;
        }
        
        .quick-stats .stat-label {
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .btn-group-custom {
            margin: 5px;
        }
        
        .btn-group-custom .btn {
            border-radius: 20px;
            margin: 0 2px;
            padding: 8px 16px;
            font-size: 0.85rem;
            border: none;
        }
        
        .pagination-custom {
            justify-content: center;
            margin-top: 30px;
        }
        
        .pagination-custom .page-link {
            border-radius: 50%;
            margin: 0 5px;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 2px solid #007bff;
            color: #007bff;
        }
        
        .pagination-custom .page-link:hover {
            background: #007bff;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                            <li><a href="admin_dashboard.aspx" class="nav-link">Dashboard</a></li>
                            <li><a href="manage_users.aspx" class="nav-link active">Manage Users</a></li>
                            <li><a href="manage_job.aspx" class="nav-link">Manage Jobs</a></li>
                         
                            <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg'); padding: 100px 0 80px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h1 class="text-white font-weight-bold mb-3" style="font-size: 2.5rem;">
                        User Management 👥
                    </h1>
                    <p class="text-white lead">
                        Manage all users, monitor activities, and maintain system security across your platform.
                    </p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="text-white mt-3">
                        <p class="mb-1"><i class="icon-calendar mr-2"></i><asp:Label ID="lblCurrentDate" runat="server"></asp:Label></p>
                        <p class="mb-0"><i class="icon-shield mr-2"></i>User Administrator</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- User Statistics -->
    <section class="site-section" style="padding: 50px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="icon-users" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Users</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card green">
                        <i class="icon-user-plus" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblActiveUsers" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Active Users</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card orange">
                        <i class="icon-clock" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblPendingUsers" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Pending Approval</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card red">
                        <i class="icon-user-times" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblInactiveUsers" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Inactive Users</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-flash mr-2" style="color: #007bff;"></i>Quick User Actions</h3>
                        <div class="text-center">
                            <asp:Button ID="btnAddUser" runat="server" Text="Add New User" CssClass="action-btn success" 
                                OnClick="btnAddUser_Click" />
                            <asp:Button ID="btnExportUsers" runat="server" Text="Export Users" CssClass="action-btn" 
                                OnClick="btnExportUsers_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Section -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="filter-section">
                        <h4 class="mb-4"><i class="icon-search mr-2" style="color: #28a745;"></i>Search & Filter Users</h4>
                        <div class="row">
                            <div class="col-md-4">
                                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control search-box" 
                                    placeholder="Search by name, email, or ID..."></asp:TextBox>
                            </div>
                            <div class="col-md-2">
                                <asp:DropDownList ID="ddlUserRole" runat="server" CssClass="form-control dropdown-filter">
                                    <asp:ListItem Text="All Roles" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Job Seekers" Value="JobSeeker"></asp:ListItem>
                                    <asp:ListItem Text="Recruiters" Value="Recruiter"></asp:ListItem>
                                    <asp:ListItem Text="Administrators" Value="Admin"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2">
                                <asp:DropDownList ID="ddlUserStatus" runat="server" CssClass="form-control dropdown-filter">
                                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                    <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2">
                                <asp:DropDownList ID="ddlDateFilter" runat="server" CssClass="form-control dropdown-filter">
                                    <asp:ListItem Text="All Time" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Today" Value="Today"></asp:ListItem>
                                    <asp:ListItem Text="This Week" Value="Week"></asp:ListItem>
                                    <asp:ListItem Text="This Month" Value="Month"></asp:ListItem>
                                    <asp:ListItem Text="This Year" Value="Year"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-2">
                                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="action-btn" 
                                    OnClick="btnSearch_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User Management Table -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h3><i class="icon-users mr-2" style="color: #007bff;"></i>User Directory</h3>
                            <div>
                                <span class="text-muted">Total: <asp:Label ID="lblTotalCount" runat="server" Text="0"></asp:Label> users</span>
                            </div>
                        </div>
                        
                        <div class="user-table">
                            <asp:GridView ID="gvUsers" runat="server" CssClass="table table-hover mb-0" 
                                AutoGenerateColumns="false" GridLines="None" AllowPaging="true" PageSize="10"
                                OnPageIndexChanging="gvUsers_PageIndexChanging" OnRowCommand="gvUsers_RowCommand">
                                <HeaderStyle CssClass="thead-dark" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-Width="50px">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="User" ItemStyle-Width="200px">
                                        <ItemTemplate>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar mr-3">
                                                    <%# GetUserInitials(Eval("FullName").ToString()) %>
                                                </div>
                                                <div>
                                                    <strong><%# Eval("FullName") %></strong><br />
                                                    <small class="text-muted"><%# Eval("Email") %></small>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:BoundField DataField="Role" HeaderText="Role" ItemStyle-Width="100px" />
                                    
                                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="100px">
                                        <ItemTemplate>
                                            <span class='user-status status-<%# GetStatusClass(Eval("Status").ToString()) %>'>
                                                <%# Eval("Status") ?? "Active" %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Joined" ItemStyle-Width="120px">
                                        <ItemTemplate>
                                            <%# GetFormattedDate(Eval("CreatedDate")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Last Login" ItemStyle-Width="120px">
                                        <ItemTemplate>
                                            <span class="text-muted">
                                                <%# GetRandomLastLogin() %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="200px">
                                        <ItemTemplate>
                                            <div class="btn-group-custom">
                                                <asp:Button ID="btnView" runat="server" Text="View" 
                                                    CssClass="btn btn-sm btn-info" 
                                                    CommandName="ViewUser" CommandArgument='<%# Eval("UserID") %>' />
                                                <asp:Button ID="btnEdit" runat="server" Text="Edit" 
                                                    CssClass="btn btn-sm btn-primary" 
                                                    CommandName="EditUser" CommandArgument='<%# Eval("UserID") %>' />
                                                <asp:Button ID="btnDelete" runat="server" Text="Delete" 
                                                    CssClass="btn btn-sm btn-danger" 
                                                    CommandName="DeleteUser" CommandArgument='<%# Eval("UserID") %>'
                                                    OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle HorizontalAlign="Center" CssClass="pagination-custom" />
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activities and System Overview -->
            <div class="row mt-4">
                <!-- Recent User Activities -->
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-activity mr-2" style="color: #007bff;"></i>Recent User Activities</h3>
                        <asp:Panel ID="pnlRecentActivities" runat="server">
                            <!-- Static Recent Activities for Display -->
                            <div class="activity-item">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <strong>John Doe</strong> updated profile
                                        <p class="mb-1 text-muted">Added new skills and experience</p>
                                        <small class="text-muted">
                                            <i class="icon-clock mr-1"></i>2 hours ago
                                        </small>
                                    </div>
                                    <span class="user-status status-active">
                                        Profile Update
                                    </span>
                                </div>
                            </div>
                            
                            <div class="activity-item">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <strong>Tech Solutions Inc.</strong> posted new job
                                        <p class="mb-1 text-muted">Senior Developer position in New York</p>
                                        <small class="text-muted">
                                            <i class="icon-clock mr-1"></i>5 hours ago
                                        </small>
                                    </div>
                                    <span class="user-status status-active">
                                        Job Posted
                                    </span>
                                </div>
                            </div>
                            
                            <div class="activity-item">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <strong>Sarah Wilson</strong> applied for job
                                        <p class="mb-1 text-muted">Marketing Manager at ABC Corp</p>
                                        <small class="text-muted">
                                            <i class="icon-clock mr-1"></i>1 day ago
                                        </small>
                                    </div>
                                    <span class="user-status status-pending">
                                        Application
                                    </span>
                                </div>
                            </div>
                        </asp:Panel>
                    </div>
                </div>

                <!-- User Analytics -->
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-bar-chart mr-2" style="color: #007bff;"></i>User Analytics</h3>
                        
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h5>Registration Trends</h5>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>This Month</span>
                                        <strong><asp:Label ID="lblMonthlyRegistrations" runat="server" Text="42"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 75%"></div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>This Week</span>
                                        <strong><asp:Label ID="lblWeeklyRegistrations" runat="server" Text="12"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-primary" role="progressbar" style="width: 60%"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h5>User Engagement</h5>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Active Today</span>
                                        <strong><asp:Label ID="lblActiveToday" runat="server" Text="156"></asp:Label></strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: 80%"></div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Login Rate</span>
                                        <strong>87%</strong>
                                    </div>
                                    <div class="progress" style="height: 10px;">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: 87%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- User Distribution Chart -->
                        <div class="quick-stats">
                            <div class="stat">
                                <div class="stat-number">68%</div>
                                <div class="stat-label">Job Seekers</div>
                            </div>
                            <div class="stat">
                                <div class="stat-number">30%</div>
                                <div class="stat-label">Recruiters</div>
                            </div>
                            <div class="stat">
                                <div class="stat-number">2%</div>
                                <div class="stat-label">Admins</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- User Management Tools -->
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="user-card">
                        <h4 class="mb-3"><i class="icon-shield mr-2" style="color: #dc3545;"></i>Security Center</h4>
                        <div class="activity-item" style="border-left-color: #ffc107; background: #fff3cd;">
                            <i class="icon-lock text-warning mr-2"></i>
                            <strong>Password Policies:</strong> Enforced for all users
                        </div>
                        <div class="activity-item" style="border-left-color: #28a745; background: #d4edda;">
                            <i class="icon-check text-success mr-2"></i>
                            <strong>Two-Factor Auth:</strong> Available for all accounts
                        </div>
                        <div class="activity-item" style="border-left-color: #dc3545; background: #f8d7da;">
                            <i class="icon-alert-triangle text-danger mr-2"></i>
                            <strong>Suspicious Activity:</strong> 3 accounts flagged
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                </div>
            </div>
        </div>
    </section>

    <!-- Success/Error Messages -->
    <asp:Panel ID="pnlMessages" runat="server" Visible="false" CssClass="container">
        <div class="alert alert-dismissible fade show" role="alert" id="alertMessage" runat="server">
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </asp:Panel>
</asp:Content>

