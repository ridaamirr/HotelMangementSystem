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
    public partial class Payments : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "All Payments are done";
            }
        }

        protected void status_Click(object sender, EventArgs e)
        {
            GridViewRow item = (GridViewRow)(sender as Button).NamingContainer;
            Label hf = (Label)item.FindControl("lblBillid");

            string query = "execute Paid @billing_id=@billid";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@billid", hf.Text);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    
                    GridView1.DataBind();
                }

                if (GridView1.Rows.Count == 0)
                {
                    lblError.Visible = true;
                    lblError.Text = "All Payments are done";
                }
            }

        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

                Button btnStatus = (Button)e.Row.FindControl("status");

                if (status.Equals("Paid"))
                {
                    btnStatus.Visible = false;
                }
                else
                {
                    btnStatus.Visible = true;
                }
            }
        }

        protected void cnicradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "CNIC");
        }

        protected void idradio_CheckedChanged(object sender, EventArgs e)
        {
            SearchBox.Attributes.Add("placeholder", "ID");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (idradio.Checked && SearchBox.Text != "")
            {
                int billid;
                if (int.TryParse(SearchBox.Text, out billid))
                {
                    SQ1.SelectCommand = "select * from Billing where Billing_ID=" + SearchBox.Text;
                    searcherror.Visible = false;
                }
                else
                {
                    searcherror.Visible = true;
                    searcherror.ForeColor = Color.Red;
                    searcherror.Text = "Invalid search input for Billing ID";
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
                    SQ1.SelectCommand = "select * from Billing where User_ID='" + SearchBox.Text + "'";
                    searcherror.Visible = false;
                }
            }
            else
                SQ1.SelectCommand = "Select * from Billing";

            GridView1.DataBind();

            if (GridView1.Rows.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "Search Results not found";
            }
            else
                lblError.Visible = false;


        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void details_Click(object sender, EventArgs e)
        {
            GridViewRow item = (GridViewRow)(sender as Button).NamingContainer;
            Label hf = (Label)item.FindControl("lblBillid");
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "declare @st int execute isBillPresent @id = '" + hf.Text + "', @flag = @st output  select @st as flag";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                string flag;
                if (reader.Read())
                {
                    flag = reader["flag"].ToString();

                    if (flag[0] == '0')
                    {             
                        Response.Redirect("ViewBillDetails.aspx?Parameter=" + hf.Text);
                        lblError.Visible = false;
                    }
                    else
                    {
                        lblError.Text = "Details of this Bill can not be viewed";
                        lblError.Visible = true;
                    }

                }

                reader.Close();
            }
         
        }
    }
}