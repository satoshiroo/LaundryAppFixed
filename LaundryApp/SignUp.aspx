<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="LaundryApp.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <link href="SignUp.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <style>
        /* GLOBAL STYLES */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    padding: 20px;
    background: linear-gradient(135deg, #c6f3ff, #e0f7ff); /* updated laundry gradient */
}

/* MAIN CARD */
.container {
    width: 100%;
    max-width: 550px;
    padding: 45px 35px;
    border-radius: 18px;
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
    text-align: center;
    background: linear-gradient(145deg, #ffffff, #d0f0ff); /* updated laundry gradient */
}

    .container h1 {
        font-size: 32px;
        font-weight: 800;
        margin-bottom: 20px;
        color: #0099cc; /* updated to fresh blue */
    }

/* INPUT GROUP */
.input-group {
    position: relative;
    margin: 25px 0;
}

    .input-group input {
        width: 100%;
        padding: 14px 50px 14px 18px;
        background: linear-gradient(120deg, #e0f7ff, #f0fcff); /* updated */
        border-radius: 12px;
        border: 1px solid #99d6f0; /* updated */
        outline: none;
        font-size: 16px;
        color: #006699; /* updated text color */
        transition: 0.3s;
    }

        .input-group input:focus {
            border-color: #00bfff; /* updated */
            box-shadow: 0 0 8px rgba(0, 191, 255, 0.3); /* updated */
        }

    /* ICON */
    .input-group .icon {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 20px;
        color: #0099cc; /* updated */
    }

/* TERMS CHECKBOX */
.agreeterms-box {
    font-size: 14px;
    margin: 5px 0 15px;
    text-align: left;
    color: #006699; /* updated */
}

.checkbox {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    user-select: none;
}

    .checkbox input[type="checkbox"] {
        appearance: none;
        width: 22px;
        height: 22px;
        border-radius: 6px;
        border: 2px solid #99d6f0; /* updated */
        background: linear-gradient(120deg, #e0f7ff, #f0fcff); /* updated */
        position: relative;
        cursor: pointer;
        transition: all 0.3s ease;
    }

        .checkbox input[type="checkbox"]:hover {
            border-color: #00bfff; /* updated */
            box-shadow: 0 0 8px rgba(0, 191, 255, 0.3); /* updated */
        }

        .checkbox input[type="checkbox"]:checked {
            background: linear-gradient(135deg, #00bfff, #66d9ff); /* updated */
            border-color: #00bfff; /* updated */
        }

            .checkbox input[type="checkbox"]:checked::after {
                content: '✔';
                color: #fff;
                font-size: 14px;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

/* BUTTON */
.btn {
    width: 100%;
    height: 50px;
    background: linear-gradient(135deg, #00bfff, #66d9ff); /* updated */
    border-radius: 12px;
    border: none;
    color: #fff;
    font-size: 17px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
}

    .btn:hover {
        background: linear-gradient(135deg, #0099cc, #33ccff); /* updated */
    }

/* LINK TO LOGIN */
.Already-Account-Link {
    margin-top: 20px;
    font-size: 14px;
}

    .Already-Account-Link a {
        color: #00bfff; /* updated */
        text-decoration: none;
        font-weight: 500;
    }

        .Already-Account-Link a:hover {
            text-decoration: underline;
        }

/* ERROR / SUCCESS MESSAGES */
.error-text, .success-text {
    padding: 8px 12px;
    font-size: 14px;
    border-radius: 8px;
    font-weight: bold;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
}

.error-text {
    background: #ffe6e6;
    color: #ff2d2d;
    border: 1px solid #ff2d2d;
}

    .error-text::before {
        content: "⚠";
        font-size: 16px;
    }

.success-text {
    background: #e6ffe6;
    color: #2d8f2d;
    border: 1px solid #2d8f2d;
}

    .success-text::before {
        content: "✔";
        font-size: 16px;
    }

/* INLINE ERROR UNDER INPUTS */
.input-error {
    border-color: #ff2d2d !important;
}

.inline-error {
    color: #ff2d2d;
    font-size: 12px;
    margin-top: 4px;
    text-align: left;
}

/* RESPONSIVE */
@media (max-width: 600px) {
    .container {
        padding: 25px 18px;
    }

        .container h1 {
            font-size: 28px;
        }

    .input-group input {
        padding: 12px 45px 12px 15px;
        font-size: 15px;
    }

    .btn {
        height: 45px;
        font-size: 15px;
    }
}
    </style>
    <script>
        function validateForm() {
            const username = document.getElementById("<%= txtUsername.ClientID %>");
            const email = document.getElementById("<%= txtEmail.ClientID %>");
            const password = document.getElementById("<%= txtPassword.ClientID %>");
            const contact = document.getElementById("<%= txtContact.ClientID %>");
            const terms = document.getElementById("<%= checkbox.ClientID %>");
            let isValid = true;

            // Clear previous errors
            document.querySelectorAll('.inline-error').forEach(el => el.remove());
            [username, email, password, contact].forEach(input => input.classList.remove('input-error'));

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

            // Terms
            if (!terms.checked) { alert("You must agree to the terms and conditions!"); isValid = false; }

            return isValid;
        }

        function showInlineError(input, message) {
            input.classList.add('input-error');
            const error = document.createElement('div');
            error.className = 'inline-error';
            error.innerText = message;
            input.parentNode.appendChild(error);
        }

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
                <asp:Label ID="msg" runat="server" CssClass="hidden"></asp:Label>

                <div class="input-group">
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input" placeholder="Username"></asp:TextBox>
                    <ion-icon name="person-sharp" class="icon"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" placeholder="Email"></asp:TextBox>
                    <ion-icon name="mail" class="icon"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtPassword" TextMode="Password" runat="server" CssClass="form-input" placeholder="Password"></asp:TextBox>
                    <ion-icon name="lock-closed-sharp" class="icon"></ion-icon>
                </div>

                <div class="input-group">
                    <asp:TextBox ID="txtContact" runat="server" CssClass="form-input" placeholder="Contact Number"></asp:TextBox>
                    <ion-icon name="call" class="icon"></ion-icon>
                </div>

                <div class="agreeterms-box">
                    <label class="checkbox">
                        <asp:CheckBox ID="checkbox" runat="server" />
                        I agree to the terms and conditions
                    </label>
                </div>

                <asp:Button ID="signup" CssClass="btn" runat="server" Text="Sign Up"
                            OnClick="signup_Click" OnClientClick="return validateForm();" />

                <div class="Already-Account-Link">
                    <p>Already have an account? <a href="Login.aspx">Sign In</a></p>
                </div>
            </form>
        </div>
    </div>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>