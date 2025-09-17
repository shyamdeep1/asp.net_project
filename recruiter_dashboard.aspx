<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_dashboard.aspx.cs" Inherits="Job_Portal.recruiter_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- NAVBAR -->
    <section class="ftco-section bg-light">
        <div class="container">
            <nav class="navbar navbar-expand-lg ftco_navbar ftco-navbar-light">
                <a class="navbar-brand" href="recruiter_dashboard.aspx">Recruiter Panel</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarRecruiter"
                    aria-controls="navbarRecruiter" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarRecruiter">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active"><a href="recruiter_dashboard.aspx" class="nav-link">Dashboard</a></li>
                        <li class="nav-item"><a href="recruiter_post_job.aspx" class="nav-link">Post Job</a></li>
                        <li class="nav-item"><a href="recruiter_manage_jobs.aspx" class="nav-link">Manage Jobs</a></li>
                        <li class="nav-item"><a href="recruiter_applications.aspx" class="nav-link">Applications</a></li>
                        <li class="nav-item"><a href="recruiter_profile.aspx" class="nav-link">Profile</a></li>
                        <li class="nav-item cta cta-colored"><a href="logout.aspx" class="nav-link">Logout</a></li>
                    </ul>
                </div>
            </nav>
        </div>
    </section>
    <!-- HOME -->
    <section class="ftco-section">
        <div class="container">
            <div class="row mb-4">
                <div class="col-md-12 text-center">
                    <h2 class="heading-section">Welcome, <%= Session["UserName"] %> 👋</h2>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="row d-flex">
                <div class="col-md-3">
                    <div class="services text-center p-4 bg-light">
                        <h2>
                            <asp:Label ID="lblTotalJobs" runat="server" Text="0"></asp:Label></h2>
                        <span>Total Jobs</span>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="services text-center p-4 bg-light">
                        <h2>
                            <asp:Label ID="lblActiveJobs" runat="server" Text="0"></asp:Label></h2>
                        <span>Active Jobs</span>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="services text-center p-4 bg-light">
                        <h2>
                            <asp:Label ID="lblApplications" runat="server" Text="0"></asp:Label></h2>
                        <span>Applications</span>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="services text-center p-4 bg-light">
                        <h2>
                            <asp:Label ID="lblShortlisted" runat="server" Text="0"></asp:Label></h2>
                        <span>Shortlisted</span>
                    </div>
                </div>
            </div>

            <!-- Recent Jobs Table -->
            <div class="row mt-5">
                <div class="col-md-12">
                    <h3 class="mb-4">Recent Job Posts</h3>
                    <asp:GridView ID="gvJobs" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover">
                        <Columns>
                            <asp:BoundField DataField="JobTitle" HeaderText="Job Title" />
                            <asp:BoundField DataField="Location" HeaderText="Location" />
                            <asp:BoundField DataField="PostedDate" HeaderText="Posted Date" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

