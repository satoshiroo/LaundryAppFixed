<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Admin Messages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="messages.css" rel="stylesheet" />
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- ADMIN -->
    <asp:Panel ID="AdminPanel" runat="server" CssClass="admin-panel">
        <h3>ADMIN MESSAGES</h3>

        <div class="messages-container">

             <!-- LEFT: Customers List -->
            <div class="customer-list">
            <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control mb-3" placeholder=" Search Customers..."></asp:TextBox>          
                <div class="user-item">Steven Oliverio</div>
                <div class="user-item">Eric Jhosh</div>
                <div class="user-item">Diwata </div>
            </div>


            <!-- RIGHT: Chat Box -->
              <div class="chat-box">
            <div class="messages" id="adminMessages">
                 <asp:Literal ID="litAdminMessages" runat="server"></asp:Literal>
            </div>

                     <!-- Send message -->
                  <div class="message-input">
                      <asp:TextBox ID="txtAdminReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>
                      <asp:Button ID="btnAdminSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnAdminSend_Click" />
                  </div>  
        </div>
     </div>
            
    </asp:Panel>

    <!-- User -->
    <asp:Panel ID="UserPanel" runat="server" CssClass="admin-panel">
        <h3>CUSTOMER MESSAGES</h3>

        <div class="messages-container">


            <!-- RIGHT: Chat Box -->
              <div class="chat-box">
            <div class="messages" id="UserMessages">
                <asp:Literal ID="litUserMessages" runat="server"></asp:Literal>
            </div>

                     <!-- Send message -->
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
                box.scrollTop = box.scrollHeight;
            }
        </script>
</asp:Content> 