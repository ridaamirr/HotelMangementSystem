<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MenuInformation.aspx.cs" Inherits="WebApplication1.MenuInformation" %>
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
                                         <a style="margin-left:35px;margin-top:-70px" href="Admin.aspx" class="arrow left"></a>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="LoginType" runat="server">Menu Information</h3> 
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
                                
                               <a style="margin-left:40px;margin-top:30px" href="MenuInformation.aspx" class="arrow left"></a>
                            </div>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="H1" runat="server">Add New Item</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                       
                                                  <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Name" runat="server" placeholder="Name"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="rfvname" runat="server" ControlToValidate="Name"
                                 ErrorMessage = "Name is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                                
                                                      <div class="form-group">   
                                                          <div style="margin-left:80px">
                                                           <div style="display:flex">
                                                          <label style="color:aliceblue">Cuisine&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                          <asp:DropDownList CssClass="form-control" ID="DropDownList1"  runat="server" Width="170px">
                                             
                                              <asp:ListItem>French</asp:ListItem>
                                              <asp:ListItem>Mexican</asp:ListItem>
                                              <asp:ListItem>Chinese</asp:ListItem>
                                              <asp:ListItem>Japanese</asp:ListItem> 
                                              <asp:ListItem>Indian</asp:ListItem>  
                                              <asp:ListItem>Italian</asp:ListItem>  
                                              <asp:ListItem>Greek</asp:ListItem>  
                                              <asp:ListItem>Spanish</asp:ListItem>  
                                              <asp:ListItem>Lebanese</asp:ListItem>  
                                              <asp:ListItem>Moroccan</asp:ListItem>  
                                              <asp:ListItem>Turkish</asp:ListItem>  
                                              <asp:ListItem>Thai</asp:ListItem>  
                                              <asp:ListItem>Others</asp:ListItem>  
                                          </asp:DropDownList>
                                            </div>
                                                        </div>  
                                                          </div>
                                        
                                             <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Description" runat="server" placeholder="Description"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Description"
                                 ErrorMessage = "Description is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
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

                  
                 <div class="card2" id="panel3" runat="server" style="width:210%;justify-content:center; margin-left:-65vh" visible="false">
                    <div class="card-body" > 
                        <div class="row">
                            <div class="col" style="margin-left:490px" >
                                 <br />
                          <div style="position:absolute">
                                
                               <a style="margin-left:-400px;margin-top:30px" href="MenuInformation.aspx" class="arrow left"></a>
                            </div>
                                <h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Update/Delete</h3>  <br />                                 
                            </div>  
                            <div class="r1"  style="margin-left:410px">
                             <div style="display:flex"> 
                                    
                                    <label style="color:aliceblue">Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    
                           <asp:TextBox CssClass="form-control" ID="SearchBox" runat="server" Width="150px" placeholder="ID"></asp:TextBox> 
                                          <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <asp:Button class="btn btn-success " ID="SearchButton" runat="server" Text="Search"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="btnSearch_Click"></asp:Button> 
                                  </div>
                        </div>  
                                                       <div class="error-container" ">
                                     <center>
                                         <br />
            <asp:Label ID="searcherror" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                    <asp:Label ID="Label2" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                         </center> 
                                     
        </div>           
                             <div class="radio" style="margin-left:320px; top: 1px; left: 90px;">  
                                        <asp:RadioButton ID="idradio" GroupName="searchtype" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="idradio_CheckedChanged" /><label style="color:aliceblue">ID</label> <label></label><label></label>
                                        <asp:RadioButton ID="nameradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="nameradio_CheckedChanged"/><label style="color:aliceblue">Name</label> <label></label><label></label>
                                        <asp:RadioButton ID="cuisineradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="cuisineradio_CheckedChanged" /><label style="color:aliceblue">Cuisine</label><label></label><label></label>
                                        <asp:RadioButton ID="priceradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="priceradio_CheckedChanged" /><label style="color:aliceblue">Price</label>
                                    </div>     
                            </div>

                        <div class="row" style="margin-left:38px; width:90%">
                            <div class="col">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting" CommandRowStyle-BackColor="#2196F3" CommandRowStyle-ForeColor="white">
    <Columns>
        <asp:BoundField DataField="Food_ID" HeaderText="ID" ReadOnly="true" ItemStyle-ForeColor="Black" />
        <asp:TemplateField HeaderText="Name">
            <ItemTemplate>
                <asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>' ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtName" CssClass="form-control" runat="server" Text='<%# Bind("Name") %>' ForeColor="black" Width="100px"></asp:TextBox>
                                <br />
                <asp:Label ID="lblNameError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Cuisine">
            <ItemTemplate>
                <asp:Label ID="lblCuisine" runat="server" Text='<%# Bind("Cuisine") %>' ForeColor="black" Width="100px"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                  <asp:DropDownList CssClass="form-control" ID="DropDownList2" SelectedValue='<%# Bind("Cuisine") %>' runat="server" Width="110px"> 
                                               <asp:ListItem Value="">Cuisine</asp:ListItem>
                                              <asp:ListItem>French</asp:ListItem> 
                      <asp:ListItem>Mexican</asp:ListItem>
                                              <asp:ListItem>Chinese</asp:ListItem>
                                              <asp:ListItem>Japanese</asp:ListItem> 
                                              <asp:ListItem>Indian</asp:ListItem>  
                                              <asp:ListItem>Italian</asp:ListItem>  
                                              <asp:ListItem>Greek</asp:ListItem>  
                                              <asp:ListItem>Spanish</asp:ListItem>  
                                              <asp:ListItem>Lebanese</asp:ListItem>  
                                              <asp:ListItem>Moroccan</asp:ListItem>  
                                              <asp:ListItem>Turkish</asp:ListItem>  
                                              <asp:ListItem>Thai</asp:ListItem>  
                                              <asp:ListItem>Others</asp:ListItem>  
                                          </asp:DropDownList>
            </EditItemTemplate>
        </asp:TemplateField> 
          <asp:TemplateField HeaderText="Description">
            <ItemTemplate>
                <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Description") %>' ForeColor="black" Width="150px"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtDescription" CssClass="form-control" runat="server" Text='<%# Bind("Description") %>' ForeColor="black" Width="100px"></asp:TextBox>
                                <br />
                <asp:Label ID="lblDescriptionError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField> 
          <asp:TemplateField HeaderText="Price">
            <ItemTemplate>
                <asp:Label ID="lblPrice" runat="server" Text='<%# Bind("Price") %>' ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPrice"  CssClass="form-control" runat="server" Text='<%# Bind("Price") %>' ForeColor="black" Width="100px"></asp:TextBox>
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
        <asp:CommandField ShowEditButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-BorderColor="#1E90FF" ControlStyle-ForeColor="white" ButtonType="Button" />
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
