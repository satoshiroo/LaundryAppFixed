<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LaundryApp.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background-color: #f8f9fc;
        }

        /* Profile Card styling */
        .profile-card {
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(15, 23, 42, 0.06);
            padding: 30px;
            margin: 20px;
            width: 100%;
            max-width: 600px;
            text-align: center;
            margin-left: auto;
            margin-right: auto;
        }

        /* Avatar styling */
        .profile-avatar {
            width: 100px;
            height: 100px;
            background: #3b82f6;
            color: white;
            font-size: 36px;
            border-radius: 50%;
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Profile Title and Role */
        .profile-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin: 0;
        }

        .profile-role {
            font-size: 1rem;
            color: #6b7280;
            margin-top: 5px;
            margin-bottom: 20px;
        }

        /* Profile Information */
        .profile-details {
            text-align: left;
            margin-bottom: 20px;
            font-size: 1rem;
        }

        .profile-details p {
            margin: 8px 0;
            color: #6b7280;
        }

        .profile-button {
            background-color: #0d6efd;
            color: white;
            border-radius: 25px;
            padding: 12px 30px;
            cursor: pointer;
            font-size: 1rem;
            text-decoration: none;
            display: inline-block;
        }

        .profile-button:hover {
            background-color: #2563eb;
        }

        .email-note {
            font-size: 0.875rem;
            color: #6b7280;
            margin-top: 5px;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div>
            <h2 class="fw-bold mb-0">Profile</h2>
            <small class="text-muted">Manage your User Profile</small>
        </div>
        <!-- Profile Card -->
        <div class="row">
            <div class="col-md-12">
                <div class="profile-card">
                    <!-- Avatar -->
                    <div class="profile-avatar">
                        <span><%# User.Identity.Name.Substring(0, 1) %></span>
                    </div>

                    <!-- Profile Title and Role -->
                    <div class="profile-title"><%# User.Identity.Name %></div>
                    <div class="profile-role">Administrator</div>

                    <!-- Profile Information -->
                    <div class="section-title">Profile Information</div>
                    <div class="profile-details">
                        <p><strong>Full Name:</strong> <span><%# User.Identity.Name %></span></p>
                        <p><strong>Email Address:</strong> <span><asp:Label ID="EmailLabel" runat="server" Text="user@example.com" /></span></p>
                        <p><strong>Account ID:</strong> <span><asp:Label ID="AccountIDLabel" runat="server" Text="12345" /></span></p>
                        <p><strong>Account Created:</strong> <span><asp:Label ID="AccountCreatedLabel" runat="server" Text="October 18, 2025" /></span></p>
                        <p class="email-note">Email cannot be changed</p>
                    </div>

                    <!-- Edit Profile Button -->
                    <a href="EditProfile.aspx" class="profile-button">Edit Profile</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
