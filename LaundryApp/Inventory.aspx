<%@ Page Title="Inventory" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="LaundryApp.Inventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Styles.css" rel="stylesheet" />
    <style>
        .inventory-container {
            padding: 20px;
        }

        .inventory-table {
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(132, 192, 198, 0.15);
            overflow: hidden;
        }

        .inventory-table thead {
            background-color: #84C0C6;
            color: #fff;
        }

        .inventory-table th, .inventory-table td {
            padding: 12px 16px;
            vertical-align: middle;
        }

        .btn-primary {
            background-color: #84C0C6;
            border: none;
        }

        .btn-primary:hover {
            background-color: #6baab0;
        }

        .modal-header {
            background-color: #84C0C6;
            color: #fff;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid inventory-container py-4 px-3 px-md-4 px-lg-5">
        <h3 class="fw-bold mb-1">Inventory</h3>
        <p class="text-muted mb-4">Manage all laundry products and supplies</p>

        <!-- === Top Bar === -->
        <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
            <div class="input-group w-auto">
                <span class="input-group-text bg-white border-end-0">
                    <i class="bi bi-search text-muted"></i>
                </span>
                <input type="text" class="form-control border-start-0" placeholder="Search product..." />
            </div>

            <asp:Button ID="btnAddProduct" runat="server" CssClass="btn btn-primary" Text="Add Product"
                OnClientClick="openAddModal(); return false;" />
        </div>

        <!-- === Inventory Table === -->
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="table-responsive inventory-table">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-hover align-middle mb-0" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="ProductID" HeaderText="ID" />
                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:Button runat="server" Text="Edit" CssClass="btn btn-sm btn-outline-primary me-1" />
                                    <asp:Button runat="server" Text="Delete" CssClass="btn btn-sm btn-danger" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <!-- === Add Product Modal === -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="mb-3">
                                <label for="txtProductName" class="form-label">Product Name</label>
                                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtQuantity" class="form-label">Quantity</label>
                                <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            </div>
                            <div class="mb-3">
                                <label for="txtPrice" class="form-label">Price</label>
                                <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" TextMode="Number"></asp:TextBox>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveProduct" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveProduct_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openAddModal() {
            var modal = new bootstrap.Modal(document.getElementById('addProductModal'));
            modal.show();
        }
    </script>
</asp:Content>
