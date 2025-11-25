using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace LaundryApp
{
    public partial class Orders : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        // Load orders from the database and bind to the Repeater
        void LoadOrders()
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Orders ORDER BY DateCreated DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the data to Repeater
                rptOrders.DataSource = dt;
                rptOrders.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
            }
        }

        // Add a new order
        protected void btnSaveOrder_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Orders (CustomerName, Contact, Total, Status, DateCreated) VALUES (@n,@c,@t,@s,GETDATE())", con);

                // Add parameters for the SQL command
                cmd.Parameters.AddWithValue("@n", txtCustomerName.Text);
                cmd.Parameters.AddWithValue("@c", txtContact.Text);
                cmd.Parameters.AddWithValue("@t", txtTotal.Text);
                cmd.Parameters.AddWithValue("@s", ddlStatus.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                // Clear the input fields after the data is saved
                txtCustomerName.Text = txtContact.Text = txtTotal.Text = "";
                ddlStatus.SelectedIndex = 0;

                // Reload the orders list
                LoadOrders();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error adding order: " + ex.Message + "');</script>");
            }
        }

        // Handle Search functionality
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            if (!string.IsNullOrEmpty(searchQuery))
            {
                try
                {
                    SqlDataAdapter da = new SqlDataAdapter(
                        "SELECT * FROM Orders WHERE CustomerName LIKE '%' + @searchQuery + '%' ORDER BY DateCreated DESC", con);
                    da.SelectCommand.Parameters.AddWithValue("@searchQuery", searchQuery);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind the search results to the Repeater
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error searching orders: " + ex.Message + "');</script>");
                }
            }
        }

        // Get status class for CSS
        protected string GetStatusCss(string status)
        {
            switch (status)
            {
                case "Pending":
                    return "status-pending";
                case "In Progress":
                    return "status-progress";
                case "Completed":
                    return "status-completed";
                default:
                    return "";
            }
        }
    }
}
