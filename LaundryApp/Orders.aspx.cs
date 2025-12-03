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
                Debug.WriteLine("Page_Load executed.");
                LoadOrders();

                // Fetch customer data when the page is loaded
                if (Session["UserID"] != null)
                {
                    string userID = Session["UserID"].ToString(); // Retrieve the UserID from session
                    Debug.WriteLine("Session UserID: " + userID); // Check if UserID is set correctly

                    string query = "SELECT FirstName, LastName, ContactNumber, Address FROM Users WHERE UserID = @UserID";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", userID);

                    try
                    {
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.HasRows)
                        {
                            reader.Read();
                            string firstName = reader["FirstName"].ToString();
                            string lastName = reader["LastName"].ToString();
                            string contactNumber = reader["ContactNumber"].ToString();
                            string address = reader["Address"].ToString();

                            // Combine first and last name and set the textbox value for Customer Name
                            txtCustomerName.Text = firstName + " " + lastName;

                            // Set the ContactNumber textbox value
                            txtContact.Text = contactNumber;

                            // Set the Address textbox value
                            txtAddress.Text = address;

                            Debug.WriteLine($"Fetched Data: {firstName} {lastName}, {contactNumber}, {address}");
                        }
                        else
                        {
                            Debug.WriteLine("No customer data found.");
                        }

                        reader.Close();
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine("Error: " + ex.Message);
                    }
                    finally
                    {
                        if (con.State == ConnectionState.Open)
                            con.Close();
                    }
                }
                else
                {
                    Debug.WriteLine("Session is null or expired.");
                    Response.Redirect("~/Login.aspx"); // If session expired, redirect to login page
                }
            }
        }


        // Handling the Pickup/Delivery selection change
        protected void ddlPickupDelivery_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlPickupDelivery.SelectedValue;
            ToggleFieldsVisibility(selectedValue);
        }

        // Toggle visibility of fields based on Pickup or Delivery selection
        private void ToggleFieldsVisibility(string selectedValue)
        {
            if (selectedValue == "Pickup")
            {
                // Show Pickup Date, Hide Delivery Address
                pickupDateDiv.Visible = true;
                deliveryAddressDiv.Visible = false;
                deliveryDateDiv.Visible = false; // Hide Delivery Date
            }
            else if (selectedValue == "Delivery")
            {
                // Hide Pickup Date, Show Delivery Address
                pickupDateDiv.Visible = false;
                deliveryAddressDiv.Visible = true;
                deliveryDateDiv.Visible = true; // Show Delivery Date
            }
        }

        // Function to load orders
        void LoadOrders()
        {
            try
            {
                // Ensure UserID is present in the session
                if (Session["UserID"] != null)
                {
                    int userID = Convert.ToInt32(Session["UserID"]); // Ensure UserID is converted to the correct type (int)

                    // Modified query to load orders for the logged-in user
                    string query = @"
                SELECT 
                    o.OrderID, 
                    u.FirstName + ' ' + u.LastName AS CustomerName, 
                    o.Contact, 
                    o.Status, 
                    o.TotalAmount, 
                    o.DateCreated AS OrderDate, 
                    o.PickupDate, 
                    o.DeliveryDate, 
                    u.Address AS DeliveryAddress,  
                    o.UserID,
                    o.ServiceType,
                    -- Dynamic DueDate Calculation
                    CASE
                        WHEN o.PickupDate IS NOT NULL AND o.DeliveryDate IS NULL THEN 'Pickup: ' + CONVERT(varchar, o.PickupDate, 101)
                        WHEN o.DeliveryDate IS NOT NULL AND o.PickupDate IS NULL THEN 'Delivery: ' + CONVERT(varchar, o.DeliveryDate, 101)
                        ELSE 'Not Provided'
                    END AS DueDate
                FROM dbo.Orders o
                INNER JOIN dbo.Users u ON o.UserID = u.UserID
                WHERE o.UserID = @UserID"; // Add filtering by UserID

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@UserID", userID); // Add parameter to query

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Check if there are any orders
                    if (dt.Rows.Count > 0)
                    {
                        Debug.WriteLine("Orders found: " + dt.Rows.Count); // Log the number of orders found
                    }
                    else
                    {
                        Debug.WriteLine("No orders found for this user.");
                    }

                    // Bind the data to the Repeater
                    rptOrders.DataSource = dt;
                    rptOrders.DataBind();

                    // Update the order summary labels
                    lblTotalOrders.Text = dt.Rows.Count.ToString();
                    lblPending.Text = dt.Select("Status = 'Pending'").Length.ToString();
                    lblInProgress.Text = dt.Select("Status = 'In Progress'").Length.ToString();
                    lblCompleted.Text = dt.Select("Status = 'Completed'").Length.ToString();
                }
                else
                {
                    Debug.WriteLine("UserID session is null or expired.");
                    Response.Redirect("~/Login.aspx"); // If session expired, redirect to login page
                }
            }
            catch (Exception ex)
            {
                // Log error and show alert if there's an issue loading orders
                Debug.WriteLine("Error loading orders: " + ex.Message);
                Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
            }
        }




        // Function to fetch service details (ServiceID and Price)
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

        // Search functionality for orders
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Value.Trim();
            if (!string.IsNullOrEmpty(searchTerm))
            {
                string query = @"
            SELECT 
                o.OrderID, 
                u.FirstName + ' ' + u.LastName AS CustomerName, 
                o.Contact, 
                o.Status, 
                o.TotalAmount, 
                o.DateCreated AS OrderDate, 
                o.PickupDate, 
                o.DeliveryDate, 
                u.Address AS DeliveryAddress,  
                o.UserID,
                o.ServiceType
            FROM dbo.Orders o
            INNER JOIN dbo.Users u ON o.UserID = u.UserID
            WHERE o.UserID = @UserID AND (o.OrderID LIKE @SearchTerm OR u.FirstName LIKE @SearchTerm OR u.LastName LIKE @SearchTerm OR o.Status LIKE @SearchTerm)";

                SqlCommand cmdSearch = new SqlCommand(query, con);
                cmdSearch.Parameters.AddWithValue("@SearchTerm", "%" + searchTerm + "%");
                cmdSearch.Parameters.AddWithValue("@UserID", Session["UserID"]); // Add filtering by UserID

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
                LoadOrders(); // Reload orders if search term is empty
            }
        }


        // Save order functionality
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
