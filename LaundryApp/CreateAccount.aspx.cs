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

        protected void Signup_Click(object sender, EventArgs e)
        {
            // Get user input
            string firstName = firstNameTB.Text;
            string lastName = lastNameTB.Text;
            string email = emailTB.Text;
            string password = passwordTB.Text;
            string confirmPassword = confirmpassword.Text;
            string contactNumber = contactnum.Text;
            string address = addressTB.Text;

            // Check if any of the fields are empty
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) || string.IsNullOrEmpty(email) ||
                string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword) || string.IsNullOrEmpty(contactNumber) ||
                string.IsNullOrEmpty(address))
            {
                messagetxt.Text = "You can't register with empty fields. Please fill in all fields.";
                messagetxt.ForeColor = System.Drawing.Color.Red;
                return; // Stop further execution
            }

            // Check if passwords match
            if (password != confirmPassword)
            {
                messagetxt.Text = "Passwords do not match";
                messagetxt.ForeColor = System.Drawing.Color.Red;
                return;
            }

            // Hash the password before storing it
            string hashedPassword = HashPassword(password);

            // Database connection string
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

            // SQL query to insert user data
            string query = "INSERT INTO Users (FirstName, LastName, Email, Password, ContactNumber, Address, UserRole) " +
                           "VALUES (@FirstName, @LastName, @Email, @Password, @ContactNumber, @Address, 'Customer')";

            // Create SQL connection and command
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters to prevent SQL Injection
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword); // Use the hashed password
                    cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                    cmd.Parameters.AddWithValue("@Address", address);

                    // Execute the command
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();

                    // Show success message
                    messagetxt.Text = "Account created successfully!";
                    messagetxt.ForeColor = System.Drawing.Color.Green;
                }
            }
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
    }
}
