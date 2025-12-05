using System;
using System.Web.UI;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace LaundryApp
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent caching
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Check login
            if (Session["UserRole"] == null)
                Response.Redirect("Login.aspx");

            string UserRole = Session["UserRole"].ToString();

            adminContent.Visible = UserRole == "Admin";
            userContent.Visible = UserRole == "Customer";

            if (!IsPostBack)
            {
                LoadAdmin();
    
                LoadOrders();
            }
        }

        // Get first letter safely
        public string GetInitial(object firstName)
        {
            if (firstName == null) return "?";
            string name = firstName.ToString();
            return string.IsNullOrEmpty(name) ? "?" : name.Substring(0, 1).ToUpper();
        }

        private void LoadAdmin()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("SELECT Username, ContactNumber, Address FROM Users ", con);
                    con.Open();
                    UsersRepeater.DataSource = cmd.ExecuteReader();
                    UsersRepeater.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error loading users: " + ex.Message);
            }
        }

        private void LoadOrders()
        {
            try
            {
                string cs = ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand(
                        "SELECT CustomerName, Status, TotalAmount, DeliveryDate FROM Orders ORDER BY DeliveryDate DESC", con);
                    con.Open();
                    OrdersRepeater.DataSource = cmd.ExecuteReader();
                    OrdersRepeater.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error loading orders: " + ex.Message);
            }
        }

        // Handle order status badges
        protected void OrdersRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var dataItem = (System.Data.IDataRecord)e.Item.DataItem;
                string status = dataItem["Status"].ToString();

                Literal lit = (Literal)e.Item.FindControl("StatusLiteral");
                if (status == "Ready")
                    lit.Text = "<span class='badge bg-success'>Ready</span>";
                else
                    lit.Text = $"<span class='badge bg-warning'>{status}</span>";
            }
        }
    }
}
