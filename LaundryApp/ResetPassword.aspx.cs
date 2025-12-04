using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace LaundryApp
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string token;

        protected void Page_Load(object sender, EventArgs e)
        {
            token = Request.QueryString["token"];

            if (!IsPostBack)
                ResetInputState();

            if (string.IsNullOrEmpty(token))
            {
                msg.Text = "Invalid or missing token.";
                msg.CssClass = "error-text show";
                btnResetPassword.Enabled = false;
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            ResetInputState();

            string newPass = txtPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();
            bool hasError = false;

            if (string.IsNullOrEmpty(newPass))
            {
                txtPassword.CssClass = "input error";
                lblPasswordError.Text = "Password is required!";
                lblPasswordError.CssClass = "error-text show";
                hasError = true;
            }

            if (string.IsNullOrEmpty(confirmPass))
            {
                txtConfirmPassword.CssClass = "input error";
                lblConfirmPasswordError.Text = "Confirm your password!";
                lblConfirmPasswordError.CssClass = "error-text show";
                hasError = true;
            }

            if (!string.IsNullOrEmpty(newPass) && !string.IsNullOrEmpty(confirmPass) && newPass != confirmPass)
            {
                txtPassword.CssClass = "input error";
                txtConfirmPassword.CssClass = "input error";
                lblConfirmPasswordError.Text = "Passwords do not match!";
                lblConfirmPasswordError.CssClass = "error-text show";
                hasError = true;
            }

            if (hasError) return;

            string cs = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand getUser = new SqlCommand(
                    "SELECT TokenExpiry FROM Users WHERE ResetToken=@Token", con);
                getUser.Parameters.AddWithValue("@Token", token);

                DateTime expiry;
                using (SqlDataReader dr = getUser.ExecuteReader())
                {
                    if (!dr.Read())
                    {
                        msg.Text = "Invalid token.";
                        msg.CssClass = "error-text show";
                        return;
                    }
                    expiry = Convert.ToDateTime(dr["TokenExpiry"]);
                }

                if (expiry < DateTime.Now)
                {
                    msg.Text = "Token expired.";
                    msg.CssClass = "error-text show";
                    return;
                }

                string hashedPassword = HashPassword(newPass);

                SqlCommand update = new SqlCommand(
                    "UPDATE Users SET Password=@Password, ResetToken=NULL, TokenExpiry=NULL WHERE ResetToken=@Token", con);
                update.Parameters.AddWithValue("@Password", hashedPassword);
                update.Parameters.AddWithValue("@Token", token);
                update.ExecuteNonQuery();

                msg.Text = "Password reset successfully!";
                msg.CssClass = "success-text show";
                btnResetPassword.Enabled = false;
            }
        }

        private void ResetInputState()
        {
            txtPassword.CssClass = "input";
            txtConfirmPassword.CssClass = "input";
            lblPasswordError.Text = "";
            lblConfirmPasswordError.Text = "";
            msg.Text = "";
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }
    }
}
