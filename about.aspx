<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="Job_Portal.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
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
                            <li><a href="index.aspx" class="nav-link">Home</a></li>
                            <li><a href="job_listings.aspx" class="nav-link">Job Listings</a></li>
                            <li><a href="about.aspx" class="nav-link active">About</a></li>
                            <li><a href="contact.aspx" class="nav-link">Contact</a></li>
                        </ul>
                    </nav>
                </div>

            </div>
        </div>
    </header>

    <!-- HERO SECTION -->
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center">
                        <h1 class="text-white font-weight-bold mb-3" style="font-size: 3rem;">About Us</h1>
                        <p class="text-white lead" style="font-size: 1.3rem; max-width: 700px; margin: 0 auto;">
                            Your trusted partner in connecting talent with opportunity. We're revolutionizing the way people find jobs and companies find talent.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ABOUT INTRO -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <img src="images/hero_1.jpg" alt="About JobBoard" class="img-fluid rounded shadow-lg"
                         style="border-radius: 15px !important; box-shadow: 0 10px 40px rgba(0,0,0,0.15) !important;">
                </div>
                <div class="col-lg-6">
                    <h2 class="section-title mb-4" style="font-size: 2.5rem; font-weight: 700; color: #2c3e50;">
                        Who We Are
                    </h2>
                    <p class="lead mb-4" style="font-size: 1.2rem; color: #555; line-height: 1.8;">
                        JobBoard is a leading online job portal that connects talented professionals with their dream careers.
                        Founded with a vision to simplify the job search process, we've helped thousands of job seekers find
                        meaningful employment and assisted companies in building exceptional teams.
                    </p>
                    <p style="font-size: 1.1rem; color: #666; line-height: 1.8;">
                        With our advanced matching algorithms and user-friendly platform, we make it easier than ever for
                        job seekers to discover opportunities that align with their skills and aspirations, while helping
                        employers find the perfect candidates quickly and efficiently.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- MISSION & VISION -->
    <section class="site-section bg-light" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-8 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Our Mission & Vision</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Driven by purpose, guided by values
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="p-5 bg-white rounded shadow" style="height: 100%; border-left: 5px solid #89ba16;">
                        <div class="mb-4">
                            <span class="icon-target" style="font-size: 3rem; color: #89ba16;"></span>
                        </div>
                        <h3 class="mb-3" style="font-weight: 700; color: #2c3e50;">Our Mission</h3>
                        <p style="font-size: 1.1rem; color: #666; line-height: 1.8;">
                            To empower individuals to achieve their career aspirations while helping businesses build
                            exceptional teams. We strive to create meaningful connections between talent and opportunity,
                            making the hiring process seamless, efficient, and rewarding for everyone involved.
                        </p>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="p-5 bg-white rounded shadow" style="height: 100%; border-left: 5px solid #89ba16;">
                        <div class="mb-4">
                            <span class="icon-eye" style="font-size: 3rem; color: #89ba16;"></span>
                        </div>
                        <h3 class="mb-3" style="font-weight: 700; color: #2c3e50;">Our Vision</h3>
                        <p style="font-size: 1.1rem; color: #666; line-height: 1.8;">
                            To become the world's most trusted job platform, where every professional finds fulfilling
                            work and every organization discovers outstanding talent. We envision a future where career
                            growth is accessible to all, and hiring decisions are powered by intelligence and innovation.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- WHY CHOOSE US -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-8 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Why Choose JobBoard</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        We offer the best platform for job seekers and recruiters
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 rounded" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); height: 100%; transition: all 0.3s ease;">
                        <div class="mb-4">
                            <span class="icon-search" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Smart Job Search</h4>
                        <p style="font-size: 1rem; color: #666; line-height: 1.7;">
                            Our advanced search filters and intelligent matching algorithm help you find jobs that
                            perfectly match your skills, experience, and career goals.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 rounded" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); height: 100%; transition: all 0.3s ease;">
                        <div class="mb-4">
                            <span class="icon-briefcase" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Top Companies</h4>
                        <p style="font-size: 1rem; color: #666; line-height: 1.7;">
                            Connect with leading employers across various industries. We partner with renowned
                            organizations offering excellent career opportunities and growth potential.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 rounded" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); height: 100%; transition: all 0.3s ease;">
                        <div class="mb-4">
                            <span class="icon-shield" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Secure & Private</h4>
                        <p style="font-size: 1rem; color: #666; line-height: 1.7;">
                            Your data security is our priority. We employ industry-leading security measures to
                            protect your personal information and ensure complete privacy.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 rounded" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); height: 100%; transition: all 0.3s ease;">
                        <div class="mb-4">
                            <span class="icon-flash" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Quick Apply</h4>
                        <p style="font-size: 1rem; color: #666; line-height: 1.7;">
                            Apply to multiple jobs with just one click. Save your profile and resume, and apply
                            to opportunities instantly without repeating information.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 rounded" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); height: 100%; transition: all 0.3s ease;">
                        <div class="mb-4">
                            <span class="icon-users" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Expert Support</h4>
                        <p style="font-size: 1rem; color: #666; line-height: 1.7;">
                            Our dedicated support team is always ready to assist you. Get expert guidance on
                            resume building, interview preparation, and career planning.
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 rounded" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); height: 100%; transition: all 0.3s ease;">
                        <div class="mb-4">
                            <span class="icon-mobile-phone" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Mobile Friendly</h4>
                        <p style="font-size: 1rem; color: #666; line-height: 1.7;">
                            Search and apply for jobs on the go. Our mobile-responsive platform works seamlessly
                            on all devices, ensuring you never miss an opportunity.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- STATISTICS -->
    <section class="py-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-7 text-center">
                    <h2 class="section-title mb-2 text-white">Our Impact</h2>
                    <p class="lead text-white">
                        Numbers that reflect our commitment to excellence
                    </p>
                </div>
            </div>
            <div class="row pb-0 block__19738 section-counter">
                <div class="col-6 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="1930">0</strong>
                    </div>
                    <span class="caption">Active Candidates</span>
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
                    <span class="caption">Successful Placements</span>
                </div>
                <div class="col-6 col-md-6 col-lg-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="550">0</strong>
                    </div>
                    <span class="caption">Partner Companies</span>
                </div>
            </div>
        </div>
    </section>

    <!-- OUR TEAM -->
    <section class="site-section bg-light" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5 justify-content-center">
                <div class="col-md-8 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Meet Our Team</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Passionate professionals dedicated to your success
                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="team-member bg-white rounded shadow text-center p-4" style="transition: all 0.3s ease;">
                        <div class="mb-4">
                            <img src="images/person_transparent.png" alt="Team Member" class="img-fluid rounded-circle"
                                 style="width: 150px; height: 150px; object-fit: cover; border: 5px solid #89ba16;">
                        </div>
                        <h4 class="mb-2" style="font-weight: 700; color: #2c3e50;">John Smith</h4>
                        <p class="text-muted mb-3">CEO & Founder</p>
                        <p style="font-size: 0.95rem; color: #666;">
                            Visionary leader with 15+ years of experience in HR technology.
                        </p>
                        <div class="social-links mt-3">
                            <a href="#" class="mr-2"><span class="icon-linkedin" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                            <a href="#" class="mr-2"><span class="icon-twitter" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="team-member bg-white rounded shadow text-center p-4" style="transition: all 0.3s ease;">
                        <div class="mb-4">
                            <img src="images/person_transparent_2.png" alt="Team Member" class="img-fluid rounded-circle"
                                 style="width: 150px; height: 150px; object-fit: cover; border: 5px solid #89ba16;">
                        </div>
                        <h4 class="mb-2" style="font-weight: 700; color: #2c3e50;">Sarah Johnson</h4>
                        <p class="text-muted mb-3">CTO</p>
                        <p style="font-size: 0.95rem; color: #666;">
                            Tech innovator driving our platform's cutting-edge features.
                        </p>
                        <div class="social-links mt-3">
                            <a href="#" class="mr-2"><span class="icon-linkedin" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                            <a href="#" class="mr-2"><span class="icon-twitter" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="team-member bg-white rounded shadow text-center p-4" style="transition: all 0.3s ease;">
                        <div class="mb-4">
                            <img src="images/person_transparent.png" alt="Team Member" class="img-fluid rounded-circle"
                                 style="width: 150px; height: 150px; object-fit: cover; border: 5px solid #89ba16;">
                        </div>
                        <h4 class="mb-2" style="font-weight: 700; color: #2c3e50;">Michael Chen</h4>
                        <p class="text-muted mb-3">Head of Operations</p>
                        <p style="font-size: 0.95rem; color: #666;">
                            Ensuring seamless operations and exceptional user experience.
                        </p>
                        <div class="social-links mt-3">
                            <a href="#" class="mr-2"><span class="icon-linkedin" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                            <a href="#" class="mr-2"><span class="icon-twitter" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="team-member bg-white rounded shadow text-center p-4" style="transition: all 0.3s ease;">
                        <div class="mb-4">
                            <img src="images/person_transparent_2.png" alt="Team Member" class="img-fluid rounded-circle"
                                 style="width: 150px; height: 150px; object-fit: cover; border: 5px solid #89ba16;">
                        </div>
                        <h4 class="mb-2" style="font-weight: 700; color: #2c3e50;">Emily Davis</h4>
                        <p class="text-muted mb-3">Head of Marketing</p>
                        <p style="font-size: 0.95rem; color: #666;">
                            Building relationships and expanding our reach globally.
                        </p>
                        <div class="social-links mt-3">
                            <a href="#" class="mr-2"><span class="icon-linkedin" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                            <a href="#" class="mr-2"><span class="icon-twitter" style="font-size: 1.5rem; color: #89ba16;"></span></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA SECTION -->
    <section class="pt-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8">
                    <h2 class="text-white mb-3">Ready to Start Your Journey?</h2>
                    <p class="mb-0 text-white lead">
                        Join thousands of successful professionals who found their dream careers with JobBoard.
                        Start your journey today and discover endless opportunities.
                    </p>
                </div>
                <div class="col-md-4 text-md-right mt-4 mt-md-0">
                    <a href="register_jobseeker.aspx" class="btn btn-warning btn-lg px-5 py-3"
                       style="font-weight: 600; border-radius: 30px; box-shadow: 0 6px 20px rgba(0,0,0,0.3);">
                        Get Started Now
                    </a>
                </div>
            </div>
        </div>
    </section>

    <style>
        .team-member:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2) !important;
        }

        .col-md-4 > div:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(137, 186, 22, 0.2);
        }

        .section-hero.inner-page {
            padding: 150px 0 100px 0;
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
                        <small>
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script>
                            All rights reserved | This template is made with <i class="icon-heart text-danger" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
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