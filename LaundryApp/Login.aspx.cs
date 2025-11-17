using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
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
            string email = this.email.Text.Trim();
            string password = this.password.Text.Trim();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM Users WHERE Email = @Email", con);
                cmd.Parameters.AddWithValue("@Email", email);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    string storedHashPassword = reader["Password"].ToString();
                    string storedSalt = reader["Salt"].ToString();

                    // Hash the entered password with the stored salt
                    string enteredHashedPassword = CreatePasswordHash(password, storedSalt);

                    if (storedHashPassword == enteredHashedPassword)
                    {
                        // Successful login
                        Response.Redirect("HomePage.aspx");  // Redirect to the home page after successful login
                    }
                    else
                    {
                        lblSignInMessage.Text = "Invalid password!";
                    }
                }
                else
                {
                    lblSignInMessage.Text = "Email not registered!";
                }
            }
        }


        protected void SignUpBtn_Click(object sender, EventArgs e)
        {
            string username = txtusernamesignup.Text.Trim();
            string email = txtemailsignup.Text.Trim();
            string password = txtpasswordsignup.Text.Trim();
            string contactNumber = txtcontactnumber.Text.Trim();

            // Generate a salt for the password
            string salt = GenerateSalt();
            string hashedPassword = CreatePasswordHash(password, salt);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Users (Username, Email, Password, ContactNumber, Salt) VALUES (@Username, @Email, @Password, @ContactNumber, @Salt)", con);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);
                cmd.Parameters.AddWithValue("@ContactNumber", contactNumber);
                cmd.Parameters.AddWithValue("@Salt", salt);

                cmd.ExecuteNonQuery();
            }

            lblSignUpMessage.Text = "Account created successfully!";
        }


        public static string CreatePasswordHash(string password, string salt)
        {
            using (var sha256 = new SHA256Managed())
            {
                var saltedPassword = password + salt;
                byte[] hash = sha256.ComputeHash(Encoding.UTF8.GetBytes(saltedPassword));
                return Convert.ToBase64String(hash);
            }
        }

        public static string GenerateSalt()
        {
            var rng = new RNGCryptoServiceProvider();
            byte[] saltBytes = new byte[16];
            rng.GetBytes(saltBytes);
            return Convert.ToBase64String(saltBytes);
        }


    }
}
