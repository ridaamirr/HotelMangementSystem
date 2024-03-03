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
    public partial class BranchInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataKeyNames = new string[] { "Branch_ID" };
            if (!IsPostBack)
            {
                // Get the search text from the session, if any
                searchText = "";
                BindGridView();
                unique.Visible = false;
            }
        }

        string searchText;

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            searchText = SearchBox.Text.Trim();
            Session["SearchText"] = searchText;
            BindGridView();
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();

                string query = "SELECT COUNT(*) FROM Hotel WHERE Location = @Location";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Location", Location.Text);

                    int count = (int)command.ExecuteScalar();

                    if (count > 0)
                    {
                        unique.Text = "Branch Location already exists";
                        unique.Visible = true;
                        return;
                    }
                    else
                        unique.Visible = false;
                }
            }

            using (SqlConnection con = new SqlConnection(Hotel))
            {
                string query = "INSERT INTO Hotel (Location, PhoneNumber) " +
                               "VALUES (@Location,@PhoneNumber)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Location", Location.Text);
                    cmd.Parameters.AddWithValue("@PhoneNumber", Phone.Text);


                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        GridView1.DataKeyNames = new string[] { "Branch_ID" };
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
            Location.Text = "";
            Phone.Text = "";
           
        }

        protected void UpdateorDelete_Click(object sender, EventArgs e)
        {
            panel1.Visible = false;
            panel3.Visible = true;
            panel2.Visible = false;
        }


        private void BindGridView()
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM Hotel";

                if (!string.IsNullOrEmpty(searchText))
                {
                    if(idradio.Checked)
                    {
                        int branchId;
                        if (int.TryParse(searchText, out branchId))
                        {
                            query += " WHERE Branch_ID =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Branch ID.";
                            return;
                        }
                    } 
                    else if(locradio.Checked)
                    {
                        int loc;
                        if (Int32.TryParse(searchText, out loc))
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Location";
                            return;
                        }
                        else
                        {
                            query += " WHERE Location LIKE '%' + @searchKeywords + '%'";
                            searcherror.Visible = false;
                        }
                    } 
                    else if(phoneradio.Checked)
                    {
                        int phonenum;
                        if (Int32.TryParse(searchText, out phonenum))
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Phone Number";
                            return;
                        }
                        else
                        {
                            query += " WHERE PhoneNumber LIKE '%' + @searchKeywords + '%'";
                            searcherror.Visible = false;
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
                                dt.DefaultView.RowFilter = "Branch_ID= '" + searchText + "'";
                            }
                            else if (locradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Location LIKE '%" + searchText + "%'";
                            }
                            else if (phoneradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "PhoneNumber LIKE '%" + searchText + "%'";
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
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "DELETE FROM Hotel WHERE Branch_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    int rowsAffected = command.ExecuteNonQuery();
                    // Check if the row still exists in the Menu table
                    using (SqlCommand checkCommand = new SqlCommand("SELECT COUNT(*) FROM Hotel WHERE Branch_ID = @id", connection))
                    {
                        checkCommand.Parameters.AddWithValue("@id", id);
                        int rowCount = (int)checkCommand.ExecuteScalar();

                        if (rowCount > 0)
                        {
                            // The row still exists, deletion was not successful
                            Label1.Text = "This Branch cannot be deleted as it exists in an unpaid bill";
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
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Branch_ID"]);
            DeleteRow(rowID);
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Branch_ID"]);

            // Get the updated values for the Location and PhoneNumber fields
            string updatedLocation = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtLocation")).Text;
            string updatedPhoneNumber = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPhoneNumber")).Text;
            // Check if the hotel has any unpaid bills
            if (HasUnpaidBills(rowID) && updatedLocation != GetOldLocation(rowID))
            {
                lblError.Visible = true;
                lblError.ForeColor = Color.Red;
                lblError.Text = "The location of this hotel cannot be updated as it has unpaid bills";
                e.Cancel = true; // Cancel the update operation
            }
            else
            {
                lblError.Visible = false;
                // Check if the Location and PhoneNumber fields are not empty
                string locationError = "";
                if (string.IsNullOrEmpty(updatedLocation))
                {
                    locationError = "Location field cannot be empty";
                }
                else
                {
                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();

                        string query = "SELECT COUNT(*) FROM Hotel WHERE Location = @Location AND Branch_ID != @Branch_ID";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@Location", updatedLocation);
                            command.Parameters.AddWithValue("@Branch_ID", rowID);

                            int count = (int)command.ExecuteScalar();

                            if (count > 0)
                            {
                                locationError = "Branch Location already exists";
                            }
                        }
                    }
                }

                string phoneNumberError = "";
                if (string.IsNullOrEmpty(updatedPhoneNumber))
                {
                    phoneNumberError = "Phone number field cannot be empty";
                }
                else
                {
                    // Check if the phone number starts with "+92" and has a length of 13
                    if (!updatedPhoneNumber.StartsWith("+92") || updatedPhoneNumber.Length != 13)
                    {
                        phoneNumberError = "Incorrect Phone Number(e.g +920123456789)";
                    }
                }
                // Update the database with the new values if there are no errors
                if (string.IsNullOrEmpty(locationError) && string.IsNullOrEmpty(phoneNumberError))
                {
                    String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();

                        string query = "UPDATE Hotel SET Location = @location, PhoneNumber = @phoneNumber WHERE Branch_ID = @id";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@location", updatedLocation);
                            command.Parameters.AddWithValue("@phoneNumber", updatedPhoneNumber);
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
                    // Set the error messages for the Location and PhoneNumber TextBoxes
                    Label locationErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblLocationError");
                    if (locationErrorLabel != null)
                    {
                        locationErrorLabel.Text = locationError;
                        locationErrorLabel.ForeColor = Color.Red;
                    }

                    Label phoneNumberErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblPhoneNumberError");
                    if (phoneNumberErrorLabel != null)
                    {
                        phoneNumberErrorLabel.Text = phoneNumberError;
                        phoneNumberErrorLabel.ForeColor = Color.Red;
                    }
                }
            }
        }
        private string GetOldLocation(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Retrieve the current location of the hotel
                string query = "SELECT Location FROM Hotel WHERE Branch_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    string oldLocation = command.ExecuteScalar()?.ToString();

                    return oldLocation;
                }
            }
        }
        private bool HasUnpaidBills(int id)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the hotel has any unpaid bills
                string query = "SELECT COUNT(*) FROM Billing WHERE Billing_ID IN (SELECT Billing_ID FROM Booking WHERE Room_ID IN (SELECT Room_ID FROM Room WHERE Branch_ID = @id)) AND Status = 'Not Paid'";

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
            searchText = SearchBox.Text.Trim();
            Session["SearchText"] = searchText;
            GridView1.EditIndex = e.NewEditIndex;
            BindGridView();
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
            SearchBox.Attributes.Add("placeholder", "Branch ID");
        }

        protected void locradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Location");
        }

        protected void phoneradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Phone Number"); 
        }
    }
}