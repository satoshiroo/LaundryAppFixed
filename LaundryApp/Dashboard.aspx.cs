using System;
using System.Web;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Prevent caching of the Dashboard page
            Response.Cache.SetExpires(DateTime.Now.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Check if the user is logged in (session exists)
            if (Session["UserRole"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            // Optionally, check user role and show appropriate content
            string userRole = Session["UserRole"].ToString();
            if (userRole == "Admin")
            {
                adminContent.Visible = true;
                userContent.Visible = false;
            }
            else if (userRole == "User")
            {
                adminContent.Visible = false;
                userContent.Visible = true;
            }
        }


    }
}
