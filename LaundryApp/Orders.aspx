<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="LaundryApp.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        body {
            background-color: #f8f9fc;
        }

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

        /* Search bar */
        .search-bar {
            width: 80%;
            padding: 6px 12px;
            border-radius: 5px;
            border: 1px solid #ccc;
            line-height: 1.2;
        }

        /* Button styling */
        .btn-primary {
            background-color: #4c7ef1;
            border-color: #4c7ef1;
            color: white;
        }

        .btn-primary:hover {
            background-color: #3c6be0;
            border-color: #3c6be0;
        }

        .filter-btns {
            margin: 5px 0;
        }

        .filter-btns button {
            background-color: transparent;
            border: 1px solid #ccc;
            margin-right: 4px;
            border-radius: 5px;
            padding: 6px 12px;
            font-size: 0.9rem;
        }

        /* Service Options */
        .service-options {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        /* Custom radio button styles */
        .custom-radio input[type="radio"] {
            display: none; /* Hide the default radio button */
        }

        .custom-radio {
            display: inline-block;
            position: relative;
            margin-right: 15px;
            padding-left: 30px;
            cursor: pointer;
        }

        .custom-radio input[type="radio"]:checked + .radio-label::before {
            background-color: #4c7ef1; /* Customize the checked color */
        }

        .custom-radio input[type="radio"]:checked + .radio-label {
            font-weight: bold;
        }

        /* Creating the custom radio circle */
        .custom-radio input[type="radio"]:before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 20px;
            height: 20px;
            border-radius: 50%;
            border: 2px solid #4c7ef1;
            background-color: transparent;
        }

        /* When checked */
        .custom-radio input[type="radio"]:checked:before {
            background-color: #4c7ef1; /* Customize checked color */
            border-color: #4c7ef1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h2 class="fw-bold mb-0">My Orders</h2>
                <small class="text-muted">Track your laundry orders and place new ones.</small>
            </div>
            <button type="button" class="btn btn-primary rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addOrderModal">
                <i class="bi bi-plus-lg me-1"></i> Place Order
            </button>
        </div>

        <!-- Summary Cards -->
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

        <!-- Orders List -->
        <div class="row">
            <asp:Repeater ID="rptOrders" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="order-card">
                            <div class="order-card-header">
                                <h5 class="order-title mb-0"><%# Eval("CustomerName") %></h5>
                                <span class="order-status <%# Eval("Status") == "Pending" ? "status-pending" : Eval("Status") == "In Progress" ? "status-progress" : Eval("Status") == "Completed" ? "status-completed" : "" %>">
                                    <%# Eval("Status") %>
                                </span>
                            </div>
                            <div class="order-card-body">
                                <p class="mb-1">
                                    <strong>Service:</strong> <%# Eval("ServiceType") %>
                                </p>
                                <p class="mb-1">
                                    <strong>Items:</strong> <%# Eval("ItemCount") %>
                                </p>
                                <p class="mb-0">
                                    <strong>Total:</strong> $<%# Eval("TotalAmount") %>
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Modal: Place New Order -->
    <div class="modal fade" id="addOrderModal" tabindex="-1" aria-labelledby="addOrderLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addOrderLabel">Place New Order</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- Customer Name and Contact Number -->
                    <div class="mb-3">
                        <label class="form-label">Customer Name*</label>
                        <asp:TextBox ID="txtCustomerName" runat="server" CssClass="form-control" ReadOnly="True" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone Number*</label>
                        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" ReadOnly="True" />
                    </div>

                    <!-- Service Selection (RadioButtonList for service types) -->
                    <div class="mb-3">
                        <label class="form-label">Select Service*</label>
                        <asp:RadioButtonList ID="rblServiceType" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Wash & Fold - $3 per kg" Value="Wash & Fold" />
                            <asp:ListItem Text="Dry Clean - $15 per item" Value="Dry Clean" />
                            <asp:ListItem Text="Iron Only - $3 per item" Value="Iron Only" />
                            <asp:ListItem Text="Wash & Iron - $5 per kg" Value="Wash & Iron" />
                            <asp:ListItem Text="Express - $8 per kg" Value="Express" />
                        </asp:RadioButtonList>
                    </div>

                    <!-- Pickup or Delivery Option -->
                    <div class="mb-3">
                        <label class="form-label">Pickup or Delivery*</label>
                        <asp:DropDownList ID="ddlPickupDelivery" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlPickupDelivery_SelectedIndexChanged" AutoPostBack="True">
                            <asp:ListItem Text="Pickup" Value="Pickup" />
                            <asp:ListItem Text="Delivery" Value="Delivery" />
                        </asp:DropDownList>
                    </div>

                    <!-- Pickup Date or Delivery Address -->
                    <div class="mb-3" id="pickupDateDiv">
                        <label class="form-label">Preferred Pickup Date*</label>
                        <asp:TextBox ID="txtPickupDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY" />
                    </div>

                    <div class="mb-3" id="deliveryAddressDiv" style="display:none;">
                        <label class="form-label">Delivery Address*</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your delivery address..." />
                        <asp:DropDownList ID="ddlSavedAddress" runat="server" CssClass="form-select" AutoPostBack="True">
                            <asp:ListItem Text="Select a saved address" Value="0" />
                        </asp:DropDownList>
                    </div>

                    <!-- Total Amount -->
                    <div class="mb-3">
                        <label class="form-label">Total Amount*</label>
                        <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control" placeholder="Total Amount" />
                    </div>

                    <!-- Special Instructions -->
                    <div class="mb-3">
                        <label class="form-label">Special Instructions (Optional)</label>
                        <asp:TextBox ID="txtSpecialInstructions" runat="server" CssClass="form-control" TextMode="MultiLine" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveOrder" runat="server" Text="Place Order" CssClass="btn btn-primary" OnClick="btnSaveOrder_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
