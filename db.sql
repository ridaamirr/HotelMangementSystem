--Hotel Mangement System By 21L-5184,21L-5164,21L-7528

CREATE Database HotelManagementSystem 
go

Use HotelManagementSystem 
go   

Create Table SecurityQuestions
(Question_ID int Not Null identity(1,1) Primary Key,
[Text] nvarchar(max) Not Null);  

go

Create Table Admin_Login
(Username nvarchar(15) not null primary Key,
[Password] nvarchar(max) Not null); 

go

Create Table Customer
(CNIC nvarchar(15) not null primary key,
FirstName nvarchar(50), 
LastName nvarchar(50), 
PhoneNumber nvarchar(13), 
Email nvarchar(max), 
[Address] nvarchar(max), 
DOB Date, 
[Password] nvarchar(max) Not Null,
PaymentHistory float Default(0),
SecurityQuestion1 int, 
Answer1 nvarchar(max),
SecurityQuestion2 int, 
Answer2 nvarchar(max), 
Foreign Key(SecurityQuestion1) references SecurityQuestions(Question_ID),
Foreign Key(SecurityQuestion2) references SecurityQuestions(Question_ID));  

go

Create Table Hotel 
(Branch_ID int Not Null identity(1,1) Primary key, 
Location varchar(max), 
PhoneNumber varchar(13));  

go

Create Table RoomType
(RoomType_ID int Not Null identity(1,1) primary key, 
NumberOfBeds int, 
[Type] varchar(max),--deluxe/suite  
Price int, 
[Image] nvarchar(max), 
Rating float default(0), 
NoOfUsersRated int default(0));  

go

Create Table Room
(Room_ID int Not Null identity(1,1) primary key, 
RoomType_ID int Not Null,
RoomNumber int Not Null, 
Branch_ID int Not Null,  
isBooked nvarchar(5) Not Null Default('False'),  
foreign key (Branch_ID) references Hotel(Branch_ID) on update cascade on delete cascade, 
foreign key (RoomType_ID) references RoomType(RoomType_ID) on update cascade on delete cascade); 

go

Create Table Menu
(Food_ID int Not Null Primary Key identity(1,1),
Name nvarchar(max), 
Cuisine nvarchar(max), 
[Description] nvarchar(max),
Price int, 
[Image] nvarchar(max));

go

Create Table SalesAndOffers
(Offer_ID int Not Null Primary Key identity(1,1),
Occasion nvarchar(max), --Independance day sale etc
Percentage float,
[Image] nvarchar(max)); 

go 

Create Table Billing 
(Billing_ID int Primary key Not null identity(1,1), 
[User_ID] nvarchar(15) foreign key References Customer(CNIC), 
Status varchar(max), --paid/unpaid
History int Default(0));  

go

Create Table Booking 
(Room_ID int foreign key References Room(Room_ID) on delete set null on update set null, 
Billing_ID int foreign key References Billing(Billing_ID), 
CurrentDate Date,
NumberOfDays int,
HasRated nvarchar(max) Default('False'),
isBooked nvarchar(max) Default('False'));  

go 

Create Table Orders 
(Food_ID int foreign key References Menu(Food_ID) on delete set null on update set null, 
Billing_ID int foreign key References Billing(Billing_ID),
Quantity int); 

go 

Create Table SelectedOffers 
(Offer_ID int foreign key References SalesAndOffers(Offer_ID) on delete set null on update set null, 
Billing_ID int foreign key References Billing(Billing_ID));  

go 
-------------------------------------------------------------------Triggers/Functions/Procedures/Views----------------------------------------------------------------------
--Default Page Function(additional fucntion)--MARYAM
create function CheckAvailability(@loc nvarchar(max),@Type nvarchar(max),@noofbeds int)   
returns Table  
as
return select Room.RoomType_ID 
from RoomType join Room on Room.RoomType_ID=RoomType.RoomType_ID
where NumberOfBeds=@noofbeds and Type=@Type and Room.Branch_ID in (
		select Branch_ID from Hotel where Location=@loc) and isBooked='False'

go  

--display Cataloge
create Function catalouge(@branchlocation nvarchar(max)) 
returns table 
as  
return select Distinct(Room.RoomType_ID),NumberOfBeds,Type,Price,Rating,Image 
		from Room join RoomType on Room.RoomType_ID=RoomType.RoomType_ID 
		where Branch_ID in (select Hotel.Branch_ID 
							from Hotel 
							where Location=@branchlocation) and Room.isBooked='False' 

go  

--Display Offers 
create Procedure ViewOffers
@userid nvarchar(max), 
@flag int output 
as  
if exists(Select* from Billing where User_ID=@userid and Status='Not Paid') 
	set @flag=1 --bill exists
else 
	set @flag=0 --bill does not exist

go   

create function UserOffers(@userid nvarchar(max))
returns table 
as
return select* 
		from SalesAndOffers 
		where not exists(select Offer_ID
						from SelectedOffers 
						where Billing_ID in (Select Billing_ID 
											from Billing 
											where User_ID=@userid and Status='Not Paid'))  

go

--User Functions Only
create Procedure BookRoom --only isbooked=False room will be showed at front end
@userid nvarchar(max),
@roomtypeid int,  
@loc nvarchar(max),
@days int
as 
Begin 
	if exists(Select* from Billing where User_ID=@userid and Status='Not Paid') 
	Begin 
		Declare @billingid int 
		Select @billingid=Billing_ID from Billing where User_ID=@userid and Status='Not Paid'  
		declare @roomid int 
		select @roomid=temptable.Room_ID from (select Top 1(Room_ID) 
												from Room 
												where RoomType_ID=@roomtypeid and Branch_ID in (select Hotel.Branch_ID 
																								from Hotel 
																								where Location LIKE @loc) and isBooked='False') as temptable
		Update Room Set isBooked='True' where Room_ID=@roomid  
		Insert into Booking Values (@roomid,@billingid,GETDATE() ,@days,'False','True')
	End 
	else  
	Begin 
		declare @history int 
		select @history=PaymentHistory from Customer where CNIC=@userid
		Insert Into Billing(User_ID,Status,History) Values (@userid,'Not Paid',@history) 
		Select @billingid=Billing_ID from Billing where User_ID=@userid and Status='Not Paid'   
		select @roomid=temptable.Room_ID from (select Top 1(Room_ID) from Room where RoomType_ID=@roomtypeid and Branch_ID in (select Hotel.Branch_ID 
																																from Hotel 
																																where Location LIKE @loc) and isBooked='False') as temptable
		Update Room Set isBooked='True' where Room_ID=@roomid 
		Insert into Booking Values (@roomid,@billingid,GETDATE(),@days,'False','True')
	End 
End

go

Create Procedure PlaceOrder 
@userid nvarchar(max),
@foodid int, 
@quantity int
as 
Begin 
	if exists(Select* from Billing where User_ID=@userid and Status='Not Paid') 
	Begin 
		Declare @billingid int 
		Select @billingid=Billing_ID from Billing where User_ID=@userid and Status='Not Paid'
		Insert into Orders Values (@foodid,@billingid,@quantity) 
	End 
	else  
	Begin
		declare @history int 
		select @history=PaymentHistory from Customer where CNIC=@userid
		Insert Into Billing(User_ID,Status,History) Values (@userid,'Not Paid',@history)  
		Select @billingid=Billing_ID from Billing where User_ID=@userid and Status='Not Paid'
		Insert into Orders Values (@foodid,@billingid,@quantity) 
	End 
End

go

Create Procedure SelectOffer
@userid nvarchar(max),
@offerid int
as 
Begin 
	if exists(Select* 
			from Billing 
			where User_ID=@userid and Status='Not Paid') 
	Begin 
		Declare @billingid int 
		Select @billingid=Billing_ID 
		from Billing 
		where User_ID=@userid and Status='Not Paid'
		Insert into SelectedOffers Values (@offerid,@billingid) 
	End 
End 
go 

--Generate bill 
Create Function BookedRoom(@userid nvarchar(max))
Returns Table  
as
return Select Hotel.Location,RoomNumber,RoomType.NumberOfBeds,RoomType.Type, Booking.NumberOfDays, RoomType.Price, Booking.HasRated,Booking.Room_ID,Booking.isBooked
		from Booking join Room on Booking.Room_ID=Room.Room_ID join RoomType on RoomType.RoomType_ID=Room.RoomType_ID join Hotel on Hotel.Branch_ID=Room.Branch_ID
		where Billing_ID in(Select Billing_ID
							from Billing
							where User_ID=@userid and Status='Not Paid') 

go

Create Function OrdersPlaced(@userid nvarchar(max))
Returns Table  
as
return Select Menu.Name,Orders.Quantity,Menu.Price 
		from Orders join Menu on Orders.Food_ID=Menu.Food_ID
		where Billing_ID in(Select Billing_ID
							from Billing
							where User_ID=@userid and Status='Not Paid') 

go 

Create Function OfferSelected(@userid nvarchar(max))
Returns Table  
as
return Select SalesAndOffers.Occasion,SalesAndOffers.Percentage 
		from SelectedOffers join SalesAndOffers on SalesAndOffers.Offer_ID=SelectedOffers.Offer_ID
		where Billing_ID in(Select Billing_ID
							from Billing
							where User_ID=@userid and Status='Not Paid')    

go   

create Function TotalBill(@userid nvarchar(max)) 
Returns int
as
Begin 
	Declare @Total int
	set @Total=0 
	 
	if exists(select* from BookedRoom(@userid)) 
		select @Total=@Total+Sum(NumberOfDays*Price) 
		from BookedRoom(@userid) 
	
	if exists(select* from OrdersPlaced(@userid)) 
		select @Total=@Total+Sum(Quantity*Price) 
		from OrdersPlaced(@userid) 

	if exists(select* from OfferSelected(@userid)) 
		select  @Total=@Total-(Percentage/100)*@Total
		from OfferSelected(@userid) 

	declare @history int 
	select @history=PaymentHistory
	from Customer 
	where CNIC=@userid 

	if @history>10000 and @history<=20000 
		set @Total=@Total-@Total*0.05
	if @history>20000 and @history<=30000 
		set @Total=@Total-@Total*0.1
	if @history>30000
		set @Total=@Total-@Total*0.15
	
	return @total		
End

go   

create Procedure checkoutRoom(@roomid int,@userid nvarchar(max)) 
as 
Update Room Set isBooked='False' where Room_ID=@roomid
Update Booking Set isBooked='False' where Room_ID=@roomid and Billing_ID in(select Billing_ID 
																			from Billing 
																			where User_ID=@userid)
go 

Create Procedure Checkout 
@userid nvarchar(max) 
as 
Begin 
	Update Room Set isBooked='False' Where Room_ID In(Select Room_ID 
														from Booking 
														where Billing_ID In (select Billing_ID 
																			from Billing 
																			where User_ID=@userid))
Update Booking Set isBooked='False' where Billing_ID in(select Billing_ID from Billing where User_ID=@userid)  
End 
go  

--rating
create function RatingTable (@userid nvarchar(max)) 
Returns Table 
as
return select BookedRoom.Location,BookedRoom.RoomNumber from BookedRoom(@userid) 
			join Room on Room.RoomNumber=BookedRoom.RoomNumber 
where Room.Branch_ID in(select Distinct(Branch_ID) 
					from Hotel
					where Location=BookedRoom.Location) and BookedRoom.HasRated='False' 
group by BookedRoom.Location,BookedRoom.RoomNumber 

go 

Create Procedure RateRoom 
@loc nvarchar(max), 
@roomno int, 
@rating float, 
@userid nvarchar(max)
as 
Begin 
	Declare @roomtypeid int 
	Select @roomtypeid=Room.RoomType_ID from Room where Room.RoomNumber=@roomno and Room.Branch_ID in (select Branch_ID from Hotel where Location=@loc)  
	Declare @rate float 
	select @rate=(NoOfUsersRated*Rating+@rating)/(NoOfUsersRated+1)
								from RoomType 
								where RoomType_ID=@roomtypeid
	Update RoomType set Rating=@rate where RoomType_ID=@roomtypeid 
	Update RoomType set NoOfUsersRated=NoOfUsersRated+1 where RoomType_ID=@roomtypeid 
	Declare @billingid int
	select @billingid=Billing_ID from Billing where User_ID=@userid and Status='Not Paid' 
	Update Booking set HasRated='True' where Room_ID in (select Room_ID from Room where RoomNumber=@roomno and Branch_ID in (select Branch_ID from Hotel where Location=@loc))

End
go 

--Admin DashBoard  

Create View ShowRooms--HAISEM 
as 
Select Room_ID,RoomNumber,Hotel.Location,Room.RoomType_ID,RoomType.Type,RoomType.NumberOfBeds,RoomType.Price 
from Room join RoomType on RoomType.RoomType_ID=Room.RoomType_ID join Hotel on Hotel.Branch_ID=Room.Branch_ID
go

create view Payments as --HAISEM
select * 
from Billing 
where Status='Not Paid'
go  

create procedure Paid(@Billing_id int)
as 
Begin 	
	declare @id nvarchar(max)
	select @id=User_ID from Billing where Billing_ID=@Billing_id 
	Update Billing set History=(select PaymentHistory 
								from Customer 
								where CNIC=@id) where Billing_ID=@Billing_id
	Update Customer set PaymentHistory=PaymentHistory+dbo.TotalBill(@id) where CNIC=@id  	
	execute Checkout @userid=@id  
	Update Billing set Status='Paid' where Billing_ID=@Billing_id  	
End 
go

create View CurrentBookings--HAISEM
as 
select User_ID as CNIC,RoomNumber,Location,NumberOfDays,CurrentDate as CheckInDate,Room.Room_ID
from Booking join Room ON Booking.Room_ID=Room.Room_ID join Billing on Billing.Billing_ID=Booking.Billing_ID join Hotel on Hotel.Branch_ID=Room.Branch_ID
where Room.isBooked='True' 

go

create View CustomerInfo --HAISEM
as 
Select CNIC,FirstName,LastName,Address,PhoneNumber,Email,DOB,PaymentHistory 
from Customer 

go 

--View Bill Page HAISEM
create Function ViewBooking(@id int) 
Returns Table 
as 
return 
Select Hotel.Location,RoomNumber,RoomType.NumberOfBeds,RoomType.Type, Booking.NumberOfDays, RoomType.Price 
from Booking join Room on Booking.Room_ID=Room.Room_ID join RoomType on RoomType.RoomType_ID=Room.RoomType_ID join Hotel on Hotel.Branch_ID=Room.Branch_ID
		where Billing_ID=@id 

go 

Create Function ViewOrder(@id int)--HAISEM
Returns Table  
as
return Select Menu.Name,Orders.Quantity,Menu.Price 
		from Orders join Menu on Orders.Food_ID=Menu.Food_ID
		where Billing_ID=@id

go 

Create Function ViewOffer(@id int)--HAISEM
Returns Table  
as
return Select SalesAndOffers.Occasion,SalesAndOffers.Percentage 
		from SelectedOffers join SalesAndOffers on SalesAndOffers.Offer_ID=SelectedOffers.Offer_ID
		where Billing_ID=@id    

go  

create Function TotalBillById(@id nvarchar(max)) --HAISEM
Returns int
as
Begin 
	Declare @Total int
	set @Total=0 
	 
	if exists(select* from ViewBooking(@id)) 
		select @Total=@Total+Sum(NumberOfDays*Price) 
		from ViewBooking(@id) 
	
	if exists(select* from ViewOrder(@id)) 
		select @Total=@Total+Sum(Quantity*Price) 
		from ViewOrder(@id) 

	if exists(select* from ViewOffer(@id)) 
		select  @Total=@Total-(Percentage/100)*@Total
		from ViewOffer(@id) 

	declare @histroy int 
	select @histroy=History
	from Billing
	Billing where Billing_ID=@id

	if @histroy>10000 and @histroy<=20000 
		set @Total=@Total-@Total*0.05
	if @histroy>20000 and @histroy<=30000 
		set @Total=@Total-@Total*0.1
	if @histroy>30000
		set @Total=@Total-@Total*0.15
	
	return @total		
End

go

Create Procedure isBillPresent
@id int,
@flag int output  
as
Begin
if exists(select * from Orders where Billing_ID=@id and Food_ID is Null) or exists(select * from Booking where Billing_ID=@id and Room_ID is Null) or exists(select * from SelectedOffers where Billing_ID=@id and Offer_ID is Null)
set @flag=1--bill should not open
else
set @flag=0--bill should open
End
go

--Additional Feature
Create Procedure AutomaticCheckOut 
as  
Begin 
	Update Room Set isBooked='False' where Room.Room_ID in (Select Booking.Room_ID 
															from Booking 
															where DATEDIFF ( DAY , Booking.CurrentDate,GETDATE() )>=Booking.NumberOfDays) 
	Update Booking Set isBooked='False' where Booking.Room_ID in (Select Booking.Room_ID 
															from Booking 
															where DATEDIFF ( DAY , Booking.CurrentDate,GETDATE() )>=Booking.NumberOfDays)
	
End
go  
--delete triggers 
Create trigger DeleteFood
on Menu 
instead of Delete  
as
begin 
declare @Food_ID int
select @Food_ID=Food_ID from deleted 
if exists(select * from Billing where Billing_ID in (select Billing_ID from Orders where Food_ID=@Food_ID) and Status='Not Paid') 
 print 'Not Deleted' 
else 
	delete from Menu where Food_ID=@Food_ID
end 

go 

Create trigger DeleteRoomType
on RoomType 
instead of Delete  
as
begin 
declare @ID int
select @ID=RoomType_ID from deleted 
if exists(select * from Billing where Billing_ID in (select Billing_ID from Booking 
													where Room_ID in (select Room_ID from Room where RoomType_ID=@ID) )and Status='Not Paid') 
 print 'Not Deleted' 
else 
	delete from RoomType where RoomType_ID=@ID
end 

go 

Create trigger DeleteBranch
on Hotel
instead of Delete  
as
begin 
declare @ID int
select @ID=Branch_ID from deleted 
if exists(select * from Billing where Billing_ID in (select Billing_ID from Booking 
													where Room_ID in (select Room_ID from Room where Branch_ID=@ID) )and Status='Not Paid') 
 print 'Not Deleted' 
else 
	delete from Hotel where Branch_ID=@ID
end 

go   

Create trigger DeleteOffer
on SalesAndOffers
instead of Delete  
as
begin 
declare @ID int
select @ID=Offer_ID from deleted 
if exists(select * from Billing where Billing_ID in (select Billing_ID from SelectedOffers 
													where Offer_ID=@ID) and Status='Not Paid') 
 print 'Not Deleted' 
else 
	delete from SalesAndOffers where Offer_ID=@ID
end 

go
---------------------------------------------------------------Populating Tables-------------------------------------------------------------------------

--Admin
Insert INTO Admin_Login values('admin','admin') 

go 

--Security Questions
Insert Into SecurityQuestions(Text) Values ('What is your Favourite Color?')
Insert Into SecurityQuestions(Text) Values ('What is your  NickName')
Insert Into SecurityQuestions(Text) Values ('What is your Dream Job?')
Insert Into SecurityQuestions(Text) Values ('What is your Favourite Movie?')

go 

--Customer
Insert Into Customer(CNIC,FirstName,LastName,PhoneNumber,Email,Address,DOB,Password,SecurityQuestion1,Answer1,SecurityQuestion2,Answer2,PaymentHistory)
			Values ('35202-8433941-2','Ali','Ahmed','+923013561457','ailahmed533@gmail.com','44B-Model Town Lahore','1998-04-23','12345678',1,'Blue',3,'Doctor',15320)
Insert Into Customer(CNIC,FirstName,LastName,PhoneNumber,Email,Address,DOB,Password,SecurityQuestion1,Answer1,SecurityQuestion2,Answer2,PaymentHistory)
			Values ('35202-1111111-1','Amna','Abid','+923021111111','amnaabid@gmail.com','3A-Garden Town Lahore','1995-06-07','11111111',1,'Red',4,'Brave',1111)
Insert Into Customer(CNIC,FirstName,LastName,PhoneNumber,Email,Address,DOB,Password,SecurityQuestion1,Answer1,SecurityQuestion2,Answer2,PaymentHistory)
			Values ('35202-2222222-0','Faris','Ali','+923032222222','farisali@gmail.com','58F-Johar Town Lahore','1990-01-09','22222222',2,'Fari',3,'Teacher',2222)
Insert Into Customer(CNIC,FirstName,LastName,PhoneNumber,Email,Address,DOB,Password,SecurityQuestion1,Answer1,SecurityQuestion2,Answer2,PaymentHistory)
			Values ('35202-3333333-2','Kamil','Jamil','+923043333333','kamiljamil@gmail.com','48-F-2 Islamabad','2000-09-04','33333333',1,'Green',4,'Ice Age',3333)
Insert Into Customer(CNIC,FirstName,LastName,PhoneNumber,Email,Address,DOB,Password,SecurityQuestion1,Answer1,SecurityQuestion2,Answer2,PaymentHistory)
			Values ('35202-4444444-1','Sara','Nasir','+923054444444','saranasir@gmail.com','7B-Pak Sectt. Islamabad','1991-01-01','44444444',2,'Zara',4,'The Maze Runner',4444)
Insert Into Customer(CNIC,FirstName,LastName,PhoneNumber,Email,Address,DOB,Password,SecurityQuestion1,Answer1,SecurityQuestion2,Answer2,PaymentHistory)
			Values ('35202-5555555-0','Saba','Khan','+923065555555','sabakhan@gmail.com','9A-Clifton Karachi','1995-12-01','55555555',1,'Blue',3,'Enginneer',5555)

go 

--Branch
Insert Into Hotel(Location,PhoneNumber) Values ('Lahore','+923013561457')--1
Insert Into Hotel(Location,PhoneNumber) Values ('Karachi','+923556153911')--2 
Insert Into Hotel(Location,PhoneNumber) Values ('Islamabad','+923644325788')--3
Insert Into Hotel(Location,PhoneNumber) Values ('Peshawar','+923358460852')--4
Insert Into Hotel(Location,PhoneNumber) Values ('Quetta','+923550294607')--5

go 
 
 --Room Type
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (1,'Deluxe',1000,'d1.jpeg',7.5,4) --1  
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (2,'Deluxe',1200,'d2.jpeg',2.3,12)  --2 
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (2,'Deluxe',1300,'d21.jpeg',4.1,6)  --3
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (3,'Deluxe',1400,'d3.jpeg',8.2,7)  --4
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (4,'Deluxe',1600,'d4.jpeg',6.3,8)  --5
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (1,'Suite',1500,'s1.jpeg',4.5,15) --6
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (2,'Suite',1700,'s2.jpeg',2.4,7) --7 
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (2,'Suite',1800,'s21.jpeg',9.1,9) --8
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (3,'Suite',1900,'s3.jpeg',10,1) --9
Insert Into RoomType(NumberOfBeds,Type,Price,[Image],Rating,NoOfUsersRated) Values (4,'Suite',2100,'s4.jpeg',3.8,20) --10

go  

--Rooms
--Lahore
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,1,1)--1
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,2,1)--2
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,222,1)--3
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (2,3,1)--4
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (2,4,1)--5
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,213,1)--6
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,5,1)--7
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (4,212,1)--8
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (5,334,1)--9
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (6,321,1)--10
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (7,264,1)--11
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (8,21,1)--12
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (9,23,1)--13
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (10,4,1)--14
--Karachi
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,1,2)--1
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,2,2)--2
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,222,2)--3
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (2,12,2)--4
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,20,2)--5
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,233,2)--6
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,5,2)--7
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (4,212,2)--8
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (7,334,2)--9
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (6,321,2)--10
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (7,264,2)--11
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (8,21,2)--12
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (9,23,2)--13
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (10,4,2)--14
--Islamabad 
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,1,3)--1
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (1,1,3)--2
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (9,22,3)--3
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (2,12,3)--4
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,20,3)--5
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,233,3)--6
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,5,3)--7
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (4,212,3)--8
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (7,334,3)--9
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (6,321,3)--10
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (5,214,3)--11
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (8,21,3)--12
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (9,23,3)--13
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (10,4,3)--14 
--Peshawar 
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (7,1,4)--1
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (6,1,4)--2
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (3,22,4)--3
Insert Into Room(RoomType_ID,RoomNumber,Branch_ID) Values (8,12,4)--4

go 

--Menu
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Tacos','Mexican','An open wrap with a filling of meat, cheese, and lettuce as the star of the show',500,'tacos.jpeg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Pizza','Italian','The humble combination of sauce, cheese and bread is one that we all know of',400,'pizza.jpeg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Moussaka','Greek','A potato or eggplant based meat dish',600,'Moussaka.jpeg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Sushi','Japanese','Raw fish and vegetables wrapped in vinegared rice',700,'sushi.jpeg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Paella','Spanish','slowly cooked rice, vegetables, seafood and spices, till it takes its flavoursome form',700,'Paella.jpeg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Burrito','Mexican','Flour tortillas filled with a mixture of ground beef, refried beans, and chiles then topped with sauce and cheese',800,'burrito.jpg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Rose Pasta','Italian',' A simple and delicious meal made from scratch with a cream and tomato based sauce',500,'pasta.jpg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Pastitsio','Greek','Baked layers of pasta, juicy minced beef, bechamel and tomato sauce, topped melted cheese',800,'pastitsio.jpg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Tempura','Japanese','A dish of battered and fried fish, seafood, or vegetables',400,'tempura.jpg')
Insert Into Menu(Name,Cuisine,Description,Price,[Image]) Values ('Masala Dosa','Indian','A thin pancake-like flatbread made from fermented soaked rice and black gram beans',300,'dosa.jpg')

go

--sales and offers
Insert Into SalesAndOffers(Occasion,Percentage,[Image]) Values('Independence Day',10,'azadisale.jpeg') 
Insert Into SalesAndOffers(Occasion,Percentage,[Image]) Values('Eid ul Fitr',20,'eidsale.png')  

go  

--Bookings
execute BookRoom @userid='35202-1111111-1',@roomtypeid=3,@loc='Islamabad',@days=4
execute BookRoom @userid='35202-1111111-1',@roomtypeid=8,@loc='Islamabad',@days=4 
execute BookRoom @userid='35202-4444444-1',@roomtypeid=9,@loc='Islamabad',@days=1
execute BookRoom @userid='35202-2222222-0',@roomtypeid=3,@loc='Karachi',@days=3 
execute BookRoom @userid='35202-5555555-0',@roomtypeid=7,@loc='Peshawar',@days=2
go

--Offers
execute SelectOffer @userid='35202-1111111-1',@offerid=2
go 

--Orders 
execute PlaceOrder @userid='35202-1111111-1',@foodid=5,@quantity=2
execute PlaceOrder @userid='35202-1111111-1',@foodid=3,@quantity=1  
execute PlaceOrder @userid='35202-8433941-2',@foodid=7,@quantity=3
go 

--Payments 
execute Paid @Billing_id=2 
go
 
