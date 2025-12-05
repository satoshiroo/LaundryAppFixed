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
                LoadCustomerData();
            }
        }

        private void LoadCustomerData()
        {
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "SELECT UserID, FullName, ContactNumber, Address FROM Users WHERE UserRole='Customer'";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                CustomerTable.DataSource = dt;
                CustomerTable.DataBind();
            }
        }

        protected void btnSaveCustomer_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string contact = txtContactNumber.Text.Trim();
            string address = txtAddress.Text.Trim();

            if (string.IsNullOrEmpty(fullName))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Full Name is required.');", true);
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string generatedUsername = fullName.ToLower().Replace(" ", "") + DateTime.Now.Ticks;

            string query = @"INSERT INTO Users 
                             (FullName, ContactNumber, Address, UserRole, Username)
                             VALUES (@FullName, @ContactNumber, @Address, 'Customer', @Username)";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@ContactNumber", contact);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@Username", generatedUsername);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (SqlException ex)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                        $"alert('Error saving customer: {ex.Message}');", true);
                    return;
                }
            }

            txtFullName.Text = "";
            txtContactNumber.Text = "";
            txtAddress.Text = "";

            LoadCustomerData();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseModal", "$('#AddCustomerModal').modal('hide');", true);
        }

        protected void CustomerTable_RowEditing(object sender, GridViewEditEventArgs e)
        {
            CustomerTable.EditIndex = e.NewEditIndex;
            LoadCustomerData();
        }

        protected void CustomerTable_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            CustomerTable.EditIndex = -1;
            LoadCustomerData();
        }

        protected void CustomerTable_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(CustomerTable.DataKeys[e.RowIndex].Value);
            GridViewRow row = CustomerTable.Rows[e.RowIndex];

            string fullName = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
            string contact = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
            string address = ((TextBox)row.Cells[3].Controls[0]).Text.Trim();

            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
            string query = "UPDATE Users SET FullName=@FullName, ContactNumber=@ContactNumber, Address=@Address WHERE UserID=@UserID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FullName", fullName);
                cmd.Parameters.AddWithValue("@ContactNumber", contact);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@UserID", id);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

            CustomerTable.EditIndex = -1;
            LoadCustomerData();
        }

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

        protected void CustomerTable_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Control control in e.Row.Cells[4].Controls)
                {
                    if (control is LinkButton btn && btn.CommandName == "Delete")
                    {
                        btn.Attributes["onclick"] = "return confirm('Are you sure you want to delete this customer?');";
                    }
                }
            }
        }

        protected void CustomerTable_SelectedIndexChanged(object sender, EventArgs e) { }
    }
}