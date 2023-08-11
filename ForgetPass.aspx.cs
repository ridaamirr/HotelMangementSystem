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
    public partial class ForgetPass : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;

        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            string query = "SELECT SecurityQuestion1,SecurityQuestion2 FROM Customer WHERE CNIC='" + cnic2.Text + "'";
            string Q11 = "";
            string Q21 = "";
             using (SqlConnection connection = new SqlConnection(Hotel))
             {
                 connection.Open();
                 SqlCommand command = new SqlCommand(query, connection);
                
                 SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    firstpanel.Visible = false;
                    secondPanel.Visible = true;
                    cnic1.Text = cnic2.Text;
                    if (reader.Read())
                    {
                        Q11 = reader["SecurityQuestion1"].ToString();
                        Q21 = reader["SecurityQuestion2"].ToString(); 
                        
                    }
                    reader.Close();
                    
                }
                else
                {
                    Invalid.Visible = true;
                    Invalid.IsValid = false;
                }
               
             }

            string query1 = "Select Text from SecurityQuestions where Question_ID= @SecurityQuestion1";
            string query2 = "Select Text from SecurityQuestions where  Question_ID= @SecurityQuestion2";

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();
                SqlCommand command1 = new SqlCommand(query1, connection);
                command1.Parameters.AddWithValue("@SecurityQuestion1", Q11);
                SqlDataReader reader1 = command1.ExecuteReader();

                if (reader1.Read())
                {
                    Q1.InnerText = reader1["Text"].ToString();
                }

                reader1.Close();
            }

            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();
                SqlCommand command2 = new SqlCommand(query2, connection);
                command2.Parameters.AddWithValue("@SecurityQuestion2", Q21);
                SqlDataReader reader2 = command2.ExecuteReader();

                if (reader2.Read())
                {
                    Q2.InnerText = reader2["Text"].ToString();
                }

                reader2.Close();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string query = "SELECT Answer1,Answer2 FROM Customer WHERE CNIC='" + cnic2.Text + "'";
            bool flag = true;
            using (SqlConnection connection = new SqlConnection(Hotel))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);

                SqlDataReader reader = command.ExecuteReader();
               
              
                 if (reader.Read())
                 {
                     if (reader["Answer1"].ToString() != Answer1.Text.Trim() || reader["Answer2"].ToString() != Answer2.Text.Trim())
                     {
                         Invalid1.Visible = true;
                         Invalid1.IsValid = false;
                        flag = false;
                     }  
                     else
                     {
                        flag = true;
                     }

                 }
              
                reader.Close();
            }
            if (flag == true)
            {
                thirdpanel.Visible = true;
                secondPanel.Visible = false;   
            }
           
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string query = "UPDATE Customer SET Password=@Password WHERE CNIC=@CNIC";

            using (SqlConnection con = new SqlConnection(Hotel))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@CNIC", cnic2.Text);
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
    }
}