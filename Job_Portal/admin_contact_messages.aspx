<%@ Page Title="Manage Contact Messages" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="admin_contact_messages.aspx.cs" Inherits="Job_Portal.admin_contact_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <!-- NAVBAR -->
    <header class="site-navbar mt-3">
        <div class="container-fluid">
            <div class="row align-items-center">
                <!-- Logo -->
                <div class="site-logo col-6">
                    <a href="admin_dashboard.aspx">Admin Panel</a>
                </div>

                <!-- Admin Navigation -->
                <nav class="mx-auto site-navigation">
                    <ul class="site-menu js-clone-nav d-none d-xl-block ml-0 pl-0">
                        <li><a href="admin_dashboard.aspx">Dashboard</a></li>
                        <li><a href="manage_users.aspx">Users</a></li>
                        <li><a href="manage_job.aspx">Jobs</a></li>
                        <li class="active"><a href="admin_contact_messages.aspx">Contact Messages</a></li>
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
                    <h1 class="text-white font-weight-bold">Contact Messages</h1>
                    <div class="custom-breadcrumbs">
                        <a href="admin_dashboard.aspx">Admin</a> <span class="mx-2 slash">/</span>
                        <span class="text-white"><strong>Contact Messages</strong></span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- MAIN CONTENT SECTION -->
    <section class="site-section" style="background: url('images/hero_1.jpg') no-repeat center center/cover; padding: 50px 0;">
        <div class="container bg-light p-5 rounded shadow">
            
            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body text-center">
                            <i class="icon-envelope" style="font-size: 2rem;"></i>
                            <h5 class="mt-2">Total Messages</h5>
                            <h3><asp:Label ID="lblTotalMessages" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body text-center">
                            <i class="icon-clock-o" style="font-size: 2rem;"></i>
                            <h5 class="mt-2">Pending</h5>
                            <h3><asp:Label ID="lblPendingMessages" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-info">
                        <div class="card-body text-center">
                            <i class="icon-calendar" style="font-size: 2rem;"></i>
                            <h5 class="mt-2">Today</h5>
                            <h3><asp:Label ID="lblTodayMessages" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="card text-white bg-success">
                        <div class="card-body text-center">
                            <i class="icon-users" style="font-size: 2rem;"></i>
                            <h5 class="mt-2">Newsletter</h5>
                            <h3><asp:Label ID="lblNewsletterSubscribers" runat="server" Text="0"></asp:Label></h3>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Filter Controls -->
            <div class="row mb-4">
                <div class="col-lg-12">
                    <div class="bg-white p-4 rounded shadow-sm">
                        <h5 class="mb-3">Filter Messages</h5>
                        <div class="row">
                            <div class="col-md-3 mb-3">
                                <label>Status:</label>
                                <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterMessages">
                                    <asp:ListItem Text="All Status" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                    <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                                    <asp:ListItem Text="Responded" Value="Responded"></asp:ListItem>
                                    <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label>Subject:</label>
                                <asp:DropDownList ID="ddlSubjectFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterMessages">
                                    <asp:ListItem Text="All Subjects" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="General Inquiry" Value="General Inquiry"></asp:ListItem>
                                    <asp:ListItem Text="Job Posting Help" Value="Job Posting Help"></asp:ListItem>
                                    <asp:ListItem Text="Technical Support" Value="Technical Support"></asp:ListItem>
                                    <asp:ListItem Text="Billing Question" Value="Billing Question"></asp:ListItem>
                                    <asp:ListItem Text="Partnership" Value="Partnership"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label>Date Range:</label>
                                <asp:DropDownList ID="ddlDateFilter" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="FilterMessages">
                                    <asp:ListItem Text="All Dates" Value="" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Today" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Last 7 Days" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="Last 30 Days" Value="30"></asp:ListItem>
                                    <asp:ListItem Text="Last 90 Days" Value="90"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label>Search:</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name or email"></asp:TextBox>
                                    <div class="input-group-append">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="FilterMessages" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Button ID="btnClearFilters" runat="server" Text="Clear Filters" CssClass="btn btn-secondary" OnClick="ClearFilters" />
                                <asp:Button ID="btnMarkAllRead" runat="server" Text="Mark All as Read" CssClass="btn btn-info ml-2" OnClick="MarkAllAsRead" />
                                <asp:Button ID="btnExportCSV" runat="server" Text="Export to CSV" CssClass="btn btn-success ml-2" OnClick="ExportToCSV" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Messages Grid -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="bg-white rounded shadow">
                        <div class="p-4 border-bottom">
                            <h5 class="mb-0">Contact Messages</h5>
                            <small class="text-muted">
                                <asp:Label ID="lblResultCount" runat="server"></asp:Label>
                            </small>
                        </div>
                        
                        <asp:GridView ID="gvMessages" runat="server" CssClass="table table-striped table-hover" 
                            AutoGenerateColumns="False" OnRowCommand="gvMessages_RowCommand" 
                            OnPageIndexChanging="gvMessages_PageIndexChanging" PageSize="15" AllowPaging="True"
                            EmptyDataText="No contact messages found." HeaderStyle-BackColor="#89ba16" HeaderStyle-ForeColor="White">
                            <Columns>
                                <asp:TemplateField HeaderText="Status" ItemStyle-Width="80px">
                                    <ItemTemplate>
                                        <span class='badge <%# GetStatusBadgeClass(Eval("Status").ToString()) %>'>
                                            <%# Eval("Status") %>
                                        </span>
                                        <%# Convert.ToBoolean(Eval("IsRead")) ? "" : "<br/><small class='text-danger'>NEW</small>" %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Contact Info">
                                    <ItemTemplate>
                                        <strong><%# Eval("FullName") %></strong><br/>
                                        <small class="text-muted"><%# Eval("Email") %></small>
                                        <%# !string.IsNullOrEmpty(Eval("Phone").ToString()) ? "<br/><small>" + Eval("Phone").ToString() + "</small>" : "" %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Subject & Message">
                                    <ItemTemplate>
                                        <strong><%# Eval("Subject") %></strong><br/>
                                        <small class="text-muted">
                                            <%# Eval("Message").ToString().Length > 100 ? 
                                                Eval("Message").ToString().Substring(0, 100) + "..." : 
                                                Eval("Message").ToString() %>
                                        </small>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Date" ItemStyle-Width="120px">
                                    <ItemTemplate>
                                        <%# Convert.ToDateTime(Eval("SubmittedDate")).ToString("MM/dd/yyyy") %><br/>
                                        <small class="text-muted"><%# Convert.ToDateTime(Eval("SubmittedDate")).ToString("HH:mm") %></small>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Newsletter" ItemStyle-Width="80px" ItemStyle-CssClass="text-center">
                                    <ItemTemplate>
                                        <%# Convert.ToBoolean(Eval("NewsletterSubscription")) ? 
                                            "<i class='icon-check text-success' title='Subscribed'></i>" : 
                                            "<i class='icon-close text-muted' title='Not subscribed'></i>" %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="150px">
                                    <ItemTemplate>
                                        <asp:Button ID="btnView" runat="server" Text="View" CssClass="btn btn-sm btn-primary mb-1" 
                                            CommandName="ViewMessage" CommandArgument='<%# Eval("MessageID") %>' />
                                        <asp:Button ID="btnRespond" runat="server" Text="Respond" CssClass="btn btn-sm btn-success mb-1" 
                                            CommandName="RespondMessage" CommandArgument='<%# Eval("MessageID") %>' />
                                        <%# Convert.ToBoolean(Eval("IsRead")) ? "" : 
                                            "<asp:Button ID='btnMarkRead' runat='server' Text='Mark Read' CssClass='btn btn-sm btn-info mb-1' CommandName='MarkRead' CommandArgument='" + Eval("MessageID") + "' />" %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
                            <PagerStyle CssClass="pagination" HorizontalAlign="Center" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Message Detail Modal -->
    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="messageModalLabel">Message Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <asp:Panel ID="pnlMessageDetails" runat="server" Visible="false">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <strong>Name:</strong> <asp:Label ID="lblModalName" runat="server"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <strong>Email:</strong> <asp:Label ID="lblModalEmail" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <strong>Phone:</strong> <asp:Label ID="lblModalPhone" runat="server"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <strong>Date:</strong> <asp:Label ID="lblModalDate" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <strong>Subject:</strong> <asp:Label ID="lblModalSubject" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <strong>Message:</strong><br/>
                                <asp:Label ID="lblModalMessage" runat="server" CssClass="mt-2 d-block"></asp:Label>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <strong>Status:</strong>
                                <asp:DropDownList ID="ddlModalStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                                    <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
                                    <asp:ListItem Text="Responded" Value="Responded"></asp:ListItem>
                                    <asp:ListItem Text="Closed" Value="Closed"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <strong>Newsletter:</strong>
                                <span class="badge badge-info d-block mt-2">
                                    <asp:Label ID="lblModalNewsletter" runat="server"></asp:Label>
                                </span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <strong>Admin Response:</strong>
                                <asp:TextBox ID="txtAdminResponse" runat="server" CssClass="form-control mt-2" 
                                    TextMode="MultiLine" Rows="4" placeholder="Type your response here..."></asp:TextBox>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnUpdateMessage" runat="server" Text="Update & Send Response" CssClass="btn btn-primary" OnClick="UpdateMessage" />
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <style>
        .table th {
            border-top: none;
            font-weight: 600;
        }
        
        .badge {
            font-size: 0.8em;
        }
        
        .modal-lg {
            max-width: 800px;
        }
        
        .card {
            transition: transform 0.2s;
        }
        
        .card:hover {
            transform: translateY(-2px);
        }
        
        .pagination {
            margin-top: 20px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>