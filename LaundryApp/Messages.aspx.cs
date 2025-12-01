using System;
using System.Collections.Generic;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Messages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role = Session["UserRole"].ToString();


            if (!IsPostBack)
            {
                // Initial messages
                litAdminMessages.Text = 
                    "<div class='message user'>Hi, I need help with my laundry.</div>"+
                    "<div class='message admin'>Sige lods.</div>";

                litUserMessages.Text =
                    "<div class='message admin'>Sige lods.</div>" +
                    "<div class='message user'>Hi, I need help with my laundry.</div>";

                litUserMessages.Text = litAdminMessages.Text;
            }

            AdminPanel.Visible = (role == "Admin");
            UserPanel.Visible = (role == "Customer");
        }


        protected void btnAdminSend_Click(object sender, EventArgs e)
        {
            {
                string msg = txtAdminReply.Text;

                litAdminMessages.Text += $"<div class='message admin'>{msg}</div>";
                litUserMessages.Text += $"<div class='message admin'>{msg}</div>";

                txtAdminReply.Text = "";
            }
        }

        protected void btnUserSend_Click(object sender, EventArgs e)
        {
            string msg = txtUserReply.Text;

            litUserMessages.Text += $"<div class='message admin'>{msg}</div>";
            litAdminMessages.Text += $"<div class='message admin'>{msg}</div>";
            
         

            txtUserReply.Text = "";

        }
    }
}




