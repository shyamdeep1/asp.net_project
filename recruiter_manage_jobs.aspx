<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_manage_jobs.aspx.cs" Inherits="Job_Portal.recruiter_manage_jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .company-logo {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
        
        .text-truncate-desc {
            max-width: 150px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .action-buttons {
            white-space: nowrap;
        }
        
        .action-buttons .btn {
            margin-right: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    
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
                        <li><a href="recruiter_post_job.aspx">Post Job</a></li>
                        <li class="active"><a href="recruiter_manage_jobs.aspx">Manage Jobs</a></li>
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
                    <h1 class="text-white font-weight-bold">Manage Jobs</h1>
                    <div class="custom-breadcrumbs">
                        <a href="index.aspx">Home</a> <span class="mx-2 slash">/</span>
                        <a href="#">Recruiter</a> <span class="mx-2 slash">/</span>
                        <span class="text-white"><strong>Manage Jobs</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MAIN CONTENT SECTION -->
    <section class="site-section" style="background: url('images/hero_1.jpg') no-repeat center center/cover; padding: 50px 0;">
        <div class="container bg-light p-5 rounded shadow">
            <div class="row mb-4">
                <div class="col-lg-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <h2 class="text-black mb-0">Your Posted Jobs</h2>
                        <a href="recruiter_post_job.aspx" class="btn btn-primary">
                            <span class="icon-add mr-2"></span>Post New Job
                        </a>
                    </div>
                    <p class="text-muted">Manage and edit your job postings</p>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <div class="bg-white p-4 rounded shadow-sm">
                        <div class="table-responsive">
                            <asp:GridView ID="GridView1" runat="server" 
                                AutoGenerateColumns="False" 
                                OnRowCommand="GridView1_RowCommand"
                                CssClass="table table-striped table-hover table-bordered"
                                HeaderStyle-CssClass="thead-dark"
                                BorderStyle="None"
                                GridLines="None">
                                <Columns>
                                    <asp:TemplateField HeaderText="Job ID" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span class="badge badge-secondary"><%# Eval("JobID") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Job Details" HeaderStyle-Width="300px">
                                        <ItemTemplate>
                                            <div class="job-details">
                                                <h6 class="mb-1 text-primary"><%# Eval("JobTitle") %></h6>
                                                <p class="mb-1 text-muted small text-truncate-desc"><%# Eval("JobDescription") %></p>
                                                <small class="text-success">
                                                    <i class="icon-location-pin"></i> <%# Eval("Location") %>
                                                </small>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Salary" HeaderStyle-Width="120px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span class="badge badge-success"><%# Eval("Salary") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Skills Required" HeaderStyle-Width="150px">
                                        <ItemTemplate>
                                            <div class="text-truncate-desc">
                                                <small class="text-info"><%# Eval("SkillsRequired") %></small>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Experience" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span class="badge badge-info"><%# Eval("ExperienceRequired") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Type & Category" HeaderStyle-Width="150px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span class="badge badge-primary d-block mb-1"><%# Eval("JobType") %></span>
                                                <span class="badge badge-warning"><%# Eval("Category") %></span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Deadline" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <small class="text-danger">
                                                    <i class="icon-calendar"></i><br>
                                                    <%# Eval("Deadline", "{0:MM/dd/yyyy}") %>
                                                </small>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Posted Date" HeaderStyle-Width="100px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <small class="text-muted">
                                                    <%# Eval("PostedDate", "{0:MM/dd/yyyy}") %>
                                                </small>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Status" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <span class="badge badge-<%# Convert.ToString(Eval("Status")).ToLower() == "active" ? "success" : "secondary" %>">
                                                    <%# Eval("Status") %>
                                                </span>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Logo" HeaderStyle-Width="80px">
                                        <ItemTemplate>
                                            <div class="text-center">
                                                <asp:Image ID="Image1" runat="server" 
                                                    ImageUrl='<%# Eval("Company_logo") %>' 
                                                    CssClass="company-logo"
                                                    AlternateText="Company Logo" />
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Actions" HeaderStyle-Width="150px">
                                        <ItemTemplate>
                                            <div class="action-buttons text-center">
                                                <asp:LinkButton ID="LinkButton1" runat="server" 
                                                    CommandArgument='<%# Eval("JobID") %>' 
                                                    CommandName="cmd_edt"
                                                    CssClass="btn btn-sm btn-outline-primary"
                                                    ToolTip="Edit Job">
                                                    <i class="icon-edit"></i> Edit
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton2" runat="server" 
                                                    CommandArgument='<%# Eval("JobID") %>' 
                                                    CommandName="cmd_dlt"
                                                    CssClass="btn btn-sm btn-outline-danger"
                                                    ToolTip="Delete Job"
                                                    OnClientClick="return confirm('Are you sure you want to delete this job?');">
                                                    <i class="icon-trash"></i> Delete
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate>
                                    <div class="text-center p-4">
                                        <i class="icon-briefcase display-1 text-muted"></i>
                                        <h4 class="text-muted mt-3">No Jobs Posted Yet</h4>
                                        <p class="text-muted">You haven't posted any jobs yet. Start by posting your first job!</p>
                                        <a href="recruiter_post_job.aspx" class="btn btn-primary">
                                            <span class="icon-add mr-2"></span>Post Your First Job
                                        </a>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

