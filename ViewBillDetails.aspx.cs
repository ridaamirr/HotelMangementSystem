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
    public partial class ViewBillDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string cnic = Request.QueryString["Parameter"].ToString();

            if(cnic!=null)
            {
                SQ1.SelectCommand = "Select * from ViewBooking('" + cnic + "')";
                SQ2.SelectCommand = "Select * from ViewOrder('" + cnic + "')";
                SQ3.SelectCommand = "Select * from ViewOffer('" + cnic + "')";

                String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                string query = "select dbo.TotalBillById(@id) as Bill";

                using (SqlConnection connection = new SqlConnection(Hotel))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@id", cnic);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        amount.InnerText = "Total Bill: Rs." + reader["Bill"].ToString();
                    }

                    reader.Close();
                }

                query = "Select * from Billing where Billing_ID=" + cnic;

                using (SqlConnection connection = new SqlConnection(Hotel))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(query, connection);
                    //command.Parameters.AddWithValue("@CNIC", cnic);
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        int phistory;
                        string price = reader["History"].ToString();
                        int.TryParse(price, out phistory);

                        if (phistory > 10000 && phistory <= 20000)
                            history.InnerText = "5% off as Payment history is greater than 10,000";
                        if (phistory > 20000 && phistory <= 30000)
                            history.InnerText = "10% off as Payment history is greater than 20,000";
                        if (phistory > 30000)
                            history.InnerText = "15% off as Payment history is greater than 30,000";
                    }
                    reader.Close();
                }
            }

        }
           
       
    }
}