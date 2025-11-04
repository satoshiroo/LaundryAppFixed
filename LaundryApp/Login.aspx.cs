using System;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Submit_Click(object sender, EventArgs e)
        {
            string emailInput = email.Text.Trim();
            string passwordInput = password.Text.Trim();

            // Simple login logic (no database yet)
            if (emailInput == "admin@laundry.com" && passwordInput == "admin123")
            {
                Session["Role"] = "Admin";
                Session["Email"] = emailInput;
                Response.Redirect("~/AdminDashboard.aspx");
            }
            else if (emailInput == "customer@laundry.com" && passwordInput == "customer123")
            {
                Session["Role"] = "Customer";
                Session["Email"] = emailInput;
                Response.Redirect("~/CustomerDashboard.aspx");
            }
            else
            {
                lblSignInMessage.Text = "Invalid email or password.";
            }
        }

        protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            string username = txtusernamesignup.Text.Trim();
            string contact = txtcontactnumber.Text.Trim();
            string emailAddress = txtemailsignup.Text.Trim();
            string passwordValue = txtpasswordsignup.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(contact) ||
                string.IsNullOrEmpty(emailAddress) || string.IsNullOrEmpty(passwordValue))
            {
                lblSignUpMessage.Text = "Please fill in all fields.";
                return;
            }

            lblSignUpMessage.ForeColor = System.Drawing.Color.Green;
            lblSignUpMessage.Text = "Account created successfully! You can now sign in.";
        }
    }
}
