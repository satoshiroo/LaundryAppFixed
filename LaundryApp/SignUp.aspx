 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="LaundryApp.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
     <!-- Link to external CSS for styling the form -->
    <link href="signup.css" rel="stylesheet" />

    <!-- Make it responsive on mobile -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <!-- 
        JavaScript client-side validation:
        - Ensures user fills required fields
        - Checks email format
        - Checks password complexity
        - Checks contact number format
        - Checks if terms are agreed
    -->
    <script>
        function validateForm() {
            const username = document.getElementById("<%= txtUsername.ClientID %>");
            const email = document.getElementById("<%= txtEmail.ClientID %>");
            const password = document.getElementById("<%= txtPassword.ClientID %>");
            const contact = document.getElementById("<%= txtContact.ClientID %>");
            const terms = document.getElementById("<%= checkbox.ClientID %>");
            const inputs = [username, email, password, contact];
            let isValid = true;

            // Remove previous errors
            document.querySelectorAll('.inline-error').forEach(el => el.remove());
            inputs.forEach(input => input.classList.remove('input-error'));

            // Username
            if (username.value.trim() === "") { showInlineError(username, "Username is required!"); isValid = false; }

            // Email
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (email.value.trim() === "") { showInlineError(email, "Email is required!"); isValid = false; }
            else if (!emailRegex.test(email.value.trim())) { showInlineError(email, "Enter a valid email!"); isValid = false; }

            // Password
            const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;
            if (password.value.trim() === "") { showInlineError(password, "Password is required!"); isValid = false; }
            else if (!passwordRegex.test(password.value.trim())) { showInlineError(password, "Password must be 8+ chars with uppercase, lowercase & number!"); isValid = false; }

            // Contact
            const contactRegex = /^[0-9]{10,15}$/;
            if (contact.value.trim() === "") { showInlineError(contact, "Contact number is required!"); isValid = false; }
            else if (!contactRegex.test(contact.value.trim())) { showInlineError(contact, "Enter a valid contact number (10-15 digits)!"); isValid = false; }

            // Terms and conditions check
            if (!terms.checked) { alert("You must agree to the terms and conditions!"); isValid = false; }

            return isValid;
        }

        // Function to show inline error messages under the input
        function showInlineError(input, message) {
            input.classList.add('input-error');
            const error = document.createElement('div');
            error.className = 'inline-error';
            error.innerText = message;
            input.parentNode.appendChild(error);
        }

        // Remove error styling when input is focused
        document.addEventListener("DOMContentLoaded", () => {
            document.querySelectorAll('input').forEach(el => el.addEventListener('focus', () => el.classList.remove('input-error')));
        });
    </script>
</head>



<body>
    <div class="container">
        <div class="Signup-box">
            <form id="form1" runat="server">

                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

                <h1>Sign Up</h1>
                <asp:Label ID="msg" runat="server" CssClass="error-text hidden" Visible="false"></asp:Label>

                  <!-- Username Input -->
                <div class="input-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" placeholder="Username"></asp:TextBox>
                    <ion-icon name="person-sharp" class="icon"></ion-icon>
                </div>

                 <!-- Email Input -->
                <div class="input-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="Email"></asp:TextBox>
                    <ion-icon name="mail" class="icon"></ion-icon>
                </div>

                 <!-- Password Input -->
                <div class="input-group">
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-input" placeholder="Password"></asp:TextBox>
                    <ion-icon name="lock-closed-sharp" class="icon"></ion-icon>
                </div>

                 <!-- Contact Number Input -->
                <div class="input-group">
                    <asp:TextBox ID="txtContact" runat="server" CssClass="form-input" placeholder="Contact Number"></asp:TextBox>
                    <ion-icon name="call" class="icon"></ion-icon>
                </div>

                <!-- Terms and Conditions Checkbox -->
                <div class="agreeterms-box">
                    <label class="checkbox">
                        <asp:CheckBox ID="checkbox" runat="server" />
                        I agree to the terms and conditions
                    </label>
                </div>

                <!-- Sign Up Button -->
                <asp:Button ID="signup" CssClass="btn" runat="server" Text="Sign Up" 
                            OnClick="signup_Click" OnClientClick="return validateForm();" />

                 <!-- Link to login page -->
                <div class="Already-Account-Link">
                    <p>Already have an account? <a href="Login.aspx">Sign In</a></p>
                </div>
            </form>
        </div>
    </div>

     <!-- Ionicons scripts for input icons -->
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>
