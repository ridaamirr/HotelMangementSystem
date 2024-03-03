<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/Site.Master" CodeBehind="SalesAndOffers.aspx.cs" Inherits="WebApplication1.SalesAndOffers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

             <div class="bg-image"></div> 
    <div  style="overflow-x:hidden;  class="container">
      <div class="container">
        <div class="row1">
            <div class="col-md-6 mx-auto"> 

  

                <div class="card1" id="panel2" runat="server"  style="width:125%;justify-content:center; margin-left:-40px">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:270px" >
                              <%--  <center>--%>
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Sales And Offers</h3>  <br /><br />
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
                                    <asp:DataList ID="DataList1" CssClass="myDataList" runat="server" RepeatDirect="Horizontal" RepeatColumns="2" DataKeyField="Offer_ID" DataSourceID="SQ1" OnItemDataBound="DataList1_ItemDataBound">
                                        <ItemTemplate> 
                                            <div class="item">
                                              &nbsp; 
                                              <asp:image runat="server" ID="img2" ImageUrl='<%# Bind("Image") %>' width="250px" height="200px" />                                          
                                           
                                             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
                                            <br /> 
                                                <center>
                                             <asp:HiddenField ID="hfOfferID" runat="server" Value='<%# Eval("Offer_ID") %>' />
                                            <div style="margin-left:0px">
                                                <div style="margin-left:0px">
                                            <asp:Label ID="OccasionLabel" ForeColor="AliceBlue" runat="server" Text='<%# Eval("Occasion") %>' />   
                                                    </div>
                                            <div style="margin-left:0px">
                                            <Label style="color:aliceblue">Discount(%):</Label>
                                            <asp:Label ID="PercentageLabel" runat="server" ForeColor="AliceBlue" Text='<%# Eval("Percentage") %>' />
                                            </div>
                                            <div style="margin-left:0px">
                                            <asp:Button class="btn btn-success" ID="orderbutton" runat="server" CommandArgument='<%# Eval("Offer_ID") %>' Text="Avail Now"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="orderbutton_Click"></asp:Button> 
                                                </center>
                                            </div>
                                            </div>
                                             <br />
                                            <br />
                                            <br />
                                                </div>
                                            </ItemTemplate> 
                                      
                                           
                                       
                                </asp:DataList> 
                                  <div style="margin-left:100px">
                                   <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                      </div>
                               <br />
                                <asp:SqlDataSource ID="SQ1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand="SELECT [Offer_ID], [Occasion], [Percentage], [Image] FROM SalesAndOffers"></asp:SqlDataSource>
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
            .myDataList {
        margin-left:-80px;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
    }
    .myDataList > div {
        width: 48%;
        margin-bottom: 20px;
    }
    .myDataList .item {
    float: left;
    margin-right: 80px;
}
        
        
    </style>
</asp:Content>

