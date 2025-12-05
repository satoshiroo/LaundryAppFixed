<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="Dashboard.aspx.cs" Inherits="LaundryApp.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid px-3 px-lg-4 dashboard-wrapper">
        <style>
            .dashboard-wrapper { background-color: #f7f9fb; }

            .dash-card {
                border-radius: 14px;
                background: #fff;
                transition: 0.2s;
            }

            .dash-card:hover { transform: translateY(-3px); }

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

            .progress { height: 6px; border-radius: 6px; }
            .progress-bar { border-radius: 6px; background-color: #3b82f6; }
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



        <!-- Admin Section -->
        <div id="adminContent" runat="server" visible="false" class="mt-4">
            <h4>Admin Tools</h4>
        <!-- Users and Orders -->
        <div class="row g-4">

            <!-- USERS LIST -->
            <div class="col-lg-6">
                <div class="card shadow-sm p-4 rounded bg-white">
                    <h5 class="fw-bold mb-3">Users</h5>

                    <asp:Repeater ID="UsersRepeater" runat="server">
                        <ItemTemplate>
                            <div class="d-flex align-items-center mb-3">
                                <div class="avatar-circle me-3">
                                    <%# GetInitial(Eval("Username")) %>
                                </div>
                                <div>
                                    <strong><%# Eval("Username") %> </strong><br />
                                    <small><%# Eval("ContactNumber")%> • <%# Eval("Address") %></small>
                                 
                                    
                                </div>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <div runat="server" id="NoUsers" visible="false">No users found.</div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- ORDERS LIST -->
            <div class="col-lg-6">
                <div class="card shadow-sm p-4 rounded bg-white">
                    <h5 class="fw-bold mb-3">Order Status</h5>

                    <asp:Repeater ID="OrdersRepeater" runat="server" OnItemDataBound="OrdersRepeater_ItemDataBound">
                        <ItemTemplate>
                            <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                                <div>
                                    <strong><%# Eval("CustomerName") %></strong><br />
                                    <small><%# Eval("DeliveryDate", "{0:MMM dd, yyyy}") %> • $<%# Eval("TotalAmount") %></small>
                                </div>
                                <asp:Literal ID="StatusLiteral" runat="server"></asp:Literal>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <div runat="server" id="NoOrders" visible="false">No orders found.</div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        </div>

        <!-- User Section -->
        <div id="userContent" runat="server" visible="false" class="mt-4">
            <h4>User Dashboard</h4>
          
    <div class="container-fluid px-3 px-lg-4 dashboard-wrapper">
        <style>
            .dashboard-wrapper { background-color: #f7f9fb; }
            .dash-card { border-radius: 14px; background: #fff; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 6px rgba(0,0,0,0.1);}
            .avatar-circle { width: 38px; height: 38px; background: #3b82f6; color: #fff; border-radius: 50%; display:flex; justify-content:center; align-items:center; font-weight:600; margin-right:10px;}
            .badge-ready { background-color: #28a745; color: #fff; padding: 3px 8px; border-radius: 4px; }
            .badge-pending { background-color: #ffc107; color: #fff; padding: 3px 8px; border-radius: 4px; }
        </style>

        <!-- Header -->
        <h2 class="fw-bold mb-1">Welcome Back!</h2>
        <p class="text-muted mb-4">Here are your current laundry orders and pickup dates</p>

        <!-- User Orders -->
        <div class="row">
            <div class="col-lg-8">
                <div class="dash-card">
                    <h5>Your Orders</h5>
                    <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="OrdersRepeater_ItemDataBound">
                        <ItemTemplate>
                            <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                                <div>
                                    <strong><%# Eval("OrderID") %> - <%# Eval("ServiceType") %></strong><br />
                                    <small>
                                        Pickup: <%# Eval("PickupDate", "{0:MMM dd, yyyy}") %> • 
                                        Amount: $<%# Eval("TotalAmount") %>
                                    </small>
                                </div>
                                <asp:Literal ID="StatusLiteral" runat="server"></asp:Literal>
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <div runat="server" id="NoOrders" visible="false">No orders found.</div>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>

            <!-- User Info -->
            <div class="col-lg-4">
                <div class="dash-card">
                    <h5>Your Info</h5>
                    <div class="d-flex align-items-center mb-3">
                        <div class="avatar-circle"><%# GetInitial(Eval("FirstName")) %></div>
                        <div>
                            <strong><%# Eval("FirstName") %> <%# Eval("LastName") %></strong><br />
                            <small><%# Eval("ContactNumber") %> • <%# Eval("Address") %></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

        </div>

    </div>
</asp:Content>
