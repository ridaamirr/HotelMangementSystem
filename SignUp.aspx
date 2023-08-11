<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="WebApplication1.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">   

   
         <div class="bg-image"></div> 
    <div  style="overflow-x:hidden;  class="container">
      <div class="container">
        <div class="row1">
            <div class="col-md-6 mx-auto">
                <div class="card1" style="width:125%;justify-content:center; margin-left:-40px">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:290px" >
                              <%--  <center>--%>
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Sign Up</h3>  <br />
                            <%--    </center>--%>
                            </div>
                        </div>
                       <%-- <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>--%> 


                        <div class="row" style="margin-left:38px">
                            <div class="col">
                               <%-- <center>--%> 
                                 <div style="display:flex"> 
                                    
                                    <label style="color:aliceblue">CNIC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                      <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="cnic1" runat="server" placeholder="00000-0000000-0"></asp:TextBox>
                          <asp:RegularExpressionValidator ID="regexCNIC" runat="server" ControlToValidate="cnic1" ForeColor="Red" ErrorMessage="Invalid CNIC format" ValidationExpression="^\d{5}-\d{7}-\d{1}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                           <asp:RequiredFieldValidator ID="rfvCNIC2" runat="server" ControlToValidate="cnic1"
                                 ErrorMessage = "Cnic is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>   
                                </div>
                               

                                <div style="display:flex">
                                <label style="color:aliceblue">Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>  
                                     <div class="form-group">
                            <asp:TextBox CssClass="form-control" ID="firstname" runat="server" placeholder="First Name"></asp:TextBox> 
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="firstname"
                                   ErrorMessage="First Name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>   
                                         </div> 
                                    <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                          <div class="form-group">
        <asp:TextBox CssClass="form-control" ID="lastname" runat="server" placeholder="Last Name"></asp:TextBox> 
                                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="lastname"
                                   ErrorMessage="Last Name is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>    
                            </div>
                              
                                 <div style="display:flex">
                              <label style="color:aliceblue">Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                 <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="password1" runat="server" placeholder="Atleast 8 characters" TextMode="Password" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="password1"
                                   ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="Password1"
                                ErrorMessage="Password must be at least 8 characters long" ForeColor="Red"
                                ValidationExpression="^.{8,}$" Display="Dynamic"></asp:RegularExpressionValidator>
                      </div> 
                                     <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                            <div class="form-group" style="margin-left:-110px">
                           <asp:TextBox CssClass="form-control" ID="ConfirmPassword" runat="server" placeholder="Re-enter Password" TextMode="Password" ></asp:TextBox> 
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ConfirmPassword"
                                   ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                             <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="ConfirmPassword"
                                    ControlToCompare="Password1" ErrorMessage="Passwords do not match" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                        </div> 
                                     </div>

                                <div style="display:flex">
                            <label style="color:aliceblue">Contact Number&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                  <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="phone" runat="server" placeholder="+9200-0000000" Width="150" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="phone"
                                   ErrorMessage="Phone Number is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="phone"
                                ErrorMessage="Please enter a valid phone number" ForeColor="Red"
                                ValidationExpression="^\+\d{12}$" Display="Dynamic"></asp:RegularExpressionValidator>
       </div>
                        </div>  

                                 <div style="display:flex">
                             <label style="color:aliceblue">Residential Address&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <div class="form-group">
                           <asp:TextBox CssClass="form-control" ID="address" runat="server" placeholder="" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="address"
                                   ErrorMessage="Address is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>    
                                     </div>
                              
                                 <div style="display:flex">
                            <label style="color:aliceblue">Date of Birth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                   <div class="form-group">
                      
                           <asp:TextBox CssClass="form-control" ID="dob" runat="server" placeholder="YYYY-MM-DD" Width="120" ></asp:TextBox> 
                     

                           <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="dob"
                            ErrorMessage="DOB is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revDOB" runat="server" ControlToValidate="dob"
                            ErrorMessage="Please enter a valid date of birth in the format YYYY-MM-DD" ForeColor="Red"
                            ValidationExpression="^(19|20)\d{2}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$" Display="Dynamic"></asp:RegularExpressionValidator>
                 </div> 
      </div>

                                 <div style="display:flex">   
                                      <label style="color:aliceblue">Security Questions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                      <div class="form-group"> 
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server">                                        
                                          </asp:DropDownList>
                                     <br />  
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server">
                                          </asp:DropDownList>          
                                                                                </div>  
                                      <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <div class="form-group"> 
                                          
       <asp:TextBox CssClass="form-control" ID="security1" runat="server" placeholder="Answer" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="security1"
                                   ErrorMessage="Answer is required" ForeColor="Red" Display="Dynamic" ></asp:RequiredFieldValidator>
          <br />
               <asp:TextBox CssClass="form-control" ID="security2" runat="server" placeholder="Answer" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="security2"
                                   ErrorMessage="Answer is required" ForeColor="Red" Display="Dynamic" ></asp:RequiredFieldValidator>
         </div> 
                                 </div>
                       
                        <div class="form-group" style="margin-left:450px;">
                           <asp:Button class="btn btn-success  btn-lg" ID="RegisterButton" runat="server" Text="Register Now" BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="RegisterButton_Click"></asp:Button>
                            </div>
                              <%--  </center>--%>
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
