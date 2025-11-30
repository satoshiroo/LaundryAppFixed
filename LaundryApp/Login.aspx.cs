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
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            if (!IsPostBack)
            {
                msg.Visible = false; // hide error initially
            }

            if (Session["UserRole"] != null)
            {
                Response.Redirect("Dashboard.aspx");
            }
        }
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


        protected void signin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string hashedPassword = HashPassword(password);



            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "SELECT UserRole FROM Users WHERE Username=@Username AND Password=@Password";

            using (SqlConnection conn = new SqlConnection(connString))
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                cmd.Parameters.Add("@Username", SqlDbType.VarChar).Value = username;
                cmd.Parameters.Add("@Password", SqlDbType.VarChar).Value = hashedPassword;

                try
                {
                    conn.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        string UserRole =  result.ToString();
                        Session["UserRole"] = UserRole;

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

        // Display error and trigger fade-in animation
        private void ShowError(string message)
        {
            msg.Text = message;
            msg.Visible = true;
            msg.ForeColor = System.Drawing.Color.Red;

            // Trigger JS function to show fade-in
            ScriptManager.RegisterStartupScript(this, GetType(), "showError", "showErrorMessage();", true);
        }
    }
}
