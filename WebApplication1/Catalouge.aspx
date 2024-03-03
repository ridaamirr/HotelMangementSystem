<div class="bg-image"></div> 
    <div  style="overflow-x:hidden;  class="container">
      <div class="container">
        <div class="row1">
            <div class="col-md-6 mx-auto"> 

                 <div class="card1" id="panel1" runat="server" style="margin-left:100px" visible="true"> 
                        <div class="card-body">
                            <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Room Catalogue</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center> 

                                         <div class="form-group">
                                           <label style="color:aliceblue">Select Location</label>
                                             <br />  
                                               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand="SELECT [Location] FROM [Hotel]"></asp:SqlDataSource>
                                               <asp:DropDownList CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="Location" ID="DropDownList1"  Width="150px" runat="server" > </asp:DropDownList>
                                             <br /> 

                                             <asp:Button class="btn btn-success btn-block btn-lg" ID="BranchSelection" runat="server" Text="Continue"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="BranchSelection_Click"></asp:Button>
                                        <br />
                                         </div>
                                    </center>

                                </div>
                            </div> 
                        </div>
                    </div> 

                 <div class="card1" id="panel2" runat="server" visible="false"  style="width:123%;justify-content:center; margin-left:-40px">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:250px" >
                              <%--  <center>--%>
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Room Catalogue</h3>  <br /><br /> 
                                 
                                 
                            <%--    </center>--%>
                            </div>
                    
                        <div class="row" style="margin-left:130px">
                            <div class="col">
                               <%-- <center>--%> 
  <asp:DataList ID="DataList1" CssClass="myDataList" runat="server" RepeatDirect="Horizontal" RepeatColumns="2" DataKeyField="RoomType_ID" DataSourceID="SQ1" OnItemDataBound="DataList1_ItemDataBound">
    <ItemTemplate> 
        <div class="item" >
        <asp:image runat="server" ID="img2" ImageUrl='<%# Bind("Image") %>' width="250px" height="200px" />                                          
        <br />
        <asp:HiddenField ID="hfRoomTypeID" runat="server" Value='<%# Eval("RoomType_ID") %>' />
           <br />
            <center>
            <Label style="color:aliceblue">Number of Beds:</Label>           
            <asp:Label ID="NumberOfBedsLabel" ForeColor="AliceBlue" runat="server" Text='<%# Eval("NumberOfBeds") %>' />
                
            <br />                                                                                      
            <Label style="color:aliceblue">Type:</Label>
            <asp:Label ID="TypeLabel" runat="server" ForeColor="AliceBlue" Text='<%# Eval("Type") %>' />                                                                                  
            <br />                                          
            <Label style="color:aliceblue">Rating:</Label>
            <asp:Label ID="RatingLabel" runat="server" ForeColor="AliceBlue" Text='<%# Eval("Rating") %>' />
            <br />
            <Label style="color:aliceblue">Rs:</Label>
            <asp:Label ID="PriceLabel" runat="server" ForeColor="AliceBlue" Text='<%# Eval("Price") %>' />
            <br />&nbsp;&nbsp;&nbsp;
            <asp:Button class="btn btn-success" ID="bookingbutton" runat="server" Text="Book Now" CommandArgument='<%# Eval("RoomType_ID") %>' BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="bookingbutton_Click"></asp:Button>
                </center> 
            <br />
        </div>
    </ItemTemplate>
</asp:DataList>

                                 <div style="margin-left:160px">
                                   <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                     </div>
                                <br />
                                        <asp:SqlDataSource ID="SQ1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                              <%--  </center>--%>
                            </div>
                        </div> 
               
                    </div>
                </div> 



            </div> 

                 <div class="card1" id="panel3" runat="server" style="margin-left:100px" visible="false"> 
                        <div class="card-body">
                            <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Room Booking</h3> 
                                        
                                       <asp:TextBox CssClass="form-control" ID="hiddenid1" runat="server" Visible="false" display="dynamic" ></asp:TextBox>
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center> 

                                         <div class="form-group">
                                           
                                                <asp:TextBox CssClass="form-control" ID="nodays" runat="server" placeholder="Number of Days"></asp:TextBox>
                                               
                                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="nodays"
                                 ErrorMessage = "Number of Days are Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                           <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="nodays" 
                                             Type="Double" MinimumValue="1" MaximumValue="1000" 
                                             ErrorMessage="Enter a Valid Number" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>

                                             <br /> 
                                             <br /> 

                                             <asp:Button class="btn btn-success btn-block btn-lg" ID="Booking" runat="server" Text="Continue"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Booking_Click"></asp:Button>
                                        <br />
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
        margin-left:-70px;
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