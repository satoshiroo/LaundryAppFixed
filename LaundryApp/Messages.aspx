<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" 
    AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Messages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="messages.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:HiddenField ID="HiddenSelectedUser" runat="server" />

    <!-- ADMIN PANEL -->
    <asp:Panel ID="AdminPanel" runat="server" CssClass="admin-panel">
        <h3>ADMIN MESSAGES</h3>
        <div class="messages-container">
            <div class="customer-list">
                
                <asp:TextBox ID="txtsearch" runat="server" CssClass="form-control search-box" 
                             placeholder="Search Customers..." AutoPostBack="true" OnTextChanged="txtsearch_TextChanged"></asp:TextBox>

                <asp:Repeater ID="rptUsers" runat="server">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" CssClass="user-item"
                                        CommandArgument='<%# Eval("UserId") %>'
                                        OnClick="User_Click">
                            <%# Eval("Username") %>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="chat-box">
                <div class="messages" id="chatMessages">
                    <asp:Literal ID="litMessages" runat="server"></asp:Literal>
                </div>

                <div class="message-input d-flex gap-2">
                    <asp:TextBox ID="txtReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>
                    <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnSend_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>

    <!-- CUSTOMER PANEL -->
    <asp:Panel ID="UserPanel" runat="server" CssClass="admin-panel">
        <h3>CUSTOMER MESSAGES</h3>
        <div class="messages-container">
            <div class="chat-box">
                <div class="messages" id="chatMessagesUser">
                    <asp:Literal ID="litUserMessages" runat="server"></asp:Literal>
                </div>

                <div class="message-input d-flex align-items-center gap-2">
                    <asp:TextBox ID="txtUserReply" runat="server" CssClass="form-control" placeholder="Type your message..."></asp:TextBox>

                    <!-- FileUpload for images -->
                    <asp:FileUpload ID="FileUpload1" runat="server" Style="display:none;" />

                    <!-- Image icon (client-side only) -->
                    <img src="https://cdn-icons-png.flaticon.com/512/61/61456.png" 
                         id="btnUploadImage" style="cursor:pointer; width:30px; height:30px;" />

                    <asp:Button ID="btnUserSend" runat="server" CssClass="btn btn-primary" Text="Send" OnClick="btnUserSend_Click" />
                </div>
            </div>
        </div>
    </asp:Panel>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        // Scroll chat to bottom
        function scrollToBottom(id) {
            var box = document.getElementById(id);
            if (box) box.scrollTop = box.scrollHeight;
        }
        setInterval(function () {
            scrollToBottom('chatMessages');
            scrollToBottom('chatMessagesUser');
        }, 500);

        // Image upload functionality
        const uploadIcon = document.getElementById('btnUploadImage');
        const fileUpload = document.getElementById('<%= FileUpload1.ClientID %>');
        const sendBtn = document.getElementById('<%= btnUserSend.ClientID %>');

        // Click image icon -> open file picker
        uploadIcon.addEventListener('click', function () {
            fileUpload.click();
        });

        // When a file is selected -> automatically send
        fileUpload.addEventListener('change', function () {
            if (fileUpload.files.length > 0) {
                sendBtn.click();
            }
        });
    </script>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</asp:Content>
