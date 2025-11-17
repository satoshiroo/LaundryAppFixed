<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LaundryApp.Inventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fc;
        }

        /* Card styling */
        .summary-card {
            border-radius: 10px;
            color: black;
            text-align: center;
            padding: 20px;
            font-weight: 100;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            background-color: white;
        }

        /* Inventory table */
        .inventory-card {
            border-radius: 10px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: 0.3s;
        }

        .inventory-header { height: 10px; }

        .table td, .table th {
            vertical-align: middle;
        }

        .btn-add-product {
            background-color: #0d6dfc;
            color: white;
            border-radius: 25px;
            padding: 6px 20px;
        }

        .btn-add-product:hover {
            background-color: #45a049;
            transition: background-color 0.3s ease;
        }

        .modal-header {
            background-color: #4caf50;
            color: white;
        }

        .modal-title {
            font-weight: bold;
        }

        /* Grid and table adjustments */
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
            <h3 class="fw-bold mb-1">Inventory</h3>
            <p class="text-muted">Manage and track all products and supplies</p>
        </div>

        <!-- Add Product Button -->
        <div class="d-flex justify-content-end mb-3">
            <button type="button" class="btn btn-add-product" data-bs-toggle="modal" data-bs-target="#AddProductModal">
                    <i class="bi bi-plus-lg me-1"></i> Add Product
            </button>
        </div>

        <!-- Inventory Table -->
        <div class="card shadow-sm border-0 inventory-card">
            <div class="card-body p-0">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table mb-0 align-middle text-center"
                    OnRowDeleting="GridView1_RowDeleting" 
                    OnRowEditing="GridView1_RowEditing" 
                    DataKeyNames="ProductID">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product" SortExpression="ProductName" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₱{0:F2}" SortExpression="Price" />
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    </Columns>
                    <HeaderStyle CssClass="bg-light fw-semibold" />
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Modal: Add Product -->
    <div class="modal fade" id="AddProductModal" tabindex="-1" aria-labelledby="AddProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-sm">
                <div class="modal-header">
                    <h5 class="modal-title" id="AddProductModalLabel">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Product Name</label>
                        <asp:TextBox ID="txtProductName" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Quantity</label>
                        <asp:TextBox ID="txtQuantity" CssClass="form-control" TextMode="Number" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Price</label>
                        <asp:TextBox ID="txtPrice" CssClass="form-control" TextMode="Number" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveProduct" runat="server" Text="Save" CssClass="btn btn-add-product text-white px-4" OnClick="btnSaveProduct_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
