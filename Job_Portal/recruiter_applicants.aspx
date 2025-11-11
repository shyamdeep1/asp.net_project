<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_applicants.aspx.cs" Inherits="Job_Portal.job_applicants" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .job-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

            .job-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 20px rgba(0,0,0,0.15);
            }

        .job-header {
            border-bottom: 2px solid #89ba16;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .application-item {
            background: #f8f9fa;
            border-left: 4px solid #89ba16;
            padding: 15px;
            margin-bottom: 10px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

            .application-item:hover {
                background: #e9ecef;
                border-left-color: #6a9413;
            }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-reviewed {
            background-color: #cfe2ff;
            color: #084298;
        }

        .status-shortlisted {
            background-color: #d1e7dd;
            color: #0f5132;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #842029;
        }

        .status-accepted {
            background-color: #d1e7dd;
            color: #0a3622;
        }

        .print-buttons {
            margin: 20px 0;
            text-align: right;
        }

        .btn-print {
            background: #89ba16;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            font-weight: 600;
            margin-left: 10px;
            transition: all 0.3s ease;
        }

            .btn-print:hover {
                background: #6a9413;
                transform: translateY(-2px);
                box-shadow: 0 4px 15px rgba(137, 186, 22, 0.3);
                color: white;
            }

        .no-applications {
            text-align: center;
            padding: 40px;
            background: #f8f9fa;
            border-radius: 10px;
            margin-top: 20px;
        }

        .job-stats {
            display: flex;
            justify-content: space-around;
            margin-top: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: bold;
            color: #89ba16;
        }

        .stat-label {
            font-size: 0.85rem;
            color: #6c757d;
        }

        .action-buttons {
            margin-top: 10px;
        }

            .action-buttons .btn {
                margin-right: 5px;
                margin-bottom: 5px;
            }

        .applicant-details {
            display: flex;
            justify-content: space-between;
            align-items: start;
            flex-wrap: wrap;
        }

        .applicant-info {
            flex: 1;
            min-width: 250px;
        }

        .applicant-status {
            text-align: right;
        }

        @media print {
            .no-print {
                display: none !important;
            }

            .job-card {
                page-break-inside: avoid;
                box-shadow: none;
                border: 1px solid #ddd;
            }

            .application-item {
                page-break-inside: avoid;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <!-- NAVBAR -->
    <header class="site-navbar mt-3 no-print">
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
                        <li><a href="recruiter_manage_jobs.aspx">Manage Jobs</a></li>
                        <li class="active"><a href="recruiter_applicants.aspx">Applications</a></li>
                        <li><a href="recruiter_profile.aspx">My Profile</a></li>
                        <li><a href="logout.aspx">Logout</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </header>

    <!-- HERO SECTION -->
    <section class="section-hero overlay inner-page bg-image no-print" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <h1 class="text-white font-weight-bold">Job Applications</h1>
                    <div class="custom-breadcrumbs">
                        <a href="index.aspx">Home</a> <span class="mx-2 slash">/</span>
                        <a href="recruiter_dashboard.aspx">Recruiter</a> <span class="mx-2 slash">/</span>
                        <span class="text-white"><strong>Applications</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MAIN CONTENT SECTION -->
    <section class="site-section" style="background: url('images/hero_1.jpg') no-repeat center center/cover; padding: 50px 0;">
        <div class="container bg-light p-5 rounded shadow">
            <div class="row mb-4 no-print">
                <div class="col-lg-12">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2 class="text-black mb-0">Applications for Your Jobs</h2>
                            <p class="text-muted">Review and manage candidate applications</p>
                        </div>
                        <div class="print-buttons">
                            <asp:Button ID="btnPrintAll" runat="server" Text="Print All Applications" CssClass="btn-print" OnClick="btnPrintAll_Click" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <asp:Panel ID="pnlJobs" runat="server">
                        <asp:Repeater ID="rptJobs" runat="server" OnItemDataBound="rptJobs_ItemDataBound" OnItemCommand="rptJobs_ItemCommand">
                            <ItemTemplate>
                                <div class="job-card">
                                    <div class="job-header">
                                        <div class="d-flex justify-content-between align-items-start">
                                            <div>
                                                <h3 class="text-primary mb-2"><%# Eval("JobTitle") %></h3>
                                                <asp:Button ID="btnViewReport"
                                                    runat="server"
                                                    Text="View Applications Report"
                                                    CssClass="btn btn-sm btn-outline-success ml-2"
                                                    CommandName="ViewApplications"
                                                    CommandArgument='<%# Eval("JobID") %>' />
                                                <p class="mb-1">
                                                    <i class="icon-room text-muted"></i><strong>Location:</strong> <%# Eval("Location") %>
                                                    <span class="mx-3">|</span>
                                                    <i class="icon-money text-muted"></i><strong>Salary:</strong> <%# Eval("Salary") %>
                                                </p>
                                                <p class="mb-0 text-muted">
                                                    <i class="icon-briefcase"></i><strong>Type:</strong> <%# Eval("JobType") %>
                                                    <span class="mx-3">|</span>
                                                    <i class="icon-tag"></i><strong>Category:</strong> <%# Eval("Category") %>
                                                </p>
                                            </div>
                                            <div>
                                                <span class="badge badge-info" style="font-size: 1rem; padding: 8px 15px;">Job ID: <%# Eval("JobID") %>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="job-stats">
                                        <div class="stat-item">
                                            <div class="stat-number"><%# Eval("TotalApplications") %></div>
                                            <div class="stat-label">Total Applications</div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-number"><%# Eval("PendingApplications") %></div>
                                            <div class="stat-label">Pending</div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-number"><%# Eval("ReviewedApplications") %></div>
                                            <div class="stat-label">Reviewed</div>
                                        </div>
                                        <div class="stat-item">
                                            <div class="stat-number"><%# Eval("ShortlistedApplications") %></div>
                                            <div class="stat-label">Shortlisted</div>
                                        </div>
                                    </div>

                                    <div class="mt-4">
                                        <h5 class="mb-3">
                                            <i class="icon-users text-primary"></i>Applicants
                                            <span class="badge badge-primary ml-2"><%# Eval("TotalApplications") %></span>
                                        </h5>

                                        <asp:Repeater ID="rptApplications" runat="server">
                                            <ItemTemplate>
                                                <div class="application-item">
                                                    <div class="applicant-details">
                                                        <div class="applicant-info">
                                                            <h6 class="mb-2">
                                                                <i class="icon-user text-primary"></i>
                                                                <strong><%# Eval("FullName") %></strong>
                                                            </h6>
                                                            <p class="mb-1">
                                                                <i class="icon-envelope text-muted"></i>
                                                                <a href='mailto:<%# Eval("Email") %>'><%# Eval("Email") %></a>
                                                            </p>
                                                            <p class="mb-1">
                                                                <i class="icon-phone text-muted"></i>
                                                                <%# Eval("Phone") %>
                                                            </p>
                                                            <p class="mb-1 text-muted">
                                                                <i class="icon-calendar"></i>
                                                                Applied on: <%# Convert.ToDateTime(Eval("ApplicationDate")).ToString("MMMM dd, yyyy") %>
                                                            </p>
                                                            <%# !string.IsNullOrEmpty(Eval("Resume").ToString()) ? 
                                                                "<p class='mb-0'><i class='icon-file-text text-info'></i> <a href='" + Eval("Resume") + "' target='_blank' class='btn btn-sm btn-outline-info'>View Resume</a></p>" 
                                                                : "" %>
                                                        </div>
                                                        <div class="applicant-status">
                                                            <span class='status-badge status-<%# Eval("Status").ToString().ToLower() %>'>
                                                                <%# Eval("Status") %>
                                                            </span>
                                                            <div class="action-buttons no-print">
                                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm mt-2"
                                                                    AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                                                                    <asp:ListItem Value="">Change Status</asp:ListItem>
                                                                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                                                    <asp:ListItem Value="Reviewed">Reviewed</asp:ListItem>
                                                                    <asp:ListItem Value="Shortlisted">Shortlisted</asp:ListItem>
                                                                    <asp:ListItem Value="Accepted">Accepted</asp:ListItem>
                                                                    <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                                                                </asp:DropDownList>
                                                                <asp:HiddenField ID="hdnApplicationID" runat="server" Value='<%# Eval("ApplicationID") %>' />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>

                                        <asp:Panel ID="pnlNoApplications" runat="server" Visible="false">
                                            <div class="text-center py-4 bg-light rounded">
                                                <i class="icon-folder-open" style="font-size: 3rem; color: #ccc;"></i>
                                                <p class="text-muted mt-2 mb-0">No applications for this job yet</p>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </asp:Panel>

                    <asp:Panel ID="pnlNoJobs" runat="server" Visible="false">
                        <div class="no-applications">
                            <i class="icon-briefcase" style="font-size: 5rem; color: #ccc;"></i>
                            <h3 class="mt-3 text-muted">No Jobs Posted Yet</h3>
                            <p class="text-muted">You haven't posted any jobs yet. Start by posting your first job to receive applications!</p>
                            <a href="recruiter_post_job.aspx" class="btn btn-primary btn-lg mt-3">
                                <i class="icon-plus mr-2"></i>Post Your First Job
                            </a>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

