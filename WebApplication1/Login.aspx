<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication1.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> 

    <div class="bg-image"></div> 
    <div style="overflow-x:hidden" class="container" > 
        <div class="container" >
            <div class="row1">
                <div class="col-md-6 mx-auto">
                    <div class="card1">
                        <div class="card-body">
                            <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="LoginType" runat="server">User Login</h3> 
                                    </center> 
                                    <div class="radio" style="margin-left:80px">  
                                        <asp:RadioButton ID="userradio" GroupName="logintyoe" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="userradio_CheckedChanged"/><label style="color:aliceblue">User Login</label> <label></label><label></label>
                                        <asp:RadioButton ID="adminradio" GroupName="logintyoe" runat="server" AutoPostBack="True" OnCheckedChanged="adminradio_CheckedChanged"/><label style="color:aliceblue">Admin Login</label>
                                    </div>                                  
                                </div>  
                            </div>

                            <div class="row">
                                <div class="col">
                                    <center>
                                        
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="username" runat="server" placeholder="CNIC"></asp:TextBox>
                                            <asp:TextBox CssClass="form-control" ID="adminusername" runat="server" placeholder="UserName" Visible="false"></asp:TextBox>
                                        </div>
                                        <div>
                                             <asp:RegularExpressionValidator ID="regexCNIC" runat="server" ControlToValidate="username" ForeColor="Red" ErrorMessage="Invalid CNIC format" ValidationExpression="^\d{5}-\d{7}-\d{1}$" Display="Dynamic"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="rfvCNIC2" runat="server" ControlToValidate="username"
                                 ErrorMessage = "Cnic is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                             <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="adminusername"
                                 ErrorMessage = "Username is Required"  ForeColor="Red" Display="Dynamic" Visible="false"></asp:RequiredFieldValidator>
                                        </div>
                                        <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="password" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                                        </div> 

                                        <asp:RequiredFieldValidator ID="Invalid" ControlToValidate="password" runat="server" Visible="false"
                                   ErrorMessage="Invalid Credentials" ForeColor="Red"></asp:RequiredFieldValidator>   

                                        <div>
                                           <a style="text-align:left" href="ForgetPass.aspx" id="forgetpass" runat="server">Forget Password?</a>
                                        </div> 
                                        <label>   </label> 
                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" ID="LoginButton" runat="server" Text="Login" OnClick="LoginButton_Click1" BackColor="#1E90FF" BorderColor="#1E90FF"></asp:Button>
                                        </div>

                                        <a style="text-align:left" href="SignUp.aspx" id="register" runat="server">Register Now</a>  <br /> 
                                        <label>             </label> 
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
            margin-top:100px;
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
