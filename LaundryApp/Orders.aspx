<%@ Page Title="Orders" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="LaundryApp.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Bootstrap container -->
    <div class="container mt-4">

        <div class="d-flex justify-content-between align-items-center mb-3">
            <h4 class="fw-bold text-primary">Orders</h4>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#AddOrderModal">
                <i class="bi bi-plus-circle"></i> New Order
            </button>
        </div>

        <!-- Orders Table (Repeater) -->
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead class="table-light">
                    <tr>
                        <th>Order #</th>
                        <th>Customer</th>
                        <th>Contact</th>
                        <th>Status</th>
                        <th>Total</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="RepeaterOrders" runat="server" OnItemCommand="RepeaterOrders_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("OrderID") %></td>
                                <td><%# Eval("CustomerName") %></td>
                                <td><%# Eval("Contact") %></td>
                                <td>
                                    <span class="badge bg-info text-dark"><%# Eval("Status") %></span>
                                </td>
                                <td>$<%# Eval("Total", "{0:F2}") %></td>
                                <td><%# ((DateTime)Eval("OrderDate")).ToString("MM/dd/yyyy") %></td>
                                <td>
                                    <asp:LinkButton runat="server" CommandName="DeleteOrder" CommandArgument='<%# Eval("OrderID") %>'
                                        CssClass="btn btn-sm btn-outline-danger">
                                        <i class="bi bi-trash"></i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>
        </div>

    </div>

    <!-- Modal: Add New Order -->
    <div class="modal fade" id="AddOrderModal" tabindex="-1" aria-labelledby="AddOrderModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="AddOrderModalLabel">Add New Order</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Customer Name</label>
                        <asp:TextBox ID="txtCustomerName" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Contact</label>
                        <asp:TextBox ID="txtContact" CssClass="form-control" runat="server" />
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Status</label>
                        <asp:DropDownList ID="ddlStatus" CssClass="form-select" runat="server">
                            <asp:ListItem>Pending</asp:ListItem>
                            <asp:ListItem>Washing</asp:ListItem>
                            <asp:ListItem>Drying</asp:ListItem>
                            <asp:ListItem>Ironing</asp:ListItem>
                            <asp:ListItem>Completed</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Total Amount</label>
                        <asp:TextBox ID="txtTotal" CssClass="form-control" runat="server" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnSaveOrder" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnSaveOrder_Click" />
                </div>
            </div>
        </div>
    </div>

</asp:Content>
