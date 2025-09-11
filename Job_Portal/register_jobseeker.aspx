<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="register_jobseeker.aspx.cs" Inherits="Job_Portal.register_jobseeker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="site-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <h2 class="mb-5 heading-219 text-center">Register as Job Seeker</h2>

                    <div class="p-4 p-md-5 border rounded">
                        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger"></asp:Label>

                        <!-- Full Name -->
                        <div class="form-group">
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtFullName" runat="server" ErrorMessage="Please Enter Name"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Email -->
                        <div class="form-group">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="txtEmail" runat="server" ErrorMessage="Please Enter Email"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Password -->
                        <div class="form-group">
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ControlToValidate="txtPassword" runat="server" ErrorMessage="Please Enter Password"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Confirm Password -->
                        <div class="form-group">
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" ControlToValidate="txtConfirmPassword" runat="server" ErrorMessage="Please Enter Confirm Password"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" runat="server" ErrorMessage="Password Not Match"></asp:CompareValidator>
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
