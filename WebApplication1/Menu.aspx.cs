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
    public partial class Menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Foodid = "";
            SQ1.SelectCommand = "SELECT [Name],[Cuisine], [Description], [Price],[Food_ID], [Image] FROM [Menu]";
        }

        string Foodid = "";

        protected void orderbutton_Click(object sender, EventArgs e)
        {
            DataListItem item = (DataListItem)(sender as Button).NamingContainer;
            HiddenField hf = (HiddenField)item.FindControl("hfFoodID");
            Foodid = hf.Value;
            hiddenid1.Text = Foodid;
            if (string.IsNullOrEmpty(Foodid) == false)
            {
                panel1.Visible = false;
                panel3.Visible = true;
            }
        }



        protected void Order_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "execute PlaceOrder @userid=@CNIC,@foodid=@FoodID,@quantity=@qtty";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                command.Parameters.AddWithValue("@FoodID", hiddenid1.Text.ToString());
                command.Parameters.AddWithValue("@qtty", Quantity.Text);
                SqlDataReader reader = command.ExecuteReader();
                reader.Close();
            }

            Foodid = ""; // Clear the hidden field 
            Quantity.Text = "";
            panel3.Visible = false;
            panel1.Visible = true;

            SQ1.SelectCommand = "SELECT [Name],[Cuisine], [Description], [Price],[Food_ID], [Image] FROM [Menu]";

            DataList1.DataBind();

        }

        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (Session["role"] == null)
                ((Button)e.Item.FindControl("orderbutton")).Visible = false;
            else if (Session["role"].ToString() == "admin")
                ((Button)e.Item.FindControl("orderbutton")).Visible = false;
        }

    }
}