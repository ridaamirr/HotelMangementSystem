<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Generate Bill.aspx.cs" Inherits="WebApplication1.Generate_Bill" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> 
    <div class="bg-image"></div> 
    <div style="overflow-x:hidden" class="container" > 
        <div class="container" >
            <div class="row1">
                <div class="col-md-6 mx-auto">
                  
                 <div class="card2" id="panel1" runat="server" style="width:120%;justify-content:center; margin-left:-170px">
                    <div class="card-body" > 
                        <div class="row">
                            <div class="col" > 
                                <center>
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Generate Bill</h3>
                                
                               <br /><h4 id="amount" runat="server"></h4><br />
                            </center>
                                    </div>  
                            
                            </div>
                        <center>
                        <div class="row" style="width:80%;margin-left:-60px">
                            <div class="col">  
                           <div style="margin-left:3vh">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CommandRowStyle-BackColor="#2196F3" CommandRowStyle-ForeColor="white" DataSourceID="SQ1" OnRowDataBound="GridView1_RowDataBound">
                             <Columns>
                                 <asp:TemplateField HeaderText="Location">
                                     <ItemTemplate>
                                         <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Room Number">
                                     <ItemTemplate>
                                         <asp:Label ID="lblRoonnNo" runat="server" Text='<%# Bind("RoomNumber") %>' ForeColor="black" Width="100px"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField> 
                                 <asp:TemplateField HeaderText="Number of Beds">
                                     <ItemTemplate>
                                         <asp:Label ID="lblNoOfBeds" runat="server" Text='<%# Bind("NumberOfBeds") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>  
                                 <asp:TemplateField HeaderText="Type">
                                     <ItemTemplate>
                                         <asp:Label ID="lblType" runat="server" Text='<%# Bind("Type") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>  
                                 <asp:TemplateField HeaderText="Number of Days">
                                     <ItemTemplate>
                                         <asp:Label ID="lblDays" runat="server" Text='<%# Bind("NumberOfDays") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField> 
                                 <asp:TemplateField HeaderText="Price">
                                     <ItemTemplate>
                                         <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("Price") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>    
                                  <asp:TemplateField HeaderText="" Visible="false">
                                     <ItemTemplate>
                                         <asp:Label ID="lblroomid" runat="server" Text='<%# Bind("Room_ID") %>' ForeColor="black"></asp:Label> </ItemTemplate>
                                     </asp:TemplateField>
                                 <asp:TemplateField HeaderText="isBooked" Visible="false">
                                     <ItemTemplate>
                                         <asp:Label ID="lblisBooked" runat="server" Text='<%# Bind("isBooked") %>' ForeColor="black"></asp:Label> </ItemTemplate>
                                     </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Checkout">
                                     <ItemTemplate>
                                         <asp:Button class="btn btn-success" ID="status" runat="server" Text="Checkout"  CommandArgument='<%# Eval("Room_ID") %>' BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="status_Click"  ></asp:Button>
                                            </ItemTemplate>
                                 </asp:TemplateField>
                                 </Columns>
                                <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F2F2F2" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>  
                               </div>
                            <asp:SqlDataSource ID="SQ1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                            <div style="margin-left:3vh; width:103%">
                             <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CommandRowStyle-BackColor="#2196F3" CommandRowStyle-ForeColor="white" DataSourceID="SQ2">
                             <Columns>
                                 <asp:TemplateField HeaderText="Name">
                                     <ItemTemplate>
                                         <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Quantity">
                                     <ItemTemplate>
                                         <asp:Label ID="lblQuantity" runat="server" Text='<%# Bind("Quantity") %>' ForeColor="black" Width="150px"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>   
                                 <asp:TemplateField HeaderText="Price">
                                     <ItemTemplate>
                                         <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("Price") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField> 
                                 </Columns>
                                <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F2F2F2" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>  
                                </div>
                            <asp:SqlDataSource ID="SQ2" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>

                            <div style="margin-left:3vh; width:103%">
                               <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CommandRowStyle-BackColor="#2196F3" CommandRowStyle-ForeColor="white" DataSourceID="SQ3">
                             <Columns>
                                 <asp:TemplateField HeaderText="Occasion">
                                     <ItemTemplate>
                                         <asp:Label ID="lblOccasion" runat="server" Text='<%# Bind("Occasion") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Percentage">
                                     <ItemTemplate>
                                         <asp:Label ID="lblPercentage" runat="server" Text='<%# Bind("Percentage") %>' ForeColor="black" Width="150px"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>   
                                 </Columns>
                                <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F2F2F2" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>  
                                </div>
                                
                            <asp:SqlDataSource ID="SQ3" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                             <center>
                                <label style="margin-left:11vh" runat="server" id="history"></label> 
                                </center>

                        </div>
                        </div>  

                         <div class="form-group">
                                    <asp:Button class="btn btn-success  btn-lg" ID="CheckOut" BackColor="#1E90FF" BorderColor="#1E90FF" runat="server" Text="Check Out All" OnClick=" CheckOut_Click"></asp:Button> 
                         
                          </div>
                        </center>
                            <br />

                    </div>
                </div> 

                  <div class="card1" id="panel2" runat="server" style="width:120%;justify-content:center; margin-left:-120px" visible="false">
                    <div class="card-body"> 
                        
                      <div class="row">
                            <div class="col" >
                                 <br />
                               <center>                          
                                <h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Rate Rooms</h3>  <br />                                 
                           </center>
                            </div>     
                </div> 

                         <div class="row" style="margin-left:38px; width:90%">
                            <div class="col"> 
<asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="SQ5">
    <Columns>
        <asp:BoundField DataField="Location" HeaderText="Location" ItemStyle-ForeColor="Black" />
        <asp:BoundField DataField="RoomNumber" HeaderText="Room Number" ItemStyle-ForeColor="Black" />
         <asp:TemplateField HeaderText="Rate Rooms">
            <ItemTemplate>
                <asp:TextBox ID="txtrate" runat="server" ForeColor="Black" Width="130px" CssClass="form-control"></asp:TextBox>
                <asp:label ID="lblrate" runat="server" ForeColor="Black" Width="130px" Visible="false"></asp:label>
                <br />
                <asp:Label ID="lblRatingError" runat="server" Text="" />
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="">
            <ItemTemplate>
                <asp:Button ID="btnRate" class="btn btn-success"  runat="server" Text="Rate" CommandName="RateRoom" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" OnCommand="GridView5_RowCommand" BackColor="#1E90FF" BorderColor="#1E90FF"  />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />
    <RowStyle BackColor="#F2F2F2" />
    <AlternatingRowStyle BackColor="White" />
</asp:GridView>
  <asp:SqlDataSource ID="SQ5" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                             



                            
                        </div>
                        </div> 
                           <center>
                         <div class="form-group">
                                <asp:Button class="btn btn-success  btn-lg" ID="Checkout2" BackColor="#1E90FF" BorderColor="#1E90FF" runat="server" Text="Done" OnClick=" CheckOut2_Click"></asp:Button> 
                         </center>  
                       <br />
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
            .curved-button {
        border-radius: 3.5px; /* adjust the radius value to your preference */
    }
        .card1 {
          background-color: rgba(0, 0, 0, 0.7); /* light color with opacity */
          color: aliceblue;
          border-radius: 20px;
          width: 65%;
          height: 120%;
          backdrop-filter: blur(2px);
        }
        .card2 {
          background-color: rgba(0, 0, 0, 0.7); /* light color with opacity */
          color: aliceblue;
          border-radius: 20px;
          width: 135%;
          height: 120%;
          backdrop-filter: blur(2px);
        }
        .row2{
            font-family:'Arial Unicode MS';
            font-weight:bold;
        }  

          table {
          border-collapse: collapse;
          width: 100%;
          margin-bottom: 20px;
        }

        th,
        td {
          text-align: left;
          padding: 8px;
        }

        th {
          background-color: #1E90FF;
          color: aliceblue;
          font-weight: bold; 
        }

        tr:nth-child(even) {
          background-color: #f2f2f2;
        }

         Update edit field styles 
        .edit-mode {
            background-color: rgba(255, 255, 255, 0.8);
        }


        .edit-mode input {
          border: none;
          padding: 5px;
          border-radius: 5px;
        }

         Update error label styles 
        .error-container {
          text-align: center;
        }

        #lblError {
          color: red;
          margin-top: 10px;
        }

        
    
    </style>
    


</asp:Content>