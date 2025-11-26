<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Laundry_Login.CreateAccount" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <link href="signup.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>

<body>
<script>
    function showErrorMessage() {
        var lbl = document.getElementById("<%= msg.ClientID %>");

        // Fade IN
        lbl.classList.remove("hidden");

        // After 3 seconds → Fade OUT
        setTimeout(function () {
            lbl.classList.add("hidden");
        }, 3000);
    }
</script>


    <div class="container">
        <div class="Signup-box">

            <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <h1>Sign Up</h1>

               <div class="error-container">
              <asp:Label ID="msg" CssClass="error-text hidden" runat="server"></asp:Label>
               </div>

                <div class="input-group">
                    <asp:TextBox ID="txtUsername" runat="server" placeholder="Username"></asp:TextBox>
                    <ion-icon name="person-sharp" class="icon"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtEmail" runat="server" placeholder="Email"></asp:TextBox>
                    <ion-icon name="mail" class="icon"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" placeholder="Password"></asp:TextBox>
                    <ion-icon name="lock-closed-sharp" class="icon"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtContact" runat="server" placeholder="Contact Number"></asp:TextBox>
                    <ion-icon name="call" class="icon"></ion-icon>
                </div>

                <div class="agreeterms-box">
                    <label class="checkbox">
                        <asp:CheckBox ID="checkbox" runat="server" />
                        I agree to the terms and conditions
                    </label>
                </div>

                <asp:Button ID="signup" CssClass="btn" runat="server" Text="Sign Up" OnClick="signup_Click" />

                <div class="Already-Account-Link">
                    <p>Already have an account?
                        <a href="Login.aspx">Sign In</a>
                    </p>
                </div>

            </form>

        </div>
    </div>
    <!-- ICONS -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

</body>
</html>
