using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace LaundryApp
{
    public partial class Machines : Page
    {
        private string ConStr
        {
            get { return ConfigurationManager.ConnectionStrings["LaundryConnection"].ConnectionString; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMachines();
                UpdateDashboard();
            }
        }

        private void BindMachines(string whereClause = null, SqlParameter[] parameters = null)
        {
            DataTable dt = new DataTable();

            try
            {
                using (SqlConnection con = new SqlConnection(ConStr))
                {
                    con.Open();
                    string sql = "SELECT * FROM Machines";
                    if (!string.IsNullOrEmpty(whereClause))
                        sql += " WHERE " + whereClause;
                    sql += " ORDER BY Name ASC";

                    using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
                    {
                        if (parameters != null)
                            da.SelectCommand.Parameters.AddRange(parameters);

                        da.Fill(dt);
                    }
                }

                rptMachines.DataSource = dt;
                rptMachines.DataBind();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "err",
                    $"alert('Error loading machines: {ex.Message}');", true);
            }
        }

        private DataTable GetMachines()
        {
            DataTable dt = new DataTable();
            try
            {
                using (SqlConnection con = new SqlConnection(ConStr))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Machines", con))
                    {
                        da.Fill(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "errGet",
                    $"alert('Error fetching machines: {ex.Message}');", true);
            }
            return dt;
        }

        private void UpdateDashboard()
        {
            try
            {
                DataTable machines = GetMachines();

                int total = machines.Rows.Count;
                int available = machines.AsEnumerable()
                    .Count(r => r["Status"].ToString() == "Available");
                int inUse = machines.AsEnumerable()
                    .Count(r => r["Status"].ToString() == "In Use");
                int maintenance = machines.AsEnumerable()
                    .Count(r => r["Status"].ToString() == "Maintenance");

                lblTotalMachines.Text = total.ToString();
                lblAvailable.Text = available.ToString();
                lblInUse.Text = inUse.ToString();
                lblMaintenance.Text = maintenance.ToString();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "errDash",
                    $"alert('Dashboard error: {ex.Message}');", true);
            }
        }

        protected void btnSaveMachine_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Machines (MachineID, Name, Type, Status, UsageCount) " +
                        "VALUES (NEWID(), @Name, @Type, @Status, @UsageCount)", con))
                    {
                        cmd.Parameters.AddWithValue("@Name", txtMachineName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@UsageCount", new Random().Next(50, 200));

                        cmd.ExecuteNonQuery();
                    }
                }

                // clear modal inputs
                txtMachineName.Text = string.Empty;
                ddlType.SelectedIndex = 0;
                ddlStatus.SelectedIndex = 0;

                BindMachines();
                UpdateDashboard();
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "errAdd",
                    $"alert('Error adding machine: {ex.Message}');", true);
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim().ToLower();

            if (string.IsNullOrEmpty(keyword))
            {
                BindMachines();
                return;
            }

            try
            {
                SqlParameter[] prms =
                {
                    new SqlParameter("@kw", "%" + keyword + "%")
                };

                BindMachines("LOWER(Name) LIKE @kw OR LOWER(Type) LIKE @kw", prms);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "errSearch",
                    $"alert('Search failed: {ex.Message}');", true);
            }
        }

        protected void btnUpdateMachine_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE Machines SET Status = @Status WHERE MachineID = @MachineID", con))
                    {
                        cmd.Parameters.AddWithValue("@Status", ddlEditStatusModal.SelectedValue);
                        cmd.Parameters.AddWithValue("@MachineID", hiddenEditMachineIdModal.Value);
                        cmd.ExecuteNonQuery();
                    }
                }

                BindMachines();
                UpdateDashboard();

                ScriptManager.RegisterStartupScript(this, GetType(), "okUpdate",
                    "alert('Machine updated successfully!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "errUpdate",
                    $"alert('Error updating machine: {ex.Message}');", true);
            }
        }

        protected void btnDeleteMachine_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConStr))
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(
                        "DELETE FROM Machines WHERE MachineID = @MachineID", con))
                    {
                        cmd.Parameters.AddWithValue("@MachineID", hiddenEditMachineIdModal.Value);
                        cmd.ExecuteNonQuery();
                    }
                }

                BindMachines();
                UpdateDashboard();

                ScriptManager.RegisterStartupScript(this, GetType(), "okDelete",
                    "alert('Machine deleted successfully!');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "errDelete",
                    $"alert('Error deleting machine: {ex.Message}');", true);
            }
        }

        // Used in the Repeater to color status text (optional, but nice)
        protected string GetStatusCss(string status)
        {
            switch (status)
            {
                case "Available": return "status-available";
                case "In Use": return "status-inuse";
                case "Maintenance": return "status-maintenance";
                default: return string.Empty;
            }
        }
    }
}
