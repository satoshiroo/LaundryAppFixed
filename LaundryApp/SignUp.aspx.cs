using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace LaundryApp
{
    public partial class SignUp : Page
    {
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes) builder.AppendFormat("{0:x2}", b);
                return builder.ToString();
            }
        }

        protected void signup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string contact = txtContact.Text.Trim();
            bool agreed = checkbox.Checked;
            string userRole = "Customer";
            string hashedPassword = HashPassword(password);

            // Server-side validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) || string.IsNullOrEmpty(contact))
            {
                ShowServerMessage("All fields are required!", "error");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[^\s@]+@[^\s@]+\.[^\s@]+$"))
            {
                ShowServerMessage("Enter a valid email!", "error");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"))
            {
                ShowServerMessage("Password must be 8+ chars with uppercase, lowercase & number!", "error");
                return;
            }

            if (!agreed)
            {
                ShowServerMessage("You must agree to the terms!", "error");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email OR Username=@Username", conn);
                checkCmd.Parameters.AddWithValue("@Email", email);
                checkCmd.Parameters.AddWithValue("@Username", username);

                if ((int)checkCmd.ExecuteScalar() > 0)
                {
                    ShowServerMessage("Email or username already exists!", "error");
                    return;
                }

                SqlCommand insert = new SqlCommand(
                    @"INSERT INTO Users (Username, Email, Password, ContactNumber, UserRole) 
                      VALUES (@Username, @Email, @Password, @ContactNumber, @UserRole)", conn);

                insert.Parameters.AddWithValue("@Username", username);
                insert.Parameters.AddWithValue("@Email", email);
                insert.Parameters.AddWithValue("@Password", hashedPassword);
                insert.Parameters.AddWithValue("@ContactNumber", contact);
                insert.Parameters.AddWithValue("@UserRole", userRole);

                try { insert.ExecuteNonQuery(); }
                catch { ShowServerMessage("An error occurred. Try again.", "error"); return; }
            }

            ShowServerMessage("Account created successfully! You can now log in.", "success");
        }

        private void ShowServerMessage(string message, string type)
        {
            msg.CssClass = type == "success" ? "success-text" : "error-text";
            msg.Text = message;
            ScriptManager.RegisterStartupScript(this, GetType(), "showMsg", $"document.getElementById('{msg.ClientID}').style.display='flex';", true);
        }
    }
}