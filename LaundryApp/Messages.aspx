<%@ Page Title="Messages" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Messages.aspx.cs" Inherits="LaundryApp.Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Admin Messages</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        .chat-box {
            height: 450px;
            overflow-y: auto;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            background-color: #f8f9fa;
        }

        .message {
            margin: 10px 0;
            padding: 10px 15px;
            border-radius: 10px;
            max-width: 70%;
            position: relative;
            display: inline-block;
            clear: both;
        }

        .message.user {
            background-color: #e9ecef;
            color: black;
            text-align: left;
            float: left;
        }

        .message.admin {
            background-color: #007bff;
            color: white;
            text-align: right;
            float: right;
        }

        .sender-label {
            font-size: 0.8em;
            font-weight: bold;
            display: block;
        }

        .timestamp {
            font-size: 0.75em;
            color: #6c757d;
            display: block;
            margin-top: 4px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h3 class="fw-bold mb-4">Customer Messages</h3>

    <div class="card shadow-sm">
        <div class="card-body">
            <div class="chat-box mb-3" id="chatBox">
                <asp:Repeater ID="rptMessages" runat="server">
                    <ItemTemplate>
                        <div class='message <%# Eval("Sender") %>'>
                            <span class="sender-label">
                                <%# Eval("Sender").ToString() == "admin" ? "You" : "Customer" %>
                            </span>
                            <%# Eval("Text") %>
                            <span class="timestamp">
                                <%# Eval("Timestamp", "{0:hh:mm tt}") %>
                            </span>
                        </div>
                        <div style="clear: both;"></div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div class="input-group">
                <asp:TextBox ID="txtReply" runat="server" CssClass="form-control" placeholder="Type your reply..." />
                <asp:Button ID="btnSendReply" runat="server" Text="Send Reply" CssClass="btn btn-primary" OnClick="btnSendReply_Click" />
            </div>
        </div>
    </div>
</asp:Content>
