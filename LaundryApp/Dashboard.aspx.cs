using System;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaundryApp
{
    public partial class Dashboard : Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["LaundryConnection"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent caching of the Dashboard page
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Check if the user is logged in (session exists)
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx", true); // Redirect to login if session is not set
            }

            // Get user role from session
            string userRole = Session["UserRole"]?.ToString();

            // Show content based on the role
            if (userRole == "Admin")
            {
                adminContent.Visible = true; // Show admin content
                userContent.Visible = false; // Hide user content
            }
            else if (userRole == "User")
            {
                adminContent.Visible = false; // Hide admin content
                userContent.Visible = true; // Show user content
            }

            // Fetch data for dashboard
            LoadDashboardData();
        }

        private void LoadDashboardData()
        {
            // Define variables for the stats
            int todayOrders = 0;
            int inProgress = 0;
            int readyForPickup = 0;
            decimal totalRevenue = 0;

            // Use 'using' statement to ensure connection is disposed properly
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();

                    // Get Today's Orders
                    string queryTodayOrders = "SELECT COUNT(*) FROM Orders WHERE CAST(DateCreated AS DATE) = CAST(GETDATE() AS DATE)";
                    SqlCommand cmdTodayOrders = new SqlCommand(queryTodayOrders, con);
                    todayOrders = (int)cmdTodayOrders.ExecuteScalar();

                    // Get In Progress Orders
                    string queryInProgress = "SELECT COUNT(*) FROM Orders WHERE Status = 'In Progress'";
                    SqlCommand cmdInProgress = new SqlCommand(queryInProgress, con);
                    inProgress = (int)cmdInProgress.ExecuteScalar();

                    // Get Ready for Pickup Orders
                    string queryReadyForPickup = "SELECT COUNT(*) FROM Orders WHERE Status = 'Ready'";
                    SqlCommand cmdReadyForPickup = new SqlCommand(queryReadyForPickup, con);
                    readyForPickup = (int)cmdReadyForPickup.ExecuteScalar();

                    // Get Total Revenue
                    string queryTotalRevenue = "SELECT SUM(TotalAmount) FROM Orders";
                    SqlCommand cmdTotalRevenue = new SqlCommand(queryTotalRevenue, con);
                    totalRevenue = (decimal)cmdTotalRevenue.ExecuteScalar();

                    // Bind the data to the dashboard controls (Summary Cards)
                    Label1.Text = todayOrders.ToString();
                    lblInProgress.Text = inProgress.ToString();
                    lblReadyForPickup.Text = readyForPickup.ToString();
                    lblTotalRevenue.Text = totalRevenue.ToString("₱{0:N2}"); // Format as currency

                    // Debugging log
                    Debug.WriteLine("Today's Orders: " + todayOrders);
                    Debug.WriteLine("In Progress: " + inProgress);
                    Debug.WriteLine("Ready for Pickup: " + readyForPickup);
                    Debug.WriteLine("Total Revenue: " + totalRevenue);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error loading dashboard data: " + ex.Message);
                }
            }

            // Load Recent Orders
            LoadRecentOrders();
        }

        private void LoadRecentOrders()
        {
            string queryRecentOrders = "SELECT TOP 6 OrderID, CustomerName, PhoneNumber, ServiceType, TotalAmount, DateCreated FROM Orders ORDER BY DateCreated DESC";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();

                    SqlCommand cmdRecent = new SqlCommand(queryRecentOrders, con);
                    SqlDataReader reader = cmdRecent.ExecuteReader();

                    // Bind the data to the GridView (for recent orders display)
                    RecentOrdersGridView.DataSource = reader;
                    RecentOrdersGridView.DataBind();

                    reader.Close();
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("Error loading recent orders: " + ex.Message);
                }
            }
        }

        protected void RecentOrdersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string serviceType = e.Row.Cells[2].Text; // Assuming the ServiceType is in the 3rd column
                if (serviceType == "Washing")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.Color.LightBlue;
                }
                else if (serviceType == "Drying")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.Color.LightYellow;
                }
                else if (serviceType == "Ironing")
                {
                    e.Row.Cells[2].BackColor = System.Drawing.Color.LightGreen;
                }
            }
        }
    }
}
