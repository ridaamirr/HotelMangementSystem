using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Generate_Bill : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["cnic"].ToString() != null)
            {
                SQ1.SelectCommand = "Select * from BookedRoom('" + Session["cnic"].ToString() + "')";
                SQ2.SelectCommand = "Select * from OrdersPlaced('" + Session["cnic"].ToString() + "')";
                SQ3.SelectCommand = "Select * from OfferSelected('" + Session["cnic"].ToString() + "')";
                //  SQ4.SelectCommand = "Select * from Customer where CNIC='" + Session["cnic"].ToString() + "'";
                SQ5.SelectCommand = "Select * from RatingTable('" + Session["cnic"].ToString() + "')";

                String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                string query = "select dbo.TotalBill(@CNIC) as Bill";

                using (SqlConnection connection = new SqlConnection(Hotel))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        amount.InnerText = "Total Bill: Rs." + reader["Bill"].ToString();
                    }

                    reader.Close();
                }

                query = "select * from Room Where Room_ID In(Select Room_ID from Booking where Billing_ID In(select Billing_ID from Billing where User_ID = @CNIC)) and isBooked='True'";
                using (SqlConnection con = new SqlConnection(Hotel))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                    int result = cmd.ExecuteNonQuery();

                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        CheckOut.Visible = true;
                    }
                    else
                        CheckOut.Visible = false;

                    reader.Close();
                }


                query = "Select * from Customer where CNIC='" + Session["cnic"].ToString() + "'";

                using (SqlConnection connection = new SqlConnection(Hotel))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                    SqlDataReader reader = command.ExecuteReader();

                    if (reader.Read())
                    {
                        int phistory;
                        string price = reader["PaymentHistory"].ToString();
                        int.TryParse(price, out phistory);

                        if (phistory > 10000 && phistory <= 20000)
                            history.InnerText = "You got 5% off as your payment history is greater than 10,000";
                        if (phistory > 20000 && phistory <= 30000)
                            history.InnerText = "You got 10% off as your payment history is greater than 20,000";
                        if (phistory > 30000)
                            history.InnerText = "You got 15% off as your payment history is greater than 30,000";
                    }
                    reader.Close();
                }
            }
        }
        protected void GridView5_RowCommand(object sender, CommandEventArgs e)
        {
            if (e.CommandName == "RateRoom")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                string location = GridView5.Rows[rowIndex].Cells[0].Text;
                string roomNumber = GridView5.Rows[rowIndex].Cells[1].Text;
                TextBox ratingTextBox = (TextBox)GridView5.Rows[rowIndex].FindControl("txtrate");
                Label ratingLabel = (Label)GridView5.Rows[rowIndex].FindControl("lblrate");
                Button rateButton = (Button)GridView5.Rows[rowIndex].FindControl("btnRate");
                if (!string.IsNullOrEmpty(ratingTextBox.Text))
                {
                    string RatingError = "";
                    int rating = 0;
                    if (!int.TryParse(ratingTextBox.Text, out rating))
                    {
                        RatingError = "Invalid Rating";
                    }
                    else if (rating < 0 || rating > 10)
                    {
                        RatingError = "Rating should be between 0 and 10";
                    }


                    if (string.IsNullOrEmpty(RatingError))
                    {
                        ratingTextBox.Visible = false;
                        ratingLabel.Visible = true;
                        rateButton.Visible = false;
                        string connectionString = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            using (SqlCommand command = new SqlCommand("RateRoom", connection))
                            {
                                command.CommandType = CommandType.StoredProcedure;
                                command.Parameters.AddWithValue("@loc", location);
                                command.Parameters.AddWithValue("@roomno", roomNumber);
                                command.Parameters.AddWithValue("@rating", ratingTextBox.Text);
                                command.Parameters.AddWithValue("@userid", Session["cnic"].ToString());

                                connection.Open();
                                command.ExecuteNonQuery();
                                connection.Close();
                            }
                        }
                    }
                    Label RatingErrorLabel = (Label)GridView5.Rows[rowIndex].FindControl("lblRatingError");
                    if (RatingErrorLabel != null)
                    {
                        RatingErrorLabel.Text = RatingError;
                        RatingErrorLabel.ForeColor = Color.Red;
                    }
                }
            }
        }

        protected void CheckOut_Click(object sender, EventArgs e)
        {
            string query = "execute Checkout @userid =@CNIC";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                int result = cmd.ExecuteNonQuery();
                CheckOut.Visible = false;
               
            }

            panel1.Visible = false;
            panel2.Visible = true;
        }

        protected void CheckOut2_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {

             if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string isBooked = DataBinder.Eval(e.Row.DataItem, "isBooked").ToString();

                Button btnStatus = (Button)e.Row.FindControl("status");

                if (isBooked.Equals("False"))
                {
                    btnStatus.Visible = false;
                }
                else
                {
                    btnStatus.Visible = true;
                }
            }
        }

        protected void status_Click(object sender, EventArgs e)
        {
            GridViewRow item = (GridViewRow)(sender as Button).NamingContainer;
            Label hf = (Label)item.FindControl("lblroomid");
            string query = "execute checkoutRoom @roomid=@id,@userid=@cnic";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@id", hf.Text);
                cmd.Parameters.AddWithValue("@cnic", Session["cnic"].ToString());
                int result = cmd.ExecuteNonQuery();
                GridView1.DataBind();

            }

            query = "select * from Room Where Room_ID In(Select Room_ID from Booking where Billing_ID In(select Billing_ID from Billing where User_ID = @CNIC)) and isBooked='True'";
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                int result = cmd.ExecuteNonQuery();

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    CheckOut.Visible = true;
                }
                else
                    CheckOut.Text = "Rate Rooms";

                reader.Close();
            }
        }

        protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
        {

        }
    }
}