<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RoomType.aspx.cs" Inherits="WebApplication1.RoomType" %>
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
                                        <a style="margin-left:40px;margin-top:-70px" href="Admin.aspx" class="arrow left"></a>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" >Room Type</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center> 

                                         <div class="form-group">
                                            <asp:Button class="btn btn-success btn-block btn-lg" ID="AddNew" runat="server" Text="Add"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="AddNew_Click"></asp:Button> 
                                             <br />
                                             <asp:Button class="btn btn-success btn-block btn-lg" ID="UpdateorDelete" runat="server" Text="Update/Delete"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="UpdateorDelete_Click"></asp:Button>
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
                                        <a style="margin-left:40px;margin-top:30px" href="RoomType.aspx" class="arrow left"></a></div>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="H1" runat="server">Add Room Type</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                       
                                                  <div class="form-group">   
                                                          <div style="margin-left:50px">
                                                           <div style="display:flex">
                                                          <label style="color:aliceblue">Room Type&nbsp;&nbsp;</label>
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList2"  runat="server" Width="200px">
                                             
                                              <asp:ListItem>Deluxe</asp:ListItem>
                                              <asp:ListItem>Suite</asp:ListItem>
                                               
                                          </asp:DropDownList>
                                            </div>
                                                        </div>  
                                                          </div>
    
                                         <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="BedNo" runat="server" placeholder="Number of Beds"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="BedNo"
                                 ErrorMessage = "Number of Beds is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                             <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="BedNo" 
                                             Type="Double" MinimumValue="0" MaximumValue="20" 
                                             ErrorMessage="Enter valid number" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>
                                        </div> 

                                         <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Price" runat="server" placeholder="Price"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="Price"
                                 ErrorMessage = "Price is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                             <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Price" 
                                             Type="Double" MinimumValue="0" MaximumValue="999999999" 
                                             ErrorMessage="Price must be a positive value" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>
                                        </div> 

                                          <div class="form-group">
                                           <label for="Image">Click here to upload image</label>
                                           <asp:FileUpload CssClass="form-control" ID="Image" runat="server" /> 
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Image"
                                 ErrorMessage = "Image is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                          
                                        </div> 

                                               <asp:Button class="btn btn-success btn-block btn-lg" ID="Add" runat="server" Text="Add"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Add_Click"></asp:Button> 
                                             <br />
                                       </center>
                                 </div>
                            </div> 
                        </div>
                    </div>   

                  
               <div class="card1" id="panel3" runat="server" style="width:170%;justify-content:center; margin-left:-280px" visible="false">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:400px" >
                                 <br />
                                <div style="position:absolute">
                                <a style="margin-left:-330px;margin-top:30px" href="RoomType.aspx" class="arrow left"></a></div>
                                <h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Update/Delete</h3>  <br />                                 
                            </div>  
                            <div class="r1"  style="margin-left:330px">
                             <div style="display:flex"> 
                                    
                                    <label style="color:aliceblue">Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    
                           <asp:TextBox CssClass="form-control" ID="SearchRoom" runat="server" Width="150px" placeholder="Room Type ID"></asp:TextBox> 
                                          <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <asp:Button class="btn btn-success " ID="SearchButton" runat="server" Text="Search"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Search_Click" ></asp:Button> 
                         
                        
                                </div>
                        </div>  

                            <div class="error-container">
                                     <center>
                                          <br />
            <asp:Label ID="searcherror" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                    <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                         <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                         </center> 
                                    
        </div>           

                             <div class="radio" style="margin-left:240px">  
                                        <asp:RadioButton ID="idradio" GroupName="searchtype" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="idradio_CheckedChanged" /><label style="color:aliceblue">Room Type ID</label> <label></label><label></label>
                                      <asp:RadioButton ID="typeradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="typeradio_CheckedChanged" /><label style="color:aliceblue">Room Type</label><label></label><label></label>
                                        <asp:RadioButton ID="bedradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="bedradio_CheckedChanged" /><label style="color:aliceblue">Number of Beds</label><label></label><label></label>
                                          <asp:RadioButton ID="priceradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="priceradio_CheckedChanged" /><label style="color:aliceblue">Price</label><label></label><label></label>
                                    </div>     
                            </div>
                       
                        <div class="row" style="margin-left:40px; width:90%">
                            <div class="col">
<asp:GridView ID="GridView1" runat="server"  AutoGenerateColumns="False" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting" OnRowDataBound="GridView1_RowDataBound">
    <Columns>
        <asp:BoundField DataField="RoomType_ID" HeaderText="Room Type ID" ReadOnly="true" ItemStyle-ForeColor="Black" ItemStyle-Width="80px"/>
      
         <asp:TemplateField HeaderText="Room Type">
            <ItemTemplate>
                <asp:Label ID="lblType" runat="server" Text='<%# Bind("Type") %>'  Width="80px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                 <asp:DropDownList CssClass="form-control" ID="DropDownList3" SelectedValue='<%# Bind("Type") %>' runat="server" Width="80px">                                      
                                              <asp:ListItem>Deluxe</asp:ListItem>
                                              <asp:ListItem>Suite</asp:ListItem>
                                          </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Number of Beds">
            <ItemTemplate>
                <asp:Label ID="lblBedNo" runat="server" Text='<%# Bind("NumberOfBeds") %>'  Width="50px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtBedNo" CssClass="form-control" runat="server" Text='<%# Bind("NumberOfBeds") %>'  Width="50px" ForeColor="black"></asp:TextBox>
            </EditItemTemplate>
        </asp:TemplateField>
        
         <asp:TemplateField HeaderText="Price">
            <ItemTemplate>
                <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("Price") %>'  Width="50px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPrice" CssClass="form-control" runat="server" Text='<%# Bind("Price") %>'  Width="50px" ForeColor="black"></asp:TextBox>
                <br />
                <asp:Label ID="lblPriceError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Image">
            <ItemTemplate>
                <asp:image runat="server" ID="img2" ImageUrl='<%# Bind("Image") %>' width="50" height="50" />
            </ItemTemplate>
            <EditItemTemplate>
                <asp:FileUpload CssClass="form-control" ID="txtImage" runat="server" Width="210px" />
                <asp:HiddenField ID="hfCurrentImage" runat="server" Value='<%# Eval("Image") %>' />
            </EditItemTemplate>
        </asp:TemplateField>
        
        <asp:CommandField ShowEditButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-BorderColor="#1E90FF" ControlStyle-ForeColor="white" ButtonType="Button" ItemStyle-Width="160px"/>
        <asp:CommandField ShowDeleteButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-BorderColor="#1E90FF" ControlStyle-ForeColor="white" ButtonType="Button"/>
    </Columns>
    <HeaderStyle BackColor="#1E90FF" Font-Bold="True" ForeColor="White" />


            <RowStyle BackColor="#F2F2F2" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView> 

            
  
                     
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

        
    
    </style>
    


</asp:Content>
