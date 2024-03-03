using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Catalouge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Roomtypeid = "";
            }

        }

        string selectedlocation = "";

        protected void BranchSelection_Click(object sender, EventArgs e)
        {
            selectedlocation = DropDownList1.SelectedValue.ToString();
          
            SQ1.SelectCommand = "Select * from catalouge('" + selectedlocation + "') Order By NumberOfBeds ";
            panel1.Visible = false;
            panel2.Visible = true;
            DataList1.DataBind();
            if (DataList1.Items.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "Booking Full!";
            }
            else
                lblError.Visible = false;

        }

        string Roomtypeid = "";

        protected void bookingbutton_Click(object sender, EventArgs e)
        {
            DataListItem item = (DataListItem)(sender as Button).NamingContainer;
            HiddenField hf = (HiddenField)item.FindControl("hfRoomTypeID");
            Roomtypeid = hf.Value;
            hiddenid1.Text = Roomtypeid;
            if (string.IsNullOrEmpty(Roomtypeid) == false)
            {
                panel2.Visible = false;
               panel3.Visible = true;
            }
        }



        protected void Booking_Click(object sender, EventArgs e)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "execute BookRoom @userid=@CNIC, @roomtypeid=@rtid, @loc=@bloc, @days=@NoOfDays";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                command.Parameters.AddWithValue("@rtid", hiddenid1.Text.ToString());
                command.Parameters.AddWithValue("@bloc", DropDownList1.SelectedValue.ToString() );
                command.Parameters.AddWithValue("@NoOfDays", nodays.Text);
                SqlDataReader reader = command.ExecuteReader();
                reader.Close();
            }

            Roomtypeid = ""; // Clear the hidden field 
            nodays.Text = "";
            panel3.Visible = false;
            panel2.Visible = true;

            SQ1.SelectCommand = "Select * from catalouge('" + DropDownList1.SelectedValue.ToString() + "') Order By NumberOfBeds ";

            DataList1.DataBind();

            if (DataList1.Items.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "Booking Full!";
            }
            else
                lblError.Visible = false;
        }

        protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if(Session["role"]==null)
            ((Button)e.Item.FindControl("bookingbutton")).Visible = false; 
            else if (Session["role"].ToString() == "admin")
                ((Button)e.Item.FindControl("bookingbutton")).Visible = false;
        }
    }
}