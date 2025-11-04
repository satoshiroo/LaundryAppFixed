using System;
using System.Web.UI.HtmlControls;

namespace LaundryApp
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Highlight the active link based on the current page
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            SetActiveLink(currentPage);
        }

        private void SetActiveLink(string page)
        {
            // Reset all link classes
            dashboardLink.Attributes["class"] = "nav-link";
            ordersLink.Attributes["class"] = "nav-link";
            inventoryLink.Attributes["class"] = "nav-link";
            machinesLink.Attributes["class"] = "nav-link";
            messagesLink.Attributes["class"] = "nav-link";

            // Add 'active' class to current page
            switch (page.ToLower())
            {
                case "dashboard.aspx":
                    dashboardLink.Attributes["class"] += " active";
                    break;
                case "orders.aspx":
                    ordersLink.Attributes["class"] += " active";
                    break;
                case "inventory.aspx":
                    inventoryLink.Attributes["class"] += " active";
                    break;
                case "machines.aspx":
                    machinesLink.Attributes["class"] += " active";
                    break;
                case "messages.aspx":
                    messagesLink.Attributes["class"] += " active";
                    break;
                default:
                    break;
            }
        }
    }
}
