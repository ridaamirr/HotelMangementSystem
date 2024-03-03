<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SalesOffersInformation.aspx.cs" Inherits="WebApplication1.SalesOffersInformation" %>
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
                                
                              <a style="margin-top:-70px;margin-left:25px" href="Admin.aspx" class="arrow left"></a>
                                    
                           
                                        <h3 style="margin-left:15px; color: aliceblue;  font-family:'Arial Unicode MS';font-weight:bold" id="LoginType" runat="server">Sales&Offers Information</h3> 
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
                                
                               <a style="margin-left:50px;margin-top:25px" href="SalesOffersInformation.aspx" class="arrow left"></a>
                            </div>
                                        <br />
                                        <br />
                                        <h3 style=" color: aliceblue; margin-top:-20px;  font-family:'Arial Unicode MS';font-weight:bold" id="H1" runat="server">Add New Offer</h3> 
                                  <br />
                                        </center> 
                                                            
                                </div>  
                            </div>
                            <div class="row">
                                <div class="col">
                                    <center>
                                       
                                                  <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Occasion" runat="server" placeholder="Occasion"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="rfvname" runat="server" ControlToValidate="Occasion"
                                 ErrorMessage = "Occasion is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </div>
    
                                        
                                             <div class="form-group">
                                            <asp:TextBox CssClass="form-control" ID="Percentage" runat="server" placeholder="Percentage"></asp:TextBox> 
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Percentage"
                                 ErrorMessage = "Percentage is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                 <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="Percentage" 
                                             Type="Double" MinimumValue="0" MaximumValue="100" 
                                             ErrorMessage="Percentage must be between 0-100" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>
                                        </div> 
                    
                                         <%-- <div class="form-group">--%>
                                            <label for="Image">Click here to upload image</label>
                                            <asp:FileUpload CssClass="form-control" ID="Image" runat="server" />  
                                                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Image"
                                 ErrorMessage = "Image is Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                          <br />
<%--                                      --%>  </div> 
                                <div style="margin-left:78px">
                                               <asp:Button  class="btn btn-success btn-block btn-lg" ID="Add" runat="server" Text="Add"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Add_Click"></asp:Button> 
                                    </div>
                                             <br />
                                       
                                 </div>
                            </div> 
                        </div>
                    </div>   

                  
                 <div class="card1" id="panel3" runat="server" style="width:70%;justify-content:center; margin-left:-180px" visible="false">
                    <div class="card-body"> 
                       
                          <div style="position:absolute">
                               <a style="margin-left:50px;margin-top:40px" href="SalesOffersInformation.aspx" class="arrow left"></a>
                            </div>
                            <br />
                            <div class="col" style="margin-left:330px; margin-top:-60px" >
                                <br />
                                <br />
                                 <br /><h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Update/Delete</h3>  <br />                                 
                            </div>  
                            <div class="r1"  style="margin-left:260px">
                             <div style="display:flex"> 
                                    
                                    <label style="color:aliceblue">Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    
                           <asp:TextBox CssClass="form-control" ID="SearchBox" runat="server" Width="150px" placeholder="ID"></asp:TextBox> 
                                          <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <asp:Button class="btn btn-success " ID="SearchButton" runat="server" Text="Search"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="btnSearch_Click"></asp:Button> 
                                  </div>
                        </div> 
                        
                                                    <div class="error-container">
                                     <center>
                                          <br />
            <asp:Label ID="searcherror" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                <asp:Label ID="Label1" runat="server" Visible="false" ForeColor="Red"></asp:Label>                     
                                         </center> 
                                    
        </div>           
                           
                            <div class="radio" style="margin-left:270px">  
                                        <asp:RadioButton ID="idradio" GroupName="searchtype" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="idradio_CheckedChanged" /><label style="color:aliceblue">ID</label> <label></label><label></label>
                                        <asp:RadioButton ID="occradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="occradio_CheckedChanged"/><label style="color:aliceblue">Occasion</label> <label></label><label></label>
                                        <asp:RadioButton ID="percentradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="percentradio_CheckedChanged" /><label style="color:aliceblue">Percentage</label>
                                    </div>  
                            </div>
             

                        <div class="row" style="margin-left:45px; width:90%">
                            <div class="col5">
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowEditing="GridView1_RowEditing" OnRowDeleting="GridView1_RowDeleting" EditRowStyle-CssClass="col5">
    <Columns>
        <asp:BoundField DataField="Offer_ID" HeaderText="ID" ReadOnly="true" ItemStyle-ForeColor="Black" />
        <asp:TemplateField HeaderText="Occasion">
            <ItemTemplate>
                <asp:Label ID="lblOccasion" runat="server" Text='<%# Bind("Occasion") %>' width="100px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtOccasion" CssClass="form-control" runat="server" Text='<%# Bind("Occasion") %>' ForeColor="black" Width="100px"></asp:TextBox>
                <br />
                <asp:Label ID="lblOccasionError" runat="server" Text="" />
            </EditItemTemplate>
        </asp:TemplateField>
          <asp:TemplateField HeaderText="Percentage">
            <ItemTemplate>
                <asp:Label ID="lblPercentage" runat="server" Text='<%# Bind("Percentage") %>' width="20px" ForeColor="black"></asp:Label>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:TextBox ID="txtPercentage"  CssClass="form-control" runat="server" Text='<%# Bind("Percentage") %>' ForeColor="black" Width="100px"></asp:TextBox>
                <br />
                <asp:Label ID="lblPercentageError" runat="server" Text="" />
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
        .col5{
             background-color: rgba(0, 0, 0, 0.7); /* light color with opacity */
          color: aliceblue;
        }
        .card1 {
          background-color: rgba(0, 0, 0, 0.7); /* light color with opacity */
          color: aliceblue;
          border-radius: 20px;
          width: 75%;
          height: 120%;
          backdrop-filter: blur(2px);
        }

        .row2{
            font-family:'Arial Unicode MS';
            font-weight:bold;
        }
        .round {
  border-radius: 50%;
}
        
          table {
          border-collapse: collapse;
          width: 100%;
          margin-bottom: 20px;
          background-color: rgba(255, 255, 255, 0.8);
          color:white;
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
        .error-label {
  display: block;
  color: red;
  margin-top: 5px;
}


        
    
    </style>
    


</asp:Content>

