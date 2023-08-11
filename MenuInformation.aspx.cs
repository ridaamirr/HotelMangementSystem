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
    public partial class MenuInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GridView1.DataKeyNames = new string[] { "Food_ID" };
            if (!IsPostBack)
            {
                // Get the search text from the session, if any
                searchText ="";
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

                string query = "SELECT * FROM Menu";

                if (!string.IsNullOrEmpty(searchText))
                {
                    if (idradio.Checked)
                    {
                        int foodid;
                        if (int.TryParse(searchText, out foodid))
                        {
                            query += " WHERE Food_ID =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Food ID";
                            return;
                        }
                    }
                    else if (nameradio.Checked)
                    {
                        int foodname;
                        if (int.TryParse(searchText, out foodname))
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Name";
                            return;
                        }
                        else
                        {
                            query += " WHERE Name LIKE '%' + @searchKeywords + '%'";
                            searcherror.Visible = false;
                        }
                    }
                    else if (cuisineradio.Checked)
                    {
                        int cuisine;
                        if (int.TryParse(searchText, out cuisine))
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Cuisine";
                            return;
                        }
                        else
                        {
                            query += " WHERE Cuisine LIKE '%' + @searchKeywords + '%'";
                            searcherror.Visible = false;
                        }
                    }
                    else if (priceradio.Checked)
                    {
                       
                        int price;
                        if (int.TryParse(searchText, out price))
                        {
                            query += " WHERE Price =@searchKeywords";
                            searcherror.Visible = false;
                        }
                        else
                        {
                            searcherror.Visible = true;
                            searcherror.ForeColor = Color.Red;
                            searcherror.Text = "Invalid search input for Price";
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
                                dt.DefaultView.RowFilter = "Food_ID= '" + searchText + "'";
                            }
                            else if (nameradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Name LIKE '%" + searchText + "%'";
                            }
                            else if (cuisineradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Cuisine LIKE '%" + searchText + "%'";
                            }
                            else if (priceradio.Checked)
                            {
                                dt.DefaultView.RowFilter = "Price= '" + searchText + "'";
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
                string query = "INSERT INTO Menu (Name, Cuisine,Description,Price,Image) " +
                               "VALUES (@Name,@Cuisine,@Description,@Price,@Image)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", Name.Text);
                    cmd.Parameters.AddWithValue("@Cuisine", DropDownList1.SelectedItem.ToString());
                    cmd.Parameters.AddWithValue("@Description", Description.Text);
                    cmd.Parameters.AddWithValue("@Price", Price.Text);
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
            Name.Text = "";
            Description.Text = "";
            Price.Text = "";
            //Image.FileName = "";
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

                string query = "DELETE FROM Menu WHERE Food_ID = @id";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@id", id);

                    command.ExecuteNonQuery();
                }
            }

            // Refresh the grid view to reflect the updated data
            BindGridView();
        }
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get the ID of the row being deleted
                int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Food_ID"]);

                // Establish a database connection
                string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Create a command to delete the row from the Menu table
                    using (SqlCommand deleteCommand = new SqlCommand("DELETE FROM Menu WHERE Food_ID = @FoodID", connection))
                    {
                        // Set the parameter value
                        deleteCommand.Parameters.AddWithValue("@FoodID", rowID);

                        // Execute the delete command
                        int rowsAffected = deleteCommand.ExecuteNonQuery();

                        // Check if the row still exists in the Menu table
                        using (SqlCommand checkCommand = new SqlCommand("SELECT COUNT(*) FROM Menu WHERE Food_ID = @FoodID", connection))
                        {
                            checkCommand.Parameters.AddWithValue("@FoodID", rowID);
                            int rowCount = (int)checkCommand.ExecuteScalar();

                            if (rowCount > 0)
                            {
                                // The row still exists, deletion was not successful
                                Label2.Text = "This Item cannot be deleted as it exists in an unpaid bill";
                                Label2.Visible = true;
                            }
                            else
                            {
                                Label2.Visible = false;
                                // The row has been deleted successfully
                                // Optionally, perform any other necessary actions
                            }
                        }
                    }
                }

                // Bind the GridView again to reflect the updated data
                BindGridView();
            }
            catch (Exception ex)
            {
                lblError.Text = "An error occurred while deleting the row: " + ex.Message;
            }
        }




        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get the ID of the row being updated
            int rowID = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values["Food_ID"]);

            // Get the updated values for the Location and PhoneNumber fields
            string updatedName = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtName")).Text;
            string updatedCuisine = ((DropDownList)GridView1.Rows[e.RowIndex].FindControl("DropDownList2")).SelectedItem.ToString();
            string updatedDescription = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtDescription")).Text;
            string updatedPrice = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("txtPrice")).Text;
            FileUpload updatedImage = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("txtImage");

            string currentImage = "";
            if (string.IsNullOrEmpty(updatedImage.FileName) == true)
            {
                // Get the current image file name
                currentImage = ((HiddenField)GridView1.Rows[e.RowIndex].FindControl("hfCurrentImage")).Value;

            }
            string NameError = "";
            if (string.IsNullOrEmpty(updatedName))
            {
                NameError = "Name cannot be empty";
            }
            string DescriptionError = "";
            if (string.IsNullOrEmpty(updatedDescription))
            {
                DescriptionError = "Description cannot be empty";
            }
            string PriceError = "";
            int price;
            if (string.IsNullOrEmpty(updatedPrice))
            {
                PriceError = "Price cannot be empty";
            }
            else if(!int.TryParse(updatedPrice, out price) || price <= 0)
            {
                PriceError = "Enter a valid price";
            }
            if (string.IsNullOrEmpty(PriceError) && string.IsNullOrEmpty(DescriptionError) && string.IsNullOrEmpty(NameError))
            {
                // Get the old values for name and cuisine
                string oldName = GetOldMenuName(rowID);
                string oldCuisine = GetOldMenuCuisine(rowID);
                string oldPrice = GetOldMenuPrice(rowID);
                Label2.Visible= false;  

                if (HasUnpaidBills(rowID) && (updatedName != oldName || updatedCuisine != oldCuisine || updatedPrice!=oldPrice))
                {
                    Label2.Visible = true;
                    Label2.ForeColor = Color.Red;
                    Label2.Text = "The name/cuisine/price of this menu item cannot be updated as it has unpaid bills";
                    e.Cancel = true; // Cancel the update operations
                    return;
                }
                // Update the database with the new values
                String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    string imageFileName = updatedImage.HasFile ? updatedImage.FileName : currentImage;
                    string query = "UPDATE Menu SET Name = @Name, Cuisine = @Cuisine, Description= @Description, Price=@Price, Image=@Image WHERE Food_ID = @id";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Name", updatedName);
                        command.Parameters.AddWithValue("@Cuisine", updatedCuisine);
                        command.Parameters.AddWithValue("@Description", updatedDescription);
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
                // Set the error messages for the Occasion and Percentage TextBoxes
                Label occasionErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblNameError");
                if (occasionErrorLabel != null)
                {
                    occasionErrorLabel.Text = NameError;
                    occasionErrorLabel.ForeColor = Color.Red;
                }
                Label DescriptionErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblDescriptionError");
                if (DescriptionErrorLabel != null)
                {
                    DescriptionErrorLabel.Text = DescriptionError;
                    DescriptionErrorLabel.ForeColor = Color.Red;
                }
                Label percentageErrorLabel = (Label)GridView1.Rows[e.RowIndex].FindControl("lblPriceError");
                if (percentageErrorLabel != null)
                {
                    percentageErrorLabel.Text = PriceError;
                    percentageErrorLabel.ForeColor = Color.Red;
                }
            }
        }
        // Retrieve the old name of the menu item
        private string GetOldMenuName(int foodID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT Name FROM Menu WHERE Food_ID = @foodID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@foodID", foodID);

                    object result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return result.ToString();
                    }
                }
            }

            return string.Empty;
        }

        // Retrieve the old cuisine of the menu item
        private string GetOldMenuCuisine(int foodID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT Cuisine FROM Menu WHERE Food_ID = @foodID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@foodID", foodID);

                    object result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return result.ToString();
                    }
                }
            }

            return string.Empty;
        }

        // Retrieve the old price of the menu item
        private string GetOldMenuPrice(int foodID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT Price FROM Menu WHERE Food_ID = @foodID";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@foodID", foodID);

                    object result = command.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return result.ToString();
                    }
                }
            }

            return string.Empty;
        }



        // Check if the menu item has any unpaid bills
        private bool HasUnpaidBills(int foodID)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM Billing WHERE Billing_ID IN (SELECT Billing_ID FROM Orders WHERE Food_ID = @foodID) AND Status = 'Not Paid'";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@foodID", foodID);

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
            Label2.Visible=false;
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

        protected void nameradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Name");
        }

        protected void cuisineradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Cuisine");
        }

        protected void priceradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Price");
        }
    }
}