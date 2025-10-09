<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="job_listings.aspx.cs" Inherits="Job_Portal.job_listings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Job Listings - JobBoard</title>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-7">
                    <h1 class="text-white font-weight-bold">Job Listings</h1>
                    <div class="custom-breadcrumbs">
                        <a href="index.aspx">Home</a> <span class="mx-2 slash">/</span>
                        <span class="text-white"><strong>Job Listings</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <!-- Search Section -->
            <div class="row mb-5">
                <div class="col-md-12">
                    <div class="search-jobs-form bg-light p-4 rounded" style="box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <h3 class="mb-4" style="color: #2c3e50; font-weight: 600;">Find Your Perfect Job</h3>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <asp:TextBox ID="txtJobTitle" runat="server" CssClass="form-control" placeholder="Job title, Keywords..." style="height: 50px; border-radius: 8px;"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="City, State" style="height: 50px; border-radius: 8px;"></asp:TextBox>
                            </div>
                            <div class="col-md-3 mb-3">
                                <asp:DropDownList ID="ddlJobType" runat="server" CssClass="form-control" style="height: 50px; border-radius: 8px;">
                                    <asp:ListItem Text="All Job Types" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Full-Time" Value="Full-Time"></asp:ListItem>
                                    <asp:ListItem Text="Part-Time" Value="Part-Time"></asp:ListItem>
                                    <asp:ListItem Text="Contract" Value="Contract"></asp:ListItem>
                                    <asp:ListItem Text="Internship" Value="Internship"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <asp:Button ID="btnSearch" runat="server" Text="Search Jobs" OnClick="btnSearch_Click"
                                    CssClass="btn btn-primary btn-block" 
                                    style="height: 50px; border-radius: 8px; font-weight: 600; border: none; background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%); box-shadow: 0 4px 12px rgba(137, 186, 22, 0.3);" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Results Header -->
            <div class="row mb-4">
                <div class="col-md-8">
                    <h2 class="section-title mb-3" style="font-size: 2.2rem; font-weight: 700;">
                        <asp:Label ID="lblResultsCount" runat="server" Text="All Job Opportunities"></asp:Label>
                    </h2>
                    <p class="lead" style="color: #666;">Discover amazing career opportunities from top employers</p>
                </div>
                <div class="col-md-4 text-right">
                    <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-control" style="width: auto; display: inline-block;" AutoPostBack="true" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                        <asp:ListItem Text="Sort by: Latest" Value="Latest" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="Sort by: Oldest" Value="Oldest"></asp:ListItem>
                        <asp:ListItem Text="Sort by: Company A-Z" Value="CompanyAZ"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Job Listings -->
            <asp:DataList ID="dlJobs" runat="server" RepeatDirection="Vertical" RepeatColumns="1" CssClass="job-listings mb-5" OnItemCommand="dlJobs_ItemCommand">
                <ItemTemplate>
                    <li class="job-listing d-block d-sm-flex pb-3 pb-sm-0 align-items-center" 
                        style="margin-bottom: 30px; border: 2px solid #f0f0f0; padding: 25px; border-radius: 12px; background: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.08); transition: all 0.3s ease;">
                        
                        <div class="job-listing-logo" style="flex: 0 0 140px; margin-right: 25px;">
                            <img src='<%# Eval("Company_Logo") != DBNull.Value && !string.IsNullOrEmpty(Eval("Company_Logo").ToString()) ? ResolveUrl(Eval("Company_Logo").ToString()) : ResolveUrl("~/images/job_logo_1.jpg") %>' 
                                 alt="Company Logo" class="img-fluid" 
                                 style="max-width: 120px; max-height: 120px; object-fit: cover; border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); border: 3px solid #f8f9fa;"
                                 onerror="this.src='images/job_logo_1.jpg';">
                        </div>

                        <div class="job-listing-about d-sm-flex custom-width w-100 justify-content-between" style="gap: 20px;">
                            <div class="job-listing-position custom-width w-50 mb-3 mb-sm-0">
                                <h2 style="font-size: 1.75rem; font-weight: 700; color: #2c3e50; margin-bottom: 12px; line-height: 1.3;">
                                    <%# Eval("JobTitle") %>
                                </h2>
                                <strong style="color: #555; font-size: 1.05rem; display: block; margin-bottom: 10px; background: #f8f9fa; padding: 8px 12px; border-radius: 6px; display: inline-block;">
                                    <i class="icon-briefcase mr-2" style="color: #89ba16;"></i><%# Eval("CompanyName") %>
                                </strong>
                                <div class="mb-2">
                                    <span class="text-muted" style="font-size: 0.95rem;">
                                        <i class="icon-layers mr-2" style="color: #89ba16;"></i>
                                        <strong>Category:</strong> <%# Eval("Category") %>
                                    </span>
                                </div>
                                <div class="mb-2">
                                    <span class="text-muted" style="font-size: 0.95rem;">
                                        <i class="icon-clock-o mr-2" style="color: #89ba16;"></i>
                                        <strong>Experience:</strong> <%# Eval("ExperienceRequired") %>
                                    </span>
                                </div>
                                <div>
                                    <span class="text-muted" style="font-size: 0.95rem;">
                                        <i class="icon-calendar mr-2" style="color: #89ba16;"></i>
                                        <strong>Posted:</strong> <%# Eval("PostedDate", "{0:MMM dd, yyyy}") %>
                                    </span>
                                </div>
                            </div>

                            <div class="job-listing-location mb-3 mb-sm-0" style="min-width: 220px;">
                                <div style="margin-bottom: 15px; padding: 12px; background: #f8f9fa; border-radius: 8px;">
                                    <span class="icon-room" style="color: #89ba16; font-size: 1.3rem; margin-right: 8px;"></span>
                                    <span style="color: #333; font-weight: 600; font-size: 1.05rem;"><%# Eval("Location") %></span>
                                </div>
                                <div style="margin-bottom: 15px; padding: 10px; background: #e8f5e9; border-radius: 8px;">
                                    <i class="icon-money mr-2" style="color: #28a745; font-size: 1.2rem;"></i>
                                    <span style="color: #28a745; font-weight: 700; font-size: 1.1rem;"><%# Eval("Salary") %></span>
                                </div>
                                <div style="font-size: 0.9rem; color: #666;">
                                    <i class="icon-user mr-1"></i>
                                    <strong>Skills:</strong> <%# Eval("SkillsRequired").ToString().Length > 30 ? Eval("SkillsRequired").ToString().Substring(0, 30) + "..." : Eval("SkillsRequired") %>
                                </div>
                            </div>

                            <div class="job-listing-meta d-flex flex-column align-items-end justify-content-center" style="min-width: 180px; gap: 15px;">
                                <span class='badge <%# Eval("JobType").ToString() == "Part-Time" ? "badge-warning" : Eval("JobType").ToString() == "Full-Time" ? "badge-success" : Eval("JobType").ToString() == "Contract" ? "badge-info" : "badge-primary" %>' 
                                      style="font-size: 0.95rem; padding: 10px 20px; font-weight: 600; border-radius: 25px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);">
                                    <%# Eval("JobType") %>
                                </span>
                                
                                <%# Eval("Deadline") != DBNull.Value ? "<div style='text-align: center; font-size: 0.85rem; color: #dc3545; font-weight: 600;'><i class='icon-clock-o mr-1'></i>Deadline: " + Eval("Deadline", "{0:MMM dd}") + "</div>" : "" %>
                                
                                <asp:Button ID="btnViewDetails" runat="server" 
                                    Text="View Details" 
                                    CommandName="ViewDetails" 
                                    CommandArgument='<%# Eval("JobID") %>' 
                                    CssClass="btn btn-primary" 
                                    style="padding: 12px 30px; font-weight: 600; border-radius: 25px; font-size: 1rem; box-shadow: 0 4px 12px rgba(137, 186, 22, 0.3); transition: all 0.3s ease; border: none; background: linear-gradient(135deg, #89ba16 0%, #6a9413 100%);" />
                                
                                <asp:Button ID="btnQuickApply" runat="server" 
                                    Text="Quick Apply" 
                                    CommandName="QuickApply" 
                                    CommandArgument='<%# Eval("JobID") %>' 
                                    CssClass="btn btn-outline-primary" 
                                    style="padding: 8px 20px; font-weight: 600; border-radius: 20px; font-size: 0.9rem; border: 2px solid #89ba16; color: #89ba16; transition: all 0.3s ease;" />
                            </div>
                        </div>
                    </li>
                </ItemTemplate>
            </asp:DataList>

            <!-- No Jobs Message -->
            <asp:Panel ID="pnlNoJobs" runat="server" Visible="false" CssClass="text-center py-5">
                <div style="padding: 60px 40px; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08);">
                    <i class="icon-briefcase" style="font-size: 4rem; color: #ccc; margin-bottom: 20px; display: block;"></i>
                    <h4 style="color: #666; font-size: 1.5rem; font-weight: 600; margin-bottom: 10px;">No Jobs Found</h4>
                    <p style="color: #999; font-size: 1.1rem;">Try adjusting your search criteria or check back later for new opportunities.</p>
                    <asp:Button ID="btnClearSearch" runat="server" Text="Clear Search" OnClick="btnClearSearch_Click"
                        CssClass="btn btn-primary mt-3" style="padding: 12px 30px; border-radius: 25px;" />
                </div>
            </asp:Panel>

            <!-- Pagination -->
            <div class="row pagination-wrap" style="margin-top: 50px;">
                <div class="col-md-6 text-center text-md-left mb-4 mb-md-0">
                    <asp:Label ID="lblPaginationInfo" runat="server" Text="Showing all jobs" style="color: #666; font-weight: 600; font-size: 1.1rem;"></asp:Label>
                </div>
                <div class="col-md-6 text-center text-md-right">
                    <div class="custom-pagination ml-auto">
                        <a href="#" class="prev" style="padding: 10px 20px; font-weight: 600;">Prev</a>
                        <div class="d-inline-block">
                            <a href="#" class="active" style="padding: 10px 15px;">1</a>
                            <a href="#" style="padding: 10px 15px;">2</a>
                            <a href="#" style="padding: 10px 15px;">3</a>
                        </div>
                        <a href="#" class="next" style="padding: 10px 20px; font-weight: 600;">Next</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <style>
        .job-listing:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15) !important;
            border-color: #89ba16 !important;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(137, 186, 22, 0.4) !important;
        }
        
        .btn-outline-primary:hover {
            background: #89ba16 !important;
            color: white !important;
            transform: translateY(-2px);
        }
        
        .search-jobs-form .form-control:focus {
            border-color: #89ba16;
            box-shadow: 0 0 0 0.2rem rgba(137, 186, 22, 0.25);
        }
        
        .custom-pagination a {
            transition: all 0.3s ease;
        }
        
        .custom-pagination a:hover {
            background: #89ba16;
            color: white;
            transform: translateY(-2px);
        }
        
        .badge-warning {
            background-color: #ffc107 !important;
        }
        
        .badge-success {
            background-color: #28a745 !important;
        }
        
        .badge-info {
            background-color: #17a2b8 !important;
        }
        
        .badge-primary {
            background-color: #89ba16 !important;
        }
    </style>
</asp:Content>

