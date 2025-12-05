using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)  // Ensure data is only loaded once when the page is first loaded
            {
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ToString();

                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string query = "SELECT UserRole, DateCreation, Username, FullName, Email, ContactNumber, Address FROM Users WHERE UserId = @UserId";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserId", userId);

                            try
                            {
                                conn.Open();
                                SqlDataReader reader = cmd.ExecuteReader();

                                if (reader.Read())
                                {
                                    // Populate the textboxes with the database values
                                    uname.Text = reader["Username"].ToString();
                                    fname.Text = reader["FullName"].ToString();
                                    emailaddress.Text = reader["Email"].ToString();
                                    contactnumber.Text = reader["ContactNumber"].ToString();
                                    delivery_addrss.Text = reader["Address"].ToString();
                                }
                            }
                            catch (Exception ex)
                            {
                                Response.Write("Error: " + ex.Message);
                            }
                            finally
                            {
                                conn.Close();
                            }
                        }
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }



        // Logout functionality
        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();

            // Prevent page caching so user can’t go back after logout
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Redirect back to Login page
            Response.Redirect("Login.aspx");
        }

        // Upload profile picture functionality
        protected void UploadButton_Click(object sender, EventArgs e)
        {
            // Check if a file is selected
            if (FileUpload1.HasFile)
            {
                try
                {
                    // Get the file extension and ensure it's an image type (JPG, PNG, etc.)
                    string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName).ToLower();

                    if (fileExtension == ".jpg" || fileExtension == ".jpeg" || fileExtension == ".png" || fileExtension == ".gif")
                    {
                        // Define the relative path where the image will be saved
                        string fileName = FileUpload1.FileName;  // Retaining the original file name
                        string filePath = "~/Uploads/" + fileName;  // Save to the "Uploads" folder

                        // Use Server.MapPath to get the absolute path on the server
                        string serverPath = Server.MapPath(filePath);

                        // Open a stream to the uploaded file
                        using (var stream = FileUpload1.PostedFile.InputStream)
                        {
                            // Create a FileStream to save the uploaded file to the server
                            using (var fileStream = new System.IO.FileStream(serverPath, System.IO.FileMode.Create))
                            {
                                // Copy the content of the input stream (file) to the destination file stream
                                stream.CopyTo(fileStream);
                            }
                        }

                        // Set the Image control's ImageUrl to the uploaded file path (relative path for the browser)
                        Image2.ImageUrl = filePath;
                    }
                    else
                    {
                        // Display an error if the file is not an image
                        Response.Write("<script>alert('Please upload a valid image file (JPG, PNG, GIF).');</script>");
                    }
                }
                catch (Exception ex)
                {
                    // Display an error if something goes wrong
                    Response.Write("<script>alert('Error uploading file: " + ex.Message + "');</script>");
                }
            }
            else
            {
                // Display an alert if no file was selected
                Response.Write("<script>alert('Please select a file to upload.');</script>");
            }
        }

        protected void SaveChanges_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                int userId = Convert.ToInt32(Session["UserId"]);  // Get the UserId from the session

                // Get the values entered by the user in the textboxes
                string username = uname.Text;  // Get username from textbox
                string fullname = fname.Text;  // Get full name from textbox
                string email = emailaddress.Text;  // Get email from textbox
                string contact = contactnumber.Text;  // Get contact number from textbox
                string address = delivery_addrss.Text;  // Get address from textbox

                // Define the connection string
                string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ToString();

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    // SQL query to update user data
                    string query = "UPDATE Users SET Username = @Username, FullName = @FullName, Email = @Email, ContactNumber = @ContactNumber, Address = @Address WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to prevent SQL injection
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@FullName", fullname);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@ContactNumber", contact);
                        cmd.Parameters.AddWithValue("@Address", address);

                        try
                        {
                            conn.Open();
                            int rowsAffected = cmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                Response.Write("<script>alert('Your account information has been updated successfully.');</script>");
                            }
                            else
                            {
                                Response.Write("<script>alert('No changes were made.');</script>");
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('Error updating the data: " + ex.Message + "');</script>");
                        }
                        finally
                        {
                            conn.Close();
                        }
                    }
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
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
