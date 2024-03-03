using Microsoft.Ajax.Utilities;
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
    public partial class SalesOffersInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataKeyNames = new string[] { "Offer_ID" };
            if (!IsPostBack)
            {
                // Get the search text from the session, if any
                searchText = "";
                BindGridView();
            }
        }
        string searchText;

        private void BindGridView()
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM SalesAndOffers";

                if (!string.IsNullOrEmpty(searchText))
                {
                    if (idradio.Checked)
                    {
                        int offerid;
                        if (int.TryParse(SearchBox.Text, out offerid))
                        {
                            query += " WHERE Offer_ID =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Offer ID";
                            return;
                        }
                    }
                    else if (occradio.Checked)
                    {
                        int occasion;
                        if (int.TryParse(SearchBox.Text, out occasion))
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Occasion";
                            return;
                        }
                        else
                        {
                            query += " WHERE Occasion LIKE '%' + @searchKeywords + '%'";
                            searcherror.Visible = false;
                        }
                    }
                    else if (percentradio.Checked)
                    {
                        int percentage;
                        if (int.TryParse(SearchBox.Text, out percentage))
                        {
                            query += " WHERE Percentage=@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Percentage";
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
                                dt.DefaultView.RowFilter = "Offer_ID= '" + searchText + "'";
                            }
                            else if (occradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Occasion LIKE '%" + searchText + "%'";
                            }
                            else if (percentradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Percentage= '" + searchText + "'";
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            searchText = SearchBox.Text.Trim();
            Session["SearchText"] = searchText;
            BindGridView();
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                string query = "INSERT INTO SalesAndOffers (Occasion, Percentage,Image) " +
                               "VALUES (@Occasion,@Percentage,@Image)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Occasion", Occasion.Text);
                    cmd.Parameters.AddWithValue("@Percentage", Percentage.Text);
                    cmd.Parameters.AddWithValue("@Image", Image.FileName);


                    con.Open();
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        // GridView1.DataKeyNames = new string[] { "Branch_ID" };
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
            Occasion.Text = "";
            Percentage.Text = "";
            //Image.Text = "";
        }

        protected void UpdateorDelete_Click(object sender, EventArgs e)
        {
            panel1.Visible = false;
            panel2.Visible = false;
            panel3.Visible = true;
        }

        protected void DeleteRow(int id)
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Check if the offer can be deleted based on the trigger
                string checkQuery = "SELECT COUNT(*) FROM Billing WHERE Billing_ID IN (SELECT Billing_ID FROM SelectedOffers WHERE Offer_ID = @id) AND Status = 'Not Paid'";

                using (SqlCommand checkCommand = new SqlCommand(checkQuery, connection))
                {
                    checkCommand.Parameters.AddWithValue("@id", id);
                    int rowCount = (int)checkCommand.ExecuteScalar();

                    if (rowCount > 0)
                    {
                        // The offer cannot be deleted as it exists in an unpaid bill
                        Label1.Text = "This offer cannot be deleted as it exists in an unpaid bill";
                        Label1.Visible = true;
                    }
                    else
                    {
                        // Delete the offer if it can be deleted
                        string deleteQuery = "DELETE FROM SalesAndOffers WHERE Offer_ID = @id";

                        using (SqlCommand deleteCommand = new SqlCommand(deleteQuery, connection))
                        {
                            deleteCommand.Parameters.AddWithValue("@id", id);
                            deleteCommand.ExecuteNonQuery();

                            Label1.Visible = false;
                            // The offer has been deleted successfully
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
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Offer_ID"]);
            DeleteRow(rowID);
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Offer_ID"]);

            // Get the updated values for the Occasion and Percentage fields
            string updatedOccasion = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtOccasion")).Text;
            string updatedPercentage = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPercentage")).Text;
            FileUpload updatedImage = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("txtImage");
            string currentImage="";
            if (string.IsNullOrEmpty(updatedImage.FileName)==true)
            {
                // Get the current image file name
                currentImage = ((HiddenField)GridView1.Rows[e.RowIndex].FindControl("hfCurrentImage")).Value;

            }

            // Check if the updatedPercentage is a valid decimal value between 0 and 100
            decimal percentage;
            string percentageError = "";
            if (!decimal.TryParse(updatedPercentage, out percentage) || percentage < 0 || percentage > 100)
            {
                percentageError = "Percentage value must be between 0 and 100";
            }

            // Check if the Occasion and Percentage fields are not empty
            string occasionError = "";
            if (string.IsNullOrEmpty(updatedOccasion))
            {
                occasionError = "Occasion field cannot be empty";
            }

            if (string.IsNullOrEmpty(updatedPercentage))
            {
                percentageError = "Percentage field cannot be empty";
            }

            // Update the database with the new values if there are no errors
            if (string.IsNullOrEmpty(occasionError) && string.IsNullOrEmpty(percentageError))
            {
                string oldOccasion = "";
                string oldPercentage="";
                Label1.Visible = false;
                GetOldValue(rowID, out oldOccasion, out oldPercentage);
                if (HasUnpaidBills(rowID) && (updatedOccasion != oldOccasion || updatedPercentage != oldPercentage))
                {
                    Label1.Text = "This offer cannot be Updated as it exists in an unpaid bill";
                    Label1.Visible = true;
                    e.Cancel = false;
                }
                else
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open();

                        // Only update the Image column if a new file has been uploaded; otherwise, use the original image file name
                        string imageFileName = updatedImage.HasFile ? updatedImage.FileName : currentImage;

                        string query = "UPDATE SalesAndOffers SET Occasion = @Occasion, Percentage=@Percentage, Image=@Image WHERE Offer_ID = @id";

                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@Occasion", updatedOccasion);
                            command.Parameters.AddWithValue("@Percentage", percentage);
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
            }
            else
            {
                // Set the error messages for the Occasion and Percentage TextBoxes
                Label occasionErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblOccasionError");
                if (occasionErrorLabel != null)
                {
                    occasionErrorLabel.Text = occasionError;
                    occasionErrorLabel.ForeColor = Color.Red;
                }

                Label percentageErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblPercentageError");
                if (percentageErrorLabel != null)
                {
                    percentageErrorLabel.Text = percentageError;
                    percentageErrorLabel.ForeColor = Color.Red;
                }
            }

        }
        private bool HasUnpaidBills(int offerID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM Billing WHERE Billing_ID IN (SELECT Billing_ID FROM SelectedOffers WHERE Offer_ID = @offerID) AND Status = 'Not Paid'";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@offerID", offerID);

                    int rowCount = (int)command.ExecuteScalar();

                    return rowCount > 0;
                }
            }
        }

        private void GetOldValue(int offerID, out string oldOccasion, out string oldPercentage)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT Occasion, Percentage FROM SalesAndOffers WHERE Offer_ID = @offerID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@offerID", offerID);

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            oldOccasion = reader["Occasion"].ToString();
                            oldPercentage = reader["Percentage"].ToString();
                        }
                        else
                        {
                            // Set default values if the offer ID is not found
                            oldOccasion = string.Empty;
                            oldPercentage = string.Empty;
                        }
                    }
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
            SearchBox.Attributes.Add("placeholder", "ID");
        }

        protected void occradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Occasion");
        }

        protected void percentradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Percentage");
        }
    }
}