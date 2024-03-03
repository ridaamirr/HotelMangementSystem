<%@ Page Title="Admin Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="WebApplication1.Admin" %>

<asp:Content runat="server" ID="MyContent" ContentPlaceHolderID="MainContent"> 
       <div class="bg-image"></div> 
    <h1></h1> 

    <div id="container">
        <div class="box" onclick="location.href='BranchInformation.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="infoheader"><br /><span class="glyphicon glyphicon-map-marker"></span> Branch Information</h2>
        </div> 

         <div class="box" onclick="location.href='RoomType.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="roomtypeheader"><br /><span class="glyphicon glyphicon-bed"></span> Room Type</h2>
        </div>

        <div class="box" onclick="location.href='RoomInformation.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="roomheader"><br /><span class="	glyphicon glyphicon-lamp"></span> Room Information</h2>
        </div>
        <div class="box" onclick="location.href='MenuInformation.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="menuheader"><br /><span class="glyphicon glyphicon-cutlery"></span> Menu</h2>
        </div>

        </div>
    <div id="container">
        
        <div class="box" onclick="location.href='SalesOffersInformation.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="salesheader"><br /><span class="glyphicon glyphicon-tags"></span> Sales &amp; Offers</h2>
        </div>  
        <div class="box" onclick="location.href='CustomerInformation.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="customerheader"><br /><span class="glyphicon glyphicon-user"></span> Customer Information</h2>
        </div>
         <div class="box" onclick="location.href='BookingInfo.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="bookingheader"><br /><span class="glyphicon glyphicon-info-sign"></span> Booking Information</h2>
        </div>
        <div class="box" onclick="location.href='Payments.aspx';" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
            <h2 id="paymentsheader"><br /><span class="glyphicon glyphicon-usd"></span> Payments</h2>
        </div>
         

    </div>



    <style>
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
        body { 
            overflow-x: hidden;
        }  
        body {
            background-color: #1F1F1F;
            color: #ffffff;
        }

       
        #container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 50vh;
            flex-wrap: wrap;
        }

    
        .box {
            background-color: rgba(0, 0, 0, 0.7);
            color: aliceblue;
            width: 230px;
            height: 220px;
            margin: 10px;
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid #000000; 
        }

     
        h1 {
            text-align: center;
            font-size: 36px;
            margin-top: 50px;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .box:hover {
            transform: translateY(-10px);
            box-shadow: 10px 10px 10px #7b9cb2;
            z-index: 1;
        }

        .highlighted {
            background-color: rgba(0, 0, 0, 0.8);
            color: #ffffff;
            transform: translateY(-10px);
            box-shadow: 10px 10px 10px #7b9cb2;
            z-index: 1;
            backdrop-filter: blur(5px);
        }


</style>

</asp:Content>
