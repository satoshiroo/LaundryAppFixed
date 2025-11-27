<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Admin Messages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="messages.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ADMIN -->
    <asp:Panel ID="AdminPanel" runat="server" Visible="true" CssClass="admin-panel">
        <h3>ADMIN MESSAGES</h3>

        <div class="messages-container">

             <!-- LEFT: Customers List -->
            <div class="customer-list">
            <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control mb-3" placeholder=" search mo sa google sulasok..."></asp:TextBox>          
                <div class="user-item">Steven Oliverio</div>
                <div class="user-item">Eric Jhosh</div>
                <div class="user-item">Diwata </div>
            </div>

            <!-- RIGHT: Chat Box -->
              <div class="chat-box">
            <div class="messages" id="adminMessages">
                <div class="message admin">Hello! How can I help?</div>
                <div class="message user">Hi, I need help with my laundry.</div>
            </div>

                     <!-- Send message -->
                  <div class="message-input">
                      <asp:TextBox ID="txtAdminReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>
                      <asp:Button ID="btnAdminSend" runat="server" CssClass="btn btn-primary" />
                  </div>  
        </div>
    </asp:Panel>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
</asp:Content> 