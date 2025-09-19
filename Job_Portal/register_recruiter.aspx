<%@ Page Title="Register as Recruiter" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register_recruiter.aspx.cs" Inherits="Job_Portal.register_recruiter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="site-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="mb-5 heading-219 text-center">Register as Recruiter</h2>

                    <div class="p-4 p-md-5 border rounded">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

                        <!-- Full Name -->
                        <div class="form-group">
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                        </div>

                        <!-- Company Name -->
                        <div class="form-group">
                            <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" placeholder="Company Name"></asp:TextBox>
                        </div>
                        <!-- Company Address -->
                        <div class="form-group">
                            <asp:TextBox ID="txtCompanyAddress" runat="server" CssClass="form-control" placeholder="Company Address"></asp:TextBox>
                        </div>


                        <!-- Email -->
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" TextMode="Email"></asp:TextBox>
                        </div>

                        <!-- Password -->
                        <div class="form-group">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                        </div>

                        <!-- Confirm Password -->
                        <div class="form-group">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                        </div>

                        <!-- Submit -->
                        <div class="form-group">
                            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary py-2 px-4" OnClick="btnRegister_Click" />
                        </div>

                        <div class="form-group">
                            <p>Already registered? <a href="login.aspx">Login here</a></p>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>
