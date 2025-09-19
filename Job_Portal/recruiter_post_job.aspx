<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_post_job.aspx.cs" Inherits="Job_Portal.post_job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">

    <!-- NAVBAR -->
    <header class="site-navbar mt-3">
        <div class="container-fluid">
            <div class="row align-items-center">

                <!-- Logo -->
                <div class="site-logo col-6">
                    <a href="recruiter_dashboard.aspx">Recruiter Panel</a>
                </div>

                <!-- Recruiter Navigation -->
                <nav class="mx-auto site-navigation">
                    <ul class="site-menu js-clone-nav d-none d-xl-block ml-0 pl-0">
                        <li><a href="recruiter_dashboard.aspx">Dashboard</a></li>
                        <li class="active"><a href="recruiter_post_job.aspx">Post Job</a></li>
                        <li><a href="recruiter_manage_jobs.aspx">Manage Jobs</a></li>
                        <li><a href="recruiter_applications.aspx">Applications</a></li>
                        <li><a href="recruiter_profile.aspx">My Profile</a></li>
                        <li><a href="logout.aspx">Logout</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <!-- HERO SECTION -->
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <h1 class="text-white font-weight-bold">Post a Job</h1>
                    <div class="custom-breadcrumbs">
                        <a href="index.aspx">Home</a> <span class="mx-2 slash">/</span>
                        <a href="#">Recruiter</a> <span class="mx-2 slash">/</span>
                        <span class="text-white"><strong>Post a Job</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FORM SECTION -->
    <section class="site-section" style="background: url('images/hero_1.jpg') no-repeat center center/cover; padding: 50px 0;">
        <div class="container bg-light p-5 rounded shadow">
            <div class="row mb-5">
                <div class="col-lg-8">
                    <h2 class="text-black">Post a New Job</h2>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-10">
                    <asp:Panel ID="pnlPostJob" runat="server" CssClass="p-5 border rounded bg-white shadow">

                        <!-- Job Title -->
                        <div class="form-group mb-3">
                            <label for="txtJobTitle">Job Title <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="e.g. Software Engineer"></asp:TextBox>
                        </div>

                        <!-- Job Description -->
                        <div class="form-group mb-3">
                            <label for="txtDescription">Job Description <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"
                                placeholder="Enter detailed job description here..."></asp:TextBox>
                        </div>

                        <!-- Location -->
                        <div class="form-group mb-3">
                            <label for="txtLocation">Location <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="e.g. New York"></asp:TextBox>
                        </div>

                        <!-- Salary -->
                        <div class="form-group mb-3">
                            <label for="txtSalary">Salary <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" placeholder="e.g. $60,000 per annum"></asp:TextBox>
                        </div>

                        <!-- Skills -->
                        <div class="form-group mb-3">
                            <label for="txtSkills">Skills Required <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtSkills" runat="server" CssClass="form-control" placeholder="e.g. ASP.NET, SQL, JavaScript"></asp:TextBox>
                        </div>

                        <!-- Experience -->
                        <div class="form-group mb-3">
                            <label for="txtExperience">Experience Required <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtExperience" runat="server" CssClass="form-control" placeholder="e.g. 2 Years"></asp:TextBox>
                        </div>

                        <!-- Job Type -->
                        <div class="form-group mb-3">
                            <label for="ddlJobType">Job Type <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Job Type" Value="" />
                                <asp:ListItem Text="Full-Time" Value="Full-Time" />
                                <asp:ListItem Text="Part-Time" Value="Part-Time" />
                                <asp:ListItem Text="Internship" Value="Internship" />
                                <asp:ListItem Text="Contract" Value="Contract" />
                            </asp:DropDownList>
                        </div>

                        <!-- Category -->
                        <div class="form-group mb-3">
                            <label for="ddlCategory">Category <span class="text-danger">*</span></label>
                            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select Category" Value="" />
                                <asp:ListItem Text="IT & Software" Value="IT & Software" />
                                <asp:ListItem Text="Finance" Value="Finance" />
                                <asp:ListItem Text="Marketing" Value="Marketing" />
                                <asp:ListItem Text="Design" Value="Design" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:DropDownList>
                        </div>

                        <!-- Deadline -->
                        <div class="form-group mb-3">
                            <label for="txtDeadline">Application Deadline <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtDeadline" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- Company Logo -->
                        <div class="form-group mb-3">
                            <label for="fuCompanyLogo">Company Logo <span class="text-danger">*</span></label>
                            <asp:FileUpload ID="fuCompanyLogo" runat="server" CssClass="form-control-file" />
                        </div>

                        <!-- Submit -->
                        <div class="form-group mt-4">
                            <asp:Button ID="btnSaveJob"  runat="server" CssClass="btn btn-primary btn-lg px-4" Text="Post Job" OnClick="btnSaveJob_Click" />
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-success ml-3"></asp:Label>
                        </div>

                    </asp:Panel>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
