<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="jobseeker_applied_jobs.aspx.cs" Inherits="Job_Portal.jobseeker_applied_jobs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                            <li><a href="jobseeker_profile.aspx" class="nav-link">My Profile</a></li>
                            <li><a href="jobseeker_applied_jobs.aspx" class="nav-link active">Applied Jobs</a></li>
                            <li><a href="saved_jobs.aspx" class="nav-link">Saved Jobs</a></li>
                            <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </header>

    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center">
                        <h1 class="text-white font-weight-bold mb-3" style="font-size: 3rem;">My Applied Jobs</h1>
                        <p class="text-white lead" style="font-size: 1.3rem; max-width: 700px; margin: 0 auto;">
                            Track all your job applications in one place. Stay updated on your application status and never miss an opportunity.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12">
                    <div class="bg-light p-4 rounded" style="box-shadow: 0 4px 15px rgba(0,0,0,0.08);">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h3 class="mb-2" style="color: #2c3e50; font-weight: 700;">
                                    <i class="icon-briefcase mr-2" style="color: #89ba16;"></i>Application Dashboard
                                </h3>
                                <p class="mb-0 text-muted">
                                    <asp:Label ID="lblApplicationCount" runat="server" Text=""></asp:Label>
                                </p>
                            </div>
                            <div class="col-md-4 text-md-right mt-3 mt-md-0">
                                <asp:Label ID="lblUserName" runat="server" CssClass="badge badge-primary" Style="font-size: 1rem; padding: 10px 20px;"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Label ID="lblResultsCount" runat="server" CssClass="h5" Style="color: #2c3e50; font-weight: 600;"></asp:Label>
                        </div>
                        <div>
                            <asp:DropDownList ID="ddlFilterStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterStatus_SelectedIndexChanged"
                                CssClass="form-control" Style="min-width: 200px;">
                                <asp:ListItem Value="" Selected="True">All Applications</asp:ListItem>
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Reviewed">Reviewed</asp:ListItem>
                                <asp:ListItem Value="Shortlisted">Shortlisted</asp:ListItem>
                                <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                                <asp:ListItem Value="Accepted">Accepted</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>

            <asp:DataList ID="dlAppliedJobs" runat="server" RepeatDirection="Vertical" RepeatColumns="1" CssClass="job-listings mb-5" OnItemCommand="dlAppliedJobs_ItemCommand">
                <ItemTemplate>
                    <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"
                        style="margin-bottom: 30px; border: 2px solid #f0f0f0; padding: 25px; border-radius: 12px; background: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: all 0.3s ease;">

                        <div class="job-listing-logo" style="flex: 0 0 140px; margin-right: 25px;">
                            <img src='<%# Eval("Company_Logo") != DBNull.Value && !string.IsNullOrEmpty(Eval("Company_Logo").ToString()) ? ResolveUrl(Eval("Company_Logo").ToString()) : ResolveUrl("~/images/job_logo_1.jpg") %>'
                                alt="Company Logo" class="img-fluid"
                                style="max-width: 120px; max-height: 120px; object-fit: cover; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); border: 3px solid #f8f9fa;"
                                onerror="this.src='images/job_logo_1.jpg';">
                        </div>

                        <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between" style="gap: 20px;">
                            <div class="job-listing-position custom-width w-100 mb-3 mb-sm-0">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h2 style="font-size: 1.75rem; font-weight: 700; color: #2c3e50; margin-bottom: 12px; line-height: 1.3;">
                                            <%# Eval("JobTitle") %>
                                        </h2>
                                        <strong style="color: #555; font-size: 1.05rem; display: block; margin-bottom: 10px; background: #f8f9fa; padding: 8px 12px; border-radius: 6px; display: inline-block;">
                                            <i class="icon-building mr-2" style="color: #89ba16;"></i><%# Eval("CompanyName") %>
                                        </strong>
                                        <p class="text-muted mb-2" style="font-size: 1rem;">
                                            <i class="icon-room mr-2" style="color: #89ba16;"></i>
                                            <strong>Location:</strong> <%# Eval("Location") %>
                                        </p>
                                        <p class="text-muted mb-2" style="font-size: 1rem;">
                                            <i class="icon-briefcase mr-2" style="color: #89ba16;"></i>
                                            <strong>Category:</strong> <%# Eval("Category") %>
                                        </p>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3" style="padding: 15px; background: #f8f9fa; border-radius: 8px;">
                                            <p class="mb-2" style="font-size: 0.95rem; color: #666;">
                                                <i class="icon-calendar mr-2" style="color: #89ba16;"></i>
                                                <strong>Applied:</strong> <%# Convert.ToDateTime(Eval("ApplicationDate")).ToString("MMM dd, yyyy") %>
                                            </p>
                                            <p class="text-success mb-2" style="font-size: 1.1rem; font-weight: 600;">
                                                <i class="icon-money mr-2"></i><%# Eval("Salary") %>
                                            </p>
                                            <div class="mt-2">
                                                <span class='badge <%# GetStatusBadgeClass(Eval("Status").ToString()) %>'
                                                    style="font-size: 0.95rem; padding: 8px 16px; font-weight: 600; border-radius: 20px;">
                                                    <%# Eval("Status") %>
                                                </span>
                                                <span class='badge <%# Eval("JobType").ToString() == "Part-Time" ? "badge-danger" : Eval("JobType").ToString() == "Full-Time" ? "badge-success" : "badge-info" %>'
                                                    style="font-size: 0.9rem; padding: 8px 16px; font-weight: 600; border-radius: 20px; margin-left: 5px;">
                                                    <%# Eval("JobType") %>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="d-flex gap-2 flex-wrap">
                                            <asp:Button ID="btnViewJob" runat="server"
                                                Text="View Job"
                                                CommandName="ViewJob"
                                                CommandArgument='<%# Eval("JobID") %>'
                                                CssClass="btn btn-primary btn-sm"
                                                Style="padding: 10px 20px; font-weight: 600; border-radius: 20px; font-size: 0.9rem; margin-right: 5px;" />

                                            <asp:Button ID="btnViewApplication" runat="server"
                                                Text="Download Application"
                                                CommandName="ViewApplication"
                                                CommandArgument='<%# Eval("ApplicationID") %>'
                                                OnClientClick="this.form.target='_blank';"
                                                CssClass="btn btn-outline-primary btn-sm"
                                                Style="padding: 10px 20px; font-weight: 600; border-radius: 20px; font-size: 0.9rem;" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:DataList>

            <asp:Panel ID="pnlNoApplications" runat="server" Visible="false" CssClass="text-center py-5">
                <div style="padding: 60px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                    <i class="icon-paper-plane" style="font-size: 4rem; color: #ccc; margin-bottom: 20px; display: block;"></i>
                    <h4 style="color: #666; font-size: 1.5rem; font-weight: 600; margin-bottom: 10px;">No Applications Yet</h4>
                    <p style="color: #999; font-size: 1.1rem; margin-bottom: 20px;">You haven't applied to any jobs yet. Start exploring opportunities!</p>
                    <a href="job_listings.aspx" class="btn btn-primary btn-lg px-5 py-3"
                        style="font-size: 1.1rem; font-weight: 600; border-radius: 30px; box-shadow: 0 6px 20px rgba(137, 186, 22, 0.3);">
                        <i class="icon-search mr-2"></i>Browse Jobs
                    </a>
                </div>
            </asp:Panel>
        </div>
    </section>

    <section class="site-section bg-light" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-8 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Application Status Guide</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Understanding your application status
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="p-4 bg-white rounded shadow-sm" style="height: 100%;">
                        <span class="badge badge-warning mb-3" style="font-size: 1rem; padding: 10px 20px;">Pending</span>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Under Review</h4>
                        <p style="color: #666; line-height: 1.8;">Your application has been received and is waiting for the recruiter's review.</p>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="p-4 bg-white rounded shadow-sm" style="height: 100%;">
                        <span class="badge badge-info mb-3" style="font-size: 1rem; padding: 10px 20px;">Reviewed</span>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Application Reviewed</h4>
                        <p style="color: #666; line-height: 1.8;">Your application has been reviewed by the recruiter and is being evaluated.</p>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="p-4 bg-white rounded shadow-sm" style="height: 100%;">
                        <span class="badge badge-primary mb-3" style="font-size: 1rem; padding: 10px 20px;">Shortlisted</span>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Congratulations!</h4>
                        <p style="color: #666; line-height: 1.8;">Great news! You've been shortlisted. The recruiter may contact you soon for the next steps.</p>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="p-4 bg-white rounded shadow-sm" style="height: 100%;">
                        <span class="badge badge-success mb-3" style="font-size: 1rem; padding: 10px 20px;">Accepted</span>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Offer Extended</h4>
                        <p style="color: #666; line-height: 1.8;">Excellent! You've received a job offer. Check your email for further details.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="pt-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8">
                    <h2 class="text-white mb-3">Keep Exploring More Opportunities</h2>
                    <p class="mb-0 text-white lead">
                        Don't stop here! Continue exploring and applying to more job opportunities that match your skills and career goals.
                    </p>
                </div>
                <div class="col-md-4 text-md-right mt-4 mt-md-0">
                    <a href="job_listings.aspx" class="btn btn-warning btn-lg px-5 py-3"
                        style="font-weight: 600; border-radius: 30px; box-shadow: 0 6px 20px rgba(0,0,0,0.3);">Browse More Jobs
                    </a>
                </div>
            </div>
        </div>
    </section>

    <style>
        .job-listing:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
            border-color: #89ba16 !important;
        }

        .btn-primary:hover, .btn-outline-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(137, 186, 22, 0.4) !important;
        }

        .section-hero.inner-page {
            padding: 150px 0 100px 0;
        }

        .badge-warning {
            background-color: #ffc107;
            color: #000;
        }

        .badge-info {
            background-color: #17a2b8;
            color: #fff;
        }

        .badge-primary {
            background-color: #89ba16;
            color: #fff;
        }

        .badge-success {
            background-color: #28a745;
            color: #fff;
        }

        .badge-danger {
            background-color: #dc3545;
            color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <footer class="site-footer">
        <a href="#top" class="smoothscroll scroll-top"><span class="icon-keyboard_arrow_up"></span></a>
        <div class="container">
            <div class="row mb-5">
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Search Trending</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Web Design</a></li>
                        <li><a href="#">Graphic Design</a></li>
                        <li><a href="#">Web Developers</a></li>
                        <li><a href="#">Python</a></li>
                        <li><a href="#">HTML5</a></li>
                        <li><a href="#">CSS3</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Company</h3>
                    <ul class="list-unstyled">
                        <li><a href="about.aspx">About Us</a></li>
                        <li><a href="#">Career</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Resources</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Support</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Support</a></li>
                        <li><a href="#">Privacy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                    </ul>
                </div>
                <div class="col-6 col-md-3 mb-4 mb-md-0">
                    <h3>Contact Us</h3>
                    <div class="footer-social">
                        <a href="#"><span class="icon-facebook"></span></a>
                        <a href="#"><span class="icon-twitter"></span></a>
                        <a href="#"><span class="icon-instagram"></span></a>
                        <a href="#"><span class="icon-linkedin"></span></a>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <p class="copyright">
                        <small>Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | This template is made with <i class="icon-heart text-danger" aria-hidden="true"></i>by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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


