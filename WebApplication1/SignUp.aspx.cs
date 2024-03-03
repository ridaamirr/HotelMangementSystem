using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
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

        }

        bool isCnicUnique()
        {
            String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(Hotel); //Replace with your own connection string
            con.Open();
            string temp1 = "SELECT * FROM Customer WHERE CNIC='" + cnic1.Text + "';";

            SqlCommand cmd = new SqlCommand(temp1, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                con.Close();
                return false;
            }
            else
            {
                con.Close();
                return true;
            }
        }

        protected void RegisterButton_Click(object sender, EventArgs e)
        {
            if (isCnicUnique())
            {
                String Hotel = ConfigurationManager.ConnectionStrings["HotelManagementSystemConnectionString"].ConnectionString;
                using (SqlConnection con = new SqlConnection(Hotel))
                {
                    string query1 = "Select Question_ID from SecurityQuestions where Text= @SecurityQuestion1";
                    string query2 = "Select Question_ID from SecurityQuestions where Text= @SecurityQuestion2";
                    string Q1 = "";
                    string Q2 = "";

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

                    string query = "INSERT INTO Customer (CNIC, FirstName, LastName, PhoneNumber, Email, Address, DOB, Password, SecurityQuestion1, Answer1, SecurityQuestion2, Answer2) " +
                                   "VALUES (@CNIC, @FirstName, @LastName, @PhoneNumber, @Email, @Address, @DOB, @Password, @SQ1, @Answer1, @SQ2, @Answer2)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@CNIC", cnic1.Text);
                        cmd.Parameters.AddWithValue("@FirstName", firstname.Text);
                        cmd.Parameters.AddWithValue("@LastName", lastname.Text);
                        cmd.Parameters.AddWithValue("@PhoneNumber", phone.Text);
                        cmd.Parameters.AddWithValue("@Email", email.Text);
                        cmd.Parameters.AddWithValue("@Address", address.Text);
                        cmd.Parameters.AddWithValue("@DOB", dob.Text);
                        cmd.Parameters.AddWithValue("@Password", password1.Text);
                        cmd.Parameters.AddWithValue("@SQ1",Q1);
                        cmd.Parameters.AddWithValue("@Answer1", security1.Text);
                        cmd.Parameters.AddWithValue("@SQ2", Q2);
                        cmd.Parameters.AddWithValue("@Answer2", security2.Text);

                        con.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Redirect("Login.aspx");
                        }

                    }
                }
              
            }
            else
            {
                if (string.IsNullOrEmpty(cnic1.Text))
                    rfvCNIC2.ErrorMessage = "Cnic is Required"; 
                else
                    rfvCNIC2.ErrorMessage = "Cnic is not unique";
                rfvCNIC2.IsValid = false;
            }
        }
    }
}
