<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >

    <div class="bg-image"></div> 
 
   <div class="container1" >
        <img src="img1.jpg" style="width:115.3%;margin-left:-90px;margin-top:0px;height:80vh; filter: brightness(50%); "> 
       
       <div class="centered">
            <h1 style="color:white; font-size:40px">Hotel</h1> 
            <h1 style="color:white; font-size:40px">Obsidian</h1> 
           <p> <p class="lead" style="font-family:'Felix Titling'; font-size:15px">Discover a new dimension of Luxury </p>  
             <p><a id="switch1" runat="server" class="btn btn-outline-primary btn-lg my-link" href="Login.aspx" role="button" style="border-color:white; color:white">Book Now</a></p>
       <br /><br /><br />
           </div>
      

       </div>
    <center>
                  <div class="box" style="margin-top:-50px;width:800px;height:100px; background-color:lightgray; border-radius:4px; cursor:auto; display:flex;flex-direction:row;justify-content:space-between" > 
               <div class="display-flex" id="loc" runat="server">
                <label style="color:black;display:block;text-align:left;margin-left:20px">Select Location</label>
                                          
                                               <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand="SELECT [Location] FROM [Hotel]"></asp:SqlDataSource>
                                               <asp:DropDownList CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="Location" ID="DropDownList1"  Width="150px" runat="server" > </asp:DropDownList>
                                             <br /> 
                   
             
                   </div>
              <div class="display-flex" runat="server" id="type">
                <label style="color:black;display:block;text-align:left;margin-left:15px">Select RoomType</label>
                   <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:HotelManagementSystemConnectionString %>" SelectCommand="SELECT DISTINCT [Type] FROM [RoomType]"></asp:SqlDataSource>
                     <asp:DropDownList CssClass="form-control" DataSourceID="SqlDataSource2" DataTextField="Type" ID="DropDownList2"  Width="150px" runat="server" > </asp:DropDownList>
                                             <br /> 
                   
             
                   </div>
                          <div class="display-flex" runat="server" id="bed">
                <label style="color:black;display:block;text-align:left;">Enter Number of Beds</label>
                  <asp:TextBox CssClass="form-control" runat="server" ID="noofbeds" Width="150px" ></asp:TextBox> 
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="noofbeds"
                                 ErrorMessage = "Number of Beds are Required"  ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator> 
                                           <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="noofbeds" 
                                             Type="Double" MinimumValue="1" MaximumValue="100" 
                                             ErrorMessage="Enter a Valid Number" ForeColor="Red" Display="Dynamic"></asp:RangeValidator>
                                             <br /> 
                   
             
                   </div>  
                     
                            <label visible="false" style="color:black;margin-left:320px; margin-top:15px; font-size:20px" runat="server" ID="status"></label> 
                      
                      <div>
                         <asp:Button class="btn btn-success btn-block btn-lg" ID="Again" Visible="false" runat="server" Text="Try Again" Width="170" Height="80%" BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Again_Click"></asp:Button>
         <asp:Button class="btn btn-success btn-block btn-lg" ID="Availability" runat="server" Text="Check Availabilty" Width="170" Height="80%" BackColor="#1E90FF" BorderColor="#1E90FF" OnClick="Availability_Click"></asp:Button>
                         
                          </div>
                          </div>
        </center>
  
    <br />
    <div class="row">
        <center> 
            <br />
        <div class="col-md-4">
         <div class="box" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
         <center>   <h2 id="roomheader"> Luxury Rooms </h2><p>  <img src="bed.png" width="80" height="80"></p> </center>
        </div>
          </div>

        <div class="col-md-4">
         <div class="box" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
         <center>   <h2 id="poolheader"> Infinity Pool </h2><p><img src="swimming-pool.png" width="80" height="80"> </p> </center>
        </div>
            </div>

         <div class="col-md-4">
         <div class="box" onmouseover="this.classList.add('highlighted');" onmouseout="this.classList.remove('highlighted');">
         <center>   <h2 id="dineheader"> Dine-In </h2><p><img src="restaurant.png" width="80" height="80"> </p> </center>
        </div>
            </div>
        </center>
<%--        <div class="slideshow">
   <img src="pool.jpg" alt="Slide 1">
   <img src="luxurybed.jpg" alt="Slide 2">
<%--   <img src="image3.jpg" alt="Slide 3">
   <img src="image4.jpg" alt="Slide 4">--%>
</div>

  

    <style>

        body{
            overflow-x:hidden;
        }
        .bg-image {
            background-image: url('');
            background-size: cover;
            height: 100%;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: -1;
        }  
        .container1 {
          position: relative;
          text-align: center;
          color: white;
        }
        .centered {
             position: absolute; 
             font-size:larger;
             top: 50%;
             left: 50%;
             transform: translate(-50%, -50%); 
              font-family:'Copperplate Gothic'
        } 
        .box {
            background-color: lightgrey;
            width: 250px;
            height: 200px;
            margin: 10px;
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            cursor: pointer;
            z-index: 9999;
            position: relative;
            box-shadow: 0px 0px 10px black;

        /*    border: 1px solid #000000; */
        }
        .box:hover {
          /*  transform: translateY(-10px);*/
            box-shadow: 0px 0px 10px #619ad9;
            z-index: 1;
        }

        .highlighted {
            background-color: lightgrey;
            transform: translateY(-10px);
            box-shadow: 0px 0px 10px #ffffff;
            z-index: 1;
        }
        .slideshow {
           position: relative;
           width: 100%;
           height: 400px;
           overflow: hidden;
        }

        .slideshow img {
           position: absolute;
           top: 0;
           left: 0;
           width: 100%;
           height: 100%;
           opacity: 0;
           transition: opacity 2s ease-in-out;
        }

        .slideshow img:first-child {
           opacity: 1;
        }


        .slideshow img.active {
           opacity: 1;
        }
        


         </style>
    <script>
        var slideIndex = 0;
        var slides = document.getElementsByClassName("slideshow")[0].getElementsByTagName("img");

        function showSlide(index) {
            if (index >= slides.length) {
                slideIndex = 0;
            } else if (index < 0) {
                slideIndex = slides.length - 1;
            } else {
                slideIndex = index;
            }

            for (var i = 0; i < slides.length; i++) {
                slides[i].classList.remove("active");
            }

            slides[slideIndex].classList.add("active");
        }

        function autoSlide() {
            showSlide(slideIndex + 1);
            setTimeout(autoSlide, 5000);
        }

        showSlide(slideIndex);

        setTimeout(autoSlide, 5000);


    </script>

</asp:Content>
