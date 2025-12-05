<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Laundry_Login.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="Login.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <script>
        function showErrorMessage() {
            var lbl = document.getElementById("<%= msg.ClientID %>");
            lbl.style.opacity = 1; // fade-in
            setTimeout(function () {
                lbl.style.opacity = 0; // fade-out
            }, 3000);
        }

        // Autofill username if cookie exists
        window.onload = function () {
            const cookie = document.cookie.split('; ').find(row => row.startsWith('UserLogin='));
            if (cookie) {
                const username = cookie.split('=')[1];
                document.getElementById('<%= txtUsername.ClientID %>').value = decodeURIComponent(username);
                document.getElementById('<%= RememberBox.ClientID %>').checked = true;
            }
        };
    </script>

</head>
<body>
    <div class="bubbles">
        <span></span><span></span><span></span><span></span><span></span>
        <span></span><span></span><span></span><span></span><span></span>
    </div>

    <div class="container">

        <div class="login-Box">
            <form id="Login" runat="server">
                <h1> Sign In!</h1>

                <!-- Error Message -->
                <div class="error-container">
                    <asp:Label ID="msg" CssClass="error-text" runat="server" Visible="false"></asp:Label>
                </div>

                <!-- LOGIN FORM -->
                <div class="input-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input" placeholder="Username"></asp:TextBox>
                    <ion-icon class="icon" name="person-sharp"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="input" TextMode="Password" placeholder="Password"></asp:TextBox>
                    <ion-icon class="icon" name="lock-closed-sharp"></ion-icon>
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="checkbox-forgotlink">
                    <label class="checkbox">
                        <asp:CheckBox ID="RememberBox" runat="server" /> Remember Me
                    </label>
                    <a href="ForgotPassword.aspx" class="forgot">Forgot your password?</a>
                </div>

                <asp:Button ID="signin" CssClass="btn" runat="server" Text="Log In" OnClick="signin_Click" />

                <div class="Create-Account-Link">
                    <p>Don't have an Account? <a href="SignUp.aspx" class="signup">SignUp</a></p>
                </div>
            </form>
        </div>

        <div class="left-container">
            <div class="Logo-box">
                <h2 class="Logo">Press & Dry <br />Laundry Services</h2>
                <div class="text-sci">
                    <h2>Welcome!</h2>
                    <p>Effortless Clean, Every Time!</p>
                </div>
            </div>
        </div>

    </div>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>
