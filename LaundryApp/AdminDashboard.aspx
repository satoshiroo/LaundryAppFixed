<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="AdminDashboard.aspx.cs" Inherits="LaundryApp.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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

        <!-- Today's Orders -->
        <div class="col-sm-6 col-lg-3">
            <div class="dash-card shadow-sm p-4 rounded bg-white">
                <i class="bi bi-box fs-3 text-primary"></i>
                <h4 class="fw-bold mt-2 mb-0">0</h4>
                <small class="text-muted">Today's Orders</small>
            </div>
        </div>

        <!-- In Progress -->
        <div class="col-sm-6 col-lg-3">
            <div class="dash-card shadow-sm p-4 rounded bg-white">
                <i class="bi bi-clock fs-3 text-primary"></i>
                <h4 class="fw-bold mt-2 mb-0">5</h4>
                <small class="text-muted">In Progress</small>
            </div>
        </div>

        <!-- Ready -->
        <div class="col-sm-6 col-lg-3">
            <div class="dash-card shadow-sm p-4 rounded bg-white">
                <i class="bi bi-check2-circle fs-3 text-success"></i>
                <h4 class="fw-bold mt-2 mb-0">0</h4>
                <small class="text-muted">Ready for Pickup</small>
            </div>
        </div>

        <!-- Revenue -->
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

        <!-- Recent Orders -->
        <div class="col-lg-8">
            <div class="card shadow-sm p-4 rounded bg-white">
                <h5 class="fw-bold mb-3">Recent Orders</h5>

                <div class="order-item d-flex align-items-center justify-content-between mb-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="avatar-circle">S</div>
                        <div>
                            <strong>Sarah Johnson</strong><br>
                            <small class="text-muted">+1 (555) 234-5678 · Jan 3, 2025</small>
                        </div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-warning text-dark">drying</span>
                        <div class="fw-bold">$45.50</div>
                    </div>
                </div>

                <div class="order-item d-flex align-items-center justify-content-between mb-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="avatar-circle">M</div>
                        <div>
                            <strong>Michael Chen</strong><br>
                            <small class="text-muted">+1 (555) 345-6789 · Jan 2, 2025</small>
                        </div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-purple text-white">washing</span>
                        <div class="fw-bold">$72.00</div>
                    </div>
                </div>

                <div class="order-item d-flex align-items-center justify-content-between mb-3">
                    <div class="d-flex align-items-center gap-3">
                        <div class="avatar-circle bg-success">E</div>
                        <div>
                            <strong>Emma Williams</strong><br>
                            <small class="text-muted">+1 (555) 456-7890 · Jan 3, 2025</small>
                        </div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-warning text-dark">ironing</span>
                        <div class="fw-bold">$95.00</div>
                    </div>
                </div>

                <div class="order-item d-flex align-items-center justify-content-between">
                    <div class="d-flex align-items-center gap-3">
                        <div class="avatar-circle bg-info">D</div>
                        <div>
                            <strong>David Brown</strong><br>
                            <small class="text-muted">+1 (555) 567-8901 · Jan 3, 2025</small>
                        </div>
                    </div>
                    <div class="text-end">
                        <span class="badge bg-light text-dark">received</span>
                        <div class="fw-bold">$52.00</div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Order Status -->
        <div class="col-lg-4">
            <div class="card shadow-sm p-4 rounded bg-white">
                <h5 class="fw-bold mb-3">Order Status</h5>

                <div class="status-item mb-3">
                    <div class="d-flex justify-content-between mb-1">
                        <small>Received</small><small>1</small>
                    </div>
                    <div class="progress"><div class="progress-bar" style="width: 20%"></div></div>
                </div>

                <div class="status-item mb-3">
                    <div class="d-flex justify-content-between mb-1">
                        <small>Washing</small><small>2</small>
                    </div>
                    <div class="progress"><div class="progress-bar" style="width: 50%"></div></div>
                </div>

                <div class="status-item mb-3">
                    <div class="d-flex justify-content-between mb-1">
                        <small>Drying</small><small>1</small>
                    </div>
                    <div class="progress"><div class="progress-bar" style="width: 30%"></div></div>
                </div>

                <div class="status-item mb-3">
                    <div class="d-flex justify-content-between mb-1">
                        <small>Ironing</small><small>1</small>
                    </div>
                    <div class="progress"><div class="progress-bar" style="width: 25%"></div></div>
                </div>

                <div class="status-item mb-3">
                    <div class="d-flex justify-content-between mb-1">
                        <small>Ready</small><small>0</small>
                    </div>
                    <div class="progress"><div class="progress-bar" style="width: 0%"></div></div>
                </div>

                <div class="status-item">
                    <div class="d-flex justify-content-between mb-1">
                        <small>Delivered</small><small>0</small>
                    </div>
                    <div class="progress"><div class="progress-bar" style="width: 0%"></div></div>
                </div>
            </div>
        </div>
    </div>
</div>

</asp:Content>
