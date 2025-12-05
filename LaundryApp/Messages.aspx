<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" 
    AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Messages</title>
    <!-- Bootstrap CSS for layout and styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Custom CSS for chat styling -->
    <link href="messages.css" rel="stylesheet" />
    <style>
        /* --------------------------- */
/* Admin Panel & Layout */
/* --------------------------- */
.admin-panel {
    font-family: 'Segoe UI', sans-serif;
}

.messages-container {
    display: flex;
    gap: 20px;
    padding: 20px;
    background: #f0f2f5;
    min-height: 90vh;
}

.customer-list {
    width: 300px;
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    height: 80vh;
    padding: 20px;
}

.search-box {
    position: sticky;
    top: 0;
    z-index: 10;
    margin-bottom: 10px;
    padding: 10px;
}

.user-item {
    padding: 10px 15px;
    border-radius: 12px;
    margin: 5px;
    cursor: pointer;
    transition: 0.2s;
}

    .user-item:hover,
    .user-item.active {
        background: #1877f2;
        color: #fff;
    }

/* --------------------------- */
/* Chat Box */
/* --------------------------- */
.chat-box {
    flex-grow: 1;
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    display: flex;
    flex-direction: column;
    padding: 15px;
    height: 80vh;
}

.messages {
    flex-grow: 1;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
    gap: 10px;
    padding-right: 5px;
}

/* --------------------------- */
/* Messages Styling - Messenger Style */
/* --------------------------- */
.message {
    max-width: 70%;
    padding: 12px 18px;
    border-radius: 20px;
    font-size: 14px;
    word-wrap: break-word;
    position: relative;
}

/* --------------------------- */
/* Messages Styling - Circle Tail Only */
/* --------------------------- */
.message {
    max-width: 70%;
    padding: 12px 18px;
    border-radius: 25px; /* fully rounded corners */
    font-size: 14px;
    word-wrap: break-word;
    position: relative;
}

    /* Left-aligned message - other person / user */
    .message.left {
        align-self: flex-start;
        margin-left: 10px;
        margin-right: auto;
        background: #e4e6eb;
        color: #000;
    }

    /* Right-aligned message - logged-in user / admin */
    .message.right {
        align-self: flex-end;
        margin-right: 10px;
        margin-left: auto;
        background: #1877f2;
        color: #fff;
    }



    /* Images inside messages */
    .message img {
        display: block;
        margin-top: 5px;
        border-radius: 12px;
        max-width: 150px;
    }

/* --------------------------- */
/* Message Input Box */
/* --------------------------- */
.message-input {
    display: flex;
    gap: 15px;
    border-top: 1px solid #ddd;
    padding-top: 10px;
}

    .message-input .form-control {
        flex-grow: 1;
        border-radius: 25px;
        padding: 10px 15px;
    }

.btn-primary {
    background: #1877f2;
    border: none;
    padding: 10px 20px;
    border-radius: 25px;
}

    .btn-primary:hover {
        background: #166fe5;
    }

/* --------------------------- */
/* Responsive */
/* --------------------------- */
@media (max-width: 1200px) {
    .messages-container {
        flex-direction: column;
        align-items: center;
    }

    .chat-box {
        width: 100%;
        height: 500px;
    }

    .customer-list {
        width: 100%;
        height: 400px;
        margin-bottom: 20px;
    }
}

.upload-icon ion-icon {
    color: #555; /* change to whatever matches your theme */
    transition: color 0.3s;
}

.upload-icon:hover ion-icon {
    color: #007bff; /* blue on hover */
}
    </style>
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