using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace WebApplication1
{
    public partial class ChangeLoginDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
            if (Session["role"] != null)
            {
                if (!IsPostBack)
                {
                    String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(Hotel))
                    {
                        SqlCommand cmd = new SqlCommand("Select top 50 percent *  from SecurityQuestions", con);
                        con.Open();
                        DropDownList1.DataTextField = "Text";
                        DropDownList1.DataSource = cmd.ExecuteReader();
                        DropDownList1.DataBind();
                        con.Close();

                        SqlCommand cmd1 = new SqlCommand("Select top 50 percent *  from SecurityQuestions order by Question_ID DESC", con);
                        con.Open();
                        DropDownList2.DataTextField = "Text"; 
                        DropDownList2.DataSource = cmd1.ExecuteReader();
                        DropDownList2.DataBind();
                    }

                   
                    string query = "SELECT SecurityQuestion1, Answer1, SecurityQuestion2,Answer2 FROM Customer WHERE CNIC=@CNIC";
                    string Q1 = "";
                    string Q2 = "";

                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        { 
                            security1.Text = reader["Answer1"].ToString();
                            security2.Text = reader["Answer2"].ToString();
                            Q1 = reader["SecurityQuestion1"].ToString();
                            Q2 = reader["SecurityQuestion2"].ToString();
                        }

                        reader.Close();
                    }

                    string query1 = "Select Question_ID from SecurityQuestions where Text=@SQ1";
                    string query2 = "Select Question_ID from SecurityQuestions where Text=@SQ2";

                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(query1, connection);
                        command.Parameters.AddWithValue("@SQ1", Q1);
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            DropDownList1.Text = reader["Text"].ToString();
                        }

                        reader.Close();
                    }

                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(query2, connection);
                        command.Parameters.AddWithValue("@SQ2", Q2);
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            DropDownList2.Text = reader["Text"].ToString();
                        }

                        reader.Close();
                    }
                }
            }
        }

        protected void ChangePass_Click(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                {
                    String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                  
                        string query = "SELECT Password FROM Customer WHERE CNIC=@CNIC";

                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                          
                           string originalPassword= reader["Password"].ToString();
                           if(originalPassword==currentpassword.Text.Trim())
                           {
                                firstpanel.Visible = false;
                                secondPanel.Visible = true;
                           } 
                           else
                           {
                                Invalid.Visible = true;
                                Invalid.IsValid = false;
                           }
                        }
                        reader.Close();
                    }
                }
            }  
        }

        protected void SecQuesbtn_Click(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                {
                    String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

                    string query = "SELECT Password FROM Customer WHERE CNIC=@CNIC";

                    using (SqlConnection connection = new SqlConnection(Hotel))
                    {
                        connection.Open();
                        SqlCommand command = new SqlCommand(query, connection);
                        command.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {

                            string originalPassword = reader["Password"].ToString();
                            if (originalPassword == currentpassword.Text.Trim())
                            {
                                firstpanel.Visible = false;
                                midpanel.Visible = true;
                            }
                            else
                            {
                                Invalid.Visible = true;
                                Invalid.IsValid = false;
                            }
                        }
                        reader.Close();
                    }
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string query = "UPDATE Customer SET Password=@Password WHERE CNIC=@CNIC";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                cmd.Parameters.AddWithValue("@Password", password1.Text.Trim());

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string query1 = "Select Question_ID from SecurityQuestions where Text= @SecurityQuestion1";
            string query2 = "Select Question_ID from SecurityQuestions where Text= @SecurityQuestion2";
            string Q1 = "";
            string Q2 = "";
            string query = "UPDATE Customer SET SecurityQuestion1=@SQ1,SecurityQuestion2=@SQ2,Answer1=@Answer1,Answer2=@Answer2 " +
                "WHERE CNIC=@CNIC";
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query1, connection);
                command.Parameters.AddWithValue("@SecurityQuestion1", DropDownList1.SelectedItem.ToString());
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    Q1 = reader["Question_ID"].ToString();
                }

                reader.Close();
            }

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query2, connection);
                command.Parameters.AddWithValue("@SecurityQuestion2", DropDownList2.SelectedItem.ToString());
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    Q2 = reader["Question_ID"].ToString();
                }

                reader.Close();
            }

            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CNIC", Session["cnic"].ToString());
                cmd.Parameters.AddWithValue("@SQ1", Q1);
                cmd.Parameters.AddWithValue("@Answer1", security1.Text);
                cmd.Parameters.AddWithValue("@SQ2", Q2);
                cmd.Parameters.AddWithValue("@Answer2", security2.Text);

                int result = cmd.ExecuteNonQuery();

                if (result > 0)
                {
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }
    }
}