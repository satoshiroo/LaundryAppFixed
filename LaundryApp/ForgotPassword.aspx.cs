using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace Laundry_Login
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // On page load, reset error styling
            if (!IsPostBack)
            {
                ResetInputState();
            }
        }

        protected void btnForgot_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();

            // Reset styles at the start
            ResetInputState();

            // CLIENT-SIDE STYLE LIKE VALIDATION
            if (string.IsNullOrEmpty(username))
            {
                txtUsername.CssClass = "input error"; // add red border
                msg.Text = "Username is required!";
                msg.CssClass = "error-text show"; // show error text
                return;
            }

            string token = Guid.NewGuid().ToString();
            DateTime expiry = DateTime.Now.AddMinutes(30);

            string cs = ConfigurationManager.ConnectionStrings["laundryconnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // CHECK IF USERNAME EXISTS
                SqlCommand check = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Username=@Username", con);
                check.Parameters.AddWithValue("@Username", username);

                int exists = (int)check.ExecuteScalar();

                if (exists == 0)
                {
                    txtUsername.CssClass = "input error"; // add red border
                    msg.Text = "Username not found!";
                    msg.CssClass = "error-text show";
                    return;
                }

                // SAVE TOKEN TO DATABASE
                SqlCommand cmd = new SqlCommand(
                    "UPDATE Users SET ResetToken=@t, TokenExpiry=@x WHERE Username=@Username", con);

                cmd.Parameters.AddWithValue("@t", token);
                cmd.Parameters.AddWithValue("@x", expiry);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.ExecuteNonQuery();
            }

            // ✅ Redirect to reset password page
            Response.Redirect("resetpassword.aspx?token=" + token);
        }

        // HELPER: Reset input border and error message
        private void ResetInputState()
        {
            txtUsername.CssClass = "input";
            msg.Text = "";
            msg.CssClass = "error-text"; // hide by default
        }
    }
}
