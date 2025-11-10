<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_dashboard.aspx.cs" Inherits="Job_Portal.recruiter_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            margin-bottom: 30px;
            border-left: 5px solid #89ba16;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        
        .stat-card {
            background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);
            color: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(137, 186, 22, 0.3);
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(137, 186, 22, 0.4);
        }
        
        .stat-card.blue {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
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
        
        .quick-action-btn {
            background: #89ba16;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(137, 186, 22, 0.3);
            text-decoration: none;
            display: inline-block;
            margin: 5px;
        }
        
        .quick-action-btn:hover {
            background: #6a9413;
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(137, 186, 22, 0.4);
            color: white;
            text-decoration: none;
        }
        
        .activity-item {
            padding: 15px;
            border-left: 3px solid #89ba16;
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
        
        .navbar-recruiter {
            background: white;
            padding: 20px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 40px;
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
                        <a href="recruiter_dashboard.aspx" class="mb-0">Recruiter Panel</a>
                    </h1>
                </div>

                <div class="col-12 col-md-10 d-none d-xl-block">
                    <nav class="site-navigation position-relative text-right" role="navigation">
                        <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
                            <li><a href="recruiter_dashboard.aspx" class="nav-link active">Dashboard</a></li>
                            <li><a href="recruiter_post_job.aspx" class="nav-link">Post Job</a></li>
                            <li><a href="recruiter_manage_jobs.aspx" class="nav-link">Manage Jobs</a></li>
                            <li><a href="recruiter_applicants.aspx" class="nav-link">Applications</a></li>
                            <li><a href="recruiter_profile.aspx" class="nav-link">Profile</a></li>
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
                        Welcome back, <asp:Label ID="lblRecruiterName" runat="server" Text="Recruiter"></asp:Label>! 👋
                    </h1>
                    <p class="text-white lead">
                        Manage your job postings, track applications, and find the perfect candidates for your team.
                    </p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="text-white mt-3">
                        <p class="mb-1"><i class="icon-calendar mr-2"></i><asp:Label ID="lblCurrentDate" runat="server"></asp:Label></p>
                        <p class="mb-0"><i class="icon-briefcase mr-2"></i>Company: <asp:Label ID="lblCompanyName" runat="server"></asp:Label></p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Statistics Cards -->
    <section class="site-section" style="padding: 50px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-card">
                        <i class="icon-briefcase" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblTotalJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Jobs Posted</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card blue">
                        <i class="icon-paper-plane" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Active Jobs</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card orange">
                        <i class="icon-users" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblApplications" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Total Applications</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card purple">
                        <i class="icon-star" style="font-size: 2.5rem;"></i>
                        <div class="stat-number"><asp:Label ID="lblShortlisted" runat="server" Text="0"></asp:Label></div>
                        <div class="stat-label">Shortlisted</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row mt-5">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-flash mr-2" style="color: #89ba16;"></i>Quick Actions</h3>
                        <div class="text-center">
                            <a href="recruiter_post_job.aspx" class="quick-action-btn">
                                <i class="icon-plus mr-2"></i>Post New Job
                            </a>
                            <a href="recruiter_manage_jobs.aspx" class="quick-action-btn">
                                <i class="icon-list mr-2"></i>View All Jobs
                            </a>
                            <a href="recruiter_applicants.aspx" class="quick-action-btn">
                                <i class="icon-folder mr-2"></i>View Applications
                            </a>
                            <a href="recruiter_profile.aspx" class="quick-action-btn">
                                <i class="icon-user mr-2"></i>Edit Profile
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Activities and Jobs -->
            <div class="row mt-4">
                <!-- Recent Applications -->
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-bell mr-2" style="color: #89ba16;"></i>Recent Applications</h3>
                        <asp:Panel ID="pnlRecentApplications" runat="server">
                            <asp:Repeater ID="rptRecentApplications" runat="server">
                                <ItemTemplate>
                                    <div class="activity-item">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <strong><%# Eval("ApplicantName") %></strong>
                                                <p class="mb-1 text-muted">Applied for: <%# Eval("JobTitle") %></p>
                                                <small class="text-muted">
                                                    <i class="icon-calendar mr-1"></i><%# Convert.ToDateTime(Eval("ApplicationDate")).ToString("MMM dd, yyyy") %>
                                                </small>
                                            </div>
                                            <span class='badge-status <%# GetStatusClass(Eval("Status").ToString()) %>'>
                                                <%# Eval("Status") %>
                                            </span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                        <asp:Panel ID="pnlNoApplications" runat="server" Visible="false" CssClass="text-center py-4">
                            <i class="icon-folder-open" style="font-size: 3rem; color: #ccc;"></i>
                            <p class="text-muted mt-2">No recent applications</p>
                        </asp:Panel>
                        <div class="mt-3 text-right">
                            <a href="recruiter_applicants.aspx" class="btn btn-link">View All Applications →</a>
                        </div>
                    </div>
                </div>

                <!-- Active Jobs -->
                <div class="col-md-6">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-briefcase mr-2" style="color: #89ba16;"></i>Your Active Jobs</h3>
                        <asp:Panel ID="pnlActiveJobs" runat="server">
                            <asp:Repeater ID="rptActiveJobs" runat="server">
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
                                                <div class="badge badge-primary" style="font-size: 1.1rem; padding: 8px 12px;">
                                                    <%# Eval("ApplicationCount") %>
                                                </div>
                                                <small class="d-block text-muted">Applications</small>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:Panel>
                        <asp:Panel ID="pnlNoActiveJobs" runat="server" Visible="false" CssClass="text-center py-4">
                            <i class="icon-briefcase" style="font-size: 3rem; color: #ccc;"></i>
                            <p class="text-muted mt-2">No active jobs</p>
                            <a href="recruiter_post_job.aspx" class="btn btn-primary">Post Your First Job</a>
                        </asp:Panel>
                        <div class="mt-3 text-right">
                            <a href="recruiter_manage_jobs.aspx" class="btn btn-link">Manage All Jobs →</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Performance Overview -->
            <div class="row mt-4">
                <div class="col-md-12">
                    <div class="dashboard-card">
                        <h3 class="mb-4"><i class="icon-bar-chart mr-2" style="color: #89ba16;"></i>Performance Overview</h3>
                        <div class="row">
                            <div class="col-md-3 text-center mb-3">
                                <div class="p-3 bg-light rounded">
                                    <h4 class="text-primary"><asp:Label ID="lblAvgApplications" runat="server" Text="0"></asp:Label></h4>
                                    <p class="text-muted mb-0">Avg Applications/Job</p>
                                </div>
                            </div>
                            <div class="col-md-3 text-center mb-3">
                                <div class="p-3 bg-light rounded">
                                    <h4 class="text-success"><asp:Label ID="lblHiredCandidates" runat="server" Text="0"></asp:Label></h4>
                                    <p class="text-muted mb-0">Hired Candidates</p>
                                </div>
                            </div>
                            <div class="col-md-3 text-center mb-3">
                                <div class="p-3 bg-light rounded">
                                    <h4 class="text-warning"><asp:Label ID="lblPendingReview" runat="server" Text="0"></asp:Label></h4>
                                    <p class="text-muted mb-0">Pending Review</p>
                                </div>
                            </div>
                            <div class="col-md-3 text-center mb-3">
                                <div class="p-3 bg-light rounded">
                                    <h4 class="text-info"><asp:Label ID="lblProfileViews" runat="server" Text="0"></asp:Label></h4>
                                    <p class="text-muted mb-0">Profile Views</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tips and Resources -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <div class="dashboard-card" style="border-left-color: #007bff;">
                        <h3 class="mb-4"><i class="icon-lightbulb-o mr-2" style="color: #007bff;"></i>Hiring Tips</h3>
                        <ul class="list-unstyled">
                            <li class="mb-3">
                                <i class="icon-check text-success mr-2"></i>
                                <strong>Write Clear Job Descriptions:</strong> Be specific about requirements and responsibilities
                            </li>
                            <li class="mb-3">
                                <i class="icon-check text-success mr-2"></i>
                                <strong>Respond Quickly:</strong> Fast responses increase candidate engagement by 50%
                            </li>
                            <li class="mb-3">
                                <i class="icon-check text-success mr-2"></i>
                                <strong>Use Keywords:</strong> Include relevant skills to attract the right candidates
                            </li>
                            <li class="mb-3">
                                <i class="icon-check text-success mr-2"></i>
                                <strong>Update Regularly:</strong> Keep job postings fresh and accurate
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="dashboard-card" style="border-left-color: #ff9800;">
                        <h3 class="mb-4"><i class="icon-trophy mr-2" style="color: #ff9800;"></i>Success Metrics</h3>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Application Response Rate</span>
                                <strong><asp:Label ID="lblResponseRate" runat="server" Text="0%"></asp:Label></strong>
                            </div>
                            <div class="progress" style="height: 10px;">
                                <div class="progress-bar bg-success" role="progressbar" style="width: 0%" id="progressResponse"></div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Job Completion Rate</span>
                                <strong><asp:Label ID="lblCompletionRate" runat="server" Text="0%"></asp:Label></strong>
                            </div>
                            <div class="progress" style="height: 10px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 0%" id="progressCompletion"></div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Candidate Satisfaction</span>
                                <strong><asp:Label ID="lblSatisfactionRate" runat="server" Text="0%"></asp:Label></strong>
                            </div>
                            <div class="progress" style="height: 10px;">
                                <div class="progress-bar bg-warning" role="progressbar" style="width: 0%" id="progressSatisfaction"></div>
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
                    <h3>Recruiter Resources</h3>
                    <ul class="list-unstyled">
                        <li><a href="recruiter_post_job.aspx">Post a Job</a></li>
                        <li><a href="recruiter_manage_jobs.aspx">Manage Jobs</a></li>
                        <li><a href="recruiter_applicants.aspx">View Applications</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Support</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Help Center</a></li>
                        <li><a href="contact.aspx">Contact Us</a></li>
                        <li><a href="#">FAQs</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Account</h3>
                    <ul class="list-unstyled">
                        <li><a href="recruiter_profile.aspx">My Profile</a></li>
                        <li><a href="#">Settings</a></li>
                        <li><a href="logout.aspx">Logout</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Connect</h3>
                    <div class="footer-social">
                        <a href="#"><span class="icon-facebook"></span></a>
                        <a href="#"><span class="icon-twitter"></span></a>
                        <a href="#"><span class="icon-linkedin"></span></a>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <p class="copyright">
                        <small>
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | JobBoard Recruiter Portal
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

