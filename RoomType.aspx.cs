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
    public partial class RoomType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataKeyNames = new string[] { "RoomType_ID" };
            if (!IsPostBack)
            {
                // Get the search text from the session, if any
                searchText = "";
                Session["SearchText"] = "";
                BindGridView();

            }
        }
        string searchText;

        protected void Search_Click(object sender, EventArgs e)
        {
            searchText = SearchRoom.Text.Trim();
            Session["SearchText"] = searchText;
            BindGridView();
        }

        private void BindGridView()
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM RoomType";

                if (!string.IsNullOrEmpty(searchText))
                {
                    if (idradio.Checked)
                    {
                        int roomTypeId;
                        if (int.TryParse(searchText, out roomTypeId))
                        {
                            query += " WHERE RoomType_ID = @searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            // Handle invalid search input for RoomType_ID
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Room Type ID.";
                            return;
                        }
                    }
                    else if (bedradio.Checked)
                    {
                        int numberOfBeds;
                        if (int.TryParse(searchText, out numberOfBeds))
                        {
                            query += " WHERE NumberOfBeds = @searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            // Handle invalid search input for NumberOfBeds
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Number Of Beds.";
                            return;
                        }
                    }
                    else if (typeradio.Checked)
                    {
                        int type;
                        if (int.TryParse(searchText, out type))
                        {
                            // Handle invalid search input for Room Type
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Room Type.";
                            return;
                        }
                        else
                        {
                            query += " WHERE Type LIKE '%' + @searchKeywords + '%'";
                            searcherror.Visible = false;

                        }
                    }
                    else if (priceradio.Checked)
                    {
                        decimal price;
                        if (decimal.TryParse(searchText, out price))
                        {
                            query += " WHERE Price = @searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            // Handle invalid search input for Price
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Price.";
                            return;
                        }
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
                                int roomTypeId;
                                if (int.TryParse(searchText, out roomTypeId))
                                {
                                    dt.DefaultView.RowFilter = "RoomType_ID= " + roomTypeId;
                                }
                            }
                            else if (bedradio.Checked)
                            {
                                int numberOfBeds;
                                if (int.TryParse(searchText, out numberOfBeds))
                                {
                                    dt.DefaultView.RowFilter = "NumberOfBeds= " + numberOfBeds;
                                }
                            }
                            else if (typeradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Type LIKE '%" + searchText + "%'";
                            }
                            else if (priceradio.Checked)
                            {
                                decimal price;
                                if (decimal.TryParse(searchText, out price))
                                {
                                    dt.DefaultView.RowFilter = "Price= " + price;
                                }
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


        protected void Add_Click(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                string query = "INSERT INTO RoomType (NumberOfBeds,Type,Price,Image)" +
                               "VALUES (@NumberOfBeds,@Type,@Price,@Image)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@NumberOfBeds", BedNo.Text);
                    cmd.Parameters.AddWithValue("@Type", DropDownList2.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@Price", Price.Text);
                    cmd.Parameters.AddWithValue("@Image", Image.FileName);

                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                         GridView1.DataKeyNames = new string[] { "RoomType_ID" };

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

        protected void AddNew_Click(object sender, EventArgs e)
        {
            panel1.Visible = false;
            panel2.Visible = true;
            panel3.Visible = false;
            Price.Text = "";
            BedNo.Text = "";
        }

        protected void UpdateorDelete_Click(object sender, EventArgs e)
        {
            panel1.Visible = false;
            panel3.Visible = true;
            panel2.Visible = false;
        }

        protected void DeleteRow(int id)
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM RoomType WHERE RoomType_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    int rowsAffected = command.ExecuteNonQuery();
                    // Check if the row still exists in the Menu table
                    using (SqlCommand checkCommand = new SqlCommand("SELECT COUNT(*) FROM RoomType WHERE RoomType_ID = @id", connection))
                    {
                        checkCommand.Parameters.AddWithValue("@id", id);
                        int rowCount = (int)checkCommand.ExecuteScalar();

                        if (rowCount > 0)
                        {
                            // The row still exists, deletion was not successful
                            Label1.Text = "This Room Type cannot be deleted as it exists in an unpaid bill";
                            Label1.Visible = true;
                        }
                        else
                        {
                            Label1.Visible = false;
                            // The row has been deleted successfully
                            // Optionally, perform any other necessary actions
                        }
                    }
                }
            }

            // Refresh the grid view to reflect the updated data
            BindGridView();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["RoomType_ID"]);
            DeleteRow(rowID);
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Update the database with the new values

            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["RoomType_ID"]);


            // Get the updated values for the Location and PhoneNumber fields
            string updatedBedNo = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtBedNo")).Text;
            string updatedType = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList3")).SelectedItem.ToString();
            string updatedPrice = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPrice")).Text;
            FileUpload updatedImage = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("txtImage");
            string currentImage = "";
            if (string.IsNullOrEmpty(updatedImage.FileName) == true)
            {
                // Get the current image file name
                currentImage = ((HiddenField)GridView1.Rows[e.RowIndex].FindControl("hfCurrentImage")).Value;

            }
            string PriceError = "";
            int price;
            if (string.IsNullOrEmpty(updatedPrice))
            {
                PriceError = "Price cannot be empty";
            }
            else if (!int.TryParse(updatedPrice, out price) || price <= 0)
            {
                PriceError = "Enter a valid price";
            }
            // Get the old values for room type, number of beds, and price
            string oldRoomType = GetOldRoomType(rowID);
            string oldNumberOfBeds = GetOldNumberOfBeds(rowID);
            string oldPrice = GetOldPrice(rowID);
            if (string.IsNullOrEmpty(PriceError)){
                if (HasUnpaidBills(rowID) && (updatedType != oldRoomType || updatedBedNo != oldNumberOfBeds || updatedPrice!=oldPrice))
                {
                    lblError.Visible = true;
                    lblError.ForeColor = Color.Red;
                    lblError.Text = "The value/values of this room type cannot be updated as it has unpaid bills";
                    e.Cancel = true; // Cancel the update operation
                    return;
                }
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string imageFileName = updatedImage.HasFile ? updatedImage.FileName : currentImage;
                    string query = "UPDATE RoomType SET  NumberOfBeds = @NumberOfBeds, Type=@Type, Price=@Price, Image=@Image WHERE RoomType_ID = @id";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {

                        command.Parameters.AddWithValue("@NumberOfBeds", updatedBedNo);
                        command.Parameters.AddWithValue("@Type", updatedType);
                        command.Parameters.AddWithValue("@Price", updatedPrice);
                        command.Parameters.AddWithValue("@Image", imageFileName);
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
                Label percentageErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblPriceError");
                if (percentageErrorLabel != null)
                {
                    percentageErrorLabel.Text = PriceError;
                    percentageErrorLabel.ForeColor = Color.Red;
                }
            }
        }
        private string GetOldRoomType(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Retrieve the current room type of the room
                string query = "SELECT Type FROM RoomType WHERE RoomType_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    string oldRoomType = command.ExecuteScalar()?.ToString();

                    return oldRoomType;
                }
            }
        }

        private string GetOldNumberOfBeds(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Retrieve the current number of beds of the room
                string query = "SELECT NumberOfBeds FROM RoomType WHERE RoomType_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    string oldNumberOfBeds = command.ExecuteScalar()?.ToString();

                    return oldNumberOfBeds;
                }
            }
        }

        private string GetOldPrice(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Retrieve the current price of the room
                string query = "SELECT Price FROM RoomType WHERE RoomType_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    string oldPrice = command.ExecuteScalar()?.ToString();

                    return oldPrice;
                }
            }
        }

        private bool HasUnpaidBills(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the room type has any unpaid bills
                string query = "SELECT COUNT(*) FROM Billing WHERE Billing_ID IN (SELECT Billing_ID FROM Booking WHERE Room_ID IN (SELECT Room_ID FROM Room WHERE RoomType_ID = @id)) AND Status = 'Not Paid'";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    int rowCount = (int)command.ExecuteScalar();

                    return rowCount > 0;
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
            //if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            //{
            //    // Get the DropDownList control in the EditItemTemplate of the current row
            //    DropDownList ddlBranch = (DropDownList)e.Row.FindControl("DropDownList4");

            //    // Bind the DropDownList with data from the database
            //    string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            //    using (SqlConnection conn = new SqlConnection(connectionString))
            //    {
            //        SqlCommand cmd = new SqlCommand("SELECT Branch_ID FROM Hotel", conn);
            //        conn.Open();
            //        SqlDataReader rdr = cmd.ExecuteReader();
            //        ddlBranch.DataSource = rdr;
            //        ddlBranch.DataTextField = "Branch_ID";
            //        ddlBranch.DataValueField = "Branch_ID";
            //        ddlBranch.DataBind();
            //    }

            //    // Set the selected value of the DropDownList to the current value of the Branch_ID field
            //    DataRowView drv = (DataRowView)e.Row.DataItem;
            //    ddlBranch.SelectedValue = drv["Branch_ID"].ToString();
            //}
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
            SearchRoom.Attributes.Add("placeholder", "Room Type ID");
        }

       
        protected void bedradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Number of Beds");
        }

        protected void typeradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Room Type");
        }

        protected void priceradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchRoom.Attributes.Add("placeholder", "Price");
        }

      
    }
}