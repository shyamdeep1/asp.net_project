<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Job_Portal.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- HOME SECTION - Navigation removed, now in Master page -->
    <section class="home-section section-hero overlay bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-md-12">
                    <div class="mb-5 text-center">
                        <asp:Label ID="lblWelcome" runat="server" Text="Label"></asp:Label>
                        <h1 class="text-white font-weight-bold">The Easiest Way To Get Your Dream Job</h1>
                        <p class="text-white" style="font-size: 1.15rem; opacity: 0.9; max-width: 700px; margin: 0 auto;">
                            Connect with top employers and discover career opportunities that match your skills and aspirations. Start your journey today!
                        </p>
                    </div>
                    <div class="search-jobs-form">
                        <div class="row mb-5">
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control form-control-lg" placeholder="Job title" style="height: 58px; border-radius: 5px; font-size: 1rem;"></asp:TextBox>
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control form-control-lg" placeholder="City" style="height: 58px; border-radius: 5px; font-size: 1rem;"></asp:TextBox>
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-control form-control-lg" style="height: 58px; border-radius: 5px; font-size: 1rem; background-color: white; appearance: menulist;">
                                    <asp:ListItem Text="Select Job Type" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Part-Time" Value="Part-Time"></asp:ListItem>
                                    <asp:ListItem Text="Full-Time" Value="Full-Time"></asp:ListItem>
                                    <asp:ListItem Text="Contract" Value="Contract"></asp:ListItem>
                                    <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <asp:Button ID="btnSearch" runat="server" Text="Search Job" OnClick="btnSearch_Click"
                                    CssClass="btn btn-primary btn-lg btn-block text-white btn-search" 
                                    style="height: 58px; border-radius: 5px; font-size: 1rem; font-weight: 600; border: none; background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%); box-shadow: 0 4px 12px rgba(137, 186, 22, 0.3); transition: all 0.3s ease;" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 popular-keywords">
                                <h3 style="color: rgba(255,255,255,0.8); font-size: 1.1rem; margin-bottom: 15px;">Trending Keywords:</h3>
                                <ul class="keywords list-unstyled m-0 p-0">
                                    <li><a href="#" style="display: inline-block; padding: 8px 20px; background: rgba(255,255,255,0.2); border-radius: 25px; color: white; text-decoration: none; margin: 5px; transition: all 0.3s ease; font-size: 0.95rem;">UI Designer</a></li>
                                    <li><a href="#" style="display: inline-block; padding: 8px 20px; background: rgba(255,255,255,0.2); border-radius: 25px; color: white; text-decoration: none; margin: 5px; transition: all 0.3s ease; font-size: 0.95rem;">Python</a></li>
                                    <li><a href="#" style="display: inline-block; padding: 8px 20px; background: rgba(255,255,255,0.2); border-radius: 25px; color: white; text-decoration: none; margin: 5px; transition: all 0.3s ease; font-size: 0.95rem;">Developer</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <style>
                        .search-jobs-form .btn-search:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 16px rgba(137, 186, 22, 0.5) !important;
                        }
                        
                        .search-jobs-form .form-control:focus {
                            border-color: #89ba16;
                            box-shadow: 0 0 0 0.2rem rgba(137, 186, 22, 0.25);
                        }
                        
                        .keywords li a:hover {
                            background: rgba(255,255,255,0.3) !important;
                            transform: translateY(-2px);
                        }
                        
                        /* Ensure all form controls are same height */
                        .search-jobs-form .form-control,
                        .search-jobs-form .btn {
                            height: 58px !important;
                            line-height: normal;
                        }
                        
                        /* Fix dropdown arrow */
                        .search-jobs-form select.form-control {
                            padding-right: 30px;
                            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3E%3Cpath fill='none' stroke='%23343a40' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3E%3C/svg%3E");
                            background-repeat: no-repeat;
                            background-position: right 0.75rem center;
                            background-size: 16px 12px;
                        }
                    </style>
                </div>
            </div>
        </div>
        <a href="#next" class="scroll-button smoothscroll"><span class=" icon-keyboard_arrow_down"></span></a>
    </section>

    <!-- STATISTICS -->
    <section class="py-5 bg-image overlay-primary fixed overlay" id="next" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-7 text-center">
                    <h2 class="section-title mb-2 text-white">JobBoard Site Stats</h2>
                    <p class="lead text-white">
                        Join thousands of satisfied users who have found their perfect match through our platform. Your success story starts here!
                    </p>
                </div>
            </div>
            <div class="row pb-0 block__19738 section-counter">
                <div class="col-6 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="1930">0</strong>
                    </div>
                    <span class="caption">Candidates</span>
                </div>
                <div class="col-6 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="54">0</strong>
                    </div>
                    <span class="caption">Jobs Posted</span>
                </div>
                <div class="col-6 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="120">0</strong>
                    </div>
                    <span class="caption">Jobs Filled</span>
                </div>
                <div class="col-6 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="550">0</strong>
                    </div>
                    <span class="caption">Companies</span>
                </div>
            </div>
        </div>
    </section>

    <!-- JOB LISTINGS -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-9 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Latest Job Listings</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">Explore thousands of job opportunities with all the information you need</p>
                </div>
            </div>
            <asp:DataList ID="dlJobs" runat="server" RepeatDirection="Vertical" RepeatColumns="1" CssClass="job-listings mb-5" OnItemCommand="dlJobs_ItemCommand">
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
                            <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                                <h2 style="font-size: 1.75rem; font-weight: 700; color: #2c3e50; margin-bottom: 12px; line-height: 1.3;">
                                    <%# Eval("Category") %>
                                </h2>
                                <strong style="color: #555; font-size: 1.05rem; display: block; margin-bottom: 10px; background: #f8f9fa; padding: 8px 12px; border-radius: 6px; display: inline-block;">
                                    <i class="icon-briefcase mr-2" style="color: #89ba16;"></i>Skills: <%# Eval("SkillsRequired") %>
                                </strong>
                                <p class="text-muted mb-0" style="font-size: 1rem; margin-top: 10px;">
                                    <i class="icon-clock-o mr-2" style="color: #89ba16;"></i>
                                    <strong>Experience:</strong> <%# Eval("ExperienceRequired") %>
                                </p>
                            </div>
                            <div class="job-listing-location mb-3 mb-sm-0" style="min-width: 220px;">
                                <div style="margin-bottom: 15px; padding: 10px; background: #f8f9fa; border-radius: 8px;">
                                    <span class="icon-room" style="color: #89ba16; font-size: 1.3rem; margin-right: 8px;"></span>
                                    <span style="color: #333; font-weight: 600; font-size: 1.05rem;"><%# Eval("Location") %></span>
                                </div>
                                <p class="text-success mb-0" style="font-size: 1.3rem; font-weight: 700; padding: 10px; background: #e8f5e9; border-radius: 8px; text-align: center;">
                                    <i class="icon-money mr-2"></i><%# Eval("Salary") %>
                                </p>
                            </div>
                            <div class="job-listing-meta d-flex flex-column align-items-end justify-content-center" style="min-width: 180px; gap: 15px;">
                                <span class='badge <%# Eval("JobType").ToString() == "Part-Time" ? "badge-danger" : Eval("JobType").ToString() == "Full-Time" ? "badge-success" : "badge-info" %>' 
                                      style="font-size: 0.95rem; padding: 10px 20px; font-weight: 600; border-radius: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);">
                                    <%# Eval("JobType") %>
                                </span>
                                <asp:Button ID="btnViewDetails" runat="server" 
                                    Text="View Details" 
                                    CommandName="ViewDetails" 
                                    CommandArgument='<%# Eval("JobID") %>' 
                                    CssClass="btn btn-primary" 
                                    style="padding: 12px 30px; font-weight: 600; border-radius: 25px; font-size: 1rem; box-shadow: 0 4px 12px rgba(137, 186, 22, 0.3); transition: all 0.3s ease; border: none; background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);" />
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
                <ItemStyle CssClass="job-item-hover" />
            </asp:DataList>
            
            <!-- No Jobs Message -->
            <asp:Panel ID="pnlNoJobs" runat="server" Visible="false" CssClass="text-center py-5">
                <div style="padding: 60px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                    <i class="icon-briefcase" style="font-size: 4rem; color: #ccc; margin-bottom: 20px; display: block;"></i>
                    <h4 style="color: #666; font-size: 1.5rem; font-weight: 600; margin-bottom: 10px;">No Jobs Available</h4>
                    <p style="color: #999; font-size: 1.1rem;">Please check back later for new opportunities.</p>
                </div>
            </asp:Panel>
            
            <div class="row pagination-wrap" style="margin-top: 50px;">
                <div class="col-md-6 text-center text-md-left mb-4 mb-md-0">
                    <span style="color: #666; font-weight: 600; font-size: 1.1rem;">Showing Latest Jobs</span>
                </div>
                <div class="col-md-6 text-center text-md-right">
                    <div class="custom-pagination ml-auto">
                        <a href="#" class="prev" style="padding: 10px 20px; font-weight: 600;">Prev</a>
                        <div class="d-inline-block">
                            <a href="#" class="active" style="padding: 10px 15px;">1</a> 
                            <a href="#" style="padding: 10px 15px;">2</a> 
                            <a href="#" style="padding: 10px 15px;">3</a> 
                            <a href="#" class="next" style="padding: 10px 20px; font-weight: 600;">Next</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- View All Jobs Button -->
            <div class="row mt-5">
                <div class="col-md-12 text-center">
                    <a href="job_listings.aspx" class="btn btn-primary btn-lg px-5 py-3" 
                       style="font-size: 1.2rem; font-weight: 600; border-radius: 30px; box-shadow: 0 6px 20px rgba(137, 186, 22, 0.3); background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%); border: none;">
                        <i class="icon-search mr-2"></i>Browse All Jobs
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
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(137, 186, 22, 0.4) !important;
        }
        
        .custom-pagination a {
            transition: all 0.3s ease;
        }
        
        .custom-pagination a:hover {
            background: #89ba16;
            color: white;
            transform: translateY(-2px);
        }
    </style>

    <!-- COMPANIES SECTION -->
    <section class="site-section py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 text-center mt-4 mb-5">
                    <div class="row justify-content-center">
                        <div class="col-md-7">
                            <h2 class="section-title mb-2">Companies We've Helped</h2>
                            <p class="lead">
                                Trusted by leading organizations worldwide to connect them with exceptional talent and build successful teams.
                            </p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_mailchimp.svg" alt="Image" class="img-fluid logo-1">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_paypal.svg" alt="Image" class="img-fluid logo-2">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_stripe.svg" alt="Image" class="img-fluid logo-3">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_visa.svg" alt="Image" class="img-fluid logo-4">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_apple.svg" alt="Image" class="img-fluid logo-5">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_tinder.svg" alt="Image" class="img-fluid logo-6">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_sony.svg" alt="Image" class="img-fluid logo-7">
                </div>
                <div class="col-6 col-lg-3 col-md-6 text-center">
                    <img src="images/logo_airbnb.svg" alt="Image" class="img-fluid logo-8">
                </div>
            </div>
        </div>
    </section>
    
    <!-- TESTIMONIALS -->
    <section class="bg-light pt-5 testimony-full">
        <div class="owl-carousel single-carousel">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 align-self-center text-center text-lg-left">
                        <blockquote>
                            <p>
                                &ldquo;JobBoard transformed our hiring process completely. We found the perfect candidates for our team within weeks. The platform is intuitive and the quality of applicants is outstanding.&rdquo;
                            </p>
                            <p>
                                <cite>&mdash; Corey Woods, HR Director @Dribbble</cite>
                            </p>
                        </blockquote>
                    </div>
                    <div class="col-lg-6 align-self-end text-center text-lg-right">
                        <img src="images/person_transparent_2.png" alt="Image" class="img-fluid mb-0">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 align-self-center text-center text-lg-left">
                        <blockquote>
                            <p>
                                &ldquo;As a job seeker, this platform made finding my dream job incredibly easy. The search filters are powerful and I loved the ability to apply with just one click. Highly recommended!&rdquo;
                            </p>
                            <p>
                                <cite>&mdash; Chris Peters, Software Engineer @Google</cite>
                            </p>
                        </blockquote>
                    </div>
                    <div class="col-lg-6 align-self-end text-center text-lg-right">
                        <img src="images/person_transparent.png" alt="Image" class="img-fluid mb-0">
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- MOBILE APP SECTION -->
    <section class="pt-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row">
                <div class="col-md-6 align-self-center text-center text-md-left mb-5 mb-md-0">
                    <h2 class="text-white">Get The Mobile Apps</h2>
                    <p class="mb-5 lead text-white">
                        Search and apply for jobs on the go. Download our mobile app and never miss an opportunity. Available for iOS and Android devices.
                    </p>
                    <p class="mb-0">
                        <a href="#" class="btn btn-dark btn-md px-4 border-width-2"><span class="icon-apple mr-3"></span>App Store</a> <a href="#" class="btn btn-dark btn-md px-4 border-width-2"><span class="icon-android mr-3"></span>Play Store</a>
                    </p>
                </div>
                <div class="col-md-6 ml-auto align-self-end">
                    <img src="images/apps.png" alt="Free Website Template by Free-Template.co" class="img-fluid">
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder3">
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
                        <li><a href="#">About Us</a></li>
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
                        <small>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | This template is made with <i class="icon-heart text-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </small>
                    </p>
                </div>
            </div>
        </div>
    </footer>
</asp:Content>

        <!-- SCRIPTS -->
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

