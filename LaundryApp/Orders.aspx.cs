using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;

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

                // Fetch customer name, contact number, and address from the database
                if (Session["UserID"] != null)
                {
                    string userID = Session["UserID"].ToString(); // Get the UserID from session
                    string query = "SELECT FirstName, LastName, ContactNumber, Address FROM Users WHERE UserID = @UserID"; // Fetch Address as well

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();
                        string firstName = reader["FirstName"].ToString();
                        string lastName = reader["LastName"].ToString();
                        string contactNumber = reader["ContactNumber"].ToString(); // Fetch ContactNumber from the database
                        string address = reader["Address"].ToString(); // Fetch Address from the database

                        // Combine first and last name and set the textbox value for Customer Name
                        txtCustomerName.Text = firstName + " " + lastName;

                        // Set the ContactNumber textbox value
                        txtContact.Text = contactNumber;

                        // Set the current address in the address textbox
                        txtAddress.Text = address;
                    }
                    else
                    {
                        Debug.WriteLine("No customer data found for the given UserID.");
                    }

                    reader.Close();
                    con.Close();
                }

                // Set default selection to "Pickup"
                ddlPickupDelivery.SelectedValue = "Pickup";
            }
        }

        protected void ddlPickupDelivery_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlPickupDelivery.SelectedValue;
            ToggleFieldsVisibility(selectedValue);
        }

        private void ToggleFieldsVisibility(string selectedValue)
        {
            if (selectedValue == "Pickup")
            {
                // Show Pickup Date, Hide Delivery Address
                pickupDateDiv.Visible = true;
                deliveryAddressDiv.Visible = false;
            }
            else if (selectedValue == "Delivery")
            {
                // Hide Pickup Date, Show Delivery Address
                pickupDateDiv.Visible = false;
                deliveryAddressDiv.Visible = true;
            }
        }

        void LoadOrders()
        {
            try
            {
                string query = @"SELECT 
                    o.OrderID, 
                    u.FirstName + ' ' + u.LastName AS CustomerName, 
                    o.Contact, 
                    o.Status, 
                    o.TotalAmount, 
                    o.OrderDate, 
                    o.PickupDate, 
                    o.DeliveryDate, 
                    u.Address AS DeliveryAddress,  
                    o.UserID
                FROM dbo.Orders o
                INNER JOIN dbo.Users u ON o.UserID = u.UserID; ";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptOrders.DataSource = dt;
                rptOrders.DataBind();

                lblTotalOrders.Text = dt.Rows.Count.ToString();
                lblPending.Text = dt.Select("Status = 'Pending'").Length.ToString();
                lblInProgress.Text = dt.Select("Status = 'In Progress'").Length.ToString();
                lblCompleted.Text = dt.Select("Status = 'Completed'").Length.ToString();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
            }
        }

        // Function to fetch the service details (ServiceID and Price)
        private Tuple<int, decimal> GetServiceDetails(string serviceName)
        {
            int serviceID = 0;
            decimal price = 0;

            string query = "SELECT ServiceID, Price FROM dbo.Services WHERE ServiceName = @ServiceName";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@ServiceName", serviceName);

            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                reader.Read();
                serviceID = Convert.ToInt32(reader["ServiceID"]);
                price = Convert.ToDecimal(reader["Price"]);
            }
            con.Close();

            return new Tuple<int, decimal>(serviceID, price);
        }

        // Add the event handler for btnSearch
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Value.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                string query = @"SELECT 
                    o.OrderID, 
                    u.FirstName + ' ' + u.LastName AS CustomerName, 
                    o.Contact, 
                    o.Status, 
                    o.TotalAmount, 
                    o.OrderDate, 
                    o.PickupDate, 
                    o.DeliveryDate, 
                    u.Address AS DeliveryAddress,  
                    o.UserID
                FROM dbo.Orders o
                INNER JOIN dbo.Users u ON o.UserID = u.UserID
                WHERE o.OrderID LIKE @SearchTerm OR u.FirstName LIKE @SearchTerm OR u.LastName LIKE @SearchTerm OR o.Status LIKE @SearchTerm";

                SqlCommand cmdSearch = new SqlCommand(query, con);
                cmdSearch.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");

                SqlDataAdapter da = new SqlDataAdapter(cmdSearch);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptOrders.DataSource = dt;
                rptOrders.DataBind();

                lblTotalOrders.Text = dt.Rows.Count.ToString();
                lblPending.Text = dt.Select("Status = 'Pending'").Length.ToString();
                lblInProgress.Text = dt.Select("Status = 'In Progress'").Length.ToString();
                lblCompleted.Text = dt.Select("Status = 'Completed'").Length.ToString();
            }
            else
            {
                LoadOrders(); // Reload all orders if search term is empty
            }
        }

        protected void btnSaveOrder_Click(object sender, EventArgs e)
        {
            try
            {
                string pickupOrDelivery = ddlPickupDelivery.SelectedValue;
                DateTime pickupDate = DateTime.MinValue;
                DateTime? deliveryDate = null; // Nullable for delivery date
                string deliveryAddress = string.Empty;
                string specialInstructions = txtSpecialInstructions.Text;  // Fetch Special Instructions

                if (pickupOrDelivery == "Pickup")
                {
                    // Pickup date is mandatory when Pickup option is selected
                    if (!string.IsNullOrEmpty(txtPickupDate.Value))
                    {
                        pickupDate = DateTime.Parse(txtPickupDate.Value);
                    }
                }
                else if (pickupOrDelivery == "Delivery")
                {
                    // Use the current address fetched from the database (displayed in the text box)
                    deliveryAddress = txtAddress.Text;

                    // Fetch the preferred delivery date from the input
                    if (!string.IsNullOrEmpty(txtDeliveryDate.Value))
                    {
                        deliveryDate = DateTime.Parse(txtDeliveryDate.Value);  // Store preferred delivery date
                    }
                }

                // Get service type and fetch the price from the database
                string serviceType = "";
                if (Request.Form["service"] != null)
                {
                    serviceType = Request.Form["service"];  // Get the selected service value from the form
                }
                else
                {
                    // Handle the case when no service is selected
                    Response.Write("<script>alert('Please select a service!');</script>");
                    return;  // Exit if no service is selected
                }

                // Fetch the service details from the database
                var serviceDetails = GetServiceDetails(serviceType);
                int serviceID = serviceDetails.Item1;
                decimal servicePrice = serviceDetails.Item2;

                // Calculate the total amount
                decimal totalAmount = servicePrice;

                // Insert the order into the database, including Special Instructions and Preferred Delivery Date
                string queryInsert = "INSERT INTO Orders (CustomerName, Contact, ServiceType, PickupDate, DeliveryDate, TotalAmount, Status, DateCreated, DeliveryAddress, SpecialInstructions, UserID, ServiceID) " +
                                     "VALUES (@CustomerName, @Contact, @ServiceType, @PickupDate, @DeliveryDate, @TotalAmount, @Status, GETDATE(), @DeliveryAddress, @SpecialInstructions, @UserID, @ServiceID)";
                SqlCommand cmdInsert = new SqlCommand(queryInsert, con);

                cmdInsert.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text);
                cmdInsert.Parameters.AddWithValue("@Contact", txtContact.Text);
                cmdInsert.Parameters.AddWithValue("@ServiceType", serviceType);
                cmdInsert.Parameters.AddWithValue("@PickupDate", pickupOrDelivery == "Pickup" ? pickupDate : (object)DBNull.Value);
                cmdInsert.Parameters.AddWithValue("@DeliveryDate", deliveryDate.HasValue ? (object)deliveryDate.Value : DBNull.Value);  // Handle Nullable DeliveryDate
                cmdInsert.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmdInsert.Parameters.AddWithValue("@Status", "Pending");  // Default status
                cmdInsert.Parameters.AddWithValue("@DeliveryAddress", string.IsNullOrEmpty(deliveryAddress) ? (object)DBNull.Value : deliveryAddress);
                cmdInsert.Parameters.AddWithValue("@SpecialInstructions", string.IsNullOrEmpty(specialInstructions) ? (object)DBNull.Value : specialInstructions); // Add Special Instructions
                cmdInsert.Parameters.AddWithValue("@UserID", Session["UserID"]);
                cmdInsert.Parameters.AddWithValue("@ServiceID", serviceID);  // Save ServiceID

                // Execute the query
                con.Open();
                cmdInsert.ExecuteNonQuery();
                con.Close();

                // Clear form after submission
                txtCustomerName.Text = "";
                txtContact.Text = "";
                txtPickupDate.Value = "";
                txtAddress.Text = "";
                txtSpecialInstructions.Text = "";  // Clear Special Instructions
                txtDeliveryDate.Value = "";  // Clear Delivery Date

                // Reload orders after submitting
                LoadOrders();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error adding order: " + ex.Message + "');</script>");
            }
        }

    }
}
