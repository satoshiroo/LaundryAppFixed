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
            if (!IsPostBack)
            {
                // Call method to load customer data into the table
                LoadCustomerData();
            }
        }

        private void LoadCustomerData()
        {
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "SELECT UserID, CONCAT(FirstName, ' ', LastName) AS Name, ContactNumber, Address FROM Users WHERE UserRole = 'Customer'";  // Corrected query

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the data to the GridView
                CustomerTable.DataSource = dt;
                CustomerTable.DataBind();
            }
        }

        // Event handlers for editing and deleting rows
        protected void CustomerTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            // Implement edit functionality (e.g., redirect to an edit page or show a modal)
            int customerId = Convert.ToInt32(CustomerTable.DataKeys[e.NewEditIndex].Value);
            Response.Redirect($"EditCustomer.aspx?CustomerID={customerId}");
        }

        protected void CustomerTable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Implement delete functionality
            int customerId = Convert.ToInt32(CustomerTable.DataKeys[e.RowIndex].Value);

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "DELETE FROM Users WHERE UserID = @CustomerID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            // Reload the customer data to reflect the deletion
            LoadCustomerData();
        }

        protected void btnSaveCustomer_Click(object sender, EventArgs e)
        {
            // Save new customer logic
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "INSERT INTO Users (FirstName, LastName, ContactNumber, Address, UserRole) VALUES (@FirstName, @LastName, @ContactNumber, @Address, 'Customer')";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                cmd.Parameters.AddWithValue("@ContactNumber", txtContactNumber.Text);
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            // Refresh the customer table
            LoadCustomerData();
        }
    }
}