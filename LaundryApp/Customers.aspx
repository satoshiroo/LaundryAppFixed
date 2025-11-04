<%@ Page Title="Customers" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="LaundryApp.Customers" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-4">
    <h3>Customer Management</h3><hr />

    <div class="row">
        <div class="col-md-4">
            <label>Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox><br />

            <label>Contact</label>
            <asp:TextBox ID="txtContact" runat="server" CssClass="form-control"></asp:TextBox><br />

            <label>Address</label>
            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox><br />

            <asp:Button ID="btnAdd" runat="server" Text="Add Customer"
                CssClass="btn btn-primary" OnClick="btnAdd_Click" />
        </div>

        <div class="col-md-8">
            <h5>Customer List</h5>
            <asp:GridView ID="GridCustomers" runat="server" AutoGenerateColumns="false"
                CssClass="table table-bordered" OnRowDeleting="GridCustomers_RowDeleting">

                <Columns>
                    <asp:BoundField DataField="CustomerID" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Contact" HeaderText="Contact" />
                    <asp:BoundField DataField="Address" HeaderText="Address" />

                    <asp:CommandField ShowDeleteButton="true" HeaderText="Action"
                        DeleteText="Delete" />
                </Columns>

            </asp:GridView>
        </div>
    </div>
</div>

</asp:Content>
