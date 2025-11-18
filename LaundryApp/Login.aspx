<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Laundry_Login.Login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Login.css" rel="stylesheet" />
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
    min-height: 100vh;
    padding: 20px;
    background: linear-gradient(90deg, #e2e2e2, #c9d6ff);
}

/*Main */
.container {
    width: 100%;
    max-width: 850px;
    background: #fff;
    border-radius: 30px;
    box-shadow: 0 0 30px rgba(0,0,0,.2);
    overflow: hidden;
    display: flex;
    flex-direction: row;
    height: 500px;
    position: relative;
}

/* LEFT PANEL */
.left-container {
    width: 50%;
    height: 100%;
}

.Logo-box {
    width: 100%;
    height: 100%;
    background: #7494ec;
    color: #fff;
    padding: 60px;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    border-bottom-right-radius: 150px;
    border-top-right-radius: 150px;
    border-top-left-radius: 30px;
    border-bottom-left-radius: 30px;
}

/* Text Logo */
.Logo {
    font-size: 22px;
    font-weight: 600;
}

.text-sci h2 {
    font-size: 38px;
    line-height: 1;
}

.text-sci p {
    margin-top: 15px;
    font-size: 15px;
}

/* LOGIN FORM BOX */
.login-Box {
    position: absolute;
    right: 0;
    width: 50%;
    height: 100%;
    padding: 40px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
}

/* title na Sign In*/
.container h1 {
    font-size: 36px;
    margin-bottom: 10px;
}

/* INPUT BOX */
.input-group {
    position: relative;
    margin: 25px 0;
}

    .input-group input {
        width: 100%;
        padding: 13px 50px 13px 20px;
        background: #eee;
        border-radius: 8px;
        border: none;
        outline: none;
        font-size: 16px;
    }

    .input-group .icon {
        position: absolute;
        right: 20px;
        top: 50%;
        transform: translateY(-50%);
        font-size: 20px;
        color: #888;
    }

/* CheckBox & Forgot Password */
.checkbox-forgotlink {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: -10px 0 15px;
}

    .checkbox-forgotlink a {
        color: #7494ec;
        font-size: 14.5px;
        text-decoration: none;
    }

        .checkbox-forgotlink a:hover {
            text-decoration: underline;
            color: #333;
        }



    /* BUTTON */
    .btn {
        width: 100%;
        height: 48px;
        background: #7494ec;
        border-radius: 8px;
        border: none;
        color: #fff;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
    }

/* CREATE ACCOUNT */
.Create-Account-Link {
    margin-top: 20px;
}

    .Create-Account-Link a {
        color: #7494ec;
        text-decoration: none;
    }

    .Create-Account-Link a:hover {
            text-decoration: underline;
            color: #333;
        }


/* ++++++++++++RESPONSIVE+++++++++++++ */

/*  para sa Tablets at sa Small laptops */
@media (max-width: 900px) {

    .container {
        flex-direction: column;
        height: auto;
        position: relative;
    }

    /*para di gumalaw sa login box */
    .login-Box {
        position: relative;
        right: 0;
        width: 100%;
        height: auto;
        padding: 30px;
        margin-top: 0;
    }

    .left-container {
        width: 100%;
        height: auto;
        order: -1; /* sa taas yung logo  */
    }

    .Logo-box {
        width: 100%;
        padding: 40px;
        border-radius: 0;
        text-align: center;
    }
}




/* Mobile Phones */
        @media (max-width: 500px) {

            .container {
                flex-direction: column;
                height: auto;
                position: relative;
            }

            /* para mapunta yung logo sa taas */
            .left-container {
                width: 100%;
                height: auto;
                order: -1;
            }

            .Logo-box {
                padding: 30px;
                text-align: center;
                border-radius: 0;
            }

            /* para mapunta sa ibaba yung login form */
            .login-Box {
                position: relative;
                width: 100%;
                height: auto;
                padding: 30px;
                margin-top: 0;
                right: 0;
            }

            .container h1 {
                font-size: 28px;
            }

            .Logo {
                font-size: 18px;
            }

            .text-sci h2 {
                font-size: 28px;
            }

            .input-group input {
                font-size: 14px;
            }

            .btn {
                font-size: 15px;
                height: 44px;
            }
        }
    </style>
</head>
<body>
      <div class="container">

            <div class="login-Box">
                
                <form id="Login" runat="server">
                    <h1> Sign In</h1>
                    <!-- Error Message -->
                    <asp:Label ID="msg" runat="server"></asp:Label>

                    <!--  -->
                    <div class="input-group">
                        <asp:TextBox ID="emailTB" runat="server" CssClass="input" placeholder="Email"></asp:TextBox>
                        <ion-icon class="icon" name="person-sharp"></ion-icon>
                    </div>

                    <div class="input-group">
                        <asp:TextBox ID="passwordTB" runat="server" CssClass="input" TextMode="Password" placeholder="Password"></asp:TextBox>
                        <ion-icon class="icon" name="lock-closed-sharp"></ion-icon>
                    </div>

                <!-- remember me checkbox & Forgot password link -->
                    <div class="checkbox-forgotlink">
                     <label class="checkbox">
                         <asp:CheckBox ID="RememberBox" runat="server" />
                        Remember Me 
                    </label>     
                        <a href="ForgotPassword.aspx" class="forgot">Forgot your password?</a>
                    </div>

                 
                    <asp:Button ID="signin" CssClass="btn" runat="server" Text="Log In" OnClick="SignIn_Click" />

                    <div class="Create-Account-Link">
                        <p>Don't have an Account? <a href="CreateAccount.aspx" class="signup">Create Account</a></p>
                    </div>

                </form>

            </div>


            <div class="left-container">
                <div class="Logo-box">
                    <h2 class="Logo">Press & Dry <br />
                        Laundry Services</h2>

            <div class="text-sci">
                <br />
                <h2> Effortless Clean, Every Time.</h2>
            </div>

                </div>
    

            </div>
        </div>

<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule =" " src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

</body>
</html>