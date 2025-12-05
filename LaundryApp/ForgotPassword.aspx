<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Laundry_Login.ForgotPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Forgotpass.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        /* Colors i use Color
    
Hex	Usage
Vibrant Purple	#6b00ff	Headings (h1, h2), input focus border, some text

Dark Purple	#5500cc	Button hover gradient start

Pink	#ff66c4	Button gradient end, links, hover text

Light Blue	#a0eaff	Page background gradient start

Light Pink	#ffb3ff	Page background gradient end

Pastel Pink	#ffe6f7	Input background gradient start

Pastel Blue	#e0f7ff	Input background gradient end

Light Purple	#d1b3ff	Input borders

Dark Text	#5a00b3	Input text, labels, description text

White	#ffffff	Form / card backgrounds */

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
    background: linear-gradient(135deg, #c6f3ff, #e0f7ff);
    padding: 20px;
    overflow: hidden;
}

/* Container */
.container {
    width: 100%;
    max-width: 550px;
    padding: 50px 30px 60px;
    background: linear-gradient(145deg, #ffffff, #d0f7ff);
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
    text-align: center;
}

/* Form heading */
.Form h2 {
    font-size: 26px;
    margin-bottom: 25px;
    color: #0099cc;
    font-weight: 700;
    text-align: center;
    font-weight: 800;
}



/* Inputs */
.Form input {
    width: 100%;
    padding: 14px 18px;
    margin-bottom: 20px;
    border-radius: 12px;
    border: 1px solid #99d6f0;
    font-size: 16px;
    color: #006699;
    background: linear-gradient(120deg, #e0f7ff, #f0fcff);
    outline: none;
    transition: all 0.3s ease;
}

    .Form input:focus {
        border-color: #00bfff;
        box-shadow: 0 0 8px rgba(0, 191, 255, 0.3);
    }

/* Labels */
.Form label {
    display: flex;
    margin-bottom: 5px;
    color: #0099cc;
    font-weight: 500;
}

/* Description */
.Form .Description {
    margin-bottom: 40px;
}

.Description p {
    font-size: 14px;
    color: #0099cc;
    line-height: 1.5;
}

.Description h2 {
    color: #0099cc;
    margin: 10px 0;
}

/* Buttons */
.Form .btn {
    width: 100%;
    padding: 15px;
    border: none;
    border-radius: 12px;
    font-weight: 600;
    cursor: pointer;
    background: linear-gradient(135deg, #00bfff, #66d9ff);
    color: #fff;
    font-size: 17px;
    transition: 0.3s;
    margin-bottom: 15px;
}

    .Form .btn:hover {
        background: linear-gradient(135deg, #007acc, #33baff);
    }

/* Links */
.Form a {
    color: #00bfff;
    text-decoration: none;
    font-weight: 500;
}

    .Form a:hover {
        text-decoration: underline;
    }

/* Remember password text */
.rememberpass {
    margin-bottom: 20px;
    color: #007acc;
    font-size: 14px;
    text-align: center;
}





/* Responsive adjustments */
@media (max-width: 900px) {
    .container {
        padding: 40px 20px 50px;
    }

    .Form h2 {
        font-size: 22px;
    }

    .Form input {
        font-size: 15px;
        padding: 12px 15px;
    }

    .Form .btn {
        font-size: 16px;
        padding: 14px;
    }

    .forgot-img {
        width: 60%;
    }
}



/* Input wrapper */
.input-wrapper {
    margin-bottom: 20px;
    position: relative;

}

    /* Input error state */
    .input.error {
        border-color: #ff2d2d; /* red border on error */
        box-shadow: 0 0 8px rgba(255, 45, 45, 0.3);
        margin-bottom:5px;
    }

/* Error text below input */
.error-text {
    color: #ff2d2d;
    font-size: 0.85em;
    display: none; /* hide by default */
   
}

/* Show error text */
.input-wrapper .error-text.show {
    display: flex;

}
    </style>
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