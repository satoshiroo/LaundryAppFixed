<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="LaundryApp.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        body {
            background-color: #f8f9fc;
        }

        /* Top summary cards */
        .summary-card {
            border-radius: 12px;
            background-color: #ffffff;
            color: #111827;
            text-align: left;
            padding: 16px 18px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.06);
        }

        .summary-card h5 {
            font-size: 0.9rem;
            font-weight: 600;
            margin-bottom: 4px;
            color: #6b7280;
        }

        .summary-card h3 {
            font-size: 1.4rem;
            font-weight: 700;
            margin: 0;
        }

        /* Order cards */
        .order-card {
            border-radius: 14px;
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .order-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.15);
        }

        .order-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 16px;
            border-bottom: 1px solid #e5e7eb;
        }

        .order-title {
            font-weight: 600;
            font-size: 1rem;
            margin: 0;
        }

        .order-status {
            font-size: 0.7rem;
            border-radius: 999px;
            padding: 4px 10px;
            background: #e5e7eb;
            color: #374151;
            text-transform: uppercase;
            letter-spacing: .04em;
        }

        .status-pending {
            color: #f59e0b;
            font-weight: 600;
        }

        .status-completed {
            color: #16a34a;
            font-weight: 600;
        }

        .status-progress {
            color: #0d6efd;
            font-weight: 600;
        }

        .order-card-body {
            padding: 12px 16px 16px 16px;
            font-size: 0.9rem;
            color: #4b5563;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h2 class="fw-bold mb-0">Orders</h2>
                <small class="text-muted">Manage and monitor all laundry orders.</small>
            </div>
            <button type="button" class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addOrderModal">
                <i class="bi bi-plus-lg me-1"></i> Add Order
            </button>
        </div>

        <!-- Admin Orders View -->
        <div id="AdminOrdersView" runat="server">
            <div class="row mb-4">
                <div class="col-md-3 mb-3 mb-md-0">
                    <div class="summary-card">
                        <h5>Total Orders</h5>
                        <h3><asp:Label ID="lblTotalOrders" runat="server" Text="0" /></h3>
                    </div>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <div class="summary-card">
                        <h5>Pending</h5>
                        <h3><asp:Label ID="lblPending" runat="server" Text="0" /></h3>
                    </div>
                </div>
                <div class="col-md-3 mb-3 mb-md-0">
                    <div class="summary-card">
                        <h5>In Progress</h5>
                        <h3><asp:Label ID="lblInProgress" runat="server" Text="0" /></h3>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="summary-card">
                        <h5>Completed</h5>
                        <h3><asp:Label ID="lblCompleted" runat="server" Text="0" /></h3>
                    </div>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="mb-4">
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search orders by customer name..." />
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-secondary" OnClick="btnSearch_Click" />
                </div>
            </div>

            <div class="row">
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 mb-4">
                            <div class="order-card" data-type="<%# Eval("Status") %>" onclick="openEditModal('<%# Eval("OrderID") %>','<%# Eval("CustomerName") %>','<%# Eval("Status") %>')">
                                <div class="order-card-header">
                                    <h5 class="order-title mb-0"><%# Eval("CustomerName") %></h5>
                                    <span class="order-status <%# Eval("Status") == "Pending" ? "status-pending" : Eval("Status") == "In Progress" ? "status-progress" : Eval("Status") == "Completed" ? "status-completed" : "" %>">
                                        <%# Eval("Status") %>
                                    </span>
                                </div>
                                <div class="order-card-body">
                                    <p class="mb-1">
                                        <strong>Total:</strong> <%# Eval("TotalAmount") %>
                                    </p>
                                    <p class="mb-0">
                                        <strong>Contact:</strong> <%# Eval("Contact") %>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Customer Orders View -->
        <div id="CustomerOrdersView" runat="server" style="display:none;">
            <div class="customer-dashboard container mt-4">
                <div class="row g-3">
                    <div class="col-md-3">
                        <div class="summary-card">
                            <h5>Active Orders</h5>
                            <h3><asp:Label ID="lblCustomerActive" runat="server" Text="0" /></h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-card">
                            <h5>Completed</h5>
                            <h3><asp:Label ID="lblCustomerCompleted" runat="server" Text="0" /></h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="summary-card">
                            <h5>Total Spent</h5>
                            <h3>₱<asp:Label ID="lblCustomerSpent" runat="server" Text="0.00" /></h3>
                        </div>
                    </div>
                </div>

                <div class="card mt-4 p-4 text-center">
                    <h5>No orders yet</h5>
                    <p class="text-muted">Start by ordering your first laundry service!</p>
                    <asp:Button ID="btnBookService" runat="server" CssClass="btn btn-primary px-4" Text="+ Book Service" />
                </div>

                <div class="mt-4">
                    <h4>Our Services</h4>
                    <div class="row g-3 mt-2">
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5>Wash & Fold</h5>
                                <p class="text-muted">₱12.99 / load</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5>Dry Cleaning</h5>
                                <p class="text-muted">₱25.99 / load</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5>Press & Iron</h5>
                                <p class="text-muted">₱8.99 / load</p>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card p-3">
                                <h5>Wash & Press</h5>
                                <p class="text-muted">₱18.99 / load</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- ADD ORDER MODAL -->
    <div class="modal fade" id="addOrderModal" tabindex="-1" aria-labelledby="addOrderLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="addOrderLabel">Add Order</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Customer Name</label>
                        <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Contact</label>
                        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Total</label>
                        <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Pending" Value="Pending" />
                            <asp:ListItem Text="In Progress" Value="In Progress" />
                            <asp:ListItem Text="Completed" Value="Completed" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveOrder" runat="server" Text="Save Order" CssClass="btn btn-primary" OnClick="btnSaveOrder_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
