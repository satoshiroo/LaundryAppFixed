<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LaundryApp.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login / Register</title>
    <link href="Login.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>

    </style>
</head>
<body>
    <form id="MainForm" runat="server">
        <div class="container" id="container">

            <!-- SIGN UP -->
            <div class="form-container sign-up-container">
                <div class="form-box">
                    <h1>Create Account</h1>
                    <asp:Label ID="lblSignUpMessage" runat="server" ForeColor="Red"></asp:Label>

                    <div class="input-box">
                        <asp:TextBox ID="txtusernamesignup" runat="server" CssClass="input" placeholder="Username"></asp:TextBox>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtcontactnumber" runat="server" CssClass="input" placeholder="Contact Number"></asp:TextBox>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtemailsignup" runat="server" CssClass="input" placeholder="Email"></asp:TextBox>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="txtpasswordsignup" runat="server" CssClass="input" TextMode="Password" placeholder="Password"></asp:TextBox>
                    </div>

                    <asp:Button ID="SignupBtn" CssClass="btn" runat="server" Text="Sign Up" OnClick="SignUpBtn_Click" />
                </div>
            </div>

            <!-- SIGN IN -->
            <div class="form-container sign-in-container">
                <div class="form-box">
                    <h1>Sign In</h1>
                    <asp:Label ID="lblSignInMessage" runat="server" ForeColor="Red"></asp:Label>

                    <div class="input-box">
                        <asp:TextBox ID="email" runat="server" CssClass="input" placeholder="Email"></asp:TextBox>
                    </div>
                    <div class="input-box">
                        <asp:TextBox ID="password" runat="server" CssClass="input" TextMode="Password" placeholder="Password"></asp:TextBox>
                    </div>

                    <div class="options">
                        <label class="remember">
                            <input type="checkbox" id="chkRemember" runat="server"/> Remember me
                        </label>
                        <a href="ForgotPassword.aspx" class="forgot">Forgot your password?</a>
                    </div>

                    <asp:Button ID="Submit" CssClass="btn" runat="server" Text="Login" OnClick="Submit_Click" />
                </div>
            </div>

            <!-- OVERLAY PANELS -->
            <div class="overlay-container">
                <div class="overlay">
                    <div class="overlay-panel overlay-left">
                        <h1>Hi Po!</h1>
                        <p>Already have an account?</p>
                        <button type="button" class="ghost" id="signIn">Sign In</button>
                    </div>
                    <div class="overlay-panel overlay-right">
                        <h1>Welcome sa Website namin!</h1>
                        <p>Sumama kana sa paglipad ng Eroplano</p>
                        <button type="button" class="ghost" id="signUp">Sign Up</button>
                    </div>
                </div>
            </div>

        </div>
    </form>
    <script>
        // TRANSISYON 
        const signUpButton = document.getElementById('signUp');
        const signInButton = document.getElementById('signIn');
        const container = document.getElementById('container');

        // Kapag nag-click ng Sign Up → lilipat panel
        signUpButton.addEventListener('click', () => {
            container.classList.add("right-panel-active");
        });

        // Kapag nag-click ng Sign In → babalik panel
        signInButton.addEventListener('click', () => {
            container.classList.remove("right-panel-active");
        });
    </script>
</body>
</html>
