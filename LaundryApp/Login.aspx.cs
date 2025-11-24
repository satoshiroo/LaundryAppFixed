using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

namespace Laundry_Login
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent caching of the login page to avoid the page being cached in history
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));  // Set expiration to a past date
            Response.Cache.SetCacheability(HttpCacheability.NoCache);  // Prevent caching
            Response.Cache.SetNoStore();  // Do not store the page in cache

            // If the user is already logged in (session exists), redirect them to the Dashboard
            if (Session["UserRole"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }



        protected void SignIn_Click(object sender, EventArgs e)
        {
            string email = emailTB.Text;
            string password = passwordTB.Text;
            string hashedPassword = HashPassword(password);

            Debug.WriteLine("Username: " + email); // This will show in the Output window
            Debug.WriteLine("Hashed Password: " + hashedPassword);

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "SELECT UserRole FROM Users WHERE Email = @Email AND Password = @Password";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);

                    try
                    {
                        conn.Open();
                        var result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            string userRole = result.ToString();

                            // Store the user role in session
                            Session["UserRole"] = userRole;

                            // Redirect to Dashboard (this is the unified dashboard for both Admin and User)
                            Response.Redirect("Dashboard.aspx");
                        }
                        else
                        {
                            msg.Text = "Invalid username or password!";
                            msg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    catch (Exception ex)
                    {
                        // Log the error (optional)
                        msg.Text = "An error occurred: " + ex.Message;
                        msg.ForeColor = System.Drawing.Color.Red;
                    }
                }
            }
        }

        // Method to hash the password using SHA256
        public string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                // Convert the string to a byte array and compute the hash.
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));

                // Convert the byte array to a string.
                StringBuilder builder = new StringBuilder();
                for (int i = 0; i < bytes.Length; i++)
                {
                    builder.Append(bytes[i].ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}
