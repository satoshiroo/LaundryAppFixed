using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;

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

                    string query = "SELECT FirstName, LastName, ContactNumber, Address, UserRole FROM Users WHERE UserID = @UserID";
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
                            string userRole = reader["UserRole"].ToString();

                            txtCustomerName.Text = firstName + " " + lastName;
                            txtContact.Text = contactNumber;
                            txtAddress.Text = address;

                            // Debugging output
                            Debug.WriteLine($"Fetched Data: {firstName} {lastName}, {contactNumber}, {address}, Role: {userRole}");

                            if (userRole == "Admin")
                            {
                                AdminView.Visible = true;
                                UserView.Visible = false;
                            }
                            else if (userRole == "Customer")
                            {
                                AdminView.Visible = false;
                                UserView.Visible = true;
                            }
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



            // Make sure the orderID is passed as a string (if it's alphanumeric).
            if (Request.HttpMethod == "POST" && Request.Form["action"] == "updateStatus")
            {
                string orderID = Request.Form["orderID"];
                string status = Request.Form["status"];

                // Debugging log to ensure we have the correct data
                System.Diagnostics.Debug.WriteLine("Received orderID: " + orderID + " and status: " + status);

                // Update the database
                UpdateOrderStatus(orderID, status);
            }

        }


        private void UpdateOrderStatus(string orderID, string status)
        {
            string connString = ConfigurationManager.ConnectionStrings["LaundryConnection"].ToString();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE dbo.Orders SET Status = @Status WHERE OrderID = @OrderID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@OrderID", orderID);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    Response.Write("Status updated successfully!");  // Success message
                }
                catch (Exception ex)
                {
                    Response.Write("Error: " + ex.Message);  // Handle error
                }
                finally
                {
                    conn.Close();
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
                if (Session["UserID"] != null)
                {
                    int userID = Convert.ToInt32(Session["UserID"]);
                    string userRole = Session["UserRole"]?.ToString();

                    string query = "";
                    string countQuery = "";

                    if (userRole == "Admin")
                    {
                        query = @"
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
                CASE
                    WHEN o.PickupDate IS NOT NULL AND o.DeliveryDate IS NULL THEN 'Pickup: ' + CONVERT(varchar, o.PickupDate, 101)
                    WHEN o.DeliveryDate IS NOT NULL AND o.PickupDate IS NULL THEN 'Delivery: ' + CONVERT(varchar, o.DeliveryDate, 101)
                    ELSE 'Not Provided'
                END AS DueDate
            FROM dbo.Orders o
            INNER JOIN dbo.Users u ON o.UserID = u.UserID";

                        countQuery = "SELECT COUNT(*) FROM dbo.Orders";
                    }
                    else
                    {
                        query = @"
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
                CASE
                    WHEN o.PickupDate IS NOT NULL AND o.DeliveryDate IS NULL THEN 'Pickup: ' + CONVERT(varchar, o.PickupDate, 101)
                    WHEN o.DeliveryDate IS NOT NULL AND o.PickupDate IS NULL THEN 'Delivery: ' + CONVERT(varchar, o.DeliveryDate, 101)
                    ELSE 'Not Provided'
                END AS DueDate
            FROM dbo.Orders o
            INNER JOIN dbo.Users u ON o.UserID = u.UserID
            WHERE o.UserID = @UserID";

                        countQuery = "SELECT COUNT(*) FROM dbo.Orders WHERE UserID = @UserID";
                    }

                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                    {
                        // Fetch the total count of orders
                        SqlCommand cmdCount = new SqlCommand(countQuery, con);
                        if (userRole == "Customer")
                        {
                            cmdCount.Parameters.AddWithValue("@UserID", userID);
                        }

                        con.Open();
                        int totalOrders = Convert.ToInt32(cmdCount.ExecuteScalar());

                        // Count Pending Orders
                        SqlCommand cmdPendingCount = new SqlCommand("SELECT COUNT(*) FROM dbo.Orders WHERE Status = 'Pending'", con);
                        int pendingOrders = Convert.ToInt32(cmdPendingCount.ExecuteScalar());

                        // Count InProgress Orders
                        SqlCommand cmdInProgressCount = new SqlCommand("SELECT COUNT(*) FROM dbo.Orders WHERE Status = 'In Progress'", con);
                        int inProgressOrders = Convert.ToInt32(cmdInProgressCount.ExecuteScalar());

                        // Count Completed Orders
                        SqlCommand cmdCompletedCount = new SqlCommand("SELECT COUNT(*) FROM dbo.Orders WHERE Status = 'Completed'", con);
                        int completedOrders = Convert.ToInt32(cmdCompletedCount.ExecuteScalar());

                        // Close the connection after counting
                        con.Close();

                        // Update the summary card labels
                        Label1.Text = totalOrders.ToString();    // Total Orders
                        Label2.Text = pendingOrders.ToString();  // Pending Orders
                        Label3.Text = inProgressOrders.ToString(); // In Progress Orders
                        Label4.Text = completedOrders.ToString();  // Completed Orders

                        // Fetch order details for the specific user role
                        SqlCommand cmd = new SqlCommand(query, con);
                        if (userRole == "Customer")
                        {
                            cmd.Parameters.AddWithValue("@UserID", userID);
                        }

                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Bind the data based on the user role
                        if (userRole == "Admin")
                        {
                            Repeater1.DataSource = dt;  // Bind to Admin repeater
                            Repeater1.DataBind();
                        }
                        else if (userRole == "Customer")
                        {
                            rptOrders.DataSource = dt;  // Bind to Customer repeater
                            rptOrders.DataBind();
                        }

                        // Update the count of different statuses in the summary
                        lblTotalOrders.Text = dt.Rows.Count.ToString();
                        lblPending.Text = dt.Select("Status = 'Pending'").Length.ToString();
                        lblInProgress.Text = dt.Select("Status = 'In Progress'").Length.ToString();
                        lblCompleted.Text = dt.Select("Status = 'Completed'").Length.ToString();
                    }
                }
                else
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading orders: " + ex.Message + "');</script>");
            }
        }






        // Function to fetch service details (ServiceID and Price)
        private Tuple<int, decimal> GetServiceDetails(string serviceName)
        {
            int serviceID = 0;
            decimal price = 0;

            string query = "SELECT ServiceID, Price FROM dbo.Services WHERE ServiceName = @ServiceName";

            // Using 'using' statement for connection management
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
            {
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
            }

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

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                {
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
            }
            else
            {
                LoadOrders(); // Reload orders if search term is empty
            }
        }

        private string GenerateOrderID()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";  // Letters and numbers
            Random random = new Random();
            char[] orderID = new char[6]; // 6-character OrderID

            for (int i = 0; i < orderID.Length; i++)
            {
                orderID[i] = chars[random.Next(chars.Length)];
            }

            string generatedOrderID = new string(orderID);
            Debug.WriteLine("Generated OrderID: " + generatedOrderID);  // Log the generated OrderID for debugging
            return generatedOrderID;
        }

        protected void btnSaveOrder_Click(object sender, EventArgs e)
        {
            try
            {
                // Generate the OrderID
                string orderID = GenerateOrderID();  // Generate unique OrderID
                Debug.WriteLine("Generated OrderID: " + orderID);  // Log OrderID for debugging

                string pickupOrDelivery = ddlPickupDelivery.SelectedValue;
                DateTime pickupDate = DateTime.MinValue;
                DateTime? deliveryDate = null; // Nullable for delivery date
                string deliveryAddress = string.Empty;
                string specialInstructions = txtSpecialInstructions.Text;  // Fetch Special Instructions

                // Pickup or Delivery logic
                if (pickupOrDelivery == "Pickup")
                {
                    if (!string.IsNullOrEmpty(txtPickupDate.Value))
                    {
                        pickupDate = DateTime.Parse(txtPickupDate.Value);
                    }
                }
                else if (pickupOrDelivery == "Delivery")
                {
                    deliveryAddress = txtAddress.Text;
                    if (!string.IsNullOrEmpty(txtDeliveryDate.Value))
                    {
                        deliveryDate = DateTime.Parse(txtDeliveryDate.Value);
                    }
                }

                // Get the service type and price
                string serviceType = "";
                if (Request.Form["service"] != null)
                {
                    serviceType = Request.Form["service"];  // Get the selected service
                }
                else
                {
                    Response.Write("<script>alert('Please select a service!');</script>");
                    return;  // Exit if no service is selected
                }

                // Fetch service details from the database
                var serviceDetails = GetServiceDetails(serviceType);
                int serviceID = serviceDetails.Item1;
                decimal servicePrice = serviceDetails.Item2;

                // Calculate total amount
                decimal totalAmount = servicePrice;

                // Insert the order into the database, including generated OrderID
                string queryInsert = "INSERT INTO Orders (OrderID, CustomerName, Contact, ServiceType, PickupDate, DeliveryDate, TotalAmount, Status, DateCreated, DeliveryAddress, SpecialInstructions, UserID, ServiceID) " +
                                     "VALUES (@OrderID, @CustomerName, @Contact, @ServiceType, @PickupDate, @DeliveryDate, @TotalAmount, @Status, GETDATE(), @DeliveryAddress, @SpecialInstructions, @UserID, @ServiceID)";

                SqlCommand cmdInsert = new SqlCommand(queryInsert, con);

                // Add parameters for the order
                cmdInsert.Parameters.AddWithValue("@OrderID", orderID);  // Insert the custom OrderID
                cmdInsert.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text);
                cmdInsert.Parameters.AddWithValue("@Contact", txtContact.Text);
                cmdInsert.Parameters.AddWithValue("@ServiceType", serviceType);
                cmdInsert.Parameters.AddWithValue("@PickupDate", pickupOrDelivery == "Pickup" ? pickupDate : (object)DBNull.Value);
                cmdInsert.Parameters.AddWithValue("@DeliveryDate", deliveryDate.HasValue ? (object)deliveryDate.Value : DBNull.Value);
                cmdInsert.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmdInsert.Parameters.AddWithValue("@Status", "Pending");  // Default status
                cmdInsert.Parameters.AddWithValue("@DeliveryAddress", string.IsNullOrEmpty(deliveryAddress) ? (object)DBNull.Value : deliveryAddress);
                cmdInsert.Parameters.AddWithValue("@SpecialInstructions", string.IsNullOrEmpty(specialInstructions) ? (object)DBNull.Value : specialInstructions);
                cmdInsert.Parameters.AddWithValue("@UserID", Session["UserID"]);
                cmdInsert.Parameters.AddWithValue("@ServiceID", serviceID);  // Save ServiceID

                Debug.WriteLine("Executing query: " + queryInsert);  // Log the query for debugging

                // Execute the query
                con.Open();
                int rowsAffected = cmdInsert.ExecuteNonQuery();
                con.Close();

                Debug.WriteLine("Rows affected: " + rowsAffected);  // Log the number of rows affected

                if (rowsAffected > 0)
                {
                    // Clear the form after submission
                    txtCustomerName.Text = "";
                    txtContact.Text = "";
                    txtPickupDate.Value = "";
                    txtAddress.Text = "";
                    txtSpecialInstructions.Text = "";  // Clear Special Instructions
                    txtDeliveryDate.Value = "";  // Clear Delivery Date

                    // Reload orders after submitting
                    Response.Redirect(Request.Url.ToString(), true);
                }
                else
                {
                    Response.Write("<script>alert('Order could not be added.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error adding order: " + ex.Message + "');</script>");
            }
        }


    }
}