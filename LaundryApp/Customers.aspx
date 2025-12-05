<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true"
    CodeBehind="Customers.aspx.cs" Inherits="LaundryApp.Customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
    <style>
        body { background-color: #c6f3ff; font-family: 'Segoe UI', sans-serif; }      
        .page-wrapper { padding: 30px; }
        .page-header h3 { color: #0ea5e9; font-weight: 700; }
        .page-header p { color: #0284c7; }
        .btn-add-customer {
            background-color: #0ea5e9 !important;
            color: white !important;
            border-radius: 50px;
            padding: 8px 22px;
            font-weight: 500;
            border: 1px solid #0ea5e9;
        }
        .btn-add-customer:hover {
            background-color: #0284c7 !important;
            border-color: #0284c7 !important;
            color: white !important;
        }
        .customer-card { border-radius: 12px; background: #fff; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .table-responsive { width: 100%; overflow-x: auto; }
        .table { width: 100% !important; border: none; margin-bottom: 0; }
        .table thead th { background-color: #bae6fd; color: #0c4a6e; font-weight: 600; border-bottom: 2px solid #7dd3fc; }
        .table tbody tr:hover { background-color: #f0f9ff; }
        .table td, .table th { padding: 14px 18px; vertical-align: middle; }
        .modal-content { border-radius: 12px; border: none; box-shadow: 0 4px 20px rgba(0,0,0,0.1); }
        .modal-header h5 { font-weight: 600; color: #0ea5e9; }
        .form-label { font-weight: 500; }
        .btn-sm { font-size: 0.85rem; padding: 0.25rem 0.5rem; }
        .btn-primary { background-color: #38bdf8; border-color: #38bdf8; }
        .btn-primary:hover { background-color: #0ea5e9; border-color: #0ea5e9; }
        .btn-success { background-color: #22c55e; border-color: #22c55e; }
        .btn-secondary { background-color: #94a3b8; border-color: #94a3b8; }
        @media (max-width: 768px) { .page-wrapper { padding: 20px; } }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-wrapper">
        <div class="mb-4 page-header">
            <h3>Customers</h3>
            <p>Manage and track all customer data</p>
        </div>

        <div class="d-flex justify-content-end mb-3">
            <button type="button" class="btn btn-add-customer" data-bs-toggle="modal" data-bs-target="#AddCustomerModal">
                <i class="bi bi-plus-lg me-1"></i> Add Customer
            </button>
        </div>

        <div class="card shadow-sm border-0 customer-card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="CustomerTable" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-striped table-hover mb-0 align-middle text-center"
                        OnRowDeleting="CustomerTable_RowDeleting"
                        OnRowEditing="CustomerTable_RowEditing"
                        OnRowUpdating="CustomerTable_RowUpdating"
                        OnRowCancelingEdit="CustomerTable_RowCancelingEdit"
                        OnRowDataBound="CustomerTable_RowDataBound"
                        DataKeyNames="UserID"
                        Width="100%" OnSelectedIndexChanged="CustomerTable_SelectedIndexChanged">

                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />

                            <asp:TemplateField HeaderText="Full Name">
                                <ItemTemplate><%# Eval("FullName") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditFullName" runat="server" Text='<%# Bind("FullName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Contact Number">
                                <ItemTemplate><%# Eval("ContactNumber") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditContact" runat="server" Text='<%# Bind("ContactNumber") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate><%# Eval("Address") %></ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditAddress" runat="server" Text='<%# Bind("Address") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CssClass="btn btn-sm btn-primary me-1">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete" CssClass="btn btn-sm btn-danger">Delete</asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update" CssClass="btn btn-sm btn-success me-1">Update</asp:LinkButton>
                                    <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel" CssClass="btn btn-sm btn-secondary">Cancel</asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="fw-semibold" />
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="AddCustomerModal" tabindex="-1" aria-labelledby="AddCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="AddCustomerModalLabel">Add New Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox ID="txtFullName" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Contact Number</label>
                        <asp:TextBox ID="txtContactNumber" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Address</label>
                        <asp:TextBox ID="txtAddress" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveCustomer" runat="server" Text="Save"
                        CssClass="btn btn-add-customer text-white px-4"
                        OnClick="btnSaveCustomer_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>