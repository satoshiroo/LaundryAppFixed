<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Laundry_Login.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="forgopassword.css" rel="stylesheet" />

    <style>
        /*FRGT PASS*/
* {

    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Poppins', sans-serif;
}

header {
    background-color: white;
    padding: 10px 30px;
    border: 1px solid #ccc;
    display: flex;
    justify-content: space-between; /* logo left, form right */
}

.Logo {
    font-size: 20px;
    font-weight: bold;
    color: #4a90e2;
}

body {
    display: flex;
    flex-direction: column;
    background: linear-gradient(90deg, #e2e2e2, #c9d6ff);
}

.container {
    padding-top: 20px;
    padding-bottom: 60px;
}
/* texbox login alignment */

.LoginForm {
    padding: 5px;
    display: flex;
    align-items: center;
    gap: 10px;
    flex-wrap: wrap;
}
    /* Log In button design */

    .LoginForm .btn-signin {
        background-color: #7494ec;
        box-shadow: 0 0 10px rgba(0,0,0, .1);
        color: white;
        border: none;
        border-radius: 5px;
        padding: 6px 12px;
        cursor: pointer;
        padding: 15px;
        width: 100px;
        font-weight: 600;
    }
        /* Log In button kapag nakapoint*/

        .LoginForm .btn-signin:hover {
            background-color: #5a7ae6;
        }
    /* size of the form box */

    .LoginForm input {
        width: 180px;
        padding: 5px 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 14px;
        outline: none;
        transition: border-color 0.3s ease;
        color: #333;
        background: #eee;
    }
        /*textbox Border light effect*/

        .LoginForm input:focus {
            border-color: #7494ec; /* outline color */
            box-shadow: 0 0 4px #5a7ae6; /* gloweffect */
        }
/* formbox*/

.Form {
    background-color: white;
    width: 500px;
    border-radius: 10px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
    padding: 25px 30px;
    height: auto;
    margin: auto;
    box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
    text-align: center;
}
    /* form text*/

    .Form h2 {
        text-align: center;
        margin-bottom: 10px;
        font-size: 20px;
        margin-top: 10px;
    }

    .forgot-img {
        width: 50%;
        height: auto;
        margin: 0 auto 20px auto;
    }

    .Form input {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        font-size: 16px;
        outline: none;
        transition: border-color 0.3s ease;
        margin-bottom: 20px;
        color: #333;
        background: #eee;
        border-radius: 8px;
    }

    .Form input:focus {
        border-color: #7494ec; /* outline color */
        box-shadow: 0 0 4px #5a7ae6; /* glow effect */
    }

    .Form label {
        display: flex;
        margin-bottom: 5px;
        color: #333;
    }

    .Form .Description {
        position: relative;
        bottom: 30px;
    }

    .Description p {
        font-size: 13px;
        color: #333;
    }

    .Description H2 {
        color: #4a90e2;
    }
    /* Reset button */

    .Form .btn {
        background-color: #7494ec;
        box-shadow: 0 0 10px rgba(0,0,0, .1);
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        padding: 15px;
        width: 100%;
        margin-bottom: 12%;
        border-radius: 8px;
        font-weight: 600;
    }

        .Form .btn:hover {
            background-color: #5a7ae6;
        }
    /* Sign in click clor*/

    .Form a {
        color: #7494ec;
        text-decoration: none;
    }

        .Form a:hover {
            text-decoration: underline;
        }

    footer {
        margin-top: auto;
        padding-top: 60px;
        padding: 25px;
        text-align: center;
        color: #333;
    }

    .rememberpass {
        margin-bottom: 25px;
        color: #333;
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <!-- HEADER -->
    <header>
        <div class="Logo">
            <h2>Press & Dry Laundry Services</h2>
        </div>

        <div class="LoginForm">
            <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="input" 
                placeholder="Enter your Email" TextMode="Email"></asp:TextBox>

            <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="input" 
                placeholder="Enter your Password" TextMode="Password"></asp:TextBox>

            <asp:Button ID="btnSignIn" runat="server" Text="Sign In" CssClass="btn-signin" />
        </div>
    </header>


    <!-- MAIN CONTAINER -->
    <div class="container">

        <div class="Form">

            <img src="Images/Forget.jpg" class="forgot-img" />

            <div class="Description">
                <h2>Forgot Password?</h2>
                <p>Don't worry! Resetting your password is easy, just type in the email you used to register at Press & Dry Laundry Services.</p>
            </div>

            <label for="txtResetEmail">Email:</label>

            <asp:TextBox ID="txtResetEmail" runat="server" CssClass="input" 
                placeholder="Enter your Email"></asp:TextBox>

            <asp:Button ID="btnResetPassword" runat="server" Text="Reset Password" CssClass="btn" />

            <div class="rememberpass">
                <p>Did you remember your password?
                    <a href="Login.aspx">Sign In</a>
                </p>
            </div>

        </div>

    </div>


    <!-- FOOTER -->
    <footer>
        <p>Press & Dry Laundry</p>
    </footer>

</form>
</body>
</html>