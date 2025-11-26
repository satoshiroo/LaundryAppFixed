using System;
using System.Configuration;
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
            // Any page load logic can go here if needed
        }


        // Method to hash passwords (you can use a more secure method like bcrypt for production)
        private string HashPassword(string password)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder builder = new StringBuilder();

                foreach (byte t in bytes)
                {
                    builder.Append(t.ToString("x2"));
                }
                return builder.ToString(); // Return the hashed password
            }
        }

        protected void signup_Click(object sender, EventArgs e)
        {
            // Get user input
            string username = txtUsername.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string contactNumber = txtContact.Text;


            // Check if any of the fields are empty
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) || string.IsNullOrEmpty(contactNumber))

            {
                msg.Text = "You can't register with empty fields. Please fill in all fields.";
                msg.ForeColor = System.Drawing.Color.Red;
                return; // Stop further execution
            }


            // Hash the password before storing it
            string hashedPassword = HashPassword(password);

            // Database connection string
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

            // SQL query to insert user data
            string query = "INSERT INTO Users(username,Email, Password, ContactNumber, UserRole) " +
                           "VALUES (@username, @Email, @Password, @ContactNumber, 'Customer')";

            // Create SQL connection and command
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to prevent SQL Injection      
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword); // Use the hashed password
                    cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);

                    // Execute the command
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    // Show success message
                    msg.Text = "Account created successfully!";
                    msg.ForeColor = System.Drawing.Color.Green;
                }
            }
        }

    }
}
