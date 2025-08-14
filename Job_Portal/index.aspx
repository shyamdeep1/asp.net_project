<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Job_Portal.index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- NAVBAR -->

    <header class="site-navbar py-4 js-sticky-header site-navbar-target" role="banner">
        <div class="container">
            <div class="row align-items-center">

                <!-- Logo -->
                <div class="col-6 col-xl-2">
                    <h1 class="mb-0 site-logo">
                        <a href="index.aspx" class="mb-0">JobBoard</a>
                    </h1>
                </div>

                <!-- Navbar Menu -->
                <div class="col-12 col-md-10 d-none d-xl-block">
                    <nav class="site-navigation position-relative text-right" role="navigation">
                        <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">

                            <!-- Public Menu -->
                            <asp:PlaceHolder ID="phPublic" runat="server" Visible="true">
                                <li><a href="index.aspx" class="nav-link">Home</a></li>
                                <li><a href="job_listing.aspx" class="nav-link">Job Listings</a></li>
                                <li><a href="about.aspx" class="nav-link">About</a></li>
                                <li><a href="contact.aspx" class="nav-link">Contact</a></li>
                              <%--  <li><a href="login.aspx" class="nav-link">Login</a></li>
                                <li><a href="register_jobseeker.aspx" class="nav-link">Register</a></li>--%>
                            </asp:PlaceHolder>

                            <!-- Job Seeker Menu -->
                            <asp:PlaceHolder ID="phJobSeeker" runat="server" Visible="false">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="jobSeekerDropdown" role="button"
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Job Seeker
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="jobSeekerDropdown">
                                        <a class="dropdown-item" href="jobseeker_profile.aspx">My Profile</a>
                                        <a class="dropdown-item" href="jobseeker_applied_jobs.aspx">Applied Jobs</a>
                                        <a class="dropdown-item" href="logout.aspx">Logout</a>
                                    </div>
                                </li>
                            </asp:PlaceHolder>

                            <!-- Recruiter Menu -->
                            <asp:PlaceHolder ID="phRecruiter" runat="server" Visible="false">
                                <li><a href="post_job.aspx" class="nav-link">Post Job</a></li>
                                <li><a href="manage_jobs.aspx" class="nav-link">Manage Jobs</a></li>
                                <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                            </asp:PlaceHolder>

                            <!-- Admin Menu -->
                            <asp:PlaceHolder ID="phAdmin" runat="server" Visible="false">
                                <li><a href="admin_dashboard.aspx" class="nav-link">Dashboard</a></li>
                                <li><a href="manage_users.aspx" class="nav-link">Manage Users</a></li>
                                <li><a href="manage_jobs_admin.aspx" class="nav-link">Manage Jobs</a></li>
                                <li><a href="logout.aspx" class="nav-link">Logout</a></li>
                            </asp:PlaceHolder>

                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </header>


    <!-- HOME -->
    <section class="home-section section-hero overlay bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row align-items-center justify-content-center">
                <div class="col-md-12">
                    <div class="mb-5 text-center">
                        <h1 class="text-white font-weight-bold">The Easiest Way To Get Your Dream Job</h1>
                        <p>
                            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cupiditate est, consequuntur perferendis.
                        </p>
                    </div>
                    <div class="search-jobs-form">
                        <div class="row mb-5">
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <input type="text" class="form-control form-control-lg" placeholder="Job title, Company...">
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <select class="selectpicker" data-style="btn-white btn-lg" data-width="100%" data-live-search="true" title="Select Region">
                                    <option>Anywhere</option>
                                    <option>San Francisco</option>
                                    <option>Palo Alto</option>
                                    <option>New York</option>
                                    <option>Manhattan</option>
                                    <option>Ontario</option>
                                    <option>Toronto</option>
                                    <option>Kansas</option>
                                    <option>Mountain View</option>
                                </select>
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <select class="selectpicker" data-style="btn-white btn-lg" data-width="100%" data-live-search="true" title="Select Job Type">
                                    <option>Part Time</option>
                                    <option>Full Time</option>
                                </select>
                            </div>
                            <div class="col-12 col-sm-6 col-md-6 col-lg-3 mb-4 mb-lg-0">
                                <button type="submit" class="btn btn-primary btn-lg btn-block text-white btn-search">
                                    <span class="icon-search icon mr-2"></span>Search Job
                                </button>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12 popular-keywords">
                                <h3>Trending Keywords:</h3>
                                <ul class="keywords list-unstyled m-0 p-0">
                                    <li><a href="#" class="">UI Designer</a></li>
                                    <li><a href="#" class="">Python</a></li>
                                    <li><a href="#" class="">Developer</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a href="#next" class="scroll-button smoothscroll"><span class=" icon-keyboard_arrow_down"></span></a>
    </section>
    <section class="py-5 bg-image overlay-primary fixed overlay" id="next" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-7 text-center">
                    <h2 class="section-title mb-2 text-white">JobBoard Site Stats</h2>
                    <p class="lead text-white">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. Expedita unde officiis recusandae sequi excepturi corrupti.
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
    <section class="site-section">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-7 text-center">
                    <h2 class="section-title mb-2">43,167 Job Listed</h2>
                </div>
            </div>
            <ul class="job-listings mb-5">
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_1.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Product Designer</h2>
                            <strong>Adidas</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>New York, New York
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-danger">Part Time</span>
                        </div>
                    </div>
                </li>
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_2.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Digital Marketing Director</h2>
                            <strong>Sprint</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>Overland Park, Kansas
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-success">Full Time</span>
                        </div>
                    </div>
                </li>
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_3.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Back-end Engineer (Python)</h2>
                            <strong>Amazon</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>Overland Park, Kansas
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-success">Full Time</span>
                        </div>
                    </div>
                </li>
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_4.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Senior Art Director</h2>
                            <strong>Microsoft</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>Anywhere
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-success">Full Time</span>
                        </div>
                    </div>
                </li>
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_5.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Product Designer</h2>
                            <strong>Puma</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>San Mateo, CA
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-success">Full Time</span>
                        </div>
                    </div>
                </li>
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_1.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Product Designer</h2>
                            <strong>Adidas</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>New York, New York
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-danger">Part Time</span>
                        </div>
                    </div>
                </li>
                <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center"><a href="job-single.html"></a>
                    <div class="job-listing-logo">
                        <img src="images/job_logo_2.jpg" alt="Free Website Template by Free-Template.co" class="img-fluid">
                    </div>
                    <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between mx-4">
                        <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                            <h2>Digital Marketing Director</h2>
                            <strong>Sprint</strong>
                        </div>
                        <div class="job-listing-location mb-3 mb-sm-0 custom-width w-25">
                            <span class="icon-room"></span>Overland Park, Kansas
                        </div>
                        <div class="job-listing-meta">
                            <span class="badge badge-success">Full Time</span>
                        </div>
                    </div>
                </li>
            </ul>
            <div class="row pagination-wrap">
                <div class="col-md-6 text-center text-md-left mb-4 mb-md-0">
                    <span>Showing 1-7 Of 43,167 Jobs</span>
                </div>
                <div class="col-md-6 text-center text-md-right">
                    <div class="custom-pagination ml-auto">
                        <a href="#" class="prev">Prev</a>
                        <div class="d-inline-block">
                            <a href="#" class="active">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a>
                        </div>
                        <a href="#" class="next">Next</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="py-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="text-white">Looking For A Job?</h2>
                    <p class="mb-0 text-white lead">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit tempora adipisci impedit.
                    </p>
                </div>
                <div class="col-md-3 ml-auto">
                    <a href="#" class="btn btn-warning btn-block btn-lg">Sign Up</a>
                </div>
            </div>
        </div>
    </section>
    <section class="site-section py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12 text-center mt-4 mb-5">
                    <div class="row justify-content-center">
                        <div class="col-md-7">
                            <h2 class="section-title mb-2">Company We've Helped</h2>
                            <p class="lead">
                                Porro error reiciendis commodi beatae omnis similique voluptate rerum ipsam fugit mollitia ipsum facilis expedita tempora suscipit iste
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
    <section class="bg-light pt-5 testimony-full">
        <div class="owl-carousel single-carousel">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 align-self-center text-center text-lg-left">
                        <blockquote>
                            <p>
                                &ldquo;Soluta quasi cum delectus eum facilis recusandae nesciunt molestias accusantium libero dolores repellat id in dolorem laborum ad modi qui at quas dolorum voluptatem voluptatum repudiandae.&rdquo;
                            </p>
                            <p>
                                <cite>&mdash; Corey Woods, @Dribbble</cite>
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
                                &ldquo;Soluta quasi cum delectus eum facilis recusandae nesciunt molestias accusantium libero dolores repellat id in dolorem laborum ad modi qui at quas dolorum voluptatem voluptatum repudiandae.&rdquo;
                            </p>
                            <p>
                                <cite>&mdash; Chris Peters, @Google</cite>
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
    <section class="pt-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row">
                <div class="col-md-6 align-self-center text-center text-md-left mb-5 mb-md-0">
                    <h2 class="text-white">Get The Mobile Apps</h2>
                    <p class="mb-5 lead text-white">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit tempora adipisci impedit.
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
                        <a href="#"><span class="icon-facebook"></span></a><a href="#"><span class="icon-twitter"></span></a><a href="#"><span class="icon-instagram"></span></a><a href="#"><span class="icon-linkedin"></span></a>
                    </div>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-12">
                    <p class="copyright">
                        <small>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | This template is made with <i class="icon-heart text-danger" aria-hidden="true"></i>by <a href="https://colorlib.com" target="_blank">Colorlib</a>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                        </small>
                    </p>
                </div>
            </div>
        </div>
    </footer>
    </div>

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
</asp:Content>

