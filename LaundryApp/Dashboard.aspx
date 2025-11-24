<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LaundryApp.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="container-fluid px-3 px-lg-4 dashboard-wrapper">
        <style>
            .dashboard-wrapper {
                background-color: #f7f9fb;
            }

            .dash-card {
                border-radius: 14px;
                background: #fff;
                transition: 0.2s;
            }

            .dash-card:hover {
                transform: translateY(-3px);
            }

            .avatar-circle {
                width: 38px;
                height: 38px;
                background: #3b82f6;
                color: white;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                font-weight: 600;
            }

            .bg-purple { background: #a855f7 !important; }
            .text-purple { color: #8b5cf6; }

            .progress {
                height: 6px;
                border-radius: 6px;
            }

            .progress-bar {
                border-radius: 6px;
                background-color: #3b82f6;
            }

        </style>

        <!-- Welcome Header -->
        <h2 class="fw-bold mb-1">Welcome Back</h2>
        <p class="text-muted mb-4">Here's what's happening today</p>

        <!-- Stats Cards -->
        <div class="row g-3 mb-4">
            <div class="col-sm-6 col-lg-3">
                <div class="dash-card shadow-sm p-4 rounded bg-white">
                    <i class="bi bi-box fs-3 text-primary"></i>
                    <h4 class="fw-bold mt-2 mb-0">0</h4>
                    <small class="text-muted">Today's Orders</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="dash-card shadow-sm p-4 rounded bg-white">
                    <i class="bi bi-clock fs-3 text-primary"></i>
                    <h4 class="fw-bold mt-2 mb-0">5</h4>
                    <small class="text-muted">In Progress</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="dash-card shadow-sm p-4 rounded bg-white">
                    <i class="bi bi-check2-circle fs-3 text-success"></i>
                    <h4 class="fw-bold mt-2 mb-0">0</h4>
                    <small class="text-muted">Ready for Pickup</small>
                </div>
            </div>

            <div class="col-sm-6 col-lg-3">
                <div class="dash-card shadow-sm p-4 rounded bg-white">
                    <i class="bi bi-currency-dollar fs-3 text-purple"></i>
                    <h4 class="fw-bold mt-2 mb-0">$300.50</h4>
                    <small class="text-success fw-semibold">▲ +12% this week</small><br />
                    <small class="text-muted">Total Revenue</small>
                </div>
            </div>
        </div>

        <!-- Recent orders + Order status -->
        <div class="row g-4">
            <div class="col-lg-8">
                <div class="card shadow-sm p-4 rounded bg-white">
                    <h5 class="fw-bold mb-3">Recent Orders</h5>

                    <!-- Recent orders here -->
                </div>
            </div>

            <div class="col-lg-4">
                <div class="card shadow-sm p-4 rounded bg-white">
                    <h5 class="fw-bold mb-3">Order Status</h5>

                    <!-- Order status items here -->
                </div>
            </div>
        </div>

        <!-- Admin Content (Visible for Admin only) -->
        <div id="adminContent" runat="server" visible="false">
            <!-- Admin-specific content here -->
            <h4>Admin Only Content</h4>
            <p>Admin can manage orders, users, and other administrative tasks here.</p>
        </div>

        <!-- User Content (Visible for User only) -->
        <div id="userContent" runat="server" visible="false">
            <!-- User-specific content here -->
            <h4>User Dashboard</h4>
            <p>User-specific tasks and order tracking can be managed here.</p>
        </div>

    </div>

</asp:Content>
