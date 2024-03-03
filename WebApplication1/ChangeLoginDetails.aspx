<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ChangeLoginDetails.aspx.cs" Inherits="WebApplication1.ChangeLoginDetails" %>
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
                                        <h3 style="color:aliceblue;font-weight:bold" id="LoginType" runat="server">Login Details</h3> 
                                    </center>                               
                                </div>  
                            </div>

                            <div class="row" id="firstpanel" runat="server">
                                <div class="col">
                                    <center>
                                        
                                        <div class="form-group"> 
                                           <br /> <label style="color:aliceblue;">Enter your Password to continue</label><br /> 
                                            <label></label> 
                                            
                                            <asp:TextBox CssClass="form-control" ID="currentpassword" runat="server" placeholder="Current Password" TextMode="Password"></asp:TextBox>
                                             <asp:RequiredFieldValidator ID="Invalid" ControlToValidate="currentpassword" runat="server" Visible="false"
                                   ErrorMessage="Invalid Password" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                        </div>                                                                          
                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" BorderColor="#003399" ID="ChangePassbtn" runat="server" Onclick="ChangePass_Click" Text="Change Password"></asp:Button>
                                        </div>  

                                            <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" BorderColor="#003399" ID="SecQuesbtn" runat="server" Onclick="SecQuesbtn_Click" Text="Change Security Questions"></asp:Button>
                                        </div>  
                                      
                                        </center>

                                </div>
                            </div> 

                            <div class="row" id="midpanel" runat="server" visible="false">
                                <div class="col">
                                    <center>                                        
                                       <div class="form-group">
                                         <br />
                                      <label style="color:aliceblue ;margin-left:30px" >Security Questions&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <br /> 
                                            <label></label> 
                                    
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server">
                                                                                          
                                          </asp:DropDownList>
                                     <br />   

                                            <asp:TextBox CssClass="form-control" ID="security1" runat="server" placeholder="Answer" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="security1"
                                   ErrorMessage="Answer is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                           <br />
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server">
                                                                                    </asp:DropDownList>          
                                                                               
                                          
      
          <br />
               <asp:TextBox CssClass="form-control" ID="security2" runat="server" placeholder="Answer" ></asp:TextBox>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="security2"
                                   ErrorMessage="Answer is required" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                   </div>
                                                                                                                 
                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" ID="Button2" type="submit" runat="server" Text="Save" OnClick="Button2_Click"></asp:Button>
                                        </div>                                     
                                        
                                    </center>

                               </div>
                            </div>

                             <div class="row" id="secondPanel" runat="server" visible="false">
                                <div class="col">
                                    <center>                                        
                                       <div class="form-group"> 
                                           <br /> <label style="color:aliceblue;">Change Password</label><br /> 
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
                
         </div> 
                               
                                                                                                                 
                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" BackColor="#1E90FF" ID="Button1" type="submit" runat="server" Text="Save" OnClick="Button1_Click"></asp:Button>
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
          color: black;
          border-color:black;
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
