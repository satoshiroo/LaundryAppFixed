<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateAccount.aspx.cs" Inherits="Laundry_Login.CreateAccount" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Create Account</title>
    <link href="createaccount.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

body {
    display: flex;
    justify-content: center;
    align-items: center;  /* Vertically centers the content */
    min-height: 100vh;  /* Makes sure the body takes up the full height of the viewport */
    padding: 20px;
    background: linear-gradient(90deg, #e2e2e2, #c9d6ff);
}

.container {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    max-width: 800px; /* Adjust to the desired width */
    width: 100%;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 0 30px rgba(0, 0, 0, .2);
    overflow: hidden;
    height: 650px;
    padding: 20px;
    margin: 0 auto; /* This ensures horizontal centering */
}



.left-container {
    flex: 1;
    background: #7494ec;
    padding: 40px;
    color: white;
    border-radius: 20px;
    text-align: center;
    display: flex;
    flex-direction: column;
    justify-content: center; /* Centers the content vertically */
    align-items: center; /* Centers the content horizontally */
}


.left-container h2 {
    font-size: 36px;
}

.left-container p {
    font-size: 16px;
    margin-top: 10px;
}

.right-container {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 40px;
}

.container h1 {
    font-size: 30px;
    font-weight: bold;
    text-align: center;
    margin-bottom: 20px;
}

.input-group {
    position: relative;
    margin-bottom: 15px;
}

.input-group input {
    width: 100%;
    padding: 12px 40px;
    background: #f1f1f1;
    border-radius: 8px;
    border: 1px solid #ddd;
    font-size: 16px;
}

.input-group .icon {
    position: absolute;
    right: 15px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 18px;
    color: #888;
}

.btn {
    width: 100%;
    padding: 14px;
    background-color: #7494ec;
    color: white;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    border: none;
    font-weight: bold;
}

.btn:hover {
    background-color: #5c7bb7;
}

.checkbox {
    margin-bottom: 20px;
}

.Create-Account-Link {
    text-align: center;
    margin-top: 10px;
}

.Create-Account-Link a {
    color: #7494ec;
    font-size: 14px;
}

.Create-Account-Link a:hover {
    text-decoration: underline;
}

@media (max-width: 1024px) {
    .container {
        flex-direction: column;
        padding: 15px;
    }

    .left-container {
        width: 100%;
        padding: 30px;
        text-align: center;
    }

    .right-container {
        width: 100%;
        margin-top: 20px;
    }

    .container h1 {
        font-size: 24px;
    }

    .input-group input {
        font-size: 14px;
        padding: 10px 30px;
    }

    .btn {
        height: 45px;
    }
}

/* Mobile */
@media (max-width: 768px) {
    .container {
        flex-direction: column;
        padding: 10px;
    }

    .left-container {
        display: none;
    }

    .right-container {
        width: 100%;
        margin-top: 20px;
    }

    .container h1 {
        font-size: 24px;
    }

    .input-group input {
        font-size: 14px;
        padding: 10px 30px;
    }

    .btn {
        height: 45px;
    }
}

@media (max-width: 480px) {
    .left-container h2 {
        font-size: 24px;
    }

    .container h1 {
        font-size: 20px;
    }

    .input-group input {
        padding: 8px 20px;
    }

    .btn {
        height: 40px;
    }
}
.create-account-link {
    text-align: center;
    margin-top: 10px;
}

.create-account-link a {
    color: #7494ec;
    font-size: 14px;
    font-weight: bold;
}

        .create-account-link a:hover {
            text-decoration: underline;
        }

#messagetxt {
    text-align: center;
    color: green;
    font-weight: bold;
    margin-top: 20px;
}



    </style>
</head>
<body>
    <div class="container">

        <div class="left-container">
            <h2>Press & Dry Laundry Services</h2>
            <p>Efficient laundry solutions tailored just for you.</p>
        </div>

        <div class="right-container">
            <h1>Let's create your account</h1>
            <form id="form1" runat="server">
                <asp:Label ID="messagetxt" runat="server"></asp:Label>

                <div class="input-group">
                    <asp:TextBox ID="firstNameTB" runat="server" placeholder="First Name"></asp:TextBox>
                    <ion-icon class="icon" name="person-sharp"></ion-icon>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="lastNameTB" runat="server" placeholder="Last Name"></asp:TextBox>
                    <ion-icon class="icon" name="person-sharp"></ion-icon>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="emailTB" runat="server" placeholder="Email"></asp:TextBox>
                    <ion-icon class="icon" name="mail"></ion-icon>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="passwordTB" runat="server" TextMode="Password" placeholder="Password"></asp:TextBox>
                    <ion-icon class="icon" name="lock-closed-sharp"></ion-icon>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="confirmpassword" runat="server" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                    <ion-icon class="icon" name="lock-closed-sharp"></ion-icon>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="contactnum" runat="server" placeholder="Contact Number"></asp:TextBox>
                    <ion-icon class="icon" name="call"></ion-icon>
                </div>
                <div class="input-group">
                    <asp:TextBox ID="addressTB" runat="server" placeholder="Address"></asp:TextBox>
                    <ion-icon class="icon" name="location-sharp"></ion-icon>
                </div>

                <div class="checkbox">
                    <label>
                        <asp:CheckBox ID="checkbox" runat="server" />
                        I agree to the terms and conditions
                    </label>
                </div>

                <asp:Button ID="signup" CssClass="btn" runat="server" Text="Sign Up" OnClick="Signup_Click" />
                <div class="create-account-link"><p>Already have an account? <a href="Login.aspx">Sign In</a></p>
            </div>
            </form>
        </div>
    </div>

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule="" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</body>
</html>
