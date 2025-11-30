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
        // Hash password using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                    builder.AppendFormat("{0:x2}", b);
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
                ShowServerError("All fields are required!", "");
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(email, @"^[^\s@]+@[^\s@]+\.[^\s@]+$"))
            {
                ShowServerError("Enter a valid email!", txtEmail.ClientID);
                return;
            }

            if (!System.Text.RegularExpressions.Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$"))
            {
                ShowServerError("Password must be 8+ chars with uppercase, lowercase & number!", txtPassword.ClientID);
                return;
            }

            if (!agreed)
            {
                ShowServerError("You must agree to the terms!", "");
                return;
            }

            // Database insert
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // Check duplicate
                SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email=@Email OR Username=@Username", conn);
                checkCmd.Parameters.Add("@Email", System.Data.SqlDbType.NVarChar, 100).Value = email;
                checkCmd.Parameters.Add("@Username", System.Data.SqlDbType.NVarChar, 50).Value = username;

                if ((int)checkCmd.ExecuteScalar() > 0)
                {
                    ShowServerError("Email or username already exists!", txtEmail.ClientID);
                    return;
                }

                // Insert
                SqlCommand insert = new SqlCommand(
                    @"INSERT INTO Users (Username, Email, Password, ContactNumber, UserRole) 
                      VALUES (@Username, @Email, @Password, @ContactNumber, @UserRole)", conn);

                insert.Parameters.Add("@Username", System.Data.SqlDbType.NVarChar, 50).Value = username;
                insert.Parameters.Add("@Email", System.Data.SqlDbType.NVarChar, 100).Value = email;
                insert.Parameters.Add("@Password", System.Data.SqlDbType.NVarChar, 64).Value = hashedPassword;
                insert.Parameters.Add("@ContactNumber", System.Data.SqlDbType.NVarChar, 15).Value = contact;
                insert.Parameters.Add("@UserRole", System.Data.SqlDbType.NVarChar, 20).Value = userRole;

                try { insert.ExecuteNonQuery(); }
                catch { ShowServerError("An error occurred. Try again.", ""); return; }
            }

            // Success
            msg.CssClass = "success-text";
            msg.Text = "Account created successfully! You can now log in.";
            string jsMsg = System.Web.HttpUtility.JavaScriptStringEncode(msg.Text);
            ScriptManager.RegisterStartupScript(this, GetType(), "showSuccess", $"showErrorMessage('{jsMsg}');", true);
        }

        private void ShowServerError(string message, string fieldId)
        {
            msg.CssClass = "error-text";
            msg.Text = message;

            string jsMsg = System.Web.HttpUtility.JavaScriptStringEncode(message);
            string script = $"showErrorMessage('{jsMsg}');";

            if (!string.IsNullOrEmpty(fieldId))
                script += $"document.getElementById('{fieldId}').classList.add('input-error');";

            ScriptManager.RegisterStartupScript(this, GetType(), "showError", script, true);
        }
    }
}
