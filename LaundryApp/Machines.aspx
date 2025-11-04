<%@ Page Title="Machines" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="Machines.aspx.cs" Inherits="LaundryApp.Machines" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .machine-card {
            border-left: 6px solid #0d6efd;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .machine-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .border-washer { border-left-color: #0d6efd; }
        .border-dryer { border-left-color: #ffc107; }
        .border-press { border-left-color: #198754; }
        .border-folder { border-left-color: #dc3545; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold"><i class="bi bi-gear"></i> Machines</h2>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addMachineModal">
                <i class="bi bi-plus-lg"></i> Add Machine
            </button>
        </div>

        <!-- Search -->
        <div class="input-group mb-4">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by name or type..." />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline-primary" OnClick="btnSearch_Click" />
        </div>

        <!-- Machines list -->
        <div class="row">
            <asp:Repeater ID="rptMachines" runat="server" OnItemCommand="rptMachines_ItemCommand">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class='card machine-card <%# GetBorderColor(Eval("Type").ToString()) %>'>
                            <div class="card-body">
                                <h5 class="fw-bold"><%# Eval("Name") %></h5>
                                <p class="mb-2">
                                    <strong>Type:</strong> <%# Eval("Type") %><br />
                                    <strong>Status:</strong> <%# Eval("Status") %><br />
                                    <strong>Usage:</strong> <%# Eval("UsageCount") %>
                                </p>
                                <div class="d-flex justify-content-between">
                                    <button type="button"
                                            class="btn btn-sm btn-outline-success"
                                            onclick="openEditModal('<%# Eval("MachineID") %>', '<%# Eval("Status") %>')">
                                        <i class="bi bi-pencil"></i> Edit
                                    </button>

                                    <asp:LinkButton ID="btnDelete" runat="server"
                                        CommandName="Delete"
                                        CommandArgument='<%# Eval("MachineID") %>'
                                        CssClass="btn btn-sm btn-outline-danger"
                                        OnClientClick="return confirm('Delete this machine?');">
                                        <i class="bi bi-trash"></i> Delete
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- Add Machine Modal -->
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
                    <asp:Button ID="btnSaveMachine" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnSaveMachine_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title" id="editModalLabel">Edit Machine Status</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hiddenEditMachineId" runat="server" />
                    <div class="mb-3">
                        <label class="form-label">Select Status</label>
                        <asp:DropDownList ID="ddlEditStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Available" Value="Available" />
                            <asp:ListItem Text="In Use" Value="In Use" />
                            <asp:ListItem Text="Maintenance" Value="Maintenance" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" CssClass="btn btn-success" OnClick="btnUpdateStatus_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openEditModal(id, currentStatus) {
            // set the hidden field value
            document.getElementById('<%= hiddenEditMachineId.ClientID %>').value = id;
            // set dropdown to current value
            document.getElementById('<%= ddlEditStatus.ClientID %>').value = currentStatus;
            // show modal
            var modal = new bootstrap.Modal(document.getElementById('editModal'));
            modal.show();
        }
    </script>

    <script>
        function openEditModal(id, currentStatus) {
            const hiddenId = document.getElementById('<%= hiddenEditMachineId.ClientID %>');
            const ddlStatus = document.getElementById('<%= ddlEditStatus.ClientID %>');

            if (hiddenId && ddlStatus) {
                hiddenId.value = id;
                ddlStatus.value = currentStatus;
            } else {
                console.error('Modal elements not found');
            }

            const modalEl = document.getElementById('editModal');
            const modal = new bootstrap.Modal(modalEl);
            modal.show();
        }
    </script>
</asp:Content>
