<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Laundry_Login.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Forgotpass.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
    <form id="form1" runat="server">

        <!-- MAIN CONTAINER -->
        <div class="container">

            <!-- FORM BOX -->
            <div class="Form">
                

                <!-- IMAGE -->
                <img src="Img/forgotpassword.png" CssClass="forgot-img" width="30%"/>
          
                <!-- DESCRIPTION -->
                <div class="Description">
                    
                    <h2> Forgot Password?</h2>
                    <p>
                        Don't worry! Resetting your password is easy. Just type in the email you used to register at Press & Dry Laundry Services.
                    </p>
                    
                </div>
           
<div class="input-wrapper">
    <asp:TextBox ID="txtUsername" runat="server" CssClass="input" 
        placeholder="Enter your Username"></asp:TextBox>
    <asp:Label ID="msg" runat="server" CssClass="error-text" Text="Username is required"></asp:Label>
</div>

                <!-- RESET PASSWORD BUTTON -->
                <asp:Button ID="btnForgotPassword" runat="server" Text="Forgot Password" CssClass="btn" OnClick="btnForgot_Click"  />

                <!-- REMEMBER PASSWORD LINK -->
                <div class="rememberpass">
                    <p>
                        Did you remember your password?
                        <a href="Login.aspx">Sign In</a>
                    </p>
                </div>

            </div>

        </div>

    </form>
</body>
</html>