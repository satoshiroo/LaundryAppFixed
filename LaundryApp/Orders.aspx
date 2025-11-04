<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Orders.aspx.cs"
    Inherits="LaundryApp.Orders"
    MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Orders</h2>
    
    <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="true"
        BorderStyle="Solid" BorderWidth="1px" CellPadding="6">
    </asp:GridView>

    <br /><br />

    <label>Customer Name:</label><br />
    <asp:TextBox ID="txtCustomerName" runat="server" /><br /><br />

    <label>Contact:</label><br />
    <asp:TextBox ID="txtContact" runat="server" /><br /><br />

    <label>Total:</label><br />
    <asp:TextBox ID="txtTotal" runat="server" /><br /><br />

    <label>Status:</label><br />
    <asp:DropDownList ID="ddlStatus" runat="server">
        <asp:ListItem>Pending</asp:ListItem>
        <asp:ListItem>Completed</asp:ListItem>
    </asp:DropDownList>
    <br /><br />

    <asp:Button ID="btnAddOrder" runat="server" Text="Add Order" OnClick="btnAddOrder_Click" CssClass="btn btn-primary" />

</asp:Content>
