using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaundryApp
{
    public partial class Inventory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadInventory();
            }
        }
        private void LoadInventory()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter("SELECT ProductID, ProductName, Quantity, Price FROM Inventory", con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            string productName = txtProductName.Text.Trim();
            int quantity = int.Parse(txtQuantity.Text.Trim());
            decimal price = decimal.Parse(txtPrice.Text.Trim());

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Inventory (ProductName, Quantity, Price) VALUES (@ProductName, @Quantity, @Price)", con);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@Price", price);

                cmd.ExecuteNonQuery(); // ItemID will be generated automatically
            }

            LoadInventory();  // Refresh the inventory after adding a new product
        }


        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            LoadInventory();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            LoadInventory();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            string productId = GridView1.DataKeys[e.RowIndex].Value.ToString();
            string productName = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditProductName")).Text;
            int quantity = int.Parse(((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditQuantity")).Text);
            decimal price = decimal.Parse(((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtEditPrice")).Text);

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Inventory SET ProductName = @ProductName, Quantity = @Quantity, Price = @Price WHERE ProductID = @ProductID", con);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@ProductID", productId);

                cmd.ExecuteNonQuery();
            }

            GridView1.EditIndex = -1;
            LoadInventory();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the ProductID from the DataKeys collection
            string productId = GridView1.DataKeys[e.RowIndex].Value.ToString();

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Inventory WHERE ProductID = @ProductID", con);
                cmd.Parameters.AddWithValue("@ProductID", productId);  // Use the ProductID as a parameter

                cmd.ExecuteNonQuery();  // Execute the query
            }

            LoadInventory();  // Reload the inventory grid to reflect the changes
        }


    }
}
