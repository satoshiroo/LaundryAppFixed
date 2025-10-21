<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="LaundryApp.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <div class="dashboard-container p-4">

        <h3 class="fw-bold mb-3">Welcome Back</h3>
        <p class="text-muted mb-4">Here's what's happening today</p>

        <!-- Dashboard Cards -->
        <div class="row g-3 mb-4">
            <div class="col-md-3">
                <div class="card stat-card shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-box-seam fs-3 text-primary mb-2"></i>
                        <h6>Today's Orders</h6>
                        <h4 class="fw-bold text-dark">0</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card stat-card shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-clock-history fs-3 text-primary mb-2"></i>
                        <h6>In Progress</h6>
                        <h4 class="fw-bold text-dark">5</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card stat-card shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-check2-circle fs-3 text-success mb-2"></i>
                        <h6>Ready for Pickup</h6>
                        <h4 class="fw-bold text-dark">0</h4>
                    </div>
                </div>
            </div>

            <div class="col-md-3">
                <div class="card stat-card shadow-sm">
                    <div class="card-body text-center">
                        <i class="bi bi-currency-dollar fs-3 text-success mb-2"></i>
                        <h6>Total Revenue</h6>
                        <h4 class="fw-bold text-dark">$300.50</h4>
                        <small class="text-success fw-semibold">↑ +12% this week</small>
                    </div>
                </div>
            </div>
        </div>

        <!-- Recent Orders Section -->
        <div class="row">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">Recent Orders</h5>

                        <div class="order-item d-flex justify-content-between align-items-center border-bottom py-2">
                            <div>
                                <h6 class="mb-0">Sarah Johnson</h6>
                                <small class="text-muted">+1 (555) 234-5678</small>
                            </div>
                            <span class="badge bg-warning text-dark">Drying</span>
                            <span class="fw-semibold">$45.50</span>
                        </div>

                        <div class="order-item d-flex justify-content-between align-items-center border-bottom py-2">
                            <div>
                                <h6 class="mb-0">Michael Chen</h6>
                                <small class="text-muted">+1 (555) 345-6789</small>
                            </div>
                            <span class="badge bg-info text-dark">Washing</span>
                            <span class="fw-semibold">$72.00</span>
                        </div>

                        <div class="order-item d-flex justify-content-between align-items-center border-bottom py-2">
                            <div>
                                <h6 class="mb-0">Emma Williams</h6>
                                <small class="text-muted">+1 (555) 456-7890</small>
                            </div>
                            <span class="badge bg-success">Ironing</span>
                            <span class="fw-semibold">$95.00</span>
                        </div>

                    </div>
                </div>
            </div>

            <!-- Order Status Section -->
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h5 class="fw-bold mb-3">Order Status</h5>

                        <div class="status-item mb-2">
                            <small>Received</small>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-secondary" style="width: 10%;"></div>
                            </div>
                        </div>

                        <div class="status-item mb-2">
                            <small>Washing</small>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-info" style="width: 40%;"></div>
                            </div>
                        </div>

                        <div class="status-item mb-2">
                            <small>Drying</small>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-warning" style="width: 20%;"></div>
                            </div>
                        </div>

                        <div class="status-item mb-2">
                            <small>Ironing</small>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-success" style="width: 20%;"></div>
                            </div>
                        </div>

                        <div class="status-item mb-2">
                            <small>Ready</small>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-primary" style="width: 0%;"></div>
                            </div>
                        </div>

                        <div class="status-item">
                            <small>Delivered</small>
                            <div class="progress" style="height: 8px;">
                                <div class="progress-bar bg-dark" style="width: 0%;"></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
