using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Profile : Page
    {
 
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // Logout functionality
        protected void LogoutLink_Click(object sender, EventArgs e)
        {
           
            Session.Clear();
            Session.Abandon();

            // I-clear ang cache para walang naiiwang session data sa browser
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

        
            Response.Redirect("Login.aspx");
        }

      
        protected void Changepass_Btn_Click(object sender, EventArgs e)
        {
         
            if (Session["UserID"] == null)
            {
                AlertAndRedirect("Session expired. Please login again.", "Login.aspx");
                return;
            }

            string userID = Session["UserID"].ToString(); 
            string currentPass = currentpassword.Text.Trim();
            string newPass = newpassword.Text.Trim(); 
            string confirmPass = confirmpassword.Text.Trim();

            // 2️⃣ Validate inputs
            if (string.IsNullOrEmpty(currentPass) ||
                string.IsNullOrEmpty(newPass) ||
                string.IsNullOrEmpty(confirmPass))
            {
                Alert("All fields are required!");
                ClearPasswordFields();
                return;
            }

            if (newPass != confirmPass)
            {
                Alert("New password and confirm password do not match!");
                ClearPasswordFields();
                return;
            }

    
            string currentHash = HashPassword(currentPass);
            string newHash = HashPassword(newPass);

            string cs = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

      
                string username = "";
                string getUserSql = "SELECT Username FROM Users WHERE UserID=@UserID";
                using (SqlCommand cmd = new SqlCommand(getUserSql, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userID);
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                        username = result.ToString();
                    else
                    {
                        Alert("User not found!");
                        return;
                    }
                }


                string checkSql = "SELECT COUNT(*) FROM Users WHERE Username=@Username AND Password=@Password";
                using (SqlCommand cmd = new SqlCommand(checkSql, con))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", currentHash);

                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    if (count == 0)
                    {
                        Alert("Current password is incorrect!");
                        ClearPasswordFields();
                        return;
                    }
                }

    
                string updateSql = "UPDATE Users SET Password=@NewPass WHERE Username=@Username";
                using (SqlCommand cmd = new SqlCommand(updateSql, con))
                {
                    cmd.Parameters.AddWithValue("@NewPass", newHash);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.ExecuteNonQuery();
                }

         
                Alert("Password changed successfully!");
                ClearPasswordFields();
            }
        }

   
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

        private void Alert(string message)
        {
            string safeMessage = message.Replace("'", "\\'");
            Response.Write($"<script>alert('{safeMessage}');</script>");
        }

        private void AlertAndRedirect(string message, string redirectUrl)
        {
            string safeMessage = message.Replace("'", "\\'");
            Response.Write($"<script>alert('{safeMessage}'); window.location='{redirectUrl}';</script>");
        }

        private void ClearPasswordFields()
        {
            currentpassword.Text = "";
            newpassword.Text = "";
            confirmpassword.Text = "";
        }
    }
}
