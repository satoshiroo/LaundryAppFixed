<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LaundryApp.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="ProfileStyleSheet.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
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

                        <!-- Profile Photo Upload -->
                        <div class="Profile-container">
                            <div class="profile-upload">Upload a new profile picture</div>
                            <asp:Button CssClass="upload_btn" runat="server" Text="Upload Photo" />
                        </div>

                    </div> <!-- end profile-header -->
                </div> <!-- end profile_picture -->

                <!-- Account Details -->
                <div class="account_details_container">
                    <div class="section-title">Account Details</div>

                    <div class="two-col">
                        <div class="item">
                            <label>Account Type</label>
                            <span>Admin/User</span>
                        </div>

                        <div class="item">
                            <label>Created Account</label>
                            <span>Since Day One's</span>
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
                                <asp:TextBox ID="username" placeholder="Your username" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="person-outline"></ion-icon>
                                    <p><strong>Full Name:</strong> <span><%# User.Identity.Name %></span></p>
                                </div>
                                <asp:TextBox ID="fullname" placeholder="Your full name" runat="server"></asp:TextBox>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="mail-outline"></ion-icon>
                                    <p><strong>Email Address:</strong> 
                                        <span><asp:Label ID="EmailLabel" runat="server" /></span>
                                    </p>
                                </div>
                                <asp:TextBox ID="emailaddress" placeholder="@gmail.com" runat="server"></asp:TextBox>
                                <p class="email-note">Email cannot be changed</p>
                            </div>

                            <div class="input-group">
                                <div class="label-row">
                                    <ion-icon name="call-outline"></ion-icon>
                                    <p><strong>Phone Number:</strong> 
                                        <span><asp:Label ID="PhoneLabel" runat="server" /></span>
                                    </p>
                                </div>
                                <asp:TextBox ID="phonenumber" placeholder="+63" runat="server"></asp:TextBox>
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
                        <asp:Button ID="Button1" runat="server" Text="Save Changes" CssClass="profile-button" />

                    </div> <!-- end profile-information -->
                </div> <!-- end profile-card -->

                <!-- Laundry Preferences -->
                <div class="preferences_container">
                    <div class="section-title">Laundry Preferences</div>

                    <div class="preference_info">
                        <div class="input-group">
                            <div class="label-row">
                                <p><strong>Preferred Detergent</strong></p>
                            </div>
                            <asp:TextBox ID="detergentbox" placeholder="Tide, Ariel" runat="server"></asp:TextBox>
                        </div>

                        <p>
                            <asp:CheckBox ID="CheckBox" runat="server" Height="20px" Width="20px" />
                            <strong> Use Fabric Softener</strong>
                        </p>

                        <div class="input-group">
                            <div class="label-row">
                                <p><strong>Special Instructions</strong></p>
                            </div>
                            <asp:TextBox ID="instruction" placeholder="Any special care instruction for your laundry?" runat="server"></asp:TextBox>
                        </div>

                    </div> <!-- end preference_info -->
                </div> <!-- end preferences_container -->

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

                        <asp:Button ID="changepass_btn" runat="server" Text="Change Password" CssClass="changepass_button" />

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

                    <asp:Button ID="LogoutLink" runat="server" CssClass="Logoutbtn" Text="Logout" />
                </div> <!-- end Security -->

            </div> <!-- end col-md-12 -->
        </div> <!-- end row -->

    </div> <!-- end container-fluid -->

    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

</asp:Content>
