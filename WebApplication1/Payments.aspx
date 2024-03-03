<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payments.aspx.cs" Inherits="WebApplication1.Payments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server"> 
    <div class="bg-image"></div> 
    <div style="overflow-x:hidden" class="container" > 
        <div class="container" >
            <div class="row1">
                <div class="col-md-6 mx-auto">

                 <div class="card2" id="panel1" runat="server" style="width:140%;justify-content:center;margin-left:-180px">
                    <div class="card-body" > 
                        <div class="row">
                            <center>
                            <div class="col">
                                 <br /> 
                                
                                <div style="position:absolute">
                                <a style="margin-left:58px;margin-top:30px" href="Admin.aspx" class="arrow left"></a></div>
                                <h3 style="color:aliceblue;  font-family:'Arial Unicode MS';font-weight:bold">Payments</h3>  <br />   
                                
                                  <div class="r1"> 
                                      
                             <div style="display:flex; margin-left:250px" > 
                                    
                                    <label style="color:aliceblue">Search&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> 
                                    
                           <asp:TextBox CssClass="form-control" ID="SearchBox" runat="server" Width="150px" placeholder="ID"></asp:TextBox> 
                                          <label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                      <asp:Button class="btn btn-success " ID="SearchButton" runat="server" Text="Search"  BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="btnSearch_Click"></asp:Button> 
                                  </div> 
                                         
                        </div>  

                                     <div class="error-container">
                                     <center>
            <asp:Label ID="searcherror" runat="server" Visible="false" ForeColor="Red" display="dynamic"></asp:Label> 
                                         <br />
                                    <asp:Label ID="lblError" runat="server" Visible="false" ForeColor="Red"></asp:Label> 
                                         </center> 
        </div>           
                           
                            <div class="radio" style="margin-left:50px">  
                                        <asp:RadioButton ID="idradio" GroupName="searchtype" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="idradio_CheckedChanged" /><label style="color:aliceblue">ID</label> <label></label><label></label>
                                        <asp:RadioButton ID="cnicradio" GroupName="searchtype" runat="server" AutoPostBack="True" OnCheckedChanged="cnicradio_CheckedChanged"/><label style="color:aliceblue">CNIC</label> <label></label><label></label>
                                        </div>  

                            </div> 
                            </center>
                            </div>
             

                        <div class="row" style="margin-left:42px; width:88%">
                            <div class="col">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CommandRowStyle-BackColor="#2196F3" CommandRowStyle-ForeColor="white" DataSourceID="SQ1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowDataBound="GridView1_RowDataBound">
                             <Columns>
                                 <asp:TemplateField HeaderText="Billing ID">
                                     <ItemTemplate>
                                         <asp:Label ID="lblBillid" runat="server" Text='<%# Bind("Billing_ID") %>' ForeColor="black"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="CNIC">
                                     <ItemTemplate>
                                         <asp:Label ID="lblcnic" runat="server" Text='<%# Bind("User_ID") %>' ForeColor="black" Width="120px"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>   
                                  <asp:TemplateField HeaderText="Status">
                                     <ItemTemplate>
                                         <asp:Label ID="lblstatus" runat="server" Text='<%# Bind("Status") %>' ForeColor="black" Width="80px"></asp:Label>
                                     </ItemTemplate>
                                 </asp:TemplateField>  
                                  <asp:TemplateField HeaderText="">
                                     <ItemTemplate>
                                         <asp:Button class="btn btn-success" ID="details" runat="server" Text="View Details" CommandArgument='<%# Eval("Billing_ID") %>' BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="details_Click" ></asp:Button>
                                          
                                            </ItemTemplate>
                                 </asp:TemplateField>
                                 <asp:TemplateField HeaderText="">
                                     <ItemTemplate>
                                         <asp:Button class="btn btn-success" ID="status" runat="server" Text="Clear Bill" Visible="false"  CommandArgument='<%# Eval("Billing_ID") %>' BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="status_Click" ></asp:Button>
                                            </ItemTemplate>
                                 </asp:TemplateField>
                                 </Columns>
                                <HeaderStyle BackColor="#2196F3" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#F2F2F2" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>  
                            <asp:SqlDataSource ID="SQ1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand="select *  from Billing"></asp:SqlDataSource>
                                    
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
          width: 105%;
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
