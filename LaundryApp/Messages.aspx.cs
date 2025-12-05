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
                    SELECT SenderID, MessageText, ImagePath
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
                        string img = reader["ImagePath"] != DBNull.Value ? reader["ImagePath"].ToString() : null;

                        string bubbleClass = (loggedInRole == "Admin")
                            ? (sender == adminId ? "right" : "left")
                            : (sender == customerId ? "right" : "left");

                        // Append text message
                        if (!string.IsNullOrEmpty(msg))
                            sbAdmin.Append($"<div class='message {bubbleClass}'>{HttpUtility.HtmlEncode(msg)}</div>");
                        if (!string.IsNullOrEmpty(img))
                            sbAdmin.Append($"<div class='message {bubbleClass}'><img src='{img}' width='150' /></div>");

                        if (!string.IsNullOrEmpty(msg))
                            sbUser.Append($"<div class='message {bubbleClass}'>{HttpUtility.HtmlEncode(msg)}</div>");
                        if (!string.IsNullOrEmpty(img))
                            sbUser.Append($"<div class='message {bubbleClass}'><img src='{img}' width='150' /></div>");
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

            SaveMessage(adminId, customerId, msg, null);

            // Append dynamically
            litMessages.Text += $"<div class='message right'>{HttpUtility.HtmlEncode(msg)}</div>";
            txtReply.Text = "";
        }

        // USER SEND MESSAGE
        protected void btnUserSend_Click(object sender, EventArgs e)
        {
            string msg = txtUserReply.Text.Trim();
            string customerId = Session["UserId"].ToString();
            string adminId = "ADMIN";
            string imagePath = null;

            // Handle image upload
            if (FileUpload1.HasFile)
            {
                string ext = Path.GetExtension(FileUpload1.FileName).ToLower();
                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                {
                    string fileName = Guid.NewGuid().ToString() + ext;
                    string savePath = Server.MapPath("~/uploads/" + fileName);
                    FileUpload1.SaveAs(savePath);
                    imagePath = "/uploads/" + fileName;
                }
            }

            // Nothing to send
            if (string.IsNullOrEmpty(msg) && string.IsNullOrEmpty(imagePath))
                return;

            // Save message to DB
            SaveMessage(customerId, adminId, msg, imagePath);

            // Render message in chat (text + image separately)
            StringBuilder sb = new StringBuilder();
            if (!string.IsNullOrEmpty(msg))
                sb.Append($"<div class='message right'>{HttpUtility.HtmlEncode(msg)}</div>");
            if (!string.IsNullOrEmpty(imagePath))
                sb.Append($"<div class='message right'><img src='{imagePath}' width='150' /></div>");

            litUserMessages.Text += sb.ToString();
            txtUserReply.Text = "";
        }

        // SAVE MESSAGE RECORD
        private void SaveMessage(string senderId, string receiverId, string message, string imagePath)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    INSERT INTO Messages (SenderID, ReceiverID, MessageText, ImagePath, DateSent)
                    VALUES (@SenderID, @ReceiverID, @MessageText, @ImagePath, GETDATE())
                ";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@SenderID", senderId);
                cmd.Parameters.AddWithValue("@ReceiverID", receiverId);
                cmd.Parameters.AddWithValue("@MessageText", message ?? "");
                cmd.Parameters.AddWithValue("@ImagePath", (object)imagePath ?? DBNull.Value);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}
