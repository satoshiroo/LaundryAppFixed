using System;
using System.Collections.Generic;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Inventory : System.Web.UI.Page
    {
        private static List<Product> products = new List<Product>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial dummy data
                if (products.Count == 0)
                {
                    products.Add(new Product { ProductID = 1, ProductName = "Detergent", Quantity = 20, Price = 5.99M });
                    products.Add(new Product { ProductID = 2, ProductName = "Fabric Softener", Quantity = 15, Price = 4.49M });
                }

                BindGrid();
            }
        }

        protected void btnSaveProduct_Click(object sender, EventArgs e)
        {
            int nextId = products.Count + 1;
            products.Add(new Product
            {
                ProductID = nextId,
                ProductName = txtProductName.Text,
                Quantity = int.Parse(txtQuantity.Text),
                Price = decimal.Parse(txtPrice.Text)
            });

            BindGrid();
        }

        private void BindGrid()
        {
            GridView1.DataSource = products;
            GridView1.DataBind();
        }

        public class Product
        {
            public int ProductID { get; set; }
            public string ProductName { get; set; }
            public int Quantity { get; set; }
            public decimal Price { get; set; }
        }
    }
}
