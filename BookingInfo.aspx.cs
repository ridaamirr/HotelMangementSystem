using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class BookingInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "No Current Bookings";
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (roomoradio.Checked && SearchBox.Text != "")
            {
                int roomno;
                if (int.TryParse(SearchBox.Text, out roomno))
                {
                    CurrentBookings.SelectCommand = "select * from CurrentBookings where RoomNumber=" + SearchBox.Text;
                    searcherror.Visible = false;
                }
                else
                {
                    searcherror.Visible = true;
                    searcherror.ForeColor = Color.Red;
                    searcherror.Text = "Invalid search input for Room Number";
                    return;
                }
            }
            else if (cnicradio.Checked && SearchBox.Text != "")
            {
                int userid;
                if (int.TryParse(SearchBox.Text, out userid))
                {
                    searcherror.Visible = true;
                    searcherror.ForeColor = Color.Red;
                    searcherror.Text = "Invalid search input for CNIC";
                    return;
                }
                else
                {
                    CurrentBookings.SelectCommand = "select * from CurrentBookings where CNIC='" + SearchBox.Text + "'";
                    searcherror.Visible = false;
                }
            }
            else if (locradio.Checked && SearchBox.Text != "")
            {
                CurrentBookings.SelectCommand = "select * from CurrentBookings where Location='" + SearchBox.Text + "'";
                searcherror.Visible = false;
            }
            else
                CurrentBookings.SelectCommand = "Select * from CurrentBookings";

            GridView1.DataBind();

            if (GridView1.Rows.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "Search Results not found";
            }
            else
                lblError.Visible = false;

        }


        protected void cnicradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "CNIC");
        }

        protected void locradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Loction");
        }

        protected void roomnoradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "Room Number");
        }

        protected void checkout_Click(object sender, EventArgs e)
        {
            GridViewRow item = (GridViewRow)(sender as Button).NamingContainer;
            Label hf = (Label)item.FindControl("lblRoomID");
            Label hf2 = (Label)item.FindControl("lblcnic");

            string query = "execute checkoutRoom @roomid=@id, @userid=@cnic";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@id", hf.Text);
                cmd.Parameters.AddWithValue("@cnic", hf2.Text);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                    GridView1.DataBind();

                if (GridView1.Rows.Count == 0)
                {
                    lblError.Visible = true;
                    lblError.Text = "No Current Bookings";
                }
            }

        }
    }
}