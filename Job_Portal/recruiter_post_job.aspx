<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_post_job.aspx.cs" Inherits="Job_Portal.post_job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
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
                        <li><a href="recruiter_dashboard.aspx" class="nav-link active">Dashboard</a></li>
                        <li><a href="recruiter_post_job.aspx">Post Job</a></li>
                        <li><a href="recruiter_manage_jobs.aspx">Manage Jobs</a></li>
                        <li><a href="recruiter_applications.aspx">Applications</a></li>
                        <li><a href="recruiter_profile.aspx">My Profile</a></li>
                        <li><a href="logout.aspx">Logout</a></li>
                    </ul>
                </nav>

                <!-- Right side buttons -->
                <div class="right-cta-menu text-right d-flex aligin-items-center col-6">
                    <div class="ml-auto">
                        <a href="recruiter_post_job.aspx" class="btn btn-outline-white border-width-2 d-none d-lg-inline-block">
                            <span class="mr-2 icon-add"></span>Post Job
                        </a>
                        <a href="logout.aspx" class="btn btn-primary border-width-2 d-none d-lg-inline-block">
                            <span class="mr-2 icon-lock_outline"></span>Logout
                        </a>
                    </div>

                    <!-- Mobile menu -->
                    <a href="#" class="site-menu-toggle js-menu-toggle d-inline-block d-xl-none mt-lg-2 ml-3">
                        <span class="icon-menu h3 m-0 p-0 mt-2"></span>
                    </a>
                </div>

            </div>
        </div>
    </header>
    <!-- HOME -->
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
            <div class="row align-items-center mb-5">
                <div class="col-lg-8 mb-4 mb-lg-0">
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
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                                TextMode="MultiLine" Rows="5" placeholder="Enter detailed job description here..."></asp:TextBox>
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

                        <!-- Deadline -->
                        <div class="form-group mb-3">
                            <label for="txtDeadline">Application Deadline <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtDeadline" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>

                        <!-- Company Logo -->
                        <div class="form-group mb-3">
                            <label for="fuCompanyLogo">Company Logo (optional)</label>
                            <asp:FileUpload ID="fuCompanyLogo" runat="server" CssClass="form-control-file" />
                        </div>

                        <!-- Button -->
                        <div class="form-group mt-4">
                            <asp:Button ID="btnSaveJob" runat="server" CssClass="btn btn-primary btn-lg px-4" Text="Post Job" OnClick="btnSaveJob_Click" />
                            <asp:Label ID="lblMessage" runat="server" CssClass="text-success ml-3"></asp:Label>
                        </div>

                    </asp:Panel>
                </div>
            </div>
        </div>
    </section>



    </asp:Panel>
                </div>
            </div>

        </div>
    </section>
</asp:Content>

