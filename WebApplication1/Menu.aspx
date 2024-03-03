<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="WebApplication1.Menu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

             <div class="bg-image"></div> 
    <div  style="overflow-x:hidden";  class="container">
      <div class="container">
        <div class="row1">
            <div class="col-md-6 mx-auto"> 

                <div class="card1" id="panel1" runat="server" visible="true"  style="width:120%;justify-content:center; margin-left:-40px">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:300px" >
                              <%--  <center>--%>
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Menu</h3>  <br /><br />
                            <%--    </center>--%>
                            </div>                                             
                        </div>
                            

                       <%-- <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>--%> 
                      
                
                        <div class="row" style="margin-left:130px">
                            <div class="col">
                               <%-- <center>--%> 
                            <asp:DataList ID="DataList1" CssClass="myDataList" runat="server" RepeatDirect="Horizontal" RepeatColumns="2" DataKeyField="Food_ID" DataSourceID="SQ1" OnItemDataBound="DataList1_ItemDataBound">
    <ItemTemplate> 
        <div class="item">
            <asp:image runat="server" ID="img2" ImageUrl='<%# Bind("Image") %>' width="250px" height="200px" />                                          
            <br />
            <asp:HiddenField ID="hfFoodID" runat="server" Value='<%# Eval("Food_ID") %>' />
            <br />
           
            <div>
                <center>
                <asp:Label ID="NameLabel" ForeColor="AliceBlue" runat="server" Text='<%# Eval("Name") %>' />
           </center>
                    </div> 
             <div>
                <center>
                <asp:Label ID="CuisineLabel" ForeColor="AliceBlue" runat="server" Text='<%# Eval("Cuisine") %>' />
            </center>
                    </div>
                     <div> 
                <center>
                <asp:Label ID="DescLabel" runat="server" ForeColor="AliceBlue" Text='<%# Eval("[Description]") %>' />  
            </center>
                    </div>
           
            <div>
                <center>                         
                <Label style="color:aliceblue">Rs.</Label>
                <asp:Label ID="PriceLabel" runat="server" ForeColor="AliceBlue" Text='<%# Eval("Price") %>' />
                </center>                                 
            </div>
           
            <div>
             <center>
                <asp:Button class="btn btn-success" ID="orderbutton" runat="server" Text="Order Now" CommandArgument='<%# Eval("Food_ID") %>' BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="orderbutton_Click"></asp:Button> 
            </center>  
                 </div>
                          
            <br />
            <br />
        </div>
    </ItemTemplate> 
</asp:DataList>

                                <asp:SqlDataSource ID="SQ1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                              <%--  </center>--%>
                            </div>
                        </div> 
               
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div> 

     <div class="card1" id="panel3" runat="server" style="margin-left:430px; width:350px"  visible="false"> 
                        <div class="card-body">
                            <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Place Order</h3> 
                                        
                                        <br /><asp:TextBox CssClass="form-control" ID="hiddenid1" runat="server" Visible="false" display="dynamic" ></asp:TextBox>
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center> 

                                         <div class="form-group">
                                           
                                                <asp:TextBox CssClass="form-control" ID="Quantity" runat="server" placeholder="Quantity" Width="250"></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Quantity"
                                 ErrorMessage = "Quantity is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                           <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Quantity" 
                                             Type="Double" MinimumValue="1" MaximumValue="100" 
                                             ErrorMessage="Enter a Valid Number" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>

                                             <br /> 
                                             <br /> 

                                             <asp:Button class="btn btn-success btn-block btn-lg" ID="Order" runat="server" Text="Continue" Width="250" BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Order_Click"></asp:Button>
                                        <br />
                                         </div>
                                    </center>

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
        #container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50vh;
            flex-wrap: wrap;
        }
            .myDataList {
                margin-left:-90px;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }
            .myDataList .item {
    float: left;
    margin-right: 60px;
}

    .myDataList .col {
        width: calc(50% - 10px);
        margin-bottom: 20px;
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
