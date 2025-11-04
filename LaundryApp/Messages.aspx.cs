using System;
using System.Collections.Generic;
using System.Linq;

namespace LaundryApp
{
    public partial class Messages : System.Web.UI.Page
    {
        private static List<ChatMessage> messages = new List<ChatMessage>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dummy customer messages (for testing)
                if (messages.Count == 0)
                {
                    messages.Add(new ChatMessage { Sender = "user", Text = "Hi, can I check my laundry?", Timestamp = DateTime.Now.AddMinutes(-25) });
                    messages.Add(new ChatMessage { Sender = "user", Text = "Also, is Dryer #2 available?", Timestamp = DateTime.Now.AddMinutes(-10) });
                }

                BindMessages();
            }
        }

        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(txtReply.Text))
            {
                messages.Add(new ChatMessage
                {
                    Sender = "admin",
                    Text = txtReply.Text.Trim(),
                    Timestamp = DateTime.Now
                });

                txtReply.Text = string.Empty;
                BindMessages();
            }
        }

        private void BindMessages()
        {
            rptMessages.DataSource = messages.OrderBy(m => m.Timestamp);
            rptMessages.DataBind();
        }

        public class ChatMessage
        {
            public string Sender { get; set; } // "user" or "admin"
            public string Text { get; set; }
            public DateTime Timestamp { get; set; }
        }
    }
}
