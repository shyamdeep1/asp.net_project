<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Job_Portal.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!DOCTYPE html>
    <head>
        <title>Login - JobBoard</title>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />

        <!-- Theme CSS -->
        <link rel="stylesheet" href="css/custom-bs.css" />
        <link rel="stylesheet" href="css/jquery.fancybox.min.css" />
        <link rel="stylesheet" href="css/bootstrap-select.min.css" />
        <link rel="stylesheet" href="fonts/icomoon/style.css" />
        <link rel="stylesheet" href="fonts/line-icons/style.css" />
        <link rel="stylesheet" href="css/owl.carousel.min.css" />
        <link rel="stylesheet" href="css/animate.min.css" />
        <link rel="stylesheet" href="css/quill.snow.css" />
        <link rel="stylesheet" href="css/style.css" />
    </head>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="site-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="mb-5 heading-219 text-center">Login</h2>

                    <div class="p-4 p-md-5 border rounded">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label><br />

                        <!-- Email -->
                        <asp:Label ID="lbleml" runat="server" Text="Email"></asp:Label><br />
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEmail" runat="server" ErrorMessage="Please Enter Email"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Password -->
                        <div class="form-group">
                            <asp:Label ID="lblpass" runat="server" Text="Password"></asp:Label><br />
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtPassword" runat="server" ErrorMessage="Please Enter Password"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Submit -->
                        <div class="form-group">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary py-2 px-4" OnClick="btnLogin_Click" />
                        </div>
                        <div class="form-group">
                            <p>Don't have an account? <a href="register_jobseeker.aspx">Register here</a></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
