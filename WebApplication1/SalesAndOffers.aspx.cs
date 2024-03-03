using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class SalesAndOffers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (Session["role"] != null && Session["role"].ToString() == "user")
                {
                   
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                    string query = "declare @st int execute ViewOffers @userid = '" + Session["CNIC"].ToString() + "', @flag = @st output  select @st as flag";
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
                                lblError.Text = "You cannot select any offer right now";
                                lblError.Visible = true;
                                SQ1.SelectCommand = "";
                            } 
                            else
                            {
                                SQ1.SelectCommand = "Select * from UserOffers('" + Session["CNIC"].ToString() + "')";
                                DataList1.DataBind();
                                if (DataList1.Items.Count == 0)
                                {
                                    lblError.Text = "You have already selected an Offer";
                                    lblError.Visible = true;
                                }
                                else
                                    lblError.Visible = false;
                            }

                        }

                        reader.Close();
                    }
                    
                }
            }               
        }
        string offerid = "";

        protected void orderbutton_Click(object sender, EventArgs e)
        {
            DataListItem item = (DataListItem)(sender as Button).NamingContainer;
            HiddenField hf = (HiddenField)item.FindControl("hfOfferID");
           offerid = hf.Value;

            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            string query = "execute SelectOffer @userid = @CNIC, @offerid = @oid ";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                command.Parameters.AddWithValue("@oid", offerid);
               
                SqlDataReader reader = command.ExecuteReader();
                reader.Close();
            }
            SQ1.SelectCommand = "Select * from UserOffers('" + Session["CNIC"].ToString() + "')";
            DataList1.DataBind();
            if (DataList1.Items.Count == 0)
            {
                lblError.Text = "You have already selected an Offer";
                lblError.Visible = true;
            }
            else
                lblError.Visible = false;

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