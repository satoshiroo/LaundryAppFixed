using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace LaundryApp
{
    public partial class Customers : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadCustomers();
        }

        void LoadCustomers()
        {
            SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Customers ORDER BY CustomerID DESC", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridCustomers.DataSource = dt;
            GridCustomers.DataBind();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO Customers(Name, Contact, Address) VALUES(@Name, @Contact, @Address)", con);
            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Contact", txtContact.Text);
            cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
            cmd.ExecuteNonQuery();
            con.Close();

            txtName.Text = txtContact.Text = txtAddress.Text = "";
            LoadCustomers();
        }

        protected void GridCustomers_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridCustomers.DataKeys[e.RowIndex].Value);
            con.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Customers WHERE CustomerID=@id", con);
            cmd.Parameters.AddWithValue("@id", id);
            cmd.ExecuteNonQuery();
            con.Close();

            LoadCustomers();
        }
    }
}
