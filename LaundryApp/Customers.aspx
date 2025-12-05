<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" 
    CodeBehind="Customers.aspx.cs" Inherits="LaundryApp.Customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fc;
        }

        /* Card styling */
        .customer-card {
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: 0.3s;
        }

        .customer-header { height: 10px; }

        .table td, .table th {
            vertical-align: middle;
        }

        .btn-add-customer {
            background-color: #0d6dfc;
            color: white;
            border-radius: 25px;
            padding: 6px 20px;
        }

        .btn-add-customer:hover {
            background-color: #45a049;
            transition: background-color 0.3s ease;
        }

        .table thead th {
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #f0f0f0;
        }

        .table tbody tr:hover {
            background-color: #f5f5f5;
        }

        .table th, .table td {
            padding: 12px 15px;
        }

        @media (max-width: 768px) {
            .page-wrapper {
                padding: 25px 20px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-wrapper">
        <!-- Header Section -->
        <div class="mb-4">
            <h3 class="fw-bold mb-1">Customers</h3>
            <p class="text-muted">Manage and track all customer data</p>
        </div>

        <!-- Add Customer Button -->
        <div class="d-flex justify-content-end mb-3">
            <button type="button" class="btn btn-add-customer" data-bs-toggle="modal" data-bs-target="#AddCustomerModal">
                <i class="bi bi-plus-lg me-1"></i> Add Customer
            </button>
        </div>

        <!-- Customers Table -->
        <div class="card shadow-sm border-0 customer-card">
            <div class="card-body p-0">
                <asp:GridView ID="CustomerTable" runat="server" AutoGenerateColumns="False" CssClass="table mb-0 align-middle text-center"
                    OnRowDeleting="CustomerTable_RowDeleting" OnRowEditing="CustomerTable_RowEditing" DataKeyNames="UserID">
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" SortExpression="UserID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="ContactNumber" HeaderText="Contact Number" SortExpression="ContactNumber" />
                        <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    </Columns>
                    <HeaderStyle CssClass="bg-light fw-semibold" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Modal: Add Customer -->
    <div class="modal fade" id="AddCustomerModal" tabindex="-1" aria-labelledby="AddCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-sm">
                <div class="modal-header">
                    <h5 class="modal-title" id="AddCustomerModalLabel">Add New Customer</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">First Name</label>
                        <asp:TextBox ID="txtFirstName" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Last Name</label>
                        <asp:TextBox ID="txtLastName" CssClass="form-control" runat="server" />
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
                    <asp:Button ID="btnSaveCustomer" runat="server" Text="Save" CssClass="btn btn-add-customer text-white px-4" OnClick="btnSaveCustomer_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>