<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="jobseeker_profile.aspx.cs" Inherits="Job_Portal.jobseeker_profile" %>
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
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border-radius: 15px;
            padding: 40px;
            color: white;
            margin-bottom: 30px;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
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
            color: #007bff;
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
            color: #007bff;
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
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-update {
            background: #007bff;
            color: white;
            border: none;
            padding: 12px 40px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3);
        }

        .btn-update:hover {
            background: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4);
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
            border-bottom: 3px solid #007bff;
        }

        .icon-wrapper {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
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
            border-left: 4px solid #007bff;
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
            background: #007bff;
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
            background: #007bff;
            border: 3px solid white;
            box-shadow: 0 0 0 2px #007bff;
        }

        .alert-custom {
            border-radius: 10px;
            border-left: 4px solid #007bff;
        }

        .skill-tag {
            display: inline-block;
            background: #e9ecef;
            color: #495057;
            padding: 5px 12px;
            margin: 3px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .education-item, .experience-item {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            border-left: 4px solid #007bff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-6 col-xl-2">
                    <h1 class="mb-0 site-logo">
                        <a href="index.aspx" class="mb-0">JobBoard</a>
                    </h1>
                </div>

                <div class="col-12 col-md-10 d-none d-xl-block">
                    <nav class="site-navigation position-relative text-right" role="navigation">
                        <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
                            <li><a href="index.aspx" class="nav-link">Home</a></li>
                            <li><a href="job_listings.aspx" class="nav-link">Job Listings</a></li>
                            <li><a href="my_applications.aspx" class="nav-link">My Applications</a></li>
                            <li><a href="saved_jobs.aspx" class="nav-link">Saved Jobs</a></li>
                            <li><a href="jobseeker_profile.aspx" class="nav-link active">My Profile</a></li>
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
                        <i class="icon-user mr-2"></i>My Profile
                    </h1>
                    <p class="text-white lead">Manage your profile information and showcase your skills to potential employers</p>
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
                            <asp:Label ID="lblInitials" runat="server" Text="JS"></asp:Label>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h2 class="mb-2">
                            <asp:Label ID="lblDisplayName" runat="server" Text="Job Seeker Name"></asp:Label>
                        </h2>
                        <p class="mb-1">
                            <i class="icon-briefcase mr-2"></i>
                            <asp:Label ID="lblDisplayTitle" runat="server" Text="Professional Title"></asp:Label>
                        </p>
                        <p class="mb-1">
                            <i class="icon-envelope mr-2"></i>
                            <asp:Label ID="lblDisplayEmail" runat="server" Text="jobseeker@email.com"></asp:Label>
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
                                    <span class="number"><asp:Label ID="lblTotalApplications" runat="server" Text="0"></asp:Label></span>
                                    <span class="label">Applications</span>
                                </div>
                                <div class="col-6 stat-item">
                                    <span class="number"><asp:Label ID="lblProfileViews" runat="server" Text="0"></asp:Label></span>
                                    <span class="label">Profile Views</span>
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
                    <!-- Personal Information -->
                    <div class="profile-card">
                        <h3 class="section-title-profile">
                            <i class="icon-edit mr-2"></i>Personal Information
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
                                placeholder="your.email@example.com" TextMode="Email" ReadOnly="true"></asp:TextBox>
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
                                <i class="icon-briefcase mr-2"></i>Professional Title
                            </label>
                            <asp:TextBox ID="txtProfessionalTitle" runat="server" CssClass="form-control" 
                                placeholder="e.g. Software Developer, Marketing Manager"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-room mr-2"></i>Location
                            </label>
                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" 
                                placeholder="City, State/Province, Country"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-link mr-2"></i>LinkedIn Profile
                            </label>
                            <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-control" 
                                placeholder="https://www.linkedin.com/in/yourprofile"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-globe mr-2"></i>Portfolio/Website
                            </label>
                            <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-control" 
                                placeholder="https://yourportfolio.com"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-align-left mr-2"></i>Professional Summary
                            </label>
                            <asp:TextBox ID="txtSummary" runat="server" CssClass="form-control" 
                                placeholder="Brief overview of your professional background and career objectives..." 
                                TextMode="MultiLine" Rows="5"></asp:TextBox>
                        </div>

                        <div class="mt-4">
                            <asp:Button ID="btnUpdateProfile" runat="server" Text="Update Profile" 
                                CssClass="btn-update mr-2" OnClick="btnUpdateProfile_Click"
                                ValidationGroup="ProfileUpdate" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                CssClass="btn-cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                        </div>
                    </div>

                    <!-- Skills and Experience -->
                    <div class="profile-card">
                        <h3 class="section-title-profile">
                            <i class="icon-star mr-2"></i>Skills & Experience
                        </h3>
                        
                        <div class="form-group">
                            <label>
                                <i class="icon-tools mr-2"></i>Skills (comma-separated)
                            </label>
                            <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" 
                                placeholder="e.g. JavaScript, Python, Project Management, Communication"></asp:TextBox>
                            <small class="form-text text-muted">Separate skills with commas</small>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-clock-o mr-2"></i>Years of Experience
                            </label>
                            <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Select Experience Level</asp:ListItem>
                                <asp:ListItem Value="Entry Level">Entry Level (0-1 years)</asp:ListItem>
                                <asp:ListItem Value="Junior">Junior (1-3 years)</asp:ListItem>
                                <asp:ListItem Value="Mid-level">Mid-level (3-5 years)</asp:ListItem>
                                <asp:ListItem Value="Senior">Senior (5-10 years)</asp:ListItem>
                                <asp:ListItem Value="Expert">Expert (10+ years)</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-graduation-cap mr-2"></i>Education Level
                            </label>
                            <asp:DropDownList ID="ddlEducation" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Select Education Level</asp:ListItem>
                                <asp:ListItem Value="High School">High School</asp:ListItem>
                                <asp:ListItem Value="Associate Degree">Associate Degree</asp:ListItem>
                                <asp:ListItem Value="Bachelor's Degree">Bachelor's Degree</asp:ListItem>
                                <asp:ListItem Value="Master's Degree">Master's Degree</asp:ListItem>
                                <asp:ListItem Value="Doctorate">Doctorate/PhD</asp:ListItem>
                                <asp:ListItem Value="Other">Other</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-dollar mr-2"></i>Expected Salary Range
                            </label>
                            <asp:DropDownList ID="ddlSalaryRange" runat="server" CssClass="form-control">
                                <asp:ListItem Value="">Preferred Salary Range</asp:ListItem>
                                <asp:ListItem Value="$30,000 - $40,000">$30,000 - $40,000</asp:ListItem>
                                <asp:ListItem Value="$40,000 - $50,000">$40,000 - $50,000</asp:ListItem>
                                <asp:ListItem Value="$50,000 - $60,000">$50,000 - $60,000</asp:ListItem>
                                <asp:ListItem Value="$60,000 - $70,000">$60,000 - $70,000</asp:ListItem>
                                <asp:ListItem Value="$70,000 - $80,000">$70,000 - $80,000</asp:ListItem>
                                <asp:ListItem Value="$80,000 - $100,000">$80,000 - $100,000</asp:ListItem>
                                <asp:ListItem Value="$100,000+">$100,000+</asp:ListItem>
                                <asp:ListItem Value="Open to negotiation">Open to negotiation</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label>
                                <i class="icon-briefcase mr-2"></i>Job Type Preference
                            </label>
                            <asp:CheckBoxList ID="cblJobTypes" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" CssClass="job-type-list">
                                <asp:ListItem Value="Full-Time">Full-Time</asp:ListItem>
                                <asp:ListItem Value="Part-Time">Part-Time</asp:ListItem>
                                <asp:ListItem Value="Contract">Contract</asp:ListItem>
                                <asp:ListItem Value="Remote">Remote</asp:ListItem>
                                <asp:ListItem Value="Internship">Internship</asp:ListItem>
                            </asp:CheckBoxList>
                        </div>

                        <div class="mt-4">
                            <asp:Button ID="btnUpdateSkills" runat="server" Text="Update Skills & Experience" 
                                CssClass="btn-update" OnClick="btnUpdateSkills_Click" />
                        </div>
                    </div>

                    <!-- Change Password -->
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
                    <!-- Profile Summary -->
                    <div class="profile-card">
                        <h3 class="section-title-profile">
                            <i class="icon-bar-chart mr-2"></i>Profile Summary
                        </h3>
                        
                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-paper-plane"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsApplications" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Total Applications</small>
                                </div>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-eye"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsViews" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Profile Views</small>
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
                                    <small class="text-muted">Times Shortlisted</small>
                                </div>
                            </div>
                        </div>

                        <div class="info-item">
                            <div class="d-flex align-items-center">
                                <div class="icon-wrapper">
                                    <i class="icon-bookmark"></i>
                                </div>
                                <div>
                                    <h4 class="mb-0">
                                        <asp:Label ID="lblStatsSaved" runat="server" Text="0"></asp:Label>
                                    </h4>
                                    <small class="text-muted">Saved Jobs</small>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Activity -->
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
                            
                            <asp:Panel ID="pnlNoActivity" runat="server" Visible="true" CssClass="text-center py-4">
                                <i class="icon-clock-o" style="font-size: 3rem; color: #ccc;"></i>
                                <p class="text-muted mt-2">No recent activity</p>
                            </asp:Panel>
                        </div>
                    </div>

                    <!-- Profile Completion -->
                    <div class="profile-card mt-4">
                        <h3 class="section-title-profile">
                            <i class="icon-check-circle mr-2"></i>Profile Completion
                        </h3>
                        
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <span>Profile Strength</span>
                                <strong><asp:Label ID="lblProfileCompletion" runat="server" Text="70%"></asp:Label></strong>
                            </div>
                            <div class="progress" style="height: 10px;">
                                <div class="progress-bar bg-primary" role="progressbar" style="width: 70%"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <asp:CheckBox ID="chkBasicInfo" runat="server" Text="Basic Information" Checked="true" Enabled="false" />
                        </div>
                        
                        <div class="mb-3">
                            <asp:CheckBox ID="chkSkills" runat="server" Text="Skills Added" Enabled="false" />
                        </div>
                        
                        <div class="mb-3">
                            <asp:CheckBox ID="chkExperience" runat="server" Text="Experience Level" Enabled="false" />
                        </div>
                        
                        <div class="mb-3">
                            <asp:CheckBox ID="chkEducation" runat="server" Text="Education Details" Enabled="false" />
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="profile-card mt-4">
                        <h3 class="section-title-profile">
                            <i class="icon-flash mr-2"></i>Quick Actions
                        </h3>
                        
                        <div class="d-flex flex-column gap-2">
                            <a href="job_listings.aspx" class="btn btn-primary btn-block">
                                <i class="icon-search mr-2"></i>Browse Jobs
                            </a>
                            
                            <a href="my_applications.aspx" class="btn btn-outline-primary btn-block">
                                <i class="icon-briefcase mr-2"></i>View Applications
                            </a>
                            
                            <a href="saved_jobs.aspx" class="btn btn-outline-primary btn-block">
                                <i class="icon-bookmark mr-2"></i>Saved Jobs
                            </a>
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
                    <h3>Job Seeker Resources</h3>
                    <ul class="list-unstyled">
                        <li><a href="job_listings.aspx">Browse Jobs</a></li>
                        <li><a href="my_applications.aspx">My Applications</a></li>
                        <li><a href="saved_jobs.aspx">Saved Jobs</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Career Support</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Resume Tips</a></li>
                        <li><a href="#">Interview Guide</a></li>
                        <li><a href="#">Career Advice</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Account</h3>
                    <ul class="list-unstyled">
                        <li><a href="jobseeker_profile.aspx">My Profile</a></li>
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
                            All rights reserved | JobBoard Job Seeker Portal
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

