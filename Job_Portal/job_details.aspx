<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="job_details.aspx.cs" Inherits="Job_Portal.job_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Job Details - JobBoard</title>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <h1 class="text-white font-weight-bold">Job Details</h1>
                    <div class="custom-breadcrumbs">
                        <a href="index.aspx">Home</a> <span class="mx-2 slash">/</span>
                        <a href="job_listings.aspx">Job Listings</a> <span class="mx-2 slash">/</span>
                        <span class="text-white"><strong>Job Details</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="site-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="mb-5">
                        <div class="row align-items-center mb-5">
                            <div class="col-lg-6">
                                <div class="d-flex align-items-center">
                                    <div class="border p-2 d-inline-block mr-3 rounded">
                                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="img-fluid" style="max-width: 80px; max-height: 80px;" />
                                    </div>
                                    <div>
                                        <h2><asp:Label ID="lblJobTitle" runat="server" Text=""></asp:Label></h2>
                                        <div>
                                            <span class="ml-0 mr-2 mb-2"><span class="icon-briefcase mr-2"></span><asp:Label ID="lblCompanyName" runat="server" Text=""></asp:Label></span>
                                            <span class="m-2"><span class="icon-room mr-2"></span><asp:Label ID="lblLocation" runat="server" Text=""></asp:Label></span>
                                            <span class="m-2"><span class="icon-clock-o mr-2"></span><asp:Label ID="lblJobType" runat="server" Text=""></asp:Label></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="row">
                                    <div class="col-6">
                                        <asp:Button ID="btnApplyNow" runat="server" Text="Apply Now" CssClass="btn btn-block btn-primary btn-md" OnClick="btnApplyNow_Click" />
                                    </div>
                                    <div class="col-6">
                                        <asp:Button ID="btnSaveJob" runat="server" Text="Save Job" CssClass="btn btn-block btn-outline-primary btn-md" OnClick="btnSaveJob_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-8">
                                <div class="mb-5">
                                    <h3 class="h5 d-flex align-items-center mb-4 text-primary"><span class="icon-align-left mr-3"></span>Job Description</h3>
                                    <asp:Label ID="lblJobDescription" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="mb-5">
                                    <h3 class="h5 d-flex align-items-center mb-4 text-primary"><span class="icon-rocket mr-3"></span>Responsibilities</h3>
                                    <asp:Label ID="lblResponsibilities" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="mb-5">
                                    <h3 class="h5 d-flex align-items-center mb-4 text-primary"><span class="icon-book mr-3"></span>Education + Experience</h3>
                                    <asp:Label ID="lblEducationExperience" runat="server" Text=""></asp:Label>
                                </div>
                                <div class="mb-5">
                                    <h3 class="h5 d-flex align-items-center mb-4 text-primary"><span class="icon-turned_in mr-3"></span>Skills Required</h3>
                                    <asp:Label ID="lblSkillsRequired" runat="server" Text=""></asp:Label>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="bg-light p-3 border rounded mb-4">
                                    <h3 class="text-primary mt-3 h5 pl-3 mb-3 ">Job Summary</h3>
                                    <ul class="list-unstyled pl-3 mb-0">
                                        <li class="mb-2"><strong class="text-black">Published on:</strong> <asp:Label ID="lblPublishDate" runat="server" Text=""></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Vacancy:</strong> <asp:Label ID="lblVacancy" runat="server" Text="1"></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Employment Status:</strong> <asp:Label ID="lblEmploymentStatus" runat="server" Text=""></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Experience:</strong> <asp:Label ID="lblExperience" runat="server" Text=""></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Job Location:</strong> <asp:Label ID="lblJobLocation" runat="server" Text=""></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Salary:</strong> <asp:Label ID="lblSalary" runat="server" Text=""></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Gender:</strong> <asp:Label ID="lblGender" runat="server" Text="Both"></asp:Label></li>
                                        <li class="mb-2"><strong class="text-black">Application Deadline:</strong> <asp:Label ID="lblDeadline" runat="server" Text=""></asp:Label></li>
                                    </ul>
                                </div>

                                <div class="bg-light p-3 border rounded">
                                    <h3 class="text-primary mt-3 h5 pl-3 mb-3 ">Share</h3>
                                    <div class="px-3">
                                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-facebook"></span></a>
                                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-twitter"></span></a>
                                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-linkedin"></span></a>
                                        <a href="#" class="pt-3 pb-3 pr-3 pl-0"><span class="icon-pinterest"></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="bg-light p-3 border rounded mb-4">
                        <h3 class="text-primary mt-3 h5 pl-3 mb-3">Apply for this Job</h3>
                        <asp:Panel ID="pnlApplicationForm" runat="server" CssClass="px-3">
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-3 d-block"></asp:Label>
                            
                            <div class="form-group">
                                <asp:Label ID="lblFullName" runat="server" Text="Full Name *" CssClass="text-black"></asp:Label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Full Name is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblEmail" runat="server" Text="Email *" CssClass="text-black"></asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter your email"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblPhone" runat="server" Text="Phone Number *" CssClass="text-black"></asp:Label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone number is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblResume" runat="server" Text="Resume/CV *" CssClass="text-black"></asp:Label>
                                <asp:FileUpload ID="fuResume" runat="server" CssClass="form-control" />
                                <asp:RequiredFieldValidator ID="rfvResume" runat="server" ControlToValidate="fuResume" ErrorMessage="Resume is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblExperienceYears" runat="server" Text="Years of Experience *" CssClass="text-black"></asp:Label>
                                <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Experience" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Fresher" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="1 Year" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2 Years" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3 Years" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4 Years" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5+ Years" Value="5+"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvExperience" runat="server" ControlToValidate="ddlExperience" ErrorMessage="Experience is required" CssClass="text-danger"></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblCoverLetter" runat="server" Text="Cover Letter" CssClass="text-black"></asp:Label>
                                <asp:TextBox ID="txtCoverLetter" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Write a brief cover letter..."></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblCurrentSalary" runat="server" Text="Current Salary" CssClass="text-black"></asp:Label>
                                <asp:TextBox ID="txtCurrentSalary" runat="server" CssClass="form-control" placeholder="Enter current salary"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Label ID="lblExpectedSalary" runat="server" Text="Expected Salary" CssClass="text-black"></asp:Label>
                                <asp:TextBox ID="txtExpectedSalary" runat="server" CssClass="form-control" placeholder="Enter expected salary"></asp:TextBox>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="btnSubmitApplication" runat="server" Text="Submit Application" CssClass="btn btn-primary btn-block" OnClick="btnSubmitApplication_Click" />
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="pnlLoginRequired" runat="server" Visible="false" CssClass="px-3">
                            <p class="text-center">Please <a href="login.aspx">login</a> to apply for this job.</p>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>


