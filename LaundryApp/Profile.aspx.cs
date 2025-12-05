using System;
using System.Web;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Profile : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LogoutLink_Click(object sender, EventArgs e)
        {
            // Clear session data
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();

            // Prevent page caching so user can’t go back after logout
            Response.Cache.SetExpires(DateTime.UtcNow.AddMinutes(-1));
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            // Redirect back to Login page
            Response.Redirect("Login.aspx");
        }
    }

    }


  