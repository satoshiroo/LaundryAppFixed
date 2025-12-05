<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" 
    AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Messages</title>
    <!-- Bootstrap CSS for layout and styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Custom CSS for chat styling -->
    <link href="messages.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hidden field to store selected user ID (used by admin to know who they are chatting with) -->
    <asp:HiddenField ID="HiddenSelectedUser" runat="server" />

    <!-- ========================= ADMIN PANEL ========================= -->
    <asp:Panel ID="AdminPanel" runat="server" CssClass="admin-panel">
        <h3>ADMIN MESSAGES</h3>
        <div class="messages-container">

            <!-- Customer List -->
            <div class="customer-list">
                <!-- Search box for filtering customers -->
                <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control search-box" 
                             placeholder="Search Customers..." AutoPostBack="true" OnTextChanged="txtsearch_TextChanged"></asp:TextBox>

                <!-- Repeater to show all customers -->
                <asp:Repeater ID="rptUsers" runat="server">
                    <ItemTemplate>
                        <!-- Each customer is a clickable link to select user -->
                        <asp:LinkButton runat="server" CssClass="user-item"
                                        CommandArgument='<%# Eval("UserId") %>'
                                        OnClick="User_Click">
                            <%# Eval("Username") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Chat Box -->
            <div class="chat-box">
                <!-- Messages will appear here -->
                <div class="messages" id="chatMessages">
                    <asp:Literal ID="litMessages" runat="server"></asp:Literal>
                </div>

                <!-- Input area for admin to type message -->
                <div class="message-input d-flex gap-2">
                    <asp:TextBox ID="txtReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>
                    <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnSend_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- ========================= CUSTOMER PANEL ========================= -->
    <asp:Panel ID="UserPanel" runat="server" CssClass="admin-panel">
        <h3>CUSTOMER MESSAGES</h3>
        <div class="messages-container">

            <div class="chat-box">
                <!-- Messages will appear here -->
                <div class="messages" id="chatMessagesUser">
                    <asp:Literal ID="litUserMessages" runat="server"></asp:Literal>
                </div>

                <!-- Input area for customer to type message -->
                <div class="message-input d-flex align-items-center gap-2">
                    <asp:TextBox ID="txtUserReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>

                    <!-- FileUpload control for sending images (hidden) -->
                    <asp:FileUpload ID="FileUpload1" runat="server" Style="display:none;" />

                    <!-- Image icon to trigger file selection -->
                    <ion-icon name="image" id="btnUploadImage" style="cursor:pointer; font-size:30px;"></ion-icon>

                  
                    <!-- Send button -->

                    <asp:Button ID="btnUserSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnUserSend_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        // ================= Scroll chat to bottom automatically =================
        function scrollToBottom(id) {
            var box = document.getElementById(id);
            if (box) box.scrollTop = box.scrollHeight;
        }
        // Check every 500ms to keep scroll at bottom
        setInterval(function () {
            scrollToBottom('chatMessages');      // Admin chat
            scrollToBottom('chatMessagesUser');  // Customer chat
        }, 500);

        // ================= Image upload functionality =================
        const uploadIcon = document.getElementById('btnUploadImage'); // Image icon
        const fileUpload = document.getElementById('<%= FileUpload1.ClientID %>'); // Hidden FileUpload
        const sendBtn = document.getElementById('<%= btnUserSend.ClientID %>'); // Send button

        // Click image icon -> trigger file picker
        uploadIcon.addEventListener('click', function () {
            fileUpload.click();
        });

        // When a file is selected -> automatically click send
        fileUpload.addEventListener('change', function () {
            if (fileUpload.files.length > 0) {
                sendBtn.click();
            }
        });
    </script>

    <!-- Optional Ionicons library for icons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</asp:Content>
