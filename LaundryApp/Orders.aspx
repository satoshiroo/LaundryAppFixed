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
    width: 120px;
    text-align: center;
    display: inline-block;
}

.filter-pill.active {
    background: #0d6efd;
    color: #ffffff;
    border-color: #0d6efd;
}

/* Input Group */
.input-group {
    display: flex;
    align-items: center;
    border: 1px solid #ddd;
    border-radius: 30px;
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
}

.input-group input.form-control {
    border: none;
    border-radius: 30px;
    padding: 8px 15px;
    font-size: 1rem;
    flex-grow: 1;
}

.input-group button {
    border-radius: 30px;
    background-color: #f1f1f1;
    border: none;
    padding: 8px 15px;
    font-size: 1rem;
    cursor: pointer;
    margin-left: 10px;
}   
@media (max-width: 480px) {
    .service-card {
        width: 100%; /* Full width for cards on very small screens */
        margin-bottom: 10px; /* Space between cards */
    }
}
/* Mobile View Adjustments */
@media (max-width: 768px) {
    .summary-card {
        display: none;
    }

    .input-group {
        width: 100%;
    }

    .input-group button {
        width: 25%;
    }

    .input-group select,
    .input-group input.form-control {
        width: 75%;
        border-radius: 30px;
    }

    /* Show dropdown filter only on mobile */
    .d-none.d-md-flex {
        display: none !important;
    }
    .modal-dialog{
        max-width: 90% !important;
        width: 100%;
    }
    .service-card{
        width: 100%;
    }
}

/* Mobile responsive styles */
@media (max-width: 900px) {
    .d-md-none {
        display: block;
    }

    .d-md-block {
        display: none;
    }

    .input-group {
        width: 100%;
    }

    .input-group input.form-control {
        width: 80%;
    }

    .input-group button {
        width: 18%;
    }

    .row.mb-4 {
        display: none !important;
    }
}

/* Modal Styling */
.modal-dialog {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* Center the modal */
    max-width: 90%; /* Optional: You can adjust the max-width */
    width: 100%; /* Make sure modal takes full width */
}

.modal {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh; /* Full viewport height */
    padding: 0;
}

.modal-body {
    padding: 1rem;
}

.modal-body .form-control,
.modal-body .form-select {
    width: 100%;
    margin-bottom: 1rem;
}

.modal-footer {
    display: flex;
    justify-content: flex-end;
}

/* Service Card Styles */
.service-card {
    border: 2px solid #ccc;
    border-radius: 8px;
    padding: 16px;
    margin: 10px;
    display: inline-block;
    width: calc(25% - 20px);
    text-align: center;
    background-color: #fff;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.15);
}

/* Service Label and Price */
.service-label {
    display: block;
    padding: 10px;
    font-size: 16px;
    color: #333;
}

.service-price {
    font-size: 14px;
    color: #777;
    margin-top: 8px;
}

input[type="radio"] {
    display: none;
}

input[type="radio"]:checked + .service-label {
    border: 2px solid #007bff;
    background-color: #e6f7ff;
}

.service-options {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    margin-top: 20px;
}

.service-label img {
    width: 60px;
    height: 60px;
    margin-bottom: 10px;
}

.service-label div {
    text-align: center;
    font-size: 0.9rem;
    color: #333;
}

/* Mobile Responsiveness */
@media (max-width: 768px) {
    .service-card {
        width: 100%;
        margin: 10px 0;
        padding: 20px;
        text-align: center;
    }

    .service-label img {
        width: 50px;
        height: 50px;
    }
}

@media (max-width: 480px) {
    .service-card {
        width: 100%;
    }
}

/* Add Flexbox to each individual card container */
.col-md-4 {
    display: 0 0 33%;
    margin-bottom: 20px;
    display: flex;
    justify-content: center;
}

/* Center the card content */
.order-card {
    width: 100%;
    max-width: 100%;
    margin: 0 auto;
    padding: 10px 0px;
    background-color: #fff;
    border-radius: 20px;
    border: 2px solid #ccc;
}

button.order-card-link {
    width: 100%;
    display: flex;
    justify-content: center;
    padding: 0;
    border-radius: 20px;
    border: none;
}

button.order-card-link:hover, button.order-card-link:focus {
    background-color: #f0f0f0;
}

/* Order Card Header */
.order-card-header {
    font-weight: bold;
    margin-bottom: 10px;
}

.order-card-body p {
    font-size: 1rem;
    color: #333;
}

.order-title {
    font-size: 1.2rem;
    color: #000;
}

@media (max-width: 768px) {
    .col-md-4 {
        flex: 0 0 100%;
    }
}

/* Status Text Color */
.status-pending {
    color: #FF930F;
}

.status-progress {
    color: #1E90FF;
}

.status-completed {
    color: #32CD32;
}

/* Hide link button if card is hidden */
.order-card[style="display: none;"] .order-card-link {
    display: none;
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
            <div class="row" id="orderCards">
                <asp:Repeater ID="rptOrders" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4 mb-4">
                            <!-- Add a button to open modal for payment selection -->
                            <button type="button" class="order-card-link" data-bs-toggle="modal" data-bs-target="#paymentModal" data-orderid="<%# Eval("OrderID") %>">
                                <div class="order-card">
                                    <div class="order-card-header">
                                        <span class="order-status 
                                            <%# Eval("Status").ToString() == "Pending" ? "status-pending" : 
                                                (Eval("Status").ToString() == "In Progress" ? "status-progress" : 
                                                (Eval("Status").ToString() == "Completed" ? "status-completed" : "")) %>">
                                            <%# Eval("Status") %>
                                        </span>
                                    </div>
                                    <div class="order-card-body">
                                        <%# Eval("ServiceType") != DBNull.Value ? Eval("ServiceType") : "N/A" %></p>
                                        <p><strong>Total:</strong> ₱<%# Eval("TotalAmount") != DBNull.Value ? Convert.ToDecimal(Eval("TotalAmount")).ToString("N2") : "0.00" %></p>
                                        <p><strong>Due Date:</strong> <%# Eval("DueDate") != DBNull.Value ? Eval("DueDate") : "Not Provided" %></p>
                                    </div>
                                </div>
                            </button>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

        <!-- Payment Selection Modal -->
        <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="paymentModalLabel">Select Payment Method</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Payment Options -->
                        <form>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="Credit Card">
                                <label class="form-check-label" for="creditCard">
                                    Credit Card
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="Paypal">
                                <label class="form-check-label" for="paypal">
                                    Paypal
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="paymentMethod" id="bankTransfer" value="Bank Transfer">
                                <label class="form-check-label" for="bankTransfer">
                                    Bank Transfer
                                </label>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="submitPaymentMethod">Submit</button>
                    </div>
                </div>
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

        document.addEventListener('DOMContentLoaded', function () {
            var selectedValue = document.getElementById('<%= ddlPickupDelivery.ClientID %>').value;
            if (selectedValue === 'Pickup') {
                document.getElementById('<%= pickupDateDiv.ClientID %>').style.display = 'block';
            } else if (selectedValue === 'Delivery') {
                document.getElementById('<%= deliveryAddressDiv.ClientID %>').style.display = 'block';
            }
        });

        var paymentModal = document.getElementById('paymentModal');
        paymentModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            var orderID = button.getAttribute('data-orderid');
            console.log("Selected OrderID: " + orderID);
        });

        function filterOrders(status, button) {
            // Get all the order cards
            const orderCards = document.querySelectorAll('.order-card');

            // Get all filter buttons to reset their active states
            const filterButtons = document.querySelectorAll('.filter-pill');

            // Remove 'active' class from all filter buttons
            filterButtons.forEach(btn => btn.classList.remove('active'));

            // Add 'active' class to the clicked button
            button.classList.add('active');

            // Loop through each order card and filter them based on the status
            orderCards.forEach(card => {
                const orderStatus = card.querySelector('.order-status').textContent.trim(); // Get the status of the order

                // Show cards that match the filter criteria
                if (status === 'All' || orderStatus === status) {
                    card.style.display = 'block';  // Show the card
                } else {
                    card.style.display = 'none';   // Hide the card if it doesn't match
                }
            });
        }

    </script>
</asp:Content>
