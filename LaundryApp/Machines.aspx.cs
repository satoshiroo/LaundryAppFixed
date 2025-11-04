using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace LaundryApp
{
    public partial class Machines : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadMachines();
        }

        void LoadMachines()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Machines ORDER BY Name ASC", con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptMachines.DataSource = dt;
                    rptMachines.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error loading machines: " + ex.Message + "');</script>");
            }
        }

        protected void btnSaveMachine_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Machines (MachineID, Name, Type, Status, UsageCount) VALUES (NEWID(), @Name, @Type, @Status, @UsageCount)", con);

                    cmd.Parameters.AddWithValue("@Name", txtMachineName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@UsageCount", new Random().Next(50, 200));

                    cmd.ExecuteNonQuery();
                }

                // Clear inputs
                txtMachineName.Text = "";
                ddlType.SelectedIndex = 0;
                ddlStatus.SelectedIndex = 0;

                // Reload
                LoadMachines();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error adding machine: " + ex.Message + "');</script>");
            }
        }

        protected void rptMachines_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(
                        ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("DELETE FROM Machines WHERE MachineID = @id", con);
                        cmd.Parameters.AddWithValue("@id", e.CommandArgument.ToString());
                        cmd.ExecuteNonQuery();
                    }

                    LoadMachines();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error deleting machine: " + ex.Message + "');</script>");
                }
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();

            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                {
                    con.Open();

                    SqlDataAdapter da = new SqlDataAdapter(
                        "SELECT * FROM Machines WHERE LOWER(Name) LIKE @kw OR LOWER(Type) LIKE @kw", con);
                    da.SelectCommand.Parameters.AddWithValue("@kw", "%" + keyword + "%");

                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptMachines.DataSource = dt;
                    rptMachines.DataBind();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Search failed: " + ex.Message + "');</script>");
            }
        }

        protected string GetBorderColor(string type)
        {
            switch (type)
            {
                case "Washer": return "border-washer";
                case "Dryer": return "border-dryer";
                case "Press": return "border-press";
                case "Folder": return "border-folder";
                default: return "border-secondary";
            }
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand(
                        "UPDATE Machines SET Status = @Status WHERE MachineID = @ID", con);
                    cmd.Parameters.AddWithValue("@Status", ddlEditStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@ID", hiddenEditMachineId.Value);
                    cmd.ExecuteNonQuery();
                }

                LoadMachines();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error updating status: " + ex.Message + "');</script>");
            }
        }


    }
}
