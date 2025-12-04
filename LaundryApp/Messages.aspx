<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Messages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="messages.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Admin Panel -->
    <asp:Panel ID="AdminPanel" runat="server" CssClass="admin-panel">
        <h3>ADMIN MESSAGES</h3>
        <div class="messages-container">
            <!-- LEFT: Customers List -->
            <div class="customer-list">
                <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control search-box" placeholder="Search Customers..."></asp:TextBox>
                <asp:Repeater ID="rptUsers" runat="server">
                    <ItemTemplate>
                        <div class="user-item" data-userid='<%# Eval("UserId") %>'>
                            <%# Eval("Username") %>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- RIGHT: Chat Box -->
            <div class="chat-box">
                <div class="messages" id="chatMessages">
                    <asp:Literal ID="litMessages" runat="server"></asp:Literal>
                </div>
                <div class="message-input">
                    <asp:TextBox ID="txtReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>
                    <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnSend_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- Customer Panel -->
    <asp:Panel ID="UserPanel" runat="server" CssClass="admin-panel">
        <h3>CUSTOMER MESSAGES</h3>
        <div class="messages-container">
            <div class="chat-box">
                <div class="messages" id="chatMessagesUser">
                    <asp:Literal ID="litUserMessages" runat="server"></asp:Literal>
                </div>
                <div class="message-input">
                    <asp:TextBox ID="txtUserReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>
                    <asp:Button ID="btnUserSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnUserSend_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        function scrollToBottom(id) {
            var box = document.getElementById(id);
            if (box) box.scrollTop = box.scrollHeight;
        }
    </script>
</asp:Content>
