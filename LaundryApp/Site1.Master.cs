using System;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Site1 : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] != null)
            {
                string userRole = Session["UserRole"].ToString();

                if (userRole == "Admin")
                {
                    // Admin: Show admin-specific links
                    customersLink.Visible = true;
                    inventoryLink.Visible = true;
                    machinesLink.Visible = true;
                }
                else if (userRole == "Customer")
                {
                    // User: Hide admin-specific links
                    customersLink.Visible = false;
                    inventoryLink.Visible = false;
                    machinesLink.Visible = false;
                }
            }
            else
            {
                // If not logged in, redirect to login page
                Response.Redirect("Login.aspx");
            }
        }
    }
}