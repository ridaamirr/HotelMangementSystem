<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BranchInformation.aspx.cs" Inherits="WebApplication1.BranchInformation" %>
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
                                        <div >
                                <a style="margin-left:30px;margin-top:-70px" href="Admin.aspx" class="arrow left"></a></div>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="LoginType" runat="server">Branch Information</h3> 
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
                                     <a style="margin-left:40px;margin-top:30px" href="BranchInformation.aspx" class="arrow left"></a></div>
                                        <h3 style=" color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="H1" runat="server">Add New Branch</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                       
                                                  <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Location" runat="server" placeholder="Location"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="rfvloc" runat="server" ControlToValidate="Location"
                                 ErrorMessage = "Location is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
                                        
                                            
                                            
                                   

                                                 <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Phone" runat="server" placeholder="Phone Number"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Phone"
                                 ErrorMessage = "Phone Number is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="phone"
                                ErrorMessage="Please enter a valid phone number" ForeColor="Red"
                                ValidationExpression="^\+\d{12}$" Display="Dynamic"></asp:RegularExpressionValidator>
      
                                                     </div>
                                        
                                           
                                        <asp:label ID="unique" runat="server" ForeColor="red" Display="Dynamic"></asp:label> 
                                        <br />
                                        <br />
                                        
                                            <asp:Button class="btn btn-success btn-block btn-lg" ID="Add" runat="server" Text="Add"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Add_Click"></asp:Button> 
                                             <br />
                                       </center>
                                 </div>
                            </div> 
                        </div>
                    </div>   

                  
                 <div class="card1" id="panel3" runat="server" style="width:130%;justify-content:center; margin-left:-140px" visible="false">
                    <div class="card-body"> 
                        <div class="row">
                            <div class="col" style="margin-left:290px" >
                                 <br />
                                 <div style="position:absolute">
                                     <a style="margin-left:-220px;margin-top:30px" href="BranchInformation.aspx" class="arrow left"></a></div>
                               
                                <h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Update/Delete</h3>  <br />                                 
                            </div>  
                            <div class="r1"  style="margin-left:210px">
                             <div style="display:flex"> 
                                    
                                    <label style="color:aliceblue">Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    
                           <asp:TextBox CssClass="form-control" ID="SearchBox" runat="server" Width="150px" placeholder="Branch ID"></asp:TextBox> 
                                          <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <asp:Button class="btn btn-success " ID="SearchButton" runat="server" Text="Search"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="btnSearch_Click"></asp:Button> 
                                </div>

                        </div>  
                            <div class="error-container">
                                     <center>
                                          <br />
            <asp:Label ID="searcherror" runat="server" Visible="false" ForeColor="Red" display="dynamic"></asp:Label> 
             <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red" display="dynamic"></asp:Label>   
           <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"  display="dynamic"></asp:Label>                                          
                                         </center> 
                                    
        </div>           
                            <div class="radio" style="margin-left:220px">  
                                        <asp:RadioButton ID="idradio" GroupName="searchtype" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="idradio_CheckedChanged" /><label style="color:aliceblue">ID</label> <label></label><label></label>
                                        <asp:RadioButton ID="locradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="locradio_CheckedChanged"/><label style="color:aliceblue">Loaction</label> <label></label><label></label>
                                        <asp:RadioButton ID="phoneradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="phoneradio_CheckedChanged" /><label style="color:aliceblue">Phone Number</label>
                                    </div>     
                            </div>
             

                        <div class="row" style="margin-left:38px; width:90%">
                            <div class="col">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting">
    <Columns>
        <asp:BoundField DataField="Branch_ID" HeaderText="Branch ID" ReadOnly="true" ItemStyle-ForeColor="Black"  ItemStyle-Width="100px" />
        <asp:TemplateField HeaderText="Location" ItemStyle-Width="130px">
            <ItemTemplate >
                <asp:Label ID="lblLocation" runat="server" Text='<%# Bind("Location") %>' ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtLocation" runat="server" Text='<%# Bind("Location") %>' ForeColor="black" Width="120px"></asp:TextBox>
                                <br />
                <asp:Label ID="lblLocationError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Phone Number" ItemStyle-Width="120px">
            <ItemTemplate>
                <asp:Label ID="lblPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>' ForeColor="black" Width="140px"></asp:TextBox>
                <br />
                <asp:Label ID="lblPhoneNumberError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField>
        <asp:CommandField ShowEditButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-BorderColor="#1E90FF" ControlStyle-ForeColor="white" ButtonType="Button" ItemStyle-Width="170px"/>
        <asp:CommandField ShowDeleteButton="true" ControlStyle-BackColor="#1E90FF" ControlStyle-ForeColor="white" ControlStyle-BorderColor="#1E90FF" ButtonType="Button" ItemStyle-Width="120px"/>
    </Columns>
    <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />


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
       .arrow {
          position:absolute;
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
