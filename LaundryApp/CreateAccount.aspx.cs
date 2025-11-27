using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace Laundry_Login
{
    public partial class CreateAccount : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Handle Page_Load logic if needed
        }

        // Method to hash the password using SHA256
        public string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }

        // Sign Up Button Click Event
        protected void signup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string contact = txtContact.Text;
            string hashedPassword = HashPassword(password);

            // Validate if terms and conditions are checked
            if (!checkbox.Checked)
            {
                msg.Text = "Please agree to the terms and conditions.";
                msg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string connString = System.Configuration.ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "INSERT INTO Users (Username, Email, Password, ContactNumber) VALUES (@Username, @Email, @Password, @ContactNumber)";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.Parameters.AddWithValue("@ContactNumber", contact);

                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        // After successful sign-up, show success message and redirect or clear fields
                        msg.Text = "Sign Up successful!";
                        msg.ForeColor = System.Drawing.Color.Green;

                        // Optionally redirect to login or other page
                        // Response.Redirect("Login.aspx");
                    }
                    catch (Exception ex)
                    {
                        msg.Text = "Error: " + ex.Message;
                        msg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }
    }
}
