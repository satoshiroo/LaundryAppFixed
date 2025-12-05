using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;

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

                if (role == "Admin")
                {
                    litMessages.Text = "";
                }
                else
                {
                    LoadMessages(Session["UserId"].ToString());
                }
            }
        }

        // LOAD CUSTOMER LIST + SEARCH
        private void LoadUsers()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT UserId, Username 
                                 FROM Users 
                                 WHERE UserRole = 'Customer'
                                   AND Username LIKE '%' + @Search + '%'";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                da.SelectCommand.Parameters.AddWithValue("@Search", txtsearch.Text.Trim());

                DataTable dt = new DataTable();
                da.Fill(dt);

                rptUsers.DataSource = dt;
                rptUsers.DataBind();
            }
        }

        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            LoadUsers();
        }

        // LOAD CHAT BETWEEN ADMIN AND CUSTOMER
        private void LoadMessages(string customerId)
        {
            string loggedInRole = Session["UserRole"].ToString(); // Admin or Customer
            string adminId = "ADMIN";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = @"
                    SELECT SenderID, MessageText
                    FROM Messages
                    WHERE (SenderID = @Admin AND ReceiverID = @Cust)
                       OR (SenderID = @Cust AND ReceiverID = @Admin)
                    ORDER BY DateSent ASC
                ";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Admin", adminId);
                cmd.Parameters.AddWithValue("@Cust", customerId);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    StringBuilder sbAdmin = new StringBuilder();
                    StringBuilder sbUser = new StringBuilder();

                    while (reader.Read())
                    {
                        string sender = reader["SenderID"].ToString();
                        string msg = reader["MessageText"].ToString();

                        string bubbleClass;

                        // Determine bubble side based on logged-in role
                        if (loggedInRole == "Admin")
                            bubbleClass = sender == adminId ? "right" : "left";
                        else
                            bubbleClass = sender == customerId ? "right" : "left";

                        sbAdmin.Append($"<div class='message {bubbleClass}'>{msg}</div>");
                        sbUser.Append($"<div class='message {bubbleClass}'>{msg}</div>");
                    }

                    litMessages.Text = sbAdmin.ToString();
                    litUserMessages.Text = sbUser.ToString();
                }
            }
        }

        protected void User_Click(object sender, EventArgs e)
        {
            string customerId = (sender as System.Web.UI.WebControls.LinkButton).CommandArgument;
            HiddenSelectedUser.Value = customerId;
            LoadMessages(customerId);
        }

        // ADMIN SEND MESSAGE
        protected void btnSend_Click(object sender, EventArgs e)
        {
            string msg = txtReply.Text.Trim();
            if (string.IsNullOrEmpty(msg)) return;

            string customerId = HiddenSelectedUser.Value;
            string adminId = "ADMIN";

            SaveMessage(adminId, customerId, msg);

            // Append dynamically
            litMessages.Text += $"<div class='message right'>{HttpUtility.HtmlEncode(msg)}</div>";
            txtReply.Text = "";
        }

        // USER SEND MESSAGE
        protected void btnUserSend_Click(object sender, EventArgs e)
        {
            string msg = txtUserReply.Text.Trim();
            string imageHtml = "";
            string customerId = Session["UserId"].ToString();
            string adminId = "ADMIN";

            if (FileUpload1.HasFile)
            {
                string ext = Path.GetExtension(FileUpload1.FileName).ToLower();

                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                {
                    string fileName = Guid.NewGuid().ToString() + ext;
                    string savePath = Server.MapPath("~/uploads/" + fileName);
                    FileUpload1.SaveAs(savePath);

                    imageHtml = $"<img src='/uploads/{fileName}' width='150' />";

                }
            }

            if (string.IsNullOrEmpty(msg) && string.IsNullOrEmpty(imageHtml))
                return;

            SaveMessage(customerId, adminId, msg + imageHtml);

            litUserMessages.Text += $"<div class='message right'>{HttpUtility.HtmlEncode(msg)} {imageHtml}</div>";
            txtUserReply.Text = "";
        }

        // SAVE MESSAGE RECORD
        private void SaveMessage(string senderId, string receiverId, string message)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO Messages (SenderID, ReceiverID, MessageText, DateSent)
                    VALUES (@SenderID, @ReceiverID, @MessageText, GETDATE())
                ";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SenderID", senderId);
                cmd.Parameters.AddWithValue("@ReceiverID", receiverId);
                cmd.Parameters.AddWithValue("@MessageText", message);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
