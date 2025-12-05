using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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
            // Prevent caching of the login page
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Hide message initially
            if (!IsPostBack)
            {
                msg.Visible = false;
            }

            // If already logged in
            if (Session["UserRole"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }

        // HASH PASSWORD WITH SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();

                foreach (byte b in bytes)
                    sb.AppendFormat("{0:x2}", b);

                return sb.ToString();
            }
        }

        protected void signin_Click(object sender, EventArgs e)
        {
            string usernameOrEmail = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string hashedPassword = HashPassword(password);

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

            // YOU CAN USE EITHER USERNAME OR EMAIL HERE
            string query = @"
                SELECT UserID, UserRole 
                FROM Users 
                WHERE (Username = @User OR Email = @User)
                AND Password = @Password";

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@User", SqlDbType.VarChar).Value = usernameOrEmail;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = hashedPassword;

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();

                        Session["UserID"] = reader["UserID"].ToString();
                        Session["UserRole"] = reader["UserRole"].ToString();

                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        ShowError("Invalid username or password!");
                    }
                }
                catch (Exception ex)
                {
                    ShowError("An error occurred: " + ex.Message);
                }
            }
        }

        // REUSABLE ERROR MESSAGE FUNCTION
        private void ShowError(string message)
        {
            msg.Text = message;
            msg.Visible = true;
            msg.ForeColor = System.Drawing.Color.Red;

            // Fade-in animation (JS)
            ScriptManager.RegisterStartupScript(this, GetType(), "showError", "showErrorMessage();", true);
        }
    }
}