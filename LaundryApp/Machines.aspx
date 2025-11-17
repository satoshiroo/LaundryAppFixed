<%@ Page Title="Machines" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="Machines.aspx.cs" Inherits="LaundryApp.Machines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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

        /* Main toolbar card (search + filters are together, like your screenshot) */
        .toolbar-card {
            border-radius: 14px;
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(15, 23, 42, 0.06);
            padding: 16px 18px;
        }

        .toolbar-search input {
            border: none;
            box-shadow: none;
        }

        .toolbar-search .input-group-text {
            background: transparent;
            border: none;
        }

        .toolbar-search .form-control:focus {
            box-shadow: none;
        }

        .filter-pill {
            font-size: 0.85rem;
            border-radius: 999px;
            padding: 6px 14px;
            border: 1px solid #e5e7eb;
            background: #ffffff;
            color: #4b5563;
            margin-left: 6px;
        }

        .filter-pill.active {
            background: #0d6efd;
            color: #ffffff;
            border-color: #0d6efd;
        }

        /* Machine cards (keep size but make them modern) */
        .machine-card {
            border-radius: 14px;
            background: #ffffff;
            box-shadow: 0 2px 10px rgba(15, 23, 42, 0.08);
            overflow: hidden;
            cursor: pointer;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .machine-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.15);
        }

        .machine-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 16px;
            border-bottom: 1px solid #e5e7eb;
        }

        .machine-title {
            font-weight: 600;
            font-size: 1rem;
            margin: 0;
        }

        .machine-tag {
            font-size: 0.7rem;
            border-radius: 999px;
            padding: 4px 10px;
            background: #e5e7eb;
            color: #374151;
            text-transform: uppercase;
            letter-spacing: .04em;
        }

        .status-available {
            color: #16a34a;
            font-weight: 600;
        }

        .status-inuse {
            color: #0d6efd;
            font-weight: 600;
        }

        .status-maintenance {
            color: #f59e0b;
            font-weight: 600;
        }

        .machine-card-body {
            padding: 12px 16px 16px 16px;
            font-size: 0.9rem;
            color: #4b5563;
        }
        #btnSearch {
        background-color: #0d6efd; /* Blue background */
        color: white; /* White text color */
        border: 1px solid #0d6efd; /* Blue border */
    }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">
        <!-- Page title + Add button, like “All Orders / New Order” -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <h2 class="fw-bold mb-0">Machines</h2>
                <small class="text-muted">Manage and monitor all laundry machines.</small>
            </div>
            <button type="button" class="btn btn-primary rounded-pill px-4"
                    data-bs-toggle="modal" data-bs-target="#addMachineModal">
                <i class="bi bi-plus-lg me-1"></i> Add Machine
            </button>
        </div>

        <!-- Summary cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3 mb-md-0">
                <div class="summary-card">
                    <h5>Total Machines</h5>
                    <h3><asp:Label ID="lblTotalMachines" runat="server" Text="0" /></h3>
                </div>
            </div>
            <div class="col-md-3 mb-3 mb-md-0">
                <div class="summary-card">
                    <h5>Available</h5>
                    <h3><asp:Label ID="lblAvailable" runat="server" Text="0" /></h3>
                </div>
            </div>
            <div class="col-md-3 mb-3 mb-md-0">
                <div class="summary-card">
                    <h5>In Use</h5>
                    <h3><asp:Label ID="lblInUse" runat="server" Text="0" /></h3>
                </div>
            </div>
            <div class="col-md-3">
                <div class="summary-card">
                    <h5>Maintenance</h5>
                    <h3><asp:Label ID="lblMaintenance" runat="server" Text="0" /></h3>
                </div>
            </div>
        </div>

        <!-- Toolbar card = search + filters (like your screenshot) -->
        <div class="toolbar-card mb-4">
            <div class="d-flex flex-column flex-lg-row align-items-lg-center justify-content-between gap-3">
                <!-- Search -->
                <div class="flex-grow-1 toolbar-search">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-search"></i>
                        </span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                            placeholder="Search machines by name or type..." />
                        <asp:Button ID="btnSearch" runat="server" Text="Search"
                            CssClass="btn btn-outline-secondary"
                            OnClick="btnSearch_Click" />
                    </div>
                </div>

                <!-- Type filters -->
                <div class="d-flex align-items-center ms-lg-3">
                    <button type="button" class="filter-pill active" onclick="filterMachines('All', this)">All</button>
                    <button type="button" class="filter-pill" onclick="filterMachines('Washer', this)">Washer</button>
                    <button type="button" class="filter-pill" onclick="filterMachines('Dryer', this)">Dryer</button>
                    <button type="button" class="filter-pill" onclick="filterMachines('Press', this)">Press</button>
                    <button type="button" class="filter-pill" onclick="filterMachines('Folder', this)">Folder</button>
                </div>
            </div>
        </div>

        <!-- Machines cards -->
        <div class="row">
            <asp:Repeater ID="rptMachines" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="machine-card"
                             data-type="<%# Eval("Type") %>"
                             onclick="openEditModal('<%# Eval("MachineID") %>',
                                                    '<%# Eval("Name") %>',
                                                    '<%# Eval("Status") %>')">
                            <div class="machine-card-header">
                                <h5 class="machine-title mb-0"><%# Eval("Name") %></h5>
                                <span class="machine-tag"><%# Eval("Type") %></span>
                            </div>
                            <div class="machine-card-body">
                                <p class="mb-1">
                                    <strong>Status:</strong>
                                    <span class='<%# GetStatusCss(Eval("Status").ToString()) %>'>
                                        <%# Eval("Status") %>
                                    </span>
                                </p>
                                <p class="mb-0">
                                    <strong>Usage:</strong> <%# Eval("UsageCount") %> cycles
                                </p>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- ADD MACHINE MODAL -->
        <div class="modal fade" id="addMachineModal" tabindex="-1" aria-labelledby="addMachineLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title" id="addMachineLabel">Add Machine</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label">Machine Name</label>
                            <asp:TextBox ID="txtMachineName" runat="server" CssClass="form-control" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Type</label>
                            <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Washer" Value="Washer" />
                                <asp:ListItem Text="Dryer" Value="Dryer" />
                                <asp:ListItem Text="Press" Value="Press" />
                                <asp:ListItem Text="Folder" Value="Folder" />
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Status</label>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Available" Value="Available" />
                                <asp:ListItem Text="In Use" Value="In Use" />
                                <asp:ListItem Text="Maintenance" Value="Maintenance" />
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="btnSaveMachine" runat="server" Text="Add Machine"
                            CssClass="btn btn-primary" OnClick="btnSaveMachine_Click" />
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- EDIT MACHINE MODAL -->
        <div class="modal fade" id="editMachineModal" tabindex="-1" aria-labelledby="editMachineLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="editMachineLabel">Edit Machine</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <asp:HiddenField ID="hiddenEditMachineIdModal" runat="server" />

                <div class="mb-3">
                  <label class="form-label fw-bold">Machine Name</label>
                  <asp:TextBox ID="txtEditMachineName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>

                <div class="mb-3">
                  <label class="form-label fw-bold">Status</label>
                  <asp:DropDownList ID="ddlEditStatusModal" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
                    <asp:ListItem Text="In Use" Value="In Use"></asp:ListItem>
                    <asp:ListItem Text="Maintenance" Value="Maintenance"></asp:ListItem>
                  </asp:DropDownList>
                </div>
              </div>
              <div class="modal-footer">
                <asp:Button ID="btnUpdateMachine" runat="server" Text="Update"
                    CssClass="btn btn-success" OnClick="btnUpdateMachine_Click" />
                <asp:Button ID="btnDeleteMachine" runat="server" Text="Delete"
                    CssClass="btn btn-danger" OnClick="btnDeleteMachine_Click" />
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
              </div>
            </div>
          </div>
        </div>
    </div>

    <script>
        function openEditModal(machineId, machineName, currentStatus) {
            document.getElementById('<%= hiddenEditMachineIdModal.ClientID %>').value = machineId;
            document.getElementById('<%= txtEditMachineName.ClientID %>').value = machineName;
            document.getElementById('<%= ddlEditStatusModal.ClientID %>').value = currentStatus;

            var modal = new bootstrap.Modal(document.getElementById('editMachineModal'));
            modal.show();
        }

        function filterMachines(type, btn) {
            // UI active pill
            document.querySelectorAll('.filter-pill').forEach(b => b.classList.remove('active'));
            if (btn) btn.classList.add('active');

            var filterType = type.toLowerCase();
            document.querySelectorAll('.machine-card').forEach(card => {
                var t = (card.getAttribute('data-type') || '').trim().toLowerCase();
                card.parentElement.style.display =
                    (filterType === 'all' || t === filterType) ? '' : 'none';
            });
        }
    </script>
</asp:Content>
