<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="Job_Portal.about" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <!-- HERO SECTION - Navigation removed, now in Master page -->
    <section class="section-hero overlay inner-page bg-image" style="background-image: url('images/hero_1.jpg');" id="home-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="text-center">
                        <h1 class="text-white font-weight-bold mb-3" style="font-size: 3rem;">About Us</h1>
                        <p class="text-white lead" style="font-size: 1.3rem; max-width: 700px; margin: 0 auto;">
                            Your trusted partner in connecting talent with opportunity.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ABOUT CONTENT -->
    <section class="site-section" style="padding: 80px 0;">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6 mb-4 mb-lg-0">
                    <img src="images/hero_1.jpg" alt="About JobBoard" class="img-fluid rounded shadow-lg">
                </div>
                <div class="col-lg-6">
                    <h2 class="section-title mb-4">Who We Are</h2>
                    <p class="lead mb-4">
                        JobBoard is a leading online job portal that connects talented professionals with their dream careers.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- ...existing content sections... -->

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
    <!-- ...existing footer code... -->
</asp:Content>

