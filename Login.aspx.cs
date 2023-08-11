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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["role"] = null;
           
        }

        protected void LoginButton_Click1(object sender, EventArgs e)
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(Hotel); 
            con.Open();
            string temp1 = "";
            if (adminradio.Checked) // for admin login
            {
                temp1 = "SELECT * FROM Admin_Login WHERE Username='" + adminusername.Text + "' AND Password='" + password.Text + "';";
            }
            else // for user login
            {
                temp1 = "SELECT * FROM Customer WHERE CNIC='" + username.Text + "' AND Password='" + password.Text + "';";
            }

            SqlCommand cmd = new SqlCommand(temp1, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                if (adminradio.Checked) // for admin login
                {
                    while (dr.Read())
                    {
                        Session["username"] = dr.GetValue(0).ToString();
                        Session["role"] = "admin";

                    }
                    Response.Redirect("Default.aspx");
                }
                else // for user login
                {
                    while (dr.Read())
                    {
                        Session["cnic"] = dr.GetValue(0).ToString();
                        Session["role"] = "user";
                    }
                    Response.Redirect("Default.aspx");
                }
            }
            else
            {
                Invalid.Visible = true;
                Invalid.IsValid = false;
            }
            con.Close();
        }


        protected void userradio_CheckedChanged(object sender, EventArgs e)
        {
            Invalid.Visible = false;
            LoginType.InnerText = "User Login";
            adminusername.Visible = false;
            username.Visible = true;
            forgetpass.Visible = true;
            register.Visible = true;
            RequiredFieldValidator14.Visible = false;
            rfvCNIC2.Visible = true;
        }

        protected void adminradio_CheckedChanged(object sender, EventArgs e)
        {
            Invalid.Visible = false;
            LoginType.InnerText = "Admin Login";
            adminusername.Visible = true;
            username.Visible = false;
            forgetpass.Visible = false;
            register.Visible = false;
            RequiredFieldValidator14.Visible = true;
            rfvCNIC2.Visible = false;
        }
    }
}