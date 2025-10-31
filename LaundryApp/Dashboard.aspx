<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LaundryApp.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Page-Specific Styles */
        .dashboard-header h3 {
            font-weight: 600;
            color: #333;
        }

        .dashboard-header p {
            color: #6c757d;
            margin-bottom: 30px;
        }

        .dashboard-stats .card {
            border-radius: 15px;
            border: none;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .dashboard-stats .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
        }

        .dashboard-stats .card-body i {
            font-size: 2rem;
            color: #84C0C6;
        }

        .dashboard-stats h5 {
            margin-top: 10px;
            font-weight: 600;
            color: #333;
        }

        .dashboard-stats p {
            color: #6c757d;
            font-size: 0.9rem;
        }

        /* Center cards on smaller screens */
        @media (max-width: 768px) {
            .dashboard-stats {
                text-align: center;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid py-4 px-3 px-md-4 px-lg-5">
        <!-- Header -->
        <div class="dashboard-header text-start">
            <h3 class="fw-bold mb-1">Dashboard</h3>
            <p class="text-muted">Overview of your laundry operations and statistics</p>
        </div>

        <!-- Stats Cards -->
        <div class="row g-4 dashboard-stats">
            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="bi bi-bag-check"></i>
                        <h5>120</h5>
                        <p>Completed Orders</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="bi bi-hourglass-split"></i>
                        <h5>35</h5>
                        <p>In Progress</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="bi bi-person"></i>
                        <h5>58</h5>
                        <p>Active Customers</p>
                    </div>
                </div>
            </div>

            <div class="col-12 col-sm-6 col-lg-3">
                <div class="card text-center">
                    <div class="card-body">
                        <i class="bi bi-cash-stack"></i>
                        <h5>$2,450</h5>
                        <p>Total Revenue</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Example Chart Section -->
        <div class="row mt-5">
            <div class="col-12 col-lg-8 mx-auto">
                <div class="card p-4">
                    <h5 class="mb-3">Recent Orders Activity</h5>
                    <p class="text-muted mb-0">Coming soon — add your chart here</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
