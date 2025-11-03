<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="contact.aspx.cs" Inherits="Job_Portal.contact" %>

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
                            <li><a href="about.aspx" class="nav-link">About</a></li>
                            <li><a href="contact.aspx" class="nav-link active">Contact</a></li>
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
                        <h1 class="text-white font-weight-bold mb-3" style="font-size: 3rem;">Get In Touch</h1>
                        <p class="text-white lead" style="font-size: 1.3rem; max-width: 700px; margin: 0 auto;">
                            Have questions? We're here to help! Reach out to us and we'll get back to you as soon as possible.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Information Section -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Contact Information</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Connect with us throug
                        h any of these channels
                    </p>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-light rounded shadow-sm" style="height: 100%; transition: all 0.3s ease;">
                        <div class="mb-3">
                            <span class="icon-map" style="font-size: 3rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Our Office</h4>
                        <p style="color: #666; line-height: 1.8;">
                            123 Business Street<br />
                            Tech City, TC 12345<br />
                            United States
                        </p>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-light rounded shadow-sm" style="height: 100%; transition: all 0.3s ease;">
                        <div class="mb-3">
                            <span class="icon-phone" style="font-size: 3rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Phone & Email</h4>
                        <p style="color: #666; line-height: 1.8;">
                            <strong>Phone:</strong> +1 (555) 123-4567<br />
                            <strong>Email:</strong> info@jobboard.com<br />
                            <strong>Support:</strong> support@jobboard.com
                        </p>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-light rounded shadow-sm" style="height: 100%; transition: all 0.3s ease;">
                        <div class="mb-3">
                            <span class="icon-clock-o" style="font-size: 3rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Business Hours</h4>
                        <p style="color: #666; line-height: 1.8;">
                            <strong>Monday - Friday:</strong> 9:00 AM - 6:00 PM<br />
                            <strong>Saturday:</strong> 10:00 AM - 4:00 PM<br />
                            <strong>Sunday:</strong> Closed
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Form Section -->
    <section class="site-section bg-light" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Send Us a Message</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Fill out the form below and we'll respond within 24 hours
                    </p>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success" role="alert" style="border-radius: 10px; box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);">
                        <i class="icon-check-circle" style="font-size: 1.5rem; margin-right: 10px;"></i>
                        <strong>Success!</strong> Your message has been sent successfully. We'll get back to you soon!
                    </asp:Panel>

                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger" role="alert" style="border-radius: 10px; box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2);">
                        <i class="icon-exclamation-circle" style="font-size: 1.5rem; margin-right: 10px;"></i>
                        <strong>Error!</strong> <asp:Label ID="lblError" runat="server"></asp:Label>
                    </asp:Panel>

                    <div class="bg-white p-5 rounded shadow" style="border-radius: 15px !important;">
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="txtFullName" class="font-weight-bold" style="color: #2c3e50;">Full Name <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                                    ControlToValidate="txtFullName"
                                    ErrorMessage="Full name is required"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label for="txtEmail" class="font-weight-bold" style="color: #2c3e50;">Email Address <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="your.email@example.com" TextMode="Email" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Email is required"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Invalid email format"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="txtPhone" class="font-weight-bold" style="color: #2c3e50;">Phone Number</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+1 (555) 123-4567" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label for="txtSubject" class="font-weight-bold" style="color: #2c3e50;">Subject <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="What is this regarding?" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                                    ControlToValidate="txtSubject"
                                    ErrorMessage="Subject is required"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 mb-4">
                                <label for="txtMessage" class="font-weight-bold" style="color: #2c3e50;">Message <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="Write your message here..." style="border-radius: 8px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server"
                                    ControlToValidate="txtMessage"
                                    ErrorMessage="Message is required"
                                    CssClass="text-danger"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Send Message" OnClick="btnSubmit_Click"
                                    CssClass="btn btn-primary btn-lg px-5 py-3"
                                    ValidationGroup="ContactForm"
                                    style="font-size: 1.1rem; font-weight: 600; border-radius: 30px; box-shadow: 0 6px 20px rgba(137, 186, 22, 0.3); border: none; background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Map Section -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Find Us</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Visit our office or connect with us online
                    </p>
                </div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <div style="border-radius: 15px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.15);">
                        <iframe
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3022.2412648718453!2d-73.98784368459395!3d40.74844097932847!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c259a9b3117469%3A0xd134e199a405a163!2sEmpire%20State%20Building!5e0!3m2!1sen!2sus!4v1234567890123!5m2!1sen!2sus"
                            width="100%"
                            height="450"
                            style="border:0;"
                            allowfullscreen=""
                            loading="lazy">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="site-section bg-light" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Frequently Asked Questions</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Quick answers to common questions
                    </p>
                </div>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="accordion" id="faqAccordion">
                        <div class="card mb-3" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" style="background: white; border-radius: 10px 10px 0 0;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        How do I post a job on your platform?
                                    </button>
                                </h5>
                            </div>
                            <div class="card-body">
                                <p style="color: #666; line-height: 1.8;">
                                    To post a job, simply register as a recruiter, log in to your account, and click on "Post a Job" from your dashboard. Fill in the job details and publish!
                                </p>
                            </div>
                        </div>

                        <div class="card mb-3" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" style="background: white; border-radius: 10px 10px 0 0;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        How long does it take to get a response?
                                    </button>
                                </h5>
                            </div>
                            <div class="card-body">
                                <p style="color: #666; line-height: 1.8;">
                                    We typically respond to all inquiries within 24 hours during business days. For urgent matters, please call our support line.
                                </p>
                            </div>
                        </div>

                        <div class="card mb-3" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" style="background: white; border-radius: 10px 10px 0 0;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        Is there a fee to use JobBoard?
                                    </button>
                                </h5>
                            </div>
                            <div class="card-body">
                                <p style="color: #666; line-height: 1.8;">
                                    Job seekers can browse and apply to jobs completely free. Recruiters can post jobs with our flexible pricing plans starting from $99/month.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <style>
        .col-md-4 > div:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(137, 186, 22, 0.2) !important;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(137, 186, 22, 0.4) !important;
        }

        .section-hero.inner-page {
            padding: 150px 0 100px 0;
        }

        .form-control:focus {
            border-color: #89ba16;
            box-shadow: 0 0 0 0.2rem rgba(137, 186, 22, 0.25);
        }

        .card-header button:hover {
            color: #89ba16 !important;
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
