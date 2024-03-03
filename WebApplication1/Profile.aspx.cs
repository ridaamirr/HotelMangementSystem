using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


namespace WebApplication1
{
    public partial class Profile : System.Web.UI.Page
    { 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                if (!IsPostBack)
                {
                    String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                    string query = "SELECT FirstName, LastName, PhoneNumber, Address, DOB, Email FROM Customer WHERE CNIC=@CNIC";

                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                        SqlDataReader reader = command.ExecuteReader();
                        
                          if (reader.Read())
                          {
                            cnic1.Text = Session["cnic"].ToString();
                            firstname.Text = reader["FirstName"].ToString();
                            lastname.Text = reader["LastName"].ToString();
                            email.Text = reader["Email"].ToString();
                            phone.Text = reader["PhoneNumber"].ToString();
                            address.Text = reader["Address"].ToString();
                            string temp = reader["DOB"].ToString().Split(' ')[0];
                            string year = temp.Split('/')[2];
                            string month = temp.Split('/')[0];
                            if (month.Length == 1)
                                month = "0" + month;
                            string day = temp.Split('/')[1];
                            if (day.Length == 1)
                                day = "0" + day;
                            dob.Text =year +"-"+month +"-" +day ;
                          }

                        reader.Close();
                    }
                }
            }
    }
        protected void ProfileButton_Click(object sender, EventArgs e)
        {
            string query = "UPDATE Customer SET " +
                "FirstName=@FirstName,LastName=@LastName,PhoneNumber=@PhoneNumber,Email=@Email,Address=@Address,DOB=@DOB" +
                " WHERE CNIC=@CNIC";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                cmd.Parameters.AddWithValue("@FirstName", firstname.Text.Trim());
                cmd.Parameters.AddWithValue("@LastName", lastname.Text.Trim());
                cmd.Parameters.AddWithValue("@PhoneNumber", phone.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", email.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", address.Text.Trim());
                cmd.Parameters.AddWithValue("@DOB", dob.Text.Trim());


                int result = cmd.ExecuteNonQuery();
            }
        }

    }

}
