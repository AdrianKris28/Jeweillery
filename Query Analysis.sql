
--2
go
create proc [Insert New Customer]
@cusID varchar(255),
@cusName varchar(255),
@cusGender varchar(255),
@cusDOB date,
@cusEmail varchar(255),
@cusPhone varchar(255)
as
begin
	if(datediff(yy, @cusDOB, GETDATE()) < 17 and len(@cusName) < 3)
	begin
		print 'Customer Age must be at least 17 years old'
		print 'Customer Name length must be at least 3 characters'
	end
	else if (len(@cusName) < 3)
	begin
	print 'Customer Name length must be at least 3 characters'
	end
	else if(datediff(yy, @cusDOB, GETDATE()) < 17)
	begin
		print 'Customer Age must be at least 17 years old'
	end
	else
	begin
	insert into Customer values(@cusID, @cusName, @cusGender, @cusDOB, @cusEmail, @cusPhone)
	end
end

exec [Insert New Customer]
'CU008', 'AI', 'Female', '2005-08-08', 'agustina@yahoo.com', '+6285623195667'

exec [Insert New Customer]
'CU008', 'Agustina Intania', 'Female', '2005-08-08', 'agustina@yahoo.com', '+6285623195667'


--3
go
create proc [View My Transaction]
@cusName varchar(255)
as
begin
	declare curs cursor
	for
	select c.CustomerName, j.JewelleryName,[TotalQuantity] = sum(dt.Quantity)
	from Jewellery j
	join DetailTransaction dt
	on dt.JewelleryID = j.JewelleryID
	join HeaderTransaction dh
	on dh.TransactionID = dt.TransactionID
	join Customer c
	on c.CustomerID = dh.CustomerID
	where c.CustomerName = @cusName
	group by c.CustomerName, j.JewelleryName

	declare @name varchar(255),
	 @jewelName varchar(255),
	 @totalquantity int

	open curs
	fetch next from curs into @name, @jewelname, @totalquantity

	print 'My Jewellery Transaction'
	print 'Customer Name: ' + @name
	print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
	print 'List Transactions'
	while @@FETCH_STATUS = 0
	begin
		
	print '+ ' + @jewelname + ' -> ' + cast(@totalquantity as varchar) + + ' Jewelleries'

	fetch next from curs into @name, @jewelname, @totalquantity
	
	end
		
	print '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'

	close curs
	deallocate curs

end

exec [View My Transaction] 'Louis Hood'


--4
go
create trigger InsertJewelleryTrigger 
on Jewellery 
after insert 
as
begin
	select * from Jewellery
	select * from inserted
end

insert into Jewellery
values('JE008', 'Haera Necklace', 'Diamond', 5, 5000000)


