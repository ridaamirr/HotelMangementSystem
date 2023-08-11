<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ViewBillDetails.aspx.cs" Inherits="WebApplication1.ViewBillDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> 
    <div class="bg-image"></div> 
    <div style="overflow-x:hidden" class="container" > 
        <div class="container" >
            <div class="row1">
                <div class="col-md-6 mx-auto">
                  
                 <div class="card2" id="panel1" runat="server" style="width:120%; position:relative; margin-left:-120px">
                    <div class="card-body" > 
                        <div class="row">
                            <div class="col" style="position:absolute" > 
                                <a style="margin-left:50px;margin-top:8vh" href="Payments.aspx" class="arrow left"></a></div>
                                <center> 
                                 <br />
                                    <h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Bill</h3>
                                
                               <br /><h4 id="amount" runat="server"></h4><br />
                            </center>
                                    </div>  
                            
                            </div>
                        <center>
                        <div class="row" style="width:80%">
                            <div class="col">  
                           
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CommandRowStyle-BackColor="#2196F3" CommandRowStyle-ForeColor="white" DataSourceID="SQ1">
                             <Columns>
                                 <asp:TemplateField HeaderText="Location">
                                     <ItemTemplate>
                                         <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Room Number">
                                     <ItemTemplate>
                                         <asp:Label ID="lblRoonnNo" runat="server" Text='<%# Bind("RoomNumber") %>' ForeColor="black" Width="150px"></asp:Label>
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
                                 </Columns>
                                <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F2F2F2" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>  
                            <asp:SqlDataSource ID="SQ1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                            
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
                            <asp:SqlDataSource ID="SQ2" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                            
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
                            <asp:SqlDataSource ID="SQ3" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand=""></asp:SqlDataSource>
                             
                                <label runat="server" id="history"></label> 
                                

                        </div>
                        </div>
                        </center>
                            <br />

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
                         .arrow {
          position: absolute;
          top: 50%;
         width: 20px; /* adjust this value to resize the arrow */
          height: calc(1.4 * 14px); /* maintain 7:5 height to width ratio */
          background: transparent;
          border-top: 1vmin solid white;
          border-right: 1vmin solid white;
          box-shadow: 0 0 0 lightgray;
          transition: border-color 200ms ease;
        }

        .arrow.left {
          left: 0;
          transform: translate3d(0,-50%,0) rotate(-135deg);
        }

        .arrow:hover {
          border-color:#2196F3 ;
        }

        .arrow:before {
          content: '';
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-40%,-60%) rotate(45deg);
          width: 100%;
          height: 100%;
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