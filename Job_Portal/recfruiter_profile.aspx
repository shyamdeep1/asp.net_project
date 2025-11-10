<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recfruiter_profile.aspx.cs" Inherits="Job_Portal.recfruiter_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            transition: all 0.3s ease;
        }

        .profile-card:hover {
            box-shadow: 0 6px 25px rgba(0,0,0,0.15);
        }

        .profile-header {
            background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);
            border-radius: 15px;
            padding: 40px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(137, 186, 22, 0.3);
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 5px solid white;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #89ba16;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        .profile-stats {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
        }

        .stat-item {
            text-align: center;
            padding: 15px;
        }

        .stat-item .number {
            font-size: 2rem;
            font-weight: 700;
            color: #89ba16;
            display: block;
        }

        .stat-item .label {
            color: #666;
            font-size: 0.9rem;
        }

        .form-group label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            border-radius: 8px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #89ba16;
            box-shadow: 0 0 0 0.2rem rgba(137, 186, 22, 0.25);
        }

        .btn-update {
            background: #89ba16;
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(137, 186, 22, 0.3);
        }

        .btn-update:hover {
            background: #6a9413;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(137, 186, 22, 0.4);
            color: white;
        }

        .btn-cancel {
            background: #6c757d;
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #5a6268;
            color: white;
        }

        .section-title-profile {
            color: #333;
            font-weight: 700;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 3px solid #89ba16;
        }

        .icon-wrapper {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.5rem;
            margin-right: 15px;
        }

        .info-item {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 4px solid #89ba16;
            transition: all 0.3s ease;
        }

        .info-item:hover {
            background: #e9ecef;
            transform: translateX(5px);
        }

        .badge-success-custom {
            background: #28a745;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
        }

        .badge-info-custom {
            background: #17a2b8;
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-weight: 600;
        }

        .activity-timeline {
            position: relative;
            padding-left: 30px;
        }

        .activity-timeline::before {
            content: '';
            position: absolute;
            left: 8px;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #89ba16;
        }

        .timeline-item {
            position: relative;
            padding: 15px;
            margin-bottom: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: -26px;
            top: 20px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #89ba16;
            border: 3px solid white;
            box-shadow: 0 0 0 2px #89ba16;
        }

        .alert-custom {
            border-radius: 10px;
            border-left: 4px solid #89ba16;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                            <li><a href="recruiter_dashboard.aspx" class="nav-link">Dashboard</a></li>
                            <li><a href="recruiter_post_job.aspx" class="nav-link">Post Job</a></li>
                            <li><a href="recruiter_manage_jobs.aspx" class="nav-link">Manage Jobs</a></li>
                            <li><a href="recruiter_applicants.aspx" class="nav-link">Applications</a></li>
                            <li><a href="recfruiter_profile.aspx" class="nav-link active">Profile</a></li>
                            <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>

    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg'); padding: 80px 0 60px 0;">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1 class="text-white font-weight-bold mb-2" style="font-size: 2.5rem;">
                        <i class="icon-user mr-2"></i>Recruiter Profile
                    </h1>
                    <p class="text-white lead">Manage your profile information and company details</p>
                </div>
            </div>
        </div>
    </section>

    <section class="site-section" style="padding: 50px 0;">
        <div class="container">
            
            <div class="profile-header">
                <div class="row align-items-center">
                    <div class="col-md-2 text-center">
                        <div class="profile-avatar mx-auto">
                            <asp:Label ID="lblInitials" runat="server" Text="RC"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h2 class="mb-2">
                            <asp:Label ID="lblDisplayName" runat="server" Text="Recruiter Name"></asp:Label>
                        </h2>
                        <p class="mb-1">
                            <i class="icon-briefcase mr-2"></i>
                            <asp:Label ID="lblDisplayCompany" runat="server" Text="Company Name"></asp:Label>
                        </p>
                        <p class="mb-1">
                            <i class="icon-envelope mr-2"></i>
                            <asp:Label ID="lblDisplayEmail" runat="server" Text="email@company.com"></asp:Label>
                        </p>
                        <p class="mb-0">
                            <i class="icon-calendar mr-2"></i>Member since 
                            <asp:Label ID="lblMemberSince" runat="server" Text="Jan 2024"></asp:Label>
                        </p>
                    </div>
                    <div class="col-md-4">
                        <div class="profile-stats">
                            <div class="row">
                                <div class="col-6 stat-item">
                                    <span class="number"><asp:Label ID="lblTotalJobs" runat="server" Text="0"></asp:Label></span>
                                    <span class="label">Jobs Posted</span>
                                </div>
                                <div class="col-6 stat-item">
                                    <span class="number"><asp:Label ID="lblTotalApplications" runat="server" Text="0"></asp:Label></span>
                                    <span class="label">Applications</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="alert alert-custom">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <div class="row">
                <div class="col-md-8">
                    <div class="profile-card">
                        <h3 class="section-title-profile">
                            <i class="icon-edit mr-2"></i>Edit Profile Information
                        </h3>
                        
                        <div class="form-group">
                            <label>
                                <i class="icon-user mr-2"></i>Full Name
                            </label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" 
                                placeholder="Enter your full name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                                ControlToValidate="txtFullName" 
                                ErrorMessage="Full name is required" 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="ProfileUpdate"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-envelope mr-2"></i>Email Address
                            </label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" 
                                placeholder="email@company.com" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" 
                                ErrorMessage="Email is required" 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="ProfileUpdate"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-phone mr-2"></i>Phone Number
                            </label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" 
                                placeholder="Enter phone number"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-briefcase mr-2"></i>Company Name
                            </label>
                            <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-control" 
                                placeholder="Enter company name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCompanyName" runat="server" 
                                ControlToValidate="txtCompanyName" 
                                ErrorMessage="Company name is required" 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="ProfileUpdate"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-room mr-2"></i>Company Address
                            </label>
                            <asp:TextBox ID="txtCompanyAddress" runat="server" CssClass="form-control" 
                                placeholder="Enter company address" TextMode="MultiLine" Rows="3"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-link mr-2"></i>Company Website
                            </label>
                            <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" 
                                placeholder="https://www.company.com"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-align-left mr-2"></i>Company Description
                            </label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" 
                                placeholder="Describe your company..." TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-users mr-2"></i>Company Size
                            </label>
                            <asp:DropDownList ID="ddlCompanySize" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Select Company Size</asp:ListItem>
                                <asp:ListItem Value="1-10">1-10 employees</asp:ListItem>
                                <asp:ListItem Value="11-50">11-50 employees</asp:ListItem>
                                <asp:ListItem Value="51-200">51-200 employees</asp:ListItem>
                                <asp:ListItem Value="201-500">201-500 employees</asp:ListItem>
                                <asp:ListItem Value="501-1000">501-1000 employees</asp:ListItem>
                                <asp:ListItem Value="1000+">1000+ employees</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-tag mr-2"></i>Industry
                            </label>
                            <asp:DropDownList ID="ddlIndustry" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Select Industry</asp:ListItem>
                                <asp:ListItem Value="Technology">Technology</asp:ListItem>
                                <asp:ListItem Value="Finance">Finance</asp:ListItem>
                                <asp:ListItem Value="Healthcare">Healthcare</asp:ListItem>
                                <asp:ListItem Value="Education">Education</asp:ListItem>
                                <asp:ListItem Value="Manufacturing">Manufacturing</asp:ListItem>
                                <asp:ListItem Value="Retail">Retail</asp:ListItem>
                                <asp:ListItem Value="Hospitality">Hospitality</asp:ListItem>
                                <asp:ListItem Value="Construction">Construction</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="mt-4">
                            <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" 
                                CssClass="btn-update mr-2" OnClick="btnUpdateProfile_Click"
                                ValidationGroup="ProfileUpdate" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                CssClass="btn-cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                        </div>
                    </div>

                    <div class="profile-card mt-4">
                        <h3 class="section-title-profile">
                            <i class="icon-lock mr-2"></i>Change Password
                        </h3>
                        
                        <div class="form-group">
                            <label>Current Password</label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" CssClass="form-control" 
                                TextMode="Password" placeholder="Enter current password"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>New Password</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" 
                                TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>Confirm New Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" 
                                TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                            <asp:CompareValidator ID="cvPassword" runat="server" 
                                ControlToValidate="txtConfirmPassword" 
                                ControlToCompare="txtNewPassword"
                                ErrorMessage="Passwords do not match" 
                                ForeColor="Red" 
                                Display="Dynamic"
                                ValidationGroup="PasswordUpdate"></asp:CompareValidator>
                        </div>

                        <div class="mt-3">
                            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" 
                                CssClass="btn-update" OnClick="btnChangePassword_Click"
                                ValidationGroup="PasswordUpdate" />
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="profile-card">
                        <h3 class="section-title-profile">
                            <i class="icon-bar-chart mr-2"></i>Account Statistics
                        </h3>
                        
                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-briefcase"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsActiveJobs" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Active Jobs</small>
                                </div>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-paper-plane"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsPendingApps" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Pending Applications</small>
                                </div>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-star"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsShortlisted" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Shortlisted Candidates</small>
                                </div>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-check"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsHired" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Hired Candidates</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="profile-card mt-4">
                        <h3 class="section-title-profile">
                            <i class="icon-clock-o mr-2"></i>Recent Activity
                        </h3>
                        
                        <div class="activity-timeline">
                            <asp:Repeater ID="rptRecentActivity" runat="server">
                                <ItemTemplate>
                                    <div class="timeline-item">
                                        <strong><%# Eval("ActivityTitle") %></strong>
                                        <p class="mb-1 text-muted small"><%# Eval("ActivityDescription") %></p>
                                        <small class="text-muted">
                                            <i class="icon-calendar mr-1"></i>
                                            <%# Convert.ToDateTime(Eval("ActivityDate")).ToString("MMM dd, yyyy hh:mm tt") %>
                                        </small>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            
                            <asp:Panel ID="pnlNoActivity" runat="server" Visible="false" CssClass="text-center py-4">
                                <i class="icon-clock-o" style="font-size: 3rem; color: #ccc;"></i>
                                <p class="text-muted mt-2">No recent activity</p>
                            </asp:Panel>
                        </div>
                    </div>

                    <div class="profile-card mt-4">
                        <h3 class="section-title-profile">
                            <i class="icon-lightbulb-o mr-2"></i>Quick Tips
                        </h3>
                        
                        <div class="mb-3">
                            <div class="d-flex align-items-start">
                                <i class="icon-check text-success mr-2 mt-1"></i>
                                <p class="mb-0">Keep your profile updated with accurate company information</p>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex align-items-start">
                                <i class="icon-check text-success mr-2 mt-1"></i>
                                <p class="mb-0">Add a detailed company description to attract candidates</p>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex align-items-start">
                                <i class="icon-check text-success mr-2 mt-1"></i>
                                <p class="mb-0">Respond to applications promptly to improve engagement</p>
                            </div>
                        </div>

                        <div class="mb-0">
                            <div class="d-flex align-items-start">
                                <i class="icon-check text-success mr-2 mt-1"></i>
                                <p class="mb-0">Post clear job descriptions with specific requirements</p>
                            </div>
                        </div>
                    </div>

                    <div class="profile-card mt-4">
                        <h3 class="section-title-profile">
                            <i class="icon-shield mr-2"></i>Account Security
                        </h3>
                        
                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>Email Verified</span>
                                <span class="badge-success-custom">
                                    <i class="icon-check mr-1"></i>Verified
                                </span>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>Profile Status</span>
                                <span class="badge-info-custom">
                                    <i class="icon-star mr-1"></i>Active
                                </span>
                            </div>
                        </div>

                        <div class="mb-0">
                            <div class="d-flex justify-content-between align-items-center">
                                <span>Last Login</span>
                                <small class="text-muted">
                                    <asp:Label ID="lblLastLogin" runat="server" Text="Today"></asp:Label>
                                </small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <footer class="site-footer">
        <a href="#top" class="smoothscroll scroll-top"><span class="icon-keyboard_arrow_up"></span></a>
        <div class="container">
            <div class="row mb-5">
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Recruiter Resources</h3>
                    <ul class="list-unstyled">
                        <li><a href="recruiter_post_job.aspx">Post a Job</a></li>
                        <li><a href="recruiter_manage_jobs.aspx">Manage Jobs</a></li>
                        <li><a href="recruiter_view_applicants.aspx">View Applications</a></li>
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
                        <li><a href="recfruiter_profile.aspx">My Profile</a></li>
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

