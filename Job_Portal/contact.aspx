<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="Job_Portal.contact" %>

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
                            <li><a href="about.aspx" class="nav-link">About</a></li>
                            <li><a href="contact.aspx" class="nav-link active">Contact</a></li>
                            <li><a href="login.aspx" class="nav-link">Login</a></li>
                            <li><a href="register_jobseeker.aspx" class="nav-link">Register</a></li>
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
                        <h1 class="text-white font-weight-bold mb-3" style="font-size: 3.5rem;">Get In Touch</h1>
                        <p class="text-white lead" style="font-size: 1.3rem; max-width: 700px; margin: 0 auto;">
                            Have questions? We're here to help! Reach out to us and we'll get back to you as soon as possible.
                        </p>
                        <div class="custom-breadcrumbs mt-4">
                            <a href="index.aspx">Home</a> <span class="mx-2 slash">/</span>
                            <span class="text-white"><strong>Contact Us</strong></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CONTACT STATS SECTION -->
    <section class="py-5 bg-image overlay-primary fixed overlay" style="background-image: url('images/hero_1.jpg');">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center mb-4">
                    <h2 class="text-white mb-3" style="font-size: 2.2rem; font-weight: 700;">Why Choose Us?</h2>
                    <p class="text-white lead">Trusted by thousands of users worldwide</p>
                </div>
            </div>
            <div class="row pb-0 block__19738 section-counter">
                <div class="col-6 col-md-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="24">0</strong>
                    </div>
                    <span class="caption">Hours Support</span>
                </div>
                <div class="col-6 col-md-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="50000">0</strong>
                    </div>
                    <span class="caption">Happy Users</span>
                </div>
                <div class="col-6 col-md-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="99">0</strong>
                    </div>
                    <span class="caption">% Success Rate</span>
                </div>
                <div class="col-6 col-md-3 mb-5 mb-lg-0">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                        <strong class="number" data-number="150">0</strong>
                    </div>
                    <span class="caption">Countries Served</span>
                </div>
            </div>
        </div>
    </section>

    <!-- CONTACT INFORMATION SECTION -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Contact Information</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Connect with us through any of these channels
                    </p>
                </div>
            </div>

            <div class="row mb-5">
                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-light rounded shadow-sm contact-card" style="height: 100%; transition: all 0.3s ease;">
                        <div class="mb-3">
                            <span class="icon-map" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Our Office</h4>
                        <p style="color: #666; line-height: 1.8;">
                            <strong>Main Office:</strong><br />
                            123 Business Street<br />
                            Tech City, TC 12345<br />
                            United States<br />
                            <small class="text-muted">Open Mon-Fri 9AM-6PM</small>
                        </p>
                        <a href="#" class="btn btn-outline-primary btn-sm mt-2">
                            <i class="icon-navigation mr-1"></i>Get Directions
                        </a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-light rounded shadow-sm contact-card" style="height: 100%; transition: all 0.3s ease;">
                        <div class="mb-3">
                            <span class="icon-phone" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Contact Details</h4>
                        <p style="color: #666; line-height: 1.8;">
                            <strong>Main:</strong> <a href="tel:+15551234567">+1 (555) 123-4567</a><br />
                            <strong>Support:</strong> <a href="tel:+15559876543">+1 (555) 987-6543</a><br />
                            <strong>Email:</strong> <a href="mailto:info@jobboard.com">info@jobboard.com</a><br />
                            <strong>Support:</strong> <a href="mailto:support@jobboard.com">support@jobboard.com</a>
                        </p>
                        <a href="tel:+15551234567" class="btn btn-outline-success btn-sm mt-2">
                            <i class="icon-phone mr-1"></i>Call Now
                        </a>
                    </div>
                </div>

                <div class="col-md-4 mb-4">
                    <div class="text-center p-4 bg-light rounded shadow-sm contact-card" style="height: 100%; transition: all 0.3s ease;">
                        <div class="mb-3">
                            <span class="icon-clock-o" style="font-size: 3.5rem; color: #89ba16;"></span>
                        </div>
                        <h4 class="mb-3" style="font-weight: 700; color: #2c3e50;">Business Hours</h4>
                        <p style="color: #666; line-height: 1.8;">
                            <strong>Monday - Friday:</strong> 9:00 AM - 6:00 PM<br />
                            <strong>Saturday:</strong> 10:00 AM - 4:00 PM<br />
                            <strong>Sunday:</strong> Closed<br />
                            <small class="text-success"><strong>Available 24/7 Online Support</strong></small>
                        </p>
                        <span class="badge badge-success mt-2">
                            <i class="icon-check mr-1"></i>Currently Open
                        </span>
                    </div>
                </div>
            </div>

            <!-- QUICK CONTACT OPTIONS -->
            <div class="row mb-5">
                <div class="col-md-12">
                    <div class="bg-light p-4 rounded text-center">
                        <h5 class="mb-3" style="color: #2c3e50; font-weight: 600;">Quick Contact Options</h5>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <a href="#contactForm" class="btn btn-primary btn-block smooth-scroll">
                                    <i class="icon-envelope mr-2"></i>Send Message
                                </a>
                            </div>
                            <div class="col-md-3 mb-3">
                                <a href="tel:+15551234567" class="btn btn-success btn-block">
                                    <i class="icon-phone mr-2"></i>Call Us Now
                                </a>
                            </div>
                            <div class="col-md-3 mb-3">
                                <a href="mailto:info@jobboard.com" class="btn btn-info btn-block">
                                    <i class="icon-email mr-2"></i>Email Direct
                                </a>
                            </div>
                            <div class="col-md-3 mb-3">
                                <a href="#" class="btn btn-warning btn-block" data-toggle="modal" data-target="#chatModal">
                                    <i class="icon-chat mr-2"></i>Live Chat
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CONTACT FORM SECTION -->
    <section class="site-section bg-light" style="padding: 80px 0;" id="contactForm">
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
                    <!-- Success Message -->
                    <asp:Panel ID="pnlSuccess" runat="server" Visible="false" CssClass="alert alert-success alert-dismissible fade show" role="alert" style="border-radius: 10px; box-shadow: 0 4px 15px rgba(40, 167, 69, 0.2);">
                        <i class="icon-check-circle" style="font-size: 1.5rem; margin-right: 10px;"></i>
                        <strong>Success!</strong> Your message has been sent successfully. We'll get back to you within 24 hours!
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </asp:Panel>

                    <!-- Error Message -->
                    <asp:Panel ID="pnlError" runat="server" Visible="false" CssClass="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius: 10px; box-shadow: 0 4px 15px rgba(220, 53, 69, 0.2);">
                        <i class="icon-exclamation-circle" style="font-size: 1.5rem; margin-right: 10px;"></i>
                        <strong>Error!</strong> <asp:Label ID="lblError" runat="server"></asp:Label>
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </asp:Panel>

                    <div class="bg-white p-5 rounded shadow" style="border-radius: 15px !important;">
                        <h4 class="mb-4 text-center" style="color: #2c3e50; font-weight: 600;">
                            <i class="icon-envelope mr-2" style="color: #89ba16;"></i>Get In Touch
                        </h4>
                        
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="txtFullName" class="font-weight-bold" style="color: #2c3e50;">Full Name <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                                    ControlToValidate="txtFullName"
                                    ErrorMessage="Full name is required"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label for="txtEmail" class="font-weight-bold" style="color: #2c3e50;">Email Address <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="your.email@example.com" TextMode="Email" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Email is required"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Invalid email format"
                                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RegularExpressionValidator>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label for="txtPhone" class="font-weight-bold" style="color: #2c3e50;">Phone Number</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+1 (555) 123-4567" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                                <small class="form-text text-muted">Include country code for international numbers</small>
                            </div>

                            <div class="col-md-6 mb-4">
                                <label for="txtSubject" class="font-weight-bold" style="color: #2c3e50;">Subject <span style="color: red;">*</span></label>
                                <asp:DropDownList ID="ddlSubject" runat="server" CssClass="form-control" style="height: 50px; border-radius: 8px;">
                                    <asp:ListItem Text="Select Subject" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="General Inquiry" Value="General Inquiry"></asp:ListItem>
                                    <asp:ListItem Text="Job Posting Help" Value="Job Posting Help"></asp:ListItem>
                                    <asp:ListItem Text="Technical Support" Value="Technical Support"></asp:ListItem>
                                    <asp:ListItem Text="Billing Question" Value="Billing Question"></asp:ListItem>
                                    <asp:ListItem Text="Partnership" Value="Partnership"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server"
                                    ControlToValidate="ddlSubject"
                                    ErrorMessage="Please select a subject"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="row" id="customSubjectRow" style="display: none;">
                            <div class="col-md-12 mb-4">
                                <label for="txtCustomSubject" class="font-weight-bold" style="color: #2c3e50;">Custom Subject</label>
                                <asp:TextBox ID="txtCustomSubject" runat="server" CssClass="form-control" placeholder="Please specify your subject" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 mb-4">
                                <label for="txtMessage" class="font-weight-bold" style="color: #2c3e50;">Message <span style="color: red;">*</span></label>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="6" placeholder="Write your message here... Please be as detailed as possible so we can better assist you." style="border-radius: 8px; resize: vertical;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server"
                                    ControlToValidate="txtMessage"
                                    ErrorMessage="Message is required"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="ContactForm"></asp:RequiredFieldValidator>
                                <small class="form-text text-muted">Minimum 10 characters required</small>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 mb-4">
                                <div class="form-check">
                                    <asp:CheckBox ID="chkNewsletter" runat="server" CssClass="form-check-input" />
                                    <label class="form-check-label" for="<%= chkNewsletter.ClientID %>">
                                        Subscribe to our newsletter for job updates and company news
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 text-center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Send Message" OnClick="btnSubmit_Click"
                                    CssClass="btn btn-primary btn-lg px-5 py-3 send-btn"
                                    ValidationGroup="ContactForm"
                                    style="font-size: 1.1rem; font-weight: 600; border-radius: 30px; border: none; min-width: 200px;" />
                                <p class="mt-3 mb-0">
                                    <small class="text-muted">
                                        <i class="icon-shield mr-1"></i>
                                        Your information is secure and will not be shared with third parties.
                                    </small>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MAP SECTION -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row mb-5">
                <div class="col-md-12 text-center">
                    <h2 class="section-title mb-3" style="font-size: 2.5rem; font-weight: 700;">Find Our Office</h2>
                    <p class="lead" style="font-size: 1.2rem; color: #666;">
                        Visit us in person or connect with us online
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
                            loading="lazy"
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                    <div class="text-center mt-4">
                        <a href="https://maps.google.com" target="_blank" class="btn btn-outline-primary">
                            <i class="icon-navigation mr-2"></i>Open in Google Maps
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ SECTION -->
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
                        <div class="card mb-3 faq-card" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" id="faq1" style="background: white; border-radius: 10px 10px 0 0; border-bottom: 1px solid #eee;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100 collapsed" type="button" data-toggle="collapse" data-target="#collapse1" aria-expanded="false" aria-controls="collapse1" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        How do I post a job on your platform?
                                        <i class="icon-chevron-down float-right mt-1"></i>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapse1" class="collapse" aria-labelledby="faq1" data-parent="#faqAccordion">
                                <div class="card-body">
                                    <p style="color: #666; line-height: 1.8; margin-bottom: 0;">
                                        To post a job, simply register as a recruiter, log in to your account, and click on "Post a Job" from your dashboard. Fill in the job details including title, description, requirements, and salary information, then publish your listing. Your job will be reviewed and go live within 24 hours.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-3 faq-card" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" id="faq2" style="background: white; border-radius: 10px 10px 0 0; border-bottom: 1px solid #eee;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100 collapsed" type="button" data-toggle="collapse" data-target="#collapse2" aria-expanded="false" aria-controls="collapse2" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        How long does it take to get a response?
                                        <i class="icon-chevron-down float-right mt-1"></i>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapse2" class="collapse" aria-labelledby="faq2" data-parent="#faqAccordion">
                                <div class="card-body">
                                    <p style="color: #666; line-height: 1.8; margin-bottom: 0;">
                                        We typically respond to all inquiries within 24 hours during business days (Monday-Friday). For urgent technical issues, our support team aims to respond within 4 hours. For general inquiries received on weekends, we'll get back to you by the next business day.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-3 faq-card" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" id="faq3" style="background: white; border-radius: 10px 10px 0 0; border-bottom: 1px solid #eee;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100 collapsed" type="button" data-toggle="collapse" data-target="#collapse3" aria-expanded="false" aria-controls="collapse3" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        Is there a fee to use JobBoard?
                                        <i class="icon-chevron-down float-right mt-1"></i>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapse3" class="collapse" aria-labelledby="faq3" data-parent="#faqAccordion">
                                <div class="card-body">
                                    <p style="color: #666; line-height: 1.8; margin-bottom: 0;">
                                        Job seekers can browse and apply to jobs completely free of charge. Recruiters and companies can post jobs with our flexible pricing plans starting from $99/month for basic listings. We also offer premium packages with additional features like featured listings and advanced analytics.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-3 faq-card" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" id="faq4" style="background: white; border-radius: 10px 10px 0 0; border-bottom: 1px solid #eee;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100 collapsed" type="button" data-toggle="collapse" data-target="#collapse4" aria-expanded="false" aria-controls="collapse4" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        How can I reset my password?
                                        <i class="icon-chevron-down float-right mt-1"></i>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapse4" class="collapse" aria-labelledby="faq4" data-parent="#faqAccordion">
                                <div class="card-body">
                                    <p style="color: #666; line-height: 1.8; margin-bottom: 0;">
                                        Go to the login page and click on "Forgot Password?" link. Enter your registered email address and we'll send you a secure link to reset your password. The reset link expires after 24 hours for security purposes. If you don't receive the email, check your spam folder or contact our support team.
                                    </p>
                                </div>
                            </div>
                        </div>

                        <div class="card mb-3 faq-card" style="border: none; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.08);">
                            <div class="card-header" id="faq5" style="background: white; border-radius: 10px 10px 0 0; border-bottom: 1px solid #eee;">
                                <h5 class="mb-0">
                                    <button class="btn btn-link text-left w-100 collapsed" type="button" data-toggle="collapse" data-target="#collapse5" aria-expanded="false" aria-controls="collapse5" style="color: #2c3e50; font-weight: 600; text-decoration: none;">
                                        <i class="icon-question-circle mr-2" style="color: #89ba16;"></i>
                                        Do you offer customer support?
                                        <i class="icon-chevron-down float-right mt-1"></i>
                                    </button>
                                </h5>
                            </div>
                            <div id="collapse5" class="collapse" aria-labelledby="faq5" data-parent="#faqAccordion">
                                <div class="card-body">
                                    <p style="color: #666; line-height: 1.8; margin-bottom: 0;">
                                        Yes! We offer comprehensive customer support through multiple channels: email support (24/7), live chat during business hours, phone support for premium users, and an extensive help center with tutorials and guides. Our support team is knowledgeable and ready to help you succeed.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="text-center mt-5">
                        <p style="color: #666; font-size: 1.1rem;">
                            Still have questions? <a href="#contactForm" class="font-weight-bold smooth-scroll" style="color: #89ba16;">Contact us directly</a> and we'll be happy to help!
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- SOCIAL MEDIA SECTION -->
    <section class="site-section" style="padding: 60px 0; background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center">
                    <h3 class="text-white mb-4" style="font-weight: 700;">Connect With Us</h3>
                    <p class="text-white mb-4" style="font-size: 1.1rem;">Follow us on social media for the latest updates and job opportunities</p>
                    <div class="social-links">
                        <a href="#" class="text-white mr-4" style="font-size: 2rem; transition: all 0.3s ease;">
                            <i class="icon-facebook"></i>
                        </a>
                        <a href="#" class="text-white mr-4" style="font-size: 2rem; transition: all 0.3s ease;">
                            <i class="icon-twitter"></i>
                        </a>
                        <a href="#" class="text-white mr-4" style="font-size: 2rem; transition: all 0.3s ease;">
                            <i class="icon-linkedin"></i>
                        </a>
                        <a href="#" class="text-white mr-4" style="font-size: 2rem; transition: all 0.3s ease;">
                            <i class="icon-instagram"></i>
                        </a>
                        <a href="#" class="text-white" style="font-size: 2rem; transition: all 0.3s ease;">
                            <i class="icon-youtube"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Live Chat Modal -->
    <div class="modal fade" id="chatModal" tabindex="-1" role="dialog" aria-labelledby="chatModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background: #89ba16; color: white;">
                    <h5 class="modal-title" id="chatModalLabel">
                        <i class="icon-chat mr-2"></i>Live Chat Support
                    </h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="height: 400px;">
                    <div class="text-center py-5">
                        <i class="icon-chat" style="font-size: 3rem; color: #89ba16; margin-bottom: 20px;"></i>
                        <h5>Live Chat Coming Soon!</h5>
                        <p class="text-muted">Our live chat feature will be available soon. In the meantime, please use the contact form above or call us directly at <strong>+1 (555) 123-4567</strong>.</p>
                        <button type="button" class="btn btn-primary" data-dismiss="modal">
                            <i class="icon-phone mr-1"></i>Call Us Instead
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Contact Page Specific Styles */
        .contact-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(137, 186, 22, 0.2) !important;
        }

        .send-btn {
            background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);
            box-shadow: 0 6px 20px rgba(137, 186, 22, 0.3);
            transition: all 0.3s ease;
        }

        .send-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(137, 186, 22, 0.4);
        }

        .section-hero.inner-page {
            padding: 150px 0 100px 0;
        }

        .form-control:focus {
            border-color: #89ba16;
            box-shadow: 0 0 0 0.2rem rgba(137, 186, 22, 0.25);
        }

        .faq-card .card-header button:hover {
            color: #89ba16 !important;
        }

        .faq-card .card-header button[aria-expanded="true"] {
            color: #89ba16 !important;
        }

        .faq-card .card-header button[aria-expanded="true"] .icon-chevron-down {
            transform: rotate(180deg);
        }

        .social-links a:hover {
            transform: translateY(-3px);
            opacity: 0.8;
        }

        .smooth-scroll {
            cursor: pointer;
        }

        .alert {
            animation: slideInDown 0.5s ease;
        }

        @keyframes slideInDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .section-hero.inner-page {
                padding: 120px 0 80px 0;
            }
            
            .section-hero h1 {
                font-size: 2.5rem !important;
            }

            .contact-card {
                margin-bottom: 2rem;
            }
        }
    </style>

    <script>
        // Show/hide custom subject field
        document.addEventListener('DOMContentLoaded', function() {
            var subjectDropdown = document.getElementById('<%= ddlSubject.ClientID %>');
            var customSubjectRow = document.getElementById('customSubjectRow');

            if (subjectDropdown) {
                subjectDropdown.addEventListener('change', function() {
                    if (this.value === 'Other') {
                        customSubjectRow.style.display = 'block';
                    } else {
                        customSubjectRow.style.display = 'none';
                    }
                });
            }

            // Smooth scroll for contact form link
            var smoothScrollLinks = document.querySelectorAll('.smooth-scroll');
            smoothScrollLinks.forEach(function(link) {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    var target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });

        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert.classList.contains('show')) {
                    var bootstrapAlert = new bootstrap.Alert(alert);
                    bootstrapAlert.close();
                }
            });
        }, 5000);
    </script>
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
                        <li><a href="contact.aspx">Support</a></li>
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
</asp:Content>
