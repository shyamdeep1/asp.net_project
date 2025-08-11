<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Job_Portal.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <center>
        <div id="form1" runat="server">
            <div class="login-container">
                <h2>Login</h2>
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label><br />

                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box"></asp:TextBox><br />

                <label>Password:</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-box"></asp:TextBox><br />

                <label>Role:</label>
                <asp:DropDownList ID="ddlRole" runat="server" CssClass="input-box"></asp:DropDownList><br />

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
            </div>
        </div>
    </center>
    </body>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
