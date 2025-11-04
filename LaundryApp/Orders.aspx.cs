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

        void LoadOrders()
        {
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Orders ORDER BY DateCreated DESC", con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewOrders.DataSource = dt;
                GridViewOrders.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
            }
        }

        protected void btnAddOrder_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand(
                    "INSERT INTO Orders (CustomerName, Contact, Total, Status, DateCreated) VALUES (@n,@c,@t,@s,GETDATE())", con);

                cmd.Parameters.AddWithValue("@n", txtCustomerName.Text);
                cmd.Parameters.AddWithValue("@c", txtContact.Text);
                cmd.Parameters.AddWithValue("@t", txtTotal.Text);
                cmd.Parameters.AddWithValue("@s", ddlStatus.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                txtCustomerName.Text = txtContact.Text = txtTotal.Text = "";
                ddlStatus.SelectedIndex = 0;

                LoadOrders();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error adding order: " + ex.Message + "');</script>");
            }
        }
    }
}
