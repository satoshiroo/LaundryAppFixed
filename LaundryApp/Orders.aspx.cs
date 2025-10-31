using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LaundryApp
{
    public partial class Orders : System.Web.UI.Page
    {
        // Simple class for demo (replace later with your DB)
        public class Order
        {
            public int OrderID { get; set; }
            public string CustomerName { get; set; }
            public string Contact { get; set; }
            public string Status { get; set; }
            public decimal Total { get; set; }
            public DateTime OrderDate { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        private void BindOrders()
        {
            // Sample data for testing
            var orders = new List<Order>
            {
                new Order { OrderID = 1, CustomerName = "Sarah Johnson", Contact = "+1 (555) 234-5678", Status = "Drying", Total = 45.50m, OrderDate = DateTime.Now.AddDays(-1) },
                new Order { OrderID = 2, CustomerName = "Michael Chen", Contact = "+1 (555) 345-6789", Status = "Washing", Total = 72.00m, OrderDate = DateTime.Now.AddDays(-2) },
                new Order { OrderID = 3, CustomerName = "Emma Williams", Contact = "+1 (555) 456-7890", Status = "Ironing", Total = 95.00m, OrderDate = DateTime.Now.AddDays(-3) }
            };

            RepeaterOrders.DataSource = orders;
            RepeaterOrders.DataBind();
        }

        protected void RepeaterOrders_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteOrder")
            {
                int orderId = Convert.ToInt32(e.CommandArgument);
                // TODO: Delete from DB
                Response.Write($"<script>alert('Deleted Order #{orderId}');</script>");
                BindOrders();
            }
        }

        protected void btnSaveOrder_Click(object sender, EventArgs e)
        {
            // TODO: Save new order to DB later
            string name = txtCustomerName.Text;
            string contact = txtContact.Text;
            string status = ddlStatus.SelectedValue;
            decimal total = decimal.TryParse(txtTotal.Text, out decimal t) ? t : 0;

            Response.Write($"<script>alert('New Order Added: {name}');</script>");
            BindOrders();
        }

    }
}
