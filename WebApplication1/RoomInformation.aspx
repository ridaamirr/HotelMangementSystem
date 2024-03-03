<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoomInformation.aspx.cs" Inherits="WebApplication1.RoomInformation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="bg-image"></div> 
    <div style="overflow-x:hidden" class="container" > 
        <div class="container" >
            <div class="row1">
                <div class="col-md-6 mx-auto">

                    <div class="card1" id="panel1" runat="server" visible="true"> 
                        <div class="card-body">
                            <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />

                                        <a style="margin-left:30px;margin-top:-70px" href="Admin.aspx" class="arrow left"></a>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="RoomInfo" runat="server">Room Information</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center> 

                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" ID="AddRoom" runat="server" Text="Add"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Add_Click"></asp:Button> 
                                             <br />
                                             <asp:Button class="btn btn-success btn-block btn-lg" ID="UpdateDeleteRoom" runat="server" Text="Update/Delete"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Update_Delete_Click"></asp:Button>
                                        <br />
                                         </div>
                                    </center>

                                </div>
                            </div> 
                        </div>
                    </div> 

                    <div class="card1" id="panel2" runat="server" visible="false">
                        <div class="card-body">
                            <div class="row2">
                                <div class="col">
                                    <center>   
                                        <br />
                                        <div style="position:absolute">
                                        <a style="margin-left:40px;margin-top:30px" href="RoomInformation.aspx" class="arrow left"></a></div>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="H1" runat="server">Add New Room</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                       <div style="margin-left:50px">
                                          <div style="display:flex">   
                                              <label style="color:aliceblue">Room Number&nbsp;&nbsp;</label> 
                                                  <div class="form-group"> 
                                                       
                                            <asp:TextBox CssClass="form-control" ID="RoomNo" Width="150" runat="server" placeholder="Room Number"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="reqroom" runat="server" ControlToValidate="RoomNo"
                                 ErrorMessage = "Room Number is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                                      <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="RoomNo" 
                                             Type="Double" MinimumValue="0" MaximumValue="2000" 
                                             ErrorMessage="Enter a Valid Number" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>
                                       </div> 

                                              </div> 
                                        </div>
                                          <div style="margin-left:50px">
                                          <div style="display:flex">  
                                              
                                      <label style="color:aliceblue">Loction&nbsp;&nbsp;</label> 
                                             
                                      <div class="form-group"> 
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList1" runat="server" >                                        
                                          </asp:DropDownList>
                          
                                                                                </div>  
                                   
                                 </div>
                                                </div>
                                               <div style="margin-left:50px">
                                          <div style="display:flex">  
                                              
                                      <label style="color:aliceblue">Room Type ID&nbsp;&nbsp;</label>                                            
                                      <div class="form-group"> 
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList2" runat="server" >                                        
                                          </asp:DropDownList>
                                         </div> 
                                              &nbsp;&nbsp;&nbsp;&nbsp; <asp:Button  class="btn btn-success" ID="select" Height="35" runat="server" Text="Select"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Select_Click" ></asp:Button> 
                                            
                                 </div>
                                                </div>   
                                        
                                          <div style="margin-left:50px">
                                          <div style="display:flex">  
                                              
                                      <label style="color:aliceblue">Type&nbsp;&nbsp;</label>                                            
                                      <asp:TextBox CssClass="form-control" ID="type" Width="150" runat="server" Enabled="false"></asp:TextBox> 
                                            
                                 </div>
                                                </div>   

                                        <br />
                                       

                                         <div style="margin-left:50px">
                                          <div style="display:flex">  
                                              
                                      <label style="color:aliceblue">Number of Beds&nbsp;&nbsp;</label>                                            
                                      <asp:TextBox CssClass="form-control" ID="noofbeds" Width="150" runat="server" Enabled="false"></asp:TextBox> 
                                            
                                 </div>
                                                </div>   
                                        <br />
                                         <div style="margin-left:50px">
                                          <div style="display:flex">  
                                              
                                      <label style="color:aliceblue">Price&nbsp;&nbsp;</label>                                            
                                      <asp:TextBox CssClass="form-control" ID="price" Width="150" runat="server" Enabled="false"></asp:TextBox> 
                                            
                                 </div>
                                                </div>  
                                          
                                   <asp:label ID="unique" runat="server" ForeColor="red" Display="Dynamic"></asp:label> 
                                       
                                        <br />
                                        <br />
                                            <asp:Button class="btn btn-success btn-block btn-lg" ID="AddNew" runat="server" Text="Add"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="AddRoom_Click" ></asp:Button> 
                                             <br />
                                       </center>
                                 </div>
                            </div> 
                        </div>
                    </div>   

                  
                 <div class="card2" id="panel3" runat="server" style="width:150%;justify-content:center; margin-left:-220px" visible="false">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:350px" >
                                <div style="position:absolute">
                                <a style="margin-left:-280px;margin-top:50px" href="RoomInformation.aspx" class="arrow left"></a></div>
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Update/Delete</h3>  <br />                                 
                            </div>  
                            <div class="r1"  style="margin-left:250px">
                             <div style="display:flex"> 
                                    
                                    <label style="color:aliceblue">Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    
                           <asp:TextBox CssClass="form-control" ID="SearchRoom" runat="server" Width="150px" placeholder="Room ID"></asp:TextBox> 
                                          <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <asp:Button class="btn btn-success " ID="SearchButton" runat="server" Text="Search"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Search_Click" ></asp:Button> 
                         
                        
                                </div>
                        </div>  

                            <div class="error-container">
                                     <center>
            <asp:Label ID="searcherror" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                     <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                         </center> 
                                     <br />
        </div>           
                            <center>
                             <div class="radio" style="margin-left:90px">  
                                        <asp:RadioButton ID="idradio" GroupName="searchtype" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="idradio_CheckedChanged" /><label style="color:aliceblue">Room ID</label> <label></label><label></label>
                                        <asp:RadioButton ID="roomradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="roomradio_CheckedChanged"/><label style="color:aliceblue">Room Number</label> <label></label><label></label>
                                 <asp:RadioButton ID="typeradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="typeradio_CheckedChanged" /><label style="color:aliceblue">Room Type ID</label><label></label><label></label>
                                 <asp:RadioButton ID="branchradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="branchradio_CheckedChanged" /><label style="color:aliceblue">Location</label><label></label><label></label>
                                          
                                    </div>  
                                </center>
                            </div>

                            
             
                        
                        <div class="row" style="margin-left:40px; width:90%">
                            <center>
                            <div class="col">
<asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound">
    <Columns>
        <asp:BoundField DataField="Room_ID" HeaderText="Room ID" ReadOnly="true" ItemStyle-ForeColor="Black" />
        <asp:TemplateField HeaderText="Room Number">
            <ItemTemplate>
                <asp:Label ID="lblRoomNo" runat="server" Text='<%# Bind("RoomNumber") %>' Width="100px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtRoomNo" CssClass="form-control" runat="server" Text='<%# Bind("RoomNumber") %>'  Width="70px" ForeColor="black"></asp:TextBox>
                <br />
                <asp:Label ID="lblRoomNoError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="Room Type ID">
            <ItemTemplate>
                <asp:Label ID="lblRoomType" runat="server" Text='<%# Bind("RoomType_ID") %>'  Width="70px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList CssClass="form-control" ID="DropDownList5"  Width="70px" runat="server" >                                        
                                          </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>
         <asp:TemplateField HeaderText="Type">
            <ItemTemplate>
                <asp:Label ID="lblType" runat="server" Text='<%# Bind("Type") %>'  Width="70px" ForeColor="black"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>   
         <asp:TemplateField HeaderText="Number of Beds">
            <ItemTemplate>
                <asp:Label ID="lblbeds" runat="server" Text='<%# Bind("NumberOfBeds") %>'  Width="70px" ForeColor="black"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>

         <asp:TemplateField HeaderText="Location">
            <ItemTemplate>
                <asp:Label ID="lblBranch" runat="server" Text='<%# Bind("Location") %>'  Width="90px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:DropDownList CssClass="form-control" ID="DropDownList4"  Width="110px" runat="server" >                                        
                                          </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowEditButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-BorderColor="#1E90FF" ControlStyle-ForeColor="white" ButtonType="Button"/>
        <asp:CommandField ShowDeleteButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-BorderColor="#1E90FF" ControlStyle-ForeColor="white" ButtonType="Button"/>
    </Columns>
    <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />


            <RowStyle BackColor="#F2F2F2" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView> 
                                 <div class="error-container">
                                     <center>
            <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                    
                                         </center> 
                                     <br />
        </div> 
                               
                     
                        </div>
                                </center>
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
        .parent {
          position: relative;
          margin:60px;
          height:30%;
          width:30%;
          /* Set the parent element to a non-static position */
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
          background-color:#1E90FF;
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
