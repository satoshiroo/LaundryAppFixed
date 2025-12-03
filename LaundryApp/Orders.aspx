<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="LaundryApp.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        body {
            background-color: #f8f9fc;
        }

        /* Summary Card Styling */
        .summary-card {
            border-radius: 12px;
            background-color: #ffffff;
            color: #111827;
            text-align: left;
            padding: 16px 18px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.06);
        }

        /* Card Titles */
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

        /* Search Bar and Filters */
        .toolbar-card {
            border-radius: 14px;
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(15, 23, 42, 0.06);
            padding: 16px 18px;
        }

        /* Consistent button size for filter pills */
        .filter-pill {
            font-size: 0.85rem;
            border-radius: 999px;
            padding: 6px 14px;
            border: 1px solid #e5e7eb;
            background: #ffffff;
            color: #4b5563;
            margin-left: 6px;
            width: 120px; /* Set equal width for all buttons */
            text-align: center;
            display: inline-block;
        }

        .filter-pill.active {
            background: #0d6efd;
            color: #ffffff;
            border-color: #0d6efd;
        }

        .input-group {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 30px;
            width: 100%; /* Use full width for mobile */
            max-width: 600px; /* Optional: You can adjust the max-width for larger screens */
            margin: 0 auto; /* Center the search bar */
        }

        .input-group input.form-control {
            border: none;
            border-radius: 30px;
            padding: 8px 15px;
            font-size: 1rem;
            flex-grow: 1; /* Make input fill remaining space */
        }

        .input-group button {
            border-radius: 30px;
            background-color: #f1f1f1;
            border: none;
            padding: 8px 15px;
            font-size: 1rem;
            cursor: pointer;
            margin-left: 10px; /* Space between the input field and button */
        }   

        /* Remove Summary Cards for mobile view */
        @media (max-width: 768px) {
            .summary-card {
                display: none; /* Hides summary cards on mobile */
            }

            .input-group {
                width: 100%;
            }
            .input-group button{
                width: 25%;
            }

            .input-group select {
                border-radius: 30px;
                padding: 8px 15px;
                font-size: 1rem;
                border: 1px solid #ddd;
                flex-grow: 1;
            }

            .input-group input.form-control {
                width: 75%;
            }

            /* Show dropdown filter only on mobile */
            .d-none.d-md-flex {
                display: none !important;
            }
        }

        /* Mobile responsive styles */
        @media (max-width: 900px) {
            .d-md-none {
                display: block; /* Show dropdown on mobile */
            }

            .d-md-block {
                display: none; /* Hide search bar dropdown for smaller screens */
            }

            .input-group {
                width: 100%;
            }

            .input-group input.form-control {
                width: 80%; /* Adjust width of search input on smaller screens */
            }

            .input-group button {
                width: 18%; /* Adjust width of the button on smaller screens */
            }
            .row.mb-4{
                display: none !important;
            }
        }

        /* Modal Styling */
        .modal-dialog {
            max-width: 90%; /* Allow modal to take most of the screen width */
        }

        .modal-body {
            padding: 1rem;
        }

        .modal-body .form-control,
        .modal-body .form-select {
            width: 100%; /* Ensure input fields take full width inside the modal */
            margin-bottom: 1rem;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
        }

        /* Icon Adjustments */
        .service-label img {
            width: 60px; /* Adjust icon size */
            height: 60px;
            margin-bottom: 10px;
        }

        /* Aligning the icon text properly */
        .service-label div {
            text-align: center;
            font-size: 0.9rem;
            color: #333;
        }
    .order-card {
        background-color: #f8f9fc;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .order-card-header {
        font-size: 18px;
        font-weight: bold;
    }

    .order-card-body {
        font-size: 14px;
    }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <!-- Title Section -->
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

        <!-- Search and Order Status -->
        <div class="toolbar-card mb-4">
            <div class="d-flex align-items-center justify-content-between gap-3">
                <!-- Search Bar Container -->
                <div class="input-group flex-grow-1">
                    <input type="text" class="form-control" placeholder="Search by order ID or service..." id="txtSearch" runat="server" />
                    <button class="btn btn-secondary" id="searchButton">Search</button>
                </div>

                <!-- Order Status Filters (Desktop Only) -->
                <div class="d-none d-md-flex align-items-center ms-lg-3">
                    <button type="button" class="filter-pill active" onclick="filterOrders('All', this)">All</button>
                    <button type="button" class="filter-pill" onclick="filterOrders('Pending', this)">Pending</button>
                    <button type="button" class="filter-pill" onclick="filterOrders('In Progress', this)">In Progress</button>
                    <button type="button" class="filter-pill" onclick="filterOrders('Completed', this)">Completed</button>
                </div>

                <!-- Dropdown for mobile view -->
                <div class="d-md-none">
                    <select class="form-select" id="orderStatusDropdownMobile" onchange="filterOrders(this.value, null)">
                        <option value="All">All Orders</option>
                        <option value="Pending">Pending</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Completed">Completed</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Orders List Repeater -->
        <!-- Orders List Repeater -->
            <div class="row" id="orderCards">
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
                                   <p><strong>Service:</strong> <%# Eval("ServiceType") != DBNull.Value ? Eval("ServiceType") : "N/A" %></p>
                                   <p><strong>Total:</strong> $<%# Eval("TotalAmount") != DBNull.Value ? Eval("TotalAmount") : 0 %></p>
                                   <p><strong>Due Date:</strong> <%# Eval("PickupDate") != DBNull.Value ? Eval("PickupDate") : "Not Provided" %></p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
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

                    <!-- Service Selection -->
                    <div class="mb-3">
                        <label class="form-label">Select Service*</label>
                        <div class="service-options">
                            <div class="service-card" data-service-id="1">
                                <input type="radio" name="service" id="washFold" value="Wash & Fold" />
                                <label for="washFold" class="service-label">
                                    <img src="img/washnfold-removebg-preview.png" alt="Wash & Fold"/>
                                    <div>Wash & Fold</div>
                                    <div class="service-price">100 per Service</div>
                                </label>
                            </div>
                            <div class="service-card" data-service-id="2">
                                <input type="radio" name="service" id="washIron" value="Wash & Iron" />
                                <label for="washIron" class="service-label">
                                    <img src="img/washniron-removebg-preview.png" alt="Wash & Iron"/>
                                    <div>Wash & Iron</div>
                                    <div class="service-price">150 per Service</div>
                                </label>
                            </div>
                            <div class="service-card" data-service-id="3">
                                <input type="radio" name="service" id="washOnly" value="Wash Only" />
                                <label for="washOnly" class="service-label">
                                    <img src="img/dryclean-removebg-preview.png" alt="Wash Only" />
                                    <div>Wash only</div>
                                    <div class="service-price">50 per Service</div>
                                </label>
                            </div>
                            <div class="service-card" data-service-id="4">
                                <input type="radio" name="service" id="dryClean" value="Dry Clean" />
                                <label for="dryClean" class="service-label">
                                    <img src="img/irononly-removebg-preview.png" alt="Iron Only"/>
                                    <div>Dry Clean</div>
                                    <div class="service-price">80 per Service</div>
                                </label>
                            </div>                        
                        </div>
                    </div>

                    <!-- Pickup or Delivery Option -->
                    <div class="mb-3">
                        <label class="form-label">Pickup or Delivery*</label>
                        <asp:DropDownList ID="ddlPickupDelivery" runat="server" CssClass="form-select" OnSelectedIndexChanged="ddlPickupDelivery_SelectedIndexChanged">
                            <asp:ListItem Text="Pickup" Value="Pickup" />
                            <asp:ListItem Text="Delivery" Value="Delivery" />
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3" id="pickupDateDiv" runat="server" style="display:none;">
                        <label class="form-label">Preferred Pickup Date*</label>
                        <input type="date" ID="txtPickupDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"/>
                    </div>

                    <!-- Delivery Date -->
                    <div class="mb-3" id="deliveryDateDiv" runat="server" style="display:none;">
                        <label class="form-label">Preferred Delivery Date*</label>
                        <input type="date" id="txtDeliveryDate" runat="server" CssClass="form-control" placeholder="MM/DD/YYYY"/>
                    </div>

                    <div class="mb-3" id="deliveryAddressDiv" runat="server" style="display:none;">
                        <label class="form-label">Delivery Address*</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your delivery address..." ReadOnly="true"/>
                    </div>

                    <!-- Total Amount -->
                    <div class="mb-3">
                        <label class="form-label">Total Amount*</label>
                        <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control" placeholder="Total Amount" ReadOnly="true"/>
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

    <script>
        document.getElementById('<%= ddlPickupDelivery.ClientID %>').addEventListener('change', function () {
            var selectedValue = this.value;

            // Hide both fields initially
            document.getElementById('<%= pickupDateDiv.ClientID %>').style.display = 'none';
            document.getElementById('<%= deliveryAddressDiv.ClientID %>').style.display = 'none';
            document.getElementById('<%= deliveryDateDiv.ClientID %>').style.display = 'none';
            
            // Show Pickup Date for Pickup selection
            if (selectedValue === 'Pickup') {
                document.getElementById('<%= pickupDateDiv.ClientID %>').style.display = 'block';
            }
            // Show Delivery Address and Delivery Date for Delivery selection
            else if (selectedValue === 'Delivery') {
                document.getElementById('<%= deliveryDateDiv.ClientID %>').style.display = 'block';
                document.getElementById('<%= deliveryAddressDiv.ClientID %>').style.display = 'block';
            }
        });

        document.addEventListener('DOMContentLoaded', function() {
            var selectedValue = document.getElementById('<%= ddlPickupDelivery.ClientID %>').value;
            if (selectedValue === 'Pickup') {
                document.getElementById('<%= pickupDateDiv.ClientID %>').style.display = 'block';
            } else if (selectedValue === 'Delivery') {
                document.getElementById('<%= deliveryAddressDiv.ClientID %>').style.display = 'block';
            }
        });
    </script>
</asp:Content>
