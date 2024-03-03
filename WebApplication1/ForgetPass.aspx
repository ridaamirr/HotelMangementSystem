<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgetPass.aspx.cs" Inherits="WebApplication1.ForgetPass" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> 
    <div class="bg-image"></div> 
    <div style="overflow-x:hidden" class="container"> 
        <div class="container">
            <div class="row1">
                <div class="col-md-6 mx-auto">
                    <div class="card1" id="card1" runat="server">
                        <div class="card-body">
                             <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />
                                        <h3 style="color:aliceblue;font-weight:bold" runat="server">Forget Password</h3> 
                                    </center>                               
                                </div>  
                            </div>

                            <div class="row" id="firstpanel" runat="server">
                                <div class="col">
                                    <center>
                                        
                                        <div class="form-group"> 
                                           <br /> <label style="color:aliceblue">Enter your CNIC to continue</label><br /> 
                                            <label></label> 
                                            
                                            <asp:TextBox CssClass="form-control" ID="cnic2" runat="server" placeholder="CNIC"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="Invalid" ControlToValidate="cnic2" runat="server" Visible="false"
                                   ErrorMessage="Account with this CNIC does not exist" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </div>                                                                          
                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" BorderColor="#1E90FF" ID="ContinueButton" runat="server" Onclick="ContinueButton_Click" Text="Continue"></asp:Button>
                                        </div>                                 
                                      
                                        </center>

                                </div>
                            </div> 

                             <div class="row" id="secondPanel" runat="server" visible="false">
                                <div class="col">
                                    <center>                                        
                                       <div class="form-group">  
                                           <br />
                                            <label style="color:aliceblue">CNIC</label><br /> 
                                           <asp:TextBox CssClass="form-control" ID="cnic1" runat="server" Enabled="False"></asp:TextBox>
                                           <br />
                                         
                                            <label></label>
                            
                             <label  id="Q1" runat="server" style="color:aliceblue"></label><br /> 
                           <asp:TextBox CssClass="form-control" ID="Answer1" runat="server" placeholder="Answer"></asp:TextBox>
                          <div class="form-group">    
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="Answer1"
                                   ErrorMessage="Answer is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>   
                             
                              <br />
                               <label  id="Q2" runat="server" style="color:aliceblue"></label><br /> 
                           <asp:TextBox CssClass="form-control" ID="Answer2" runat="server" placeholder="Answer"></asp:TextBox>
                          <div class="form-group">    
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="Answer2"
                                   ErrorMessage="Answer is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                              <asp:RequiredFieldValidator ID="Invalid1" ControlToValidate="Answer1" runat="server" Visible="false"
                                   ErrorMessage="Invalid Answer" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                           </div>                                                                    
         </div> 
                               
                                                                                                                 
                                         <div class="form-group">  
                                              
                                              
                                          
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" BorderColor="#1E90FF" ID="Button1" runat="server" Text="Conintue" OnClick="Button1_Click"></asp:Button>
                                        </div>                                     
                                        </div>
                                    </center>

                                </div>
                            </div> 

                            

                        
                         <div class="row" id="thirdpanel" runat="server" visible="false">
                                <div class="col">
                                    <center>                                        
                                       <div class="form-group"> 
                                           <br /> <label style="color:aliceblue">Change Password</label><br /> 
                                            <label></label>
                            
                
                           <asp:TextBox CssClass="form-control" ID="password1" runat="server" placeholder="Atleast 8 characters" TextMode="Password" ></asp:TextBox>
                          <div class="form-group">
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="password1"
                                   ErrorMessage="Password is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                           </div> 
                                            <div class="form-group">
                            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="password1"
                                ErrorMessage="Password must be at least 8 characters long" ForeColor="Red"
                                ValidationExpression="^.{8,}$" Display="Dynamic"></asp:RegularExpressionValidator> 
                              </div>
                   
                           
                           <asp:TextBox CssClass="form-control" ID="ConfirmPassword" runat="server" placeholder="Re-enter Password" TextMode="Password" ></asp:TextBox>
                             <asp:CompareValidator ID="cvConfirmPassword" runat="server" ControlToValidate="ConfirmPassword"
                                    ControlToCompare="Password1" ErrorMessage="Passwords do not match" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                       
                                               <br />
                                    
         </div> 
                               
                                                                                                                 
                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" BorderColor="#1E90FF" ID="Button2" type="submit" runat="server" Text="Save" OnClick="Button2_Click"></asp:Button>
                                        </div>                                     
                                        
                                    </center>

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
            background-size:cover;
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
            place-content:center;
            margin-left:370px;
            margin-top:50px;
        }  
        .card1 {
          background-color: rgba(0, 0, 0, 0.7); /* light color with opacity */
          color: aliceblue;
          border-radius: 20px;
          width: 65%;
          height: 120%;
          backdrop-filter: blur(2px);
        }
        .row2{
            font-family:'Arial Unicode MS';
            font-weight:bold;
        } 

        
    
    </style>
    
</asp:Content>

