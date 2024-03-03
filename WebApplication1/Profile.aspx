<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebApplication1.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> 
         <div class="bg-image"></div> 
    <div  style="overflow-x:hidden;" class="container">
      <div class="container">
        <div class="row1">
            <div class="col-md-6 mx-auto">
                <div class="card1" style="width:105%;justify-content:center; margin-left:-40px">
                    <div class="card-body"> 
                        <div class="row">

                            <div class="col" style="margin-left:20px">
                                <center>
                               <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Profile</h3>  <br />
                                </center>
                            </div>
                        </div>
                        <div class="row" style="margin-left:38px">
                            <div class="col">
                                 <div style="display:flex"> 
                                    <label style="color:aliceblue">CNIC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                      <div class="form-group">
                                          <asp:TextBox CssClass="form-control" ID="cnic1" runat="server" placeholder="CNIC" Enabled="false"></asp:TextBox>
                                      </div>   
                                 </div>
                                <div style="display:flex">
                                    <label style="color:aliceblue">Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>  
                                    <div class="form-group">
                                        <asp:TextBox CssClass="form-control" ID="firstname" runat="server" placeholder="First Name"></asp:TextBox> 
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  runat="server" ControlToValidate="firstname" Display="Dynamic" ErrorMessage="First Name is required" ForeColor="Red"></asp:RequiredFieldValidator>   
                                    </div> 
                                    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <div class="form-group">
                                        <asp:TextBox CssClass="form-control" ID="lastname" runat="server" placeholder="Last Name"></asp:TextBox> 
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="lastname" Display="Dynamic" ErrorMessage="Last Name is required" ForeColor="Red"></asp:RequiredFieldValidator>
                                    </div> 
                                </div>
                                <div style="display:flex"> 
                                    <label style="color:aliceblue">Email Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    <div class="form-group">
                                        <asp:TextBox CssClass="form-control" ID="email" runat="server" placeholder="someone@gmail.com" ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="email"
                                   ErrorMessage="Email is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="email"
                                ErrorMessage="Please enter a valid email address" ForeColor="Red"
                                ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" Display="Dynamic"></asp:RegularExpressionValidator>                                    </div>    
                                </div> 
                                <div style="display:flex">
                                    <label style="color:aliceblue">Contact Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <div class="form-group"> 
                                       
                           <asp:TextBox CssClass="form-control" ID="phone" runat="server" placeholder="+9200-0000000" ></asp:TextBox>
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="phone"
                                   ErrorMessage="Phone Number is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="phone"
                                ErrorMessage="Please enter a valid phone number" ForeColor="Red"
                                ValidationExpression="^\+\d{12}$" Display="Dynamic"></asp:RegularExpressionValidator>  </div>
                                </div> 
                                <div style="display:flex">
                                    <label style="color:aliceblue">Residential Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <div class="form-group">
                                        <asp:TextBox CssClass="form-control" ID="address" runat="server" placeholder="" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="address"
                                   ErrorMessage="Address is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> </div>
                                </div>
                                <div style="display:flex">
                                    <label style="color:aliceblue">Date of Birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <div class="form-group">
                                        <asp:TextBox CssClass="form-control" ID="dob" runat="server" placeholder="YYYY-MM-DD" ></asp:TextBox>              
                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="dob"
                            ErrorMessage="DOB is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revDOB" runat="server" ControlToValidate="dob"
                            ErrorMessage="Please enter a valid date of birth in the format YYYY-MM-DD" ForeColor="Red"
                            ValidationExpression="^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </div>
                                </div>  
                                <a href="ChangeLoginDetails.aspx">Change Login Details</a>               
                                <div class="form-group" style="margin-left:410px">
                                    <asp:Button class="btn btn-success  btn-lg" ID="ProfileButton" BackColor="#1E90FF" BorderColor="#1E90FF" runat="server" Text="Save" OnClick=" ProfileButton_Click"></asp:Button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
        <style>
        body { 
            overflow-x: hidden;
        }  
        .bg-image {
            background-image: url('3660.jpg');
            background-size: cover;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: -1;
        }
        .row1{
            width:100%;
            height:100%;
          
            margin-left:280px;
            margin-top:50px;
        }
        .card1 {
          background-color: rgba(0, 0, 0, 0.7); /* light color with opacity */
          color: black;
          border-color:black;
          border-radius: 20px;
          width: 65%;
          height: 120%;
          backdrop-filter: blur(2px);
        }
         
        
    </style>
</asp:Content>

