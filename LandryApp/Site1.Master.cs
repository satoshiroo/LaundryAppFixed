using System;
using System.IO;

namespace LandryApp
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string currentPage = System.IO.Path.GetFileName(Request.Path).ToLower();

            dashboardLink.Attributes["class"] = currentPage == "dashboard.aspx" ? "nav-link active" : "nav-link";
            ordersLink.Attributes["class"] = currentPage == "orders.aspx" ? "nav-link active" : "nav-link";
            newOrderLink.Attributes["class"] = currentPage == "neworder.aspx" ? "nav-link active" : "nav-link";
        }

        private void HighlightCurrentPage()
        {
            string currentPage = Path.GetFileName(Request.Path).ToLower();


        }
    }
}
