using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.UI.WebControls;

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

                // Fetch customer name and contact number from database based on session or logged-in user
                if (Session["UserID"] != null)
                {
                    string userID = Session["UserID"].ToString(); // Get the UserID from session
                    string query = "SELECT FirstName, LastName, ContactNumber FROM Users WHERE UserID = @UserID"; // Add ContactNumber to the query

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

                        // Combine first and last name and set the textbox value for Customer Name
                        txtCustomerName.Text = firstName + " " + lastName;

                        // Set the ContactNumber textbox value
                        txtContact.Text = contactNumber;
                    }

                    reader.Close();
                    con.Close();
                }

                // Optionally load saved addresses if needed
                LoadSavedAddresses();
            }
        }


        void LoadOrders()
        {
            try
            {
                // Define the SQL query to fetch orders with customer names from the Users table
                string query = @"SELECT 
                    o.OrderID, 
                    u.FirstName + ' ' + u.LastName AS CustomerName, 
                    o.Contact, 
                    o.Status, 
                    o.TotalAmount, 
                    o.OrderDate, 
                    o.PickupDate, 
                    o.DeliveryDate, 
                    u.Address AS DeliveryAddress,  -- Fetching the Address directly from Users table
                    o.UserID
                FROM dbo.Orders o
                INNER JOIN dbo.Users u ON o.UserID = u.UserID; ";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Bind the data to the Repeater
                rptOrders.DataSource = dt;
                rptOrders.DataBind();

                // Update the summary cards
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

        void LoadSavedAddresses()
        {
            try
            {
                string query = "SELECT Address FROM Users WHERE UserID = @UserID"; // Use the Users table
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                da.SelectCommand.Parameters.AddWithValue("@UserID", 1);  // Replace with logged-in user ID or session

                DataTable dt = new DataTable();
                da.Fill(dt);  // This will now fill the DataTable with the address for the user

                if (dt != null && dt.Rows.Count > 0)
                {
                    // Populate the dropdown with the fetched address
                    ddlSavedAddress.DataSource = dt;
                    ddlSavedAddress.DataTextField = "Address";  // Set Address as the text
                    ddlSavedAddress.DataValueField = "Address";  // Optionally, use Address as the value
                    ddlSavedAddress.DataBind();
                }
                else
                {
                    // Handle no addresses found case
                    ddlSavedAddress.Items.Add(new ListItem("No addresses found", "0"));
                }
            }
            catch (Exception ex)
            {
                // Log or display the error message
                Response.Write("<script>alert('Error loading addresses: " + ex.Message + "');</script>");
            }
        }

        protected void ddlPickupDelivery_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlPickupDelivery.SelectedValue == "Pickup")
            {
                // Show Pickup Date and hide Delivery Address
                txtPickupDate.Visible = true;
                txtAddress.Visible = false;
                ddlSavedAddress.Visible = false;
            }
            else if (ddlPickupDelivery.SelectedValue == "Delivery")
            {
                // Show Delivery Address and hide Pickup Date
                txtPickupDate.Visible = false;
                txtAddress.Visible = true;
                ddlSavedAddress.Visible = true;
            }
        }

        // Handle saving the new order
        protected void btnSaveOrder_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if the form is for Pickup or Delivery
                string pickupOrDelivery = ddlPickupDelivery.SelectedValue;

                // Handle Pickup or Delivery logic
                DateTime pickupDate = DateTime.MinValue;
                string deliveryAddress = string.Empty;

                if (pickupOrDelivery == "Pickup")
                {
                    // Pickup date is mandatory when Pickup option is selected
                    pickupDate = DateTime.Parse(txtPickupDate.Text);
                }
                else if (pickupOrDelivery == "Delivery")
                {
                    // For Delivery, address or saved address must be selected
                    if (ddlSavedAddress.SelectedValue != "0")
                    {
                        deliveryAddress = ddlSavedAddress.SelectedValue;
                    }
                    else
                    {
                        deliveryAddress = txtAddress.Text;
                    }
                }

                // Insert the new order into the database
                string query = "INSERT INTO Orders (CustomerName, Contact, ServiceType, PickupDate, DeliveryDate, TotalAmount, Status, DateCreated, DeliveryAddress) " +
                               "VALUES (@CustomerName, @Contact, @ServiceType, @PickupDate, @DeliveryDate, @TotalAmount, @Status, GETDATE(), @DeliveryAddress)";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text);
                cmd.Parameters.AddWithValue("@Contact", txtContact.Text);
                cmd.Parameters.AddWithValue("@ServiceType", rblServiceType.SelectedValue);
                cmd.Parameters.AddWithValue("@PickupDate", pickupOrDelivery == "Pickup" ? pickupDate : (object)DBNull.Value);
                cmd.Parameters.AddWithValue("@DeliveryDate", DateTime.Now);  // You can adjust the delivery date logic as needed
                cmd.Parameters.AddWithValue("@TotalAmount", decimal.Parse(txtTotal.Text));
                cmd.Parameters.AddWithValue("@Status", "Pending");  // Default status as Pending
                cmd.Parameters.AddWithValue("@DeliveryAddress", string.IsNullOrEmpty(deliveryAddress) ? (object)DBNull.Value : deliveryAddress);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                // Clear form after submission
                txtCustomerName.Text = "";
                txtContact.Text = "";
                txtPickupDate.Text = "";
                txtAddress.Text = "";

                // Reload orders after submitting
                LoadOrders();
            }
            catch (Exception ex)
            {
                // Handle any errors during the insert
                Response.Write("<script>alert('Error adding order: " + ex.Message + "');</script>");
            }
        }
    }
}