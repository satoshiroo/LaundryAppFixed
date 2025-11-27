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

        .service-card {
            display: inline-block;
            width: 180px;
            padding: 10px;
            border-radius: 10px;
            background-color: #f3f4f6;
            text-align: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin: 10px;
            cursor: pointer;
            transition: transform 0.3s ease;
            text-align: center;
            border: 2px solid transparent;
        }

        .service-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .service-card input[type="radio"] {
            display: none;
        }

        .service-card input[type="radio"]:checked + .service-label {
            font-weight: bold;
        }

        .service-card input[type="radio"]:checked + .service-label:before {
            content: '✔';
            position: absolute;
            top: 5px;
            left: 5px;
            color: white;
            font-size: 1.2rem;
        }

        .service-options {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 10px;
        }

        .service-label {
            display: block;
            position: relative;
            font-size: 1rem;
            color: #333;
            cursor: pointer;
            text-align: center;
            border-radius: 10px;
            transition: background-color 0.3s ease;
        }

        .service-label img {
            width: 50px;
            height: 50px;
            margin-bottom: 10px;
        }

        .service-price {
            font-size: 0.9rem;
            color: #666;
        }

        @media (max-width: 900px) {
            .service-label img {
                display: none;
            }
        }

        .search-container {
            width: 95%;
            max-width: auto;
        }

        .input-group {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 30px;
        }

        .input-group input.form-control {
            border: none;
            border-radius: 30px;
            padding: 8px 15px;
            font-size: 1rem;
        }

        .input-group button {
            border-radius: 30px;
            background-color: #f1f1f1;
            border: none;
            padding: 8px 15px;
            font-size: 1rem;
            cursor: pointer;
        }

        .input-group button:hover {
            background-color: #e1e1e1;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 10px;
        }

        .btn-filter {
            background-color: #fff;
            color: #4e4e4e;
            padding: 8px 16px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .btn-filter:hover {
            background-color: #f1f1f1;
            color: #333;
        }

        .btn-group .active {
            background-color: #4c75f2;
            color: #fff;
            border-color: #4c75f2;
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

        <!-- Search Bar and Filter Buttons -->
        <div class="d-flex justify-content-between mb-3">
            <div class="input-group" style="width: 50%;">
                <input type="text" class="form-control" placeholder="Search by order ID or service..." id="orderSearch" />
                <button class="btn btn-secondary" id="searchButton">Search</button>
            </div>
            <div class="btn-group mt-3" style="width: 40%;">
                <button class="btn btn-filter active" id="allOrdersBtn">All Orders</button>
                <button class="btn btn-filter" id="activeOrdersBtn">Active</button>
                <button class="btn btn-filter" id="completedOrdersBtn">Completed</button>
            </div>
        </div>

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
                                <p><strong>Service:</strong> <%# Eval("ServiceType") %></p>
                                <p><strong>Total:</strong> $<%# Eval("TotalAmount") %></p>
                                <p><strong>Due Date:</strong> <%# Eval("PickupDate") %></p>
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

                    <div class="mb-3" id="pickupDateDiv" runat="server" style="display:o">
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
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your delivery address..." ReadONly="true"/>
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

        <script type="text/javascript">
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
    </div>
</asp:Content>
