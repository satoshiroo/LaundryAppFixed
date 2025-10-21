using System;
using System.IO;
using System.Web.UI.HtmlControls;

namespace LaundryApp
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentPage = Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            SetActiveClass(dashboardLink, currentPage.Contains("dashboard"));
            SetActiveClass(ordersLink, currentPage.Contains("orders"));
            SetActiveClass(inventoryLink, currentPage.Contains("inventory"));
            SetActiveClass(machinesLink, currentPage.Contains("machines"));
            SetActiveClass(messagesLink, currentPage.Contains("messages"));
        }

        private void SetActiveClass(HtmlAnchor link, bool isActive)
        {
            string existingClass = link.Attributes["class"] ?? "";
            if (isActive)
            {
                if (!existingClass.Contains("active"))
                    link.Attributes["class"] = existingClass + " active";
            }
            else
            {
                link.Attributes["class"] = existingClass.Replace(" active", "");
            }
        }
    }
}
