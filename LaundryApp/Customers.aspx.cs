using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaundryApp
{
    public partial class Customers : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Load customer data only on first page load, not on postbacks
            if (!IsPostBack)
            {
                LoadCustomerData();
            }
        }

        // Method to load all customers into GridView
        private void LoadCustomerData()
        {
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "SELECT UserID, FirstName, LastName, ContactNumber, Address FROM Users WHERE UserRole='Customer'";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                CustomerTable.DataSource = dt;
                CustomerTable.DataBind(); // Bind data to GridView
            }
        }

        // Add new customer
        protected void btnSaveCustomer_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string contact = txtContactNumber.Text.Trim();
            string address = txtAddress.Text.Trim();

            // Validation: First and Last Name are required
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('First Name and Last Name are required.');", true);
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;

            // Generate a unique username to avoid UNIQUE constraint violation
            string generatedUsername = firstName.ToLower() + lastName.ToLower() + DateTime.Now.Ticks;

            string query = @"INSERT INTO Users 
                             (FirstName, LastName, ContactNumber, Address, UserRole, Username)
                             VALUES (@FirstName, @LastName, @ContactNumber, @Address, 'Customer', @Username)";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@ContactNumber", contact);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@Username", generatedUsername); // Unique username

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery(); // Insert customer
                }
                catch (SqlException ex)
                {
                    // Friendly error message
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        $"alert('Error saving customer: {ex.Message}');", true);
                    return;
                }
                finally
                {
                    conn.Close();
                }
            }

            // Clear modal fields after saving
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtContactNumber.Text = "";
            txtAddress.Text = "";

            LoadCustomerData(); // Refresh GridView

            // Close modal using JavaScript
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "$('#AddCustomerModal').modal('hide');", true);
        }

        // Start editing a row
        protected void CustomerTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            CustomerTable.EditIndex = e.NewEditIndex;
            LoadCustomerData();
        }

        // Cancel editing
        protected void CustomerTable_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            CustomerTable.EditIndex = -1;
            LoadCustomerData();
        }

        // Update customer details
        protected void CustomerTable_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(CustomerTable.DataKeys[e.RowIndex].Value);
            GridViewRow row = CustomerTable.Rows[e.RowIndex];

            string firstName = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
            string lastName = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
            string contact = ((TextBox)row.Cells[3].Controls[0]).Text.Trim();
            string address = ((TextBox)row.Cells[4].Controls[0]).Text.Trim();

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "UPDATE Users SET FirstName=@FirstName, LastName=@LastName, ContactNumber=@ContactNumber, Address=@Address WHERE UserID=@UserID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@ContactNumber", contact);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@UserID", id);

                conn.Open();
                cmd.ExecuteNonQuery(); // Update customer
                conn.Close();
            }

            CustomerTable.EditIndex = -1; // Exit edit mode
            LoadCustomerData();
        }

        // Delete a customer
        protected void CustomerTable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(CustomerTable.DataKeys[e.RowIndex].Value);
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "DELETE FROM Users WHERE UserID=@UserID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UserID", id);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            LoadCustomerData();
        }

        // Add confirmation dialog for delete
        protected void CustomerTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Control control in e.Row.Cells[5].Controls)
                {
                    if (control is LinkButton btn && btn.CommandName == "Delete")
                    {
                        btn.Attributes["onclick"] = "return confirm('Are you sure you want to delete this customer?');";
                    }
                }
            }
        }

        protected void CustomerTable_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
