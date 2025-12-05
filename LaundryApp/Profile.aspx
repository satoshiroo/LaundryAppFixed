<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LaundryApp.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="ProfileStyleSheet.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <style>
        /* =================== GLOBAL ======================= */
.main-content {
    background: linear-gradient(135deg, #eef7ff, #d4eaff);
    font-family: 'Poppins', sans-serif;
    margin: 0;
}

/* =================== CARD STYLES ========================= */
.profile_picture,
.profile-card,
.account_details_container,
.preferences_container,
.Security {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 8px 25px rgba(0, 140, 255, 0.12);
    padding: 40px 50px;
    width: 100%;
    max-width: 900px;
    margin: 20px auto;
}

/* =================== TITLES ======================= */
.section-title {
    font-weight: bold;
    margin-bottom: 15px;
    font-size: 1.25rem;
    color: #0088FF;
}

/* =================== PROFILE HEADER ======================= */
.myprofile {
    text-align: left;
    margin-bottom: 20px;
}

    .myprofile h2 {
        font-size: 36px;
        margin-bottom: 10px;
        color: #1B2B46;
        font-weight: 800;
    }

    .myprofile small {
        color: #0088FF;
        margin-left: 20px;
    }

.profile-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 30px;
}

/* Avatar */
.profile-avatar span {
    font-size: 40px;
    color: white;
    position: absolute;
    margin-top: 40px;
}

.Avatar {
    width: 120px;
    height: 120px;
    background: linear-gradient(135deg, #B1E5EF, #0088FF);
    border-radius: 50%;
}

/* Upload Photo */
.profile-upload {
    font-size: 0.95rem;
    line-height: 1.6;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.upload_btn {
    width: 150px;
    height: 40px;
    background: #0088FF;
    color: #fff;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    font-weight: 600;
    margin-top: 10px;
}

/* =================== INPUT GROUPS ======================= */
.two-column {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}

.input-group {
    flex: 1 1 calc(50% - 20px);
    display: flex;
    flex-direction: column;
}

.label-row {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-bottom: 7px;
    color: #2D3748;
}

    .label-row ion-icon {
        font-size: 20px;
        color: #1a1a1a;
    }

input::placeholder {
    color: #A0AEC0;
}

.input-group input,
.input-group textarea,
.input-group asp\:TextBox {
    width: 100%;
    padding: 12px 15px;
    border-radius: 8px;
    border: 1px solid #ddd;
    font-size: 15px;
    outline: none;
}

    .input-group input:focus,
    .input-group textarea:focus,
    .input-group asp\:TextBox:focus {
        border-color: #0088FF;
        box-shadow: 0 0 5px rgba(0,136,255,0.2);
    }

.email-note {
    font-size: 0.8rem;
    color: #888;
    margin-top: 3px;
}

/* =================== BUTTONS ======================= */
.profile-button,
.changepass_button,
.upload_btn {
    transition: 0.2s;
}

.profile-button {
    width: 250px;
    height: 50px;
    background: #0088FF;
    color: white;
    border: none;
    border-radius: 8px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 30px;
}

.changepass_button {
    width: 100%;
    height: 50px;
    border-radius: 8px;
    background: #0088FF;
    color: #fff;
    border: none;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 20px;
}

    .profile-button:hover,
    .upload_btn:hover,
    .changepass_button:hover {
        background-color: #0079E8;
    }

/* =================== ACCOUNT DETAILS ======================= */
.two-col {
    display: flex;
    gap: 20px;
}

.item {
    flex: 1;
}

    .item label {
        display: block;
        font-weight: 500;
        margin-bottom: 5px;
    }

    .item span {
        font-weight: bold;
        color: #2D3748;
    }

/* Security tips */
.account_security_tips {
    border-radius: 12px;
    background: #F2F6FF;
    border: 1px solid #DCE8FF;
    padding: 20px;
    margin: 20px auto;
}

    .account_security_tips p {
        color: #0047B3;
        font-size: 18px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

.Security_tips_title {
    color: #0047B3;
    margin-bottom: 8px;
}

/* =================== RESPONSIVE ======================= */
@media (max-width: 900px) {
    .profile-card,
    .account_details_container,
    .preferences_container,
    .Security {
        padding: 25px;
    }

    .myprofile h2 {
        font-size: 28px;
    }

    .two-column {
        flex-direction: column;
    }

    .two-col {
        flex-direction: column;
    }

    .profile-header {
        text-align: center;
        flex-direction: column;
    }

    .Avatar {
        margin: auto;
    }

    .profile-button {
        width: 100%;
        max-width: 100%;
    }
}

@media (max-width: 600px) {
    .section-title {
        font-size: 1.1rem;
    }

    .input-group input,
    .input-group textarea {
        font-size: 14px;
        padding: 10px 12px;
    }

    .upload_btn {
        width: 100%;
    }

    .changepass_button {
        height: 45px;
        font-size: 15px;
    }
}


.Logoutbtn {
    width: 100%;
    justify-content:center;
    height: 50px;
    border-radius: 8px;
    background: #fe625f;
    color: #fff;
    border: none;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    margin-top: 20px;
}

    .Logoutbtn:hover {
        background-color: #eb2c27;
    }
/* Hide the file upload control */
.hidden-file-upload {
    display: none;
}
/* Style the TextBox to appear gray with placeholder-like text */
input[type="text"]::placeholder {
    color: gray;  /* Placeholder text color */
    opacity: 1;   /* Make sure it's fully visible */
}

/* Optional: Style the TextBox background to give a placeholder effect */
input[type="text"] {
    background-color: #f2f2f2;  /* Light gray background */
}


    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container-fluid mt-4">

        <div class="myprofile">
            <h2>My Profile</h2>
            <small>Manage your User Profile</small>
        </div>

        <!-- Profile Card -->
        <div class="row">
            <div class="col-md-12">

                <div class="profile_picture">
                    <div class="section-title">Profile Picture</div>

                    <!-- Profile Avatar -->
                    <div class="profile-header">

                        <div class="profile-avatar">
                            <asp:Image CssClass="Avatar" ID="Image2" runat="server" ImageUrl="~/Img/Haringmanggi.jpg" />
                            <span><%# User.Identity.Name.Substring(0, 1) %></span>
                        </div>

                        <div class="Profile-container">
                            <div class="profile-upload">Upload a new profile picture</div>
    
                            <!-- FileUpload control to select a photo, but hidden -->
                            <asp:FileUpload ID="FileUpload1" runat="server" CssClass="hidden-file-upload" />

                            <!-- Button to trigger the file selection -->
                            <asp:Button CssClass="upload_btn" runat="server" Text="Upload Photo" OnClientClick="triggerFileUpload(); return false;" />
                        </div>

                    </div> <!-- end profile-header -->
                </div> <!-- end profile_picture -->

                <!-- Account Details -->
                <div class="account_details_container">
                    <div class="section-title">Account Details</div>

                    <div class="two-col">
                        <div class="item">
                            <label>Account Type</label>
                            <!-- The span is dynamically updated in the code-behind -->
                            <span id="accountTypeSpan" runat="server"></span>
                        </div>

                        <div class="item">
                            <label>Created Account Date</label>
                            <span id="accountCreatedDateSpan" runat="server">Since Day One's</span>
                        </div>
                    </div>
                </div>


                <!-- Profile Card -->
                <div class="profile-card">

                    <div class="profile-information">
                        <div class="section-title">Account Information</div>

                        <div class="two-column">

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="person-outline"></ion-icon>
                                    <p><strong>Username:</strong> 
                                        <span><asp:Label ID="UsernameLabel" runat="server" /></span>
                                    </p>
                                </div>
                                <asp:TextBox ID="uname" placeholder="Your username" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="person-outline"></ion-icon>
                                    <p><strong>Full Name:</strong> <span><%# User.Identity.Name %></span></p>
                                </div>
                                <asp:TextBox ID="fname" placeholder="Your full name" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="mail-outline"></ion-icon>
                                    <p><strong>Email Address:</strong> 
                                        <span><asp:Label ID="EmailLabel" runat="server" /></span>
                                    </p>
                                </div>
                                <asp:TextBox ID="emailaddress" placeholder="@gmail.com" runat="server" ReadOnly="true"></asp:TextBox>
                                <p class="email-note">Email cannot be changed</p>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="call-outline"></ion-icon>
                                    <p><strong>Phone Number:</strong> 
                                        <span><asp:Label ID="PhoneLabel" runat="server" /></span>
                                    </p>
                                </div>
                                <asp:TextBox ID="contactnumber" placeholder="+63" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="location-outline"></ion-icon>
                                    <p><strong>Default Address:</strong> 
                                        <span><asp:Label ID="Label1" runat="server" /></span>
                                    </p>
                                </div>
                                <asp:TextBox ID="delivery_addrss" placeholder="Your default pickup/delivery address" runat="server"></asp:TextBox>
                            </div>

                        </div> <!-- end two-column -->

                        <!-- Edit Profile Button -->
                        <asp:Button ID="SaveChangesButton" runat="server" Text="Save Changes" CssClass="profile-button" OnClick="SaveChanges_Click"/>

                    </div> <!-- end profile-information -->
                </div> <!-- end profile-card -->

                <!-- Security Section -->
                <div class="Security">
                    <div class="section-title">
                        <ion-icon name="shield-outline"></ion-icon> Security
                    </div>

                    <div class="security_info">

                        <div class="input-group">
                            <div class="label-row">
                                <ion-icon name="lock-closed-outline"></ion-icon>
                                <p><strong>Current Password</strong> 
                                    <span><asp:Label ID="currentpass" runat="server" /></span>
                                </p>
                            </div>
                            <asp:TextBox ID="currentpassword" placeholder="Enter current password" runat="server"></asp:TextBox>
                        </div>

                        <div class="input-group">
                            <div class="label-row">
                                <ion-icon name="key-outline"></ion-icon>
                                <p><strong>New Password</strong> 
                                    <span><asp:Label ID="newpass" runat="server" /></span>
                                </p>
                            </div>
                            <asp:TextBox ID="newpassword" placeholder="Enter new password" runat="server"></asp:TextBox>
                        </div>

                        <div class="input-group">
                            <div class="label-row">
                                <ion-icon name="key-outline"></ion-icon>
                                <p><strong>Confirm Password</strong> 
                                    <span><asp:Label ID="confirmpass" runat="server" /></span>
                                </p>
                            </div>
                            <asp:TextBox ID="confirmpassword" placeholder="Confirm new password" runat="server"></asp:TextBox>
                        </div>

                        <asp:Button ID="changepass_btn" runat="server" Text="Change Password" CssClass="changepass_button" OnClick="Changepass_Btn_Click" />

                        <div class="account_security_tips">
                            <div class="Security_tips_title">
                                <ion-icon name="shield-outline"></ion-icon> Account Security Tips
                            </div>

                            <p>• Use a strong, unique password</p>
                            <p>• Never share your password with anyone</p>
                            <p>• Change your password regularly</p>
                            <p>• Log out from shared devices</p>
                        </div>

                    </div> <!-- end security_info -->

                    <asp:Button ID="LogoutLink" runat="server" CssClass="Logoutbtn" Text="Logout" OnClick="LogoutLink_Click" />
                </div> <!-- end Security -->

            </div> <!-- end col-md-12 -->
        </div> <!-- end row -->

    </div> <!-- end container-fluid -->

    <script type="text/javascript">
    function triggerFileUpload() {
        // Trigger the click event of the hidden file upload control
        document.getElementById('<%= FileUpload1.ClientID %>').click();
    }
    </script>

</asp:Content>