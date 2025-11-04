<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LaundryApp.Inventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- You can put custom page-level CSS here if needed -->
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
            <button type="button" class="btn btn-info text-white" data-bs-toggle="modal" data-bs-target="#AddProductModal">
                <i class="bi bi-plus-circle me-1"></i> Add Product
            </button>
        </div>

        <!-- Inventory Table -->
        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table mb-0 align-middle text-center">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" />
                        <asp:BoundField DataField="ProductName" HeaderText="Product" />
                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="${0:F2}" />
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
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold" id="AddProductModalLabel">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Product Name</label>
                        <asp:TextBox ID="txtProductName" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Quantity</label>
                        <asp:TextBox ID="txtQuantity" CssClass="form-control" TextMode="Number" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Price</label>
                        <asp:TextBox ID="txtPrice" CssClass="form-control" TextMode="Number" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveProduct" runat="server" Text="Save" CssClass="btn btn-info text-white px-4" OnClick="btnSaveProduct_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Page-Specific Styling -->
    <style>
        .page-wrapper {
            padding: 40px 30px;
            background-color: #f8f9fa;
            min-height: 100vh;
        }

        .card {
            border-radius: 12px;
        }

        .table thead th {
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #f0f0f0;
        }

        @media (max-width: 768px) {
            .page-wrapper {
                padding: 25px 20px;
            }
        }
    </style>

</asp:Content>
