<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="LaundryApp.ResetPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reset Password</title>
    <link href="resetpassword.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="Form">
                <div class="Description">
                    <h2>Reset Password</h2>
                    <asp:Label ID="msg" runat="server" CssClass="success-text"></asp:Label>
                </div>

                <div class="input-wrapper">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" 
                        placeholder="New Password" TextMode="Password"></asp:TextBox>
                    <asp:Label ID="lblPasswordError" runat="server" CssClass="error-text"></asp:Label>
                </div>

                <div class="input-wrapper">
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="input" 
                        placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                    <asp:Label ID="lblConfirmPasswordError" runat="server" CssClass="error-text"></asp:Label>
                </div>

                <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="btn" OnClick="btnResetPassword_Click" />

                <div class="rememberpass">
                    <p>Did you remember your password? <a href="Login.aspx">Sign In</a></p>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
