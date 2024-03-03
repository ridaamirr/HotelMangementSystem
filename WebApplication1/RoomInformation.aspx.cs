using Microsoft.AspNet.FriendlyUrls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class RoomInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            if (!IsPostBack)
            {
               

                using (SqlConnection con = new SqlConnection(Hotel))
                {
                    SqlCommand cmd = new SqlCommand("Select * from Hotel", con);
                    con.Open();
                    DropDownList1.DataTextField = "Location";
                    DropDownList1.DataSource = cmd.ExecuteReader();
                    DropDownList1.DataBind();
                    con.Close();

                    SqlCommand cmd1 = new SqlCommand("Select * from RoomType", con);
                    con.Open();
                    DropDownList2.DataTextField = "RoomType_ID";
                    DropDownList2.DataSource = cmd1.ExecuteReader();
                    DropDownList2.DataBind();
                    con.Close();
                }

                GridView1.DataKeyNames = new string[] { "Room_ID" };

                // Get the search text from the session, if any
                searchText = "";
                BindGridView();
                unique.Visible = false;
            }

            string query = "SELECT Price, NumberOfBeds, Type FROM RoomType WHERE RoomType_ID=@id";

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", DropDownList2.SelectedItem.Value);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    type.Text = reader["Type"].ToString();
                    noofbeds.Text = reader["NumberOfBeds"].ToString();
                    price.Text = reader["Price"].ToString();
                }

                reader.Close();
            }
        }

        string searchText;
        protected void Add_Click(object sender, EventArgs e)
        {
            panel1.Visible = false;
            panel2.Visible = true;
            panel3.Visible = false;
            RoomNo.Text = "";
        }

        protected void Update_Delete_Click(object sender, EventArgs e)
        {
            panel1.Visible = false;
            panel3.Visible = true;
            panel2.Visible = false;
        }

        protected void AddRoom_Click(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            // Check if the updated RoomNumber already exists in the table for the same Branch_ID
            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();

                string query = "SELECT COUNT(*) FROM Room WHERE RoomNumber = @RoomNumber AND Branch_ID in (select Branch_ID from hotel where Location=@loc)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@RoomNumber", RoomNo.Text);
                    command.Parameters.AddWithValue("@loc", DropDownList1.SelectedItem.Value);
                  

                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        unique.Text = "Room Number already exists for the selected Branch";
                        unique.Visible = true;
                        return;
                    } 
                    else
                        unique.Visible = false;
                }
            }

            string branchid="";

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();

                string query = "select Branch_ID from hotel where Location=@loc";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@loc", DropDownList1.SelectedItem.Value);

                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        branchid = reader["Branch_ID"].ToString();
                    }
                    reader.Close();

                }
            }

            using (SqlConnection con = new SqlConnection(Hotel))
            {
                string query = "INSERT INTO Room (RoomNumber,RoomType_ID,Branch_ID)" +
                               "VALUES (@RoomNumber,@RoomType_ID,@Branch_ID)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@RoomNumber", RoomNo.Text);
                    
                    cmd.Parameters.AddWithValue("@RoomType_ID", DropDownList2.SelectedItem.Value);
                    cmd.Parameters.AddWithValue("@Branch_ID", branchid);
                 

                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        GridView1.DataKeyNames = new string[] { "Room_ID" };
                        // Get the search text from the session, if any
                        searchText = (string)Session["SearchText"];
                        BindGridView();

                        panel1.Visible = true;
                        panel2.Visible = false;

                    }
                    con.Close();

                }
            }

        }

        protected void Search_Click(object sender, EventArgs e)
        {
            searchText = SearchRoom.Text.Trim();
            Label1.Visible = false;
            Session["SearchText"] = searchText;
            BindGridView();
        }

        private void BindGridView()
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM ShowRooms";

                if (!string.IsNullOrEmpty(searchText))
                {
                    if (idradio.Checked)
                    {
                        int roomid;
                        if (int.TryParse(searchText, out roomid))
                        {
                            query += " WHERE Room_ID =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Room ID";
                            return;
                        }
                    }
                    else if (roomradio.Checked)
                    {
                        int roomnum;
                        if (int.TryParse(searchText, out roomnum))
                        {
                            query += " WHERE RoomNumber =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Room Number";
                            return;
                        }
                    }

                    else if (typeradio.Checked)
                    {
                        int roomtypeid;
                        if (int.TryParse(searchText, out roomtypeid))
                        {
                            query += " WHERE RoomType_ID =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Room Type ID";
                            return;
                        }
                    }
                    else if (branchradio.Checked)
                    {
                        query += " WHERE Location =@searchKeywords";
                       
                    }
                }

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (!string.IsNullOrEmpty(searchText))
                    {
                        command.Parameters.AddWithValue("@searchKeywords", searchText);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        // Filter the results based on the search criteria
                        if (!string.IsNullOrEmpty(searchText))
                        {

                            if (idradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Room_ID= '" + searchText + "'";
                            }
                            else if (roomradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "RoomNumber= '" + searchText + "'";
                            }
                           
                            else if (typeradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "RoomType_ID= '" + searchText + "'";
                            }
                           
                            else if (branchradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Location= '" + searchText + "'";
                            }
                        }

                        GridView1.DataSource = dt;
                        GridView1.DataBind();

                        if (dt.Rows.Count == 0)
                        {
                            lblError.Visible = true;
                            lblError.ForeColor = Color.Red;
                            lblError.Text = "No results found.";
                        }
                        else
                        {
                            lblError.Visible = false;
                        }
                    }
                }
            }
        }

        protected void DeleteRow(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            Label1.Visible = false;
            searcherror.Visible = false;
            // Check if the room ID is present in any unpaid bill
            if (HasUnpaidBills(id))
            {
                Label1.Text = "This Room cannot be deleted as it exists in an unpaid bill";
                Label1.Visible = true;
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM Room WHERE Room_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    command.ExecuteNonQuery();
                }
            }

            // Refresh the grid view to reflect the updated data
            BindGridView();
        }

        // Check if the room ID exists in any unpaid bill
        private bool HasUnpaidBills(int roomID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM Billing WHERE Billing_ID IN (SELECT Billing_ID FROM Booking WHERE Room_ID = @roomID) AND Status = 'Not Paid'";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@roomID", roomID);

                    int rowCount = (int)command.ExecuteScalar();

                    return rowCount > 0;
                }
            }
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Room_ID"]);
            DeleteRow(rowID);
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Update the database with the new values

            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Room_ID"]);

            // Get the updated values for the RoomNumber, RoomType_ID, and Branch_ID fields
            string updatedRoomNo = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtRoomNo")).Text;
            string updatedType = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList5")).SelectedValue;
            string updatedBranch = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList4")).SelectedValue;
            string oldRoomNumber = "";
            string oldRoomType = "";
            string oldBranch = "";
            // Validate the updated RoomNumber
            string RoomNoError = "";
            int price;
            if (string.IsNullOrEmpty(updatedRoomNo))
            {
                RoomNoError = "RoomNO cannot be empty";
            }
            else if (!int.TryParse(updatedRoomNo, out price) || price <= 0)
            {
                RoomNoError = "Enter a positive RoomNO";
            }
            else
            {
                GetOldRoomDetails(rowID, out oldRoomNumber, out oldRoomType, out oldBranch);
                Label1.Visible = false;

                if (HasUnpaidBills(rowID) && (updatedRoomNo != oldRoomNumber || updatedType != oldRoomType || updatedBranch != oldBranch))

                {
                    Label1.Visible = true;
                    Label1.ForeColor = Color.Red;
                    Label1.Text = "The Room information cannot be updated as it has an unpaid bills";
                    e.Cancel = true; // Cancel the update operations
                    return;
                }
                // Check if the updated RoomNumber already exists in the table for the same Branch_ID
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = "SELECT COUNT(*) FROM Room WHERE RoomNumber = @RoomNumber AND Branch_ID in(select Branch_ID from Hotel where Location=@Branch_loc) AND Room_ID != @id";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@RoomNumber", updatedRoomNo);
                        command.Parameters.AddWithValue("@Branch_loc", updatedBranch);
                        command.Parameters.AddWithValue("@id", rowID);

                        int count = (int)command.ExecuteScalar();

                        if (count > 0)
                        {
                            RoomNoError = "Room Number already exists for the selected Branch";
                        }
                    }
                }
            }

            // Update the database if there are no errors
            if (string.IsNullOrEmpty(RoomNoError))
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = "UPDATE Room SET RoomNumber = @RoomNumber, RoomType_ID = @Type, Branch_ID=(select Branch_ID from Hotel where Location=@Branch_loc) WHERE Room_ID = @id";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@RoomNumber", updatedRoomNo);
                        command.Parameters.AddWithValue("@Type", updatedType);
                        command.Parameters.AddWithValue("@Branch_loc", updatedBranch);
                        command.Parameters.AddWithValue("@id", rowID);

                        int rowsAffected = command.ExecuteNonQuery();

                        if (rowsAffected == 1)
                        {
                            GridView1.EditIndex = -1;
                            BindGridView();
                        }
                        else
                        {
                            lblError.Visible = true;
                            lblError.ForeColor = Color.Red;
                            lblError.Text = "Error updating record.";
                        }
                    }
                }
            }
            else
            {
                // Display the RoomNoError message
                Label RoomNoErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblRoomNoError");
                if (RoomNoErrorLabel != null)
                {
                    RoomNoErrorLabel.Text = RoomNoError;
                    RoomNoErrorLabel.ForeColor = Color.Red;
                }
            }
        }
        private void GetOldRoomDetails(int roomID, out string oldRoomNumber, out string oldRoomType, out string oldBranch)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT RoomNumber, RoomType_ID, Branch_ID FROM Room WHERE Room_ID = @roomID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@roomID", roomID);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            oldRoomNumber = reader["RoomNumber"].ToString();
                            oldRoomType = reader["RoomType_ID"].ToString();
                            int branchID = Convert.ToInt32(reader["Branch_ID"]);

                            // Close the existing SqlDataReader before executing the location query
                            reader.Close();

                            // Get the location from the Hotel table based on the branch ID
                            string locationQuery = "SELECT Location FROM Hotel WHERE Branch_ID = @branchID";

                            using (SqlCommand locationCommand = new SqlCommand(locationQuery, connection))
                            {
                                locationCommand.Parameters.AddWithValue("@branchID", branchID);

                                object result = locationCommand.ExecuteScalar();

                                if (result != null && result != DBNull.Value)
                                {
                                    oldBranch = result.ToString();
                                }
                                else
                                {
                                    // Set default value if location is not found
                                    oldBranch = string.Empty;
                                }
                            }
                        }
                        else
                        {
                            // Set default values if the room ID is not found
                            oldRoomNumber = string.Empty;
                            oldRoomType = string.Empty;
                            oldBranch = string.Empty;
                        }
                    }
                }
            }
        }



        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            searchText = SearchRoom.Text.Trim();
            Session["SearchText"] = searchText;
            GridView1.EditIndex = e.NewEditIndex;
            BindGridView();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                // Get the DropDownList control in the EditItemTemplate of the current row
                DropDownList ddlBranch = (DropDownList)e.Row.FindControl("DropDownList4");
                DropDownList ddlRoomType = (DropDownList)e.Row.FindControl("DropDownList5");

                // Bind the DropDownList with data from the database
                string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT Location FROM Hotel", conn);
                    conn.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    ddlBranch.DataSource = rdr;
                    ddlBranch.DataTextField = "Location";
                    ddlBranch.DataValueField = "Location";
                    ddlBranch.DataBind();
                    rdr.Close();

                    SqlCommand cmd1 = new SqlCommand("SELECT RoomType_ID FROM RoomType", conn);
                   
                    SqlDataReader rdr1 = cmd1.ExecuteReader();
                    ddlRoomType.DataSource = rdr1;
                    ddlRoomType.DataTextField = "RoomType_ID";
                    ddlRoomType.DataValueField = "RoomType_ID";
                    ddlRoomType.DataBind();
                    conn.Close();
                }

                // Set the selected value of the DropDownList to the current value of the Branch_ID field
                DataRowView drv = (DataRowView)e.Row.DataItem;
                ddlBranch.SelectedValue = drv["Location"].ToString();
                DataRowView drv1 = (DataRowView)e.Row.DataItem;
                ddlRoomType.SelectedValue = drv1["RoomType_ID"].ToString();
            }
        }
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGridView();

            // Reset visibility of all rows
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                GridView1.Rows[i].Visible = true;
            }
        }

        
        protected void idradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Room ID");
        }

        protected void roomradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Room Number");
        }

       

        protected void typeradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Room Type ID");
        }

      

        protected void branchradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Location");
        }

        protected void Select_Click(object sender, EventArgs e)
        {
            if (IsPostBack && ((Button)sender).ID == "btnSelect")
            {
                string Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                string query = "SELECT Price, NumberOfBeds, Type FROM RoomType WHERE RoomType_ID=@id";

                using (SqlConnection connection = new SqlConnection(Hotel))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@id", DropDownList2.SelectedItem.Value);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        type.Text = reader["Type"].ToString();
                        noofbeds.Text = reader["NumberOfBeds"].ToString();
                        price.Text = reader["Price"].ToString();
                    }

                    reader.Close();
                }
            }
        }


    }
}