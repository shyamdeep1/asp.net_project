<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="recruiter_manage_jobs.aspx.cs" Inherits="Job_Portal.recruiter_jobs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
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

    <!-- MANAGE JOBS SECTION -->
    <section class="site-section" style="background: url('images/hero_1.jpg') no-repeat center center/cover; padding: 50px 0;">
        <div class="container bg-light p-5 rounded shadow">
            <div class="row mb-5">
                <div class="col-lg-8">
                    <h2 class="text-black">Your Posted Jobs</h2>
                </div>
                <div class="col-lg-4 text-right">
                    <a href="recruiter_post_job.aspx" class="btn btn-primary"><i class="icon-add mr-2"></i>Post New Job</a>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
                    <asp:Panel ID="pnlJobs" runat="server" CssClass="p-3 border rounded bg-white shadow">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-success mb-3 d-block"></asp:Label>
                        
                        <!-- Jobs GridView -->
                        <div class="table-responsive">
                            <asp:GridView ID="gvJobs" runat="server" AutoGenerateColumns="False"
                                CssClass="table table-hover table-striped" 
                                GridLines="None" OnRowCommand="gvJobs_RowCommand"
                                DataKeyNames="JobID" EmptyDataText="No jobs found." AllowPaging="True"
                                OnPageIndexChanging="gvJobs_PageIndexChanging" PageSize="10">
                                <Columns>
                                    <asp:BoundField DataField="JobID" HeaderText="ID" HeaderStyle-CssClass="d-none" ItemStyle-CssClass="d-none" />
                                    <asp:TemplateField HeaderText="Job Title">
                                        <ItemTemplate>
                                            <h5 class="mb-0"><%# Eval("JobTitle") %></h5>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Location" HeaderText="Location" />
                                    <asp:BoundField DataField="JobType" HeaderText="Type" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" />
                                    <asp:BoundField DataField="Deadline" HeaderText="Deadline" DataFormatString="{0:dd-MMM-yyyy}" />
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <span class='badge badge-pill badge-<%# GetStatusBadgeClass(Eval("IsActive").ToString()) %>'>
                                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                                            </span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actions">
                                        <ItemTemplate>
                                            <div class="btn-group" role="group">
                                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="btn btn-sm btn-primary mr-1" CommandName="EditJob" CommandArgument='<%# Eval("JobID") %>'>
                                                    <i class="icon-edit"></i> Edit
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkViewApplications" runat="server" CssClass="btn btn-sm btn-info mr-1" CommandName="ViewApps" CommandArgument='<%# Eval("JobID") %>'>
                                                    <i class="icon-document-text"></i> Applications
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="btn btn-sm btn-danger" CommandName="DeleteJob" 
                                                    CommandArgument='<%# Eval("JobID") %>' OnClientClick="return confirm('Are you sure you want to delete this job posting?');">
                                                    <i class="icon-trash"></i> Delete
                                                </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="bg-dark text-white" />
                                <PagerStyle CssClass="pagination-ys" />
                            </asp:GridView>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </section>

    <!-- Edit Job Modal -->
    <div class="modal fade" id="editJobModal" tabindex="-1" role="dialog" aria-labelledby="editJobModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editJobModalLabel">Edit Job</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hdnJobId" runat="server" />
                    
                    <!-- Job Title -->
                    <div class="form-group">
                        <label for="txtEditJobTitle">Job Title <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtEditJobTitle" runat="server" CssClass="form-control" placeholder="e.g. Software Engineer"></asp:TextBox>
                    </div>

                    <!-- Job Description -->
                    <div class="form-group">
                        <label for="txtEditDescription">Job Description <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtEditDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5"
                            placeholder="Enter detailed job description here..."></asp:TextBox>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <!-- Location -->
                            <div class="form-group">
                                <label for="txtEditLocation">Location <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEditLocation" runat="server" CssClass="form-control" placeholder="e.g. New York"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Salary -->
                            <div class="form-group">
                                <label for="txtEditSalary">Salary <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEditSalary" runat="server" CssClass="form-control" placeholder="e.g. $60,000 per annum"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <!-- Skills -->
                            <div class="form-group">
                                <label for="txtEditSkills">Skills Required <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEditSkills" runat="server" CssClass="form-control" placeholder="e.g. ASP.NET, SQL, JavaScript"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <!-- Experience -->
                            <div class="form-group">
                                <label for="txtEditExperience">Experience Required <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEditExperience" runat="server" CssClass="form-control" placeholder="e.g. 2 Years"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <!-- Job Type -->
                            <div class="form-group">
                                <label for="ddlEditJobType">Job Type <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlEditJobType" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Job Type" Value="" />
                                    <asp:ListItem Text="Full-Time" Value="Full-Time" />
                                    <asp:ListItem Text="Part-Time" Value="Part-Time" />
                                    <asp:ListItem Text="Internship" Value="Internship" />
                                    <asp:ListItem Text="Contract" Value="Contract" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <!-- Category -->
                            <div class="form-group">
                                <label for="ddlEditCategory">Category <span class="text-danger">*</span></label>
                                <asp:DropDownList ID="ddlEditCategory" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Category" Value="" />
                                    <asp:ListItem Text="IT & Software" Value="IT & Software" />
                                    <asp:ListItem Text="Finance" Value="Finance" />
                                    <asp:ListItem Text="Marketing" Value="Marketing" />
                                    <asp:ListItem Text="Design" Value="Design" />
                                    <asp:ListItem Text="Other" Value="Other" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <!-- Deadline -->
                            <div class="form-group">
                                <label for="txtEditDeadline">Application Deadline <span class="text-danger">*</span></label>
                                <asp:TextBox ID="txtEditDeadline" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- Status -->
                    <div class="form-group">
                        <div class="custom-control custom-switch">
                            <asp:CheckBox ID="chkEditActive" runat="server" Checked="true" CssClass="custom-control-input" />
                            <label class="custom-control-label" for="<%= chkEditActive.ClientID %>">Active Job Posting</label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="fuEditCompanyLogo">Company Logo</label>
                        <asp:FileUpload ID="fuEditCompanyLogo" runat="server" CssClass="form-control-file" />
                        <small class="form-text text-muted">Leave empty to keep the current logo.</small>
                        <asp:Image ID="imgCurrentLogo" runat="server" CssClass="mt-2" Width="100" Height="100" Visible="false" />
                    </div>
                    
                    <asp:Label ID="lblEditMessage" runat="server" CssClass="text-danger"></asp:Label>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:Button ID="btnUpdateJob" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnUpdateJob_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Modal Script -->
    <script type="text/javascript">
        function openEditModal() {
            $('#editJobModal').modal('show');
            return false;
        }
    </script>
</asp:Content>


