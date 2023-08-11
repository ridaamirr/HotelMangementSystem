using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "execute AutomaticCheckout";

            using (SqlConnection con1 = new SqlConnection(Hotel))
            {
                con1.Open();

                SqlCommand cmd1 = new SqlCommand(query, con1);

                int result = cmd1.ExecuteNonQuery();
            }

            if (Session["role"]!= null && Session["role"].ToString() =="admin")
            {
                switch1.InnerText = "Admin Dashboard";
                switch1.HRef= "Admin.aspx";
            } 
            else if(Session["role"]!=null && Session["role"].ToString()=="user")
            {
                
                SqlConnection con = new SqlConnection(Hotel);
                con.Open();

                string temp1 = "Select* from Billing where (User_ID=@CNIC and Status='Not Paid')";
                SqlCommand cmd = new SqlCommand(temp1, con);
                cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    switch1.InnerText = "Generate Bill";
                    switch1.HRef = "Generate Bill.aspx";
                } 
                else
                {
                    switch1.InnerText = "Book Now";
                    switch1.HRef = "Catalouge.aspx";
                }     
            }
        }
        protected void Availability_Click(object sender, EventArgs e)
        {
            String connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "select* from CheckAvailability(@loc, @type, @beds)";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@loc", DropDownList1.SelectedValue.ToString());
                    command.Parameters.AddWithValue("@type", DropDownList2.SelectedValue.ToString());
                    command.Parameters.AddWithValue("@beds", noofbeds.Text);

                    SqlDataReader dr = command.ExecuteReader();
                   
                    if (dr.HasRows)
                    {
                       
                       
                        status.InnerText = "Available";
                    } 
                    else
                    {
                        status.InnerText = "Not Available";
                    }
                    bed.Visible = false;
                    type.Visible = false;
                    loc.Visible = false;
                    Again.Visible = true;
                    Availability.Visible = false;
                    status.Visible = true;
                    
                }
            }
        }

        protected void Again_Click(object sender, EventArgs e)
        {
            noofbeds.Text = "";
            bed.Visible = true;
            type.Visible = true;
            loc.Visible = true;
            Again.Visible = false;
            Availability.Visible = true;
            status.Visible = false;
        }
    }

}