using System;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Profile : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Example data (replace these with actual dynamic data)
                EmailLabel.Text = "user@example.com";
                AccountIDLabel.Text = "12345";
                AccountCreatedLabel.Text = "October 18, 2025";
            }
        }
    }
}

  