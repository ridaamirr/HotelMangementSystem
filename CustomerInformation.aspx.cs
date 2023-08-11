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
    public partial class CustomerInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "No customer yet";
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (SearchBox.Text != "")
            {
                int cnic;
                if (int.TryParse(SearchBox.Text, out cnic))
                {
                    searcherror.Visible = true;
                    searcherror.ForeColor = Color.Red;
                    searcherror.Text = "Invalid search input for CNIC";
                    return;
                }
                else
                {
                    SQ1.SelectCommand = "select * from CustomerInfo where CNIC='" + SearchBox.Text + "'";
                    searcherror.Visible = false;
                }
            }
            else
                SQ1.SelectCommand = "Select * from CustomerInfo";

            GridView1.DataBind();

            if (GridView1.Rows.Count == 0)
            {
                lblError.Visible = true;
                lblError.Text = "Search Results not found";
            }
            else
                lblError.Visible = false;
        }

    }
}