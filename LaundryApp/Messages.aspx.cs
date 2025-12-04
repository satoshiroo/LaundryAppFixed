using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Text;
using System.Web;

namespace LaundryApp
{
    public partial class Messages : Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role = Session["UserRole"].ToString();
            AdminPanel.Visible = (role == "Admin");
            UserPanel.Visible = (role == "Customer");

            if (!IsPostBack)
            {
                LoadUsers();
                LoadMessages();
            }
        }

        private void LoadUsers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT UserId, Username FROM Users WHERE UserRole='Customer'";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptUsers.DataSource = dt;
                rptUsers.DataBind();
            }
        }

        private void LoadMessages()
        {
            if (Session["UserRole"] == null) return;
            string role = Session["UserRole"].ToString();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT Sender, MessageText FROM Messages ORDER BY SentDate";
                SqlCommand cmd = new SqlCommand(query, conn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    var sbAdmin = new StringBuilder();
                    var sbUser = new StringBuilder();

                    while (reader.Read())
                    {
                        string sender = reader["Sender"].ToString();
                        string msg = reader["MessageText"].ToString();
                        string cssClass = "user"; // default grey

                        // Determine bubble color based on logged-in user
                        if (role == "Admin")
                        {
                            cssClass = sender == "Admin" ? "admin" : "user";
                        }
                        else // Customer logged in
                        {
                            cssClass = sender == "Customer" ? "admin" : "user";
                        }

                        string formatted = $"<div class='message {cssClass}'>{HttpUtility.HtmlEncode(msg)}</div>";
                        sbAdmin.Append(formatted);
                        sbUser.Append(formatted);
                    }

                    litMessages.Text = sbAdmin.ToString();
                    litUserMessages.Text = sbUser.ToString();
                }
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string msg = txtReply.Text.Trim();
            if (string.IsNullOrEmpty(msg)) return;

            SaveMessage("Admin", msg);

            string cssClass = Session["UserRole"].ToString() == "Admin" ? "admin" : "user";

            litMessages.Text += $"<div class='message {cssClass}'>{HttpUtility.HtmlEncode(msg)}</div>";
            litUserMessages.Text += $"<div class='message {cssClass}'>{HttpUtility.HtmlEncode(msg)}</div>";
            txtReply.Text = "";
        }

        protected void btnUserSend_Click(object sender, EventArgs e)
        {
            string msg = txtUserReply.Text.Trim();
            if (string.IsNullOrEmpty(msg)) return;

            SaveMessage("Customer", msg);

            string cssClass = Session["UserRole"].ToString() == "Customer" ? "admin" : "user";

            litMessages.Text += $"<div class='message {cssClass}'>{HttpUtility.HtmlEncode(msg)}</div>";
            litUserMessages.Text += $"<div class='message {cssClass}'>{HttpUtility.HtmlEncode(msg)}</div>";
            txtUserReply.Text = "";
        }

        private void SaveMessage(string senderRole, string message)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Messages (Sender, MessageText, SentDate) VALUES (@Sender, @MessageText, GETDATE())";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Sender", senderRole);
                cmd.Parameters.AddWithValue("@MessageText", message);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
