select *
from track;

-- tracks by Genre: Number of Tracks belonging to each Genre----------
select g.Name, count(t.TrackId) as TrackCount
from track as t
join genre as g on t.GenreId = g.GenreId
group by g.Name;

-- tracks by Media Type: What are the different media types available, and how many tracks are associated with each?----------
select m.Name, count(t.TrackId) as TrackCount
from track as t
join mediatype as m on t.MediaTypeId = m.MediaTypeId
group by m.Name; 

-- Playlists containing Specific tracks---------------------
select p.Name 
from playlisttrack as pt
join playlist as p on pt.PlaylistId = p.PlaylistId
where pt.TrackId = 2; 

-- Composer with the most tracks-----------
select Composer, count(TrackId) as TrackCount
from Track 
where Composer is not null 
group by Composer
order by TrackCount desc
limit 3;

-- Albums by Artist -----------
select a.Name as ArtistName,
count(al.AlbumId) as AlbumCount
from artist as a
join album as al on a.ArtistId = al.ArtistId
group by a.Name; 

-- Top Customers by Total Invoice Amount -------------
select c.FirstName, c.LastName, sum(i.Total) as TotalSpent
from invoice as i
join customer as c on i.CustomerId = c.CustomerId
group by c.FirstName, c.LastName
order by TotalSpent desc;

-- Number of each track sold -----------------------------
select t.Name, sum(il.Quantity) as TotalSold
from invoiceline as il
join track as t on il.TrackId = t.TrackId
group by t.Name
order by TotalSold desc;

-- Revenue by tracks of each Genre -----------
select g.Name as GenreName, sum(il.UnitPrice * il.Quantity) as TotalRevenue
from invoiceline as il
join track as t on il.TrackId = t.TrackId
join genre as g on t.GenreId = g.GenreId
group by g.Name
order by TotalRevenue desc;

-- Employee that has generated the most revenue from customers -------------
select e.FirstName, e.LastName, sum(i.Total) as TotalSales
from customer as c
join invoice as i on c.CustomerId = i.CustomerId
join employee as e on c.SupportRepId = e.EmployeeId
group by e.FirstName, e.LastName
order by TotalSales desc
limit 1;

-- Customer with the most Purchases-----------
select c.FirstName, c.LastName, count(i.InvoiceId) as PurchaseCount
from customer as c
join invoice as i on c.CustomerId = i.CustomerId
group by c.FirstName, c.LastName
order by PurchaseCount desc
limit 1;

-- Average length -of tracks in each genre -------------
select g.Name as GenreName,
avg(t.Milliseconds) as AverageLength
from track as t
join genre as g on t.GenreId = g.GenreId
group by g.Name;

-- Track Price Range -------------
select al.Title as Albumtitle,
min(t.UnitPrice) as MinPrice,
max(t.UnitPrice) as MaxPrice
from track as t 
join album al on t.AlbumId = al.AlbumId
group by al.Title;

-- Tracks each artsist have ----------------
select ar.Name as ArtistName,
 count(t.TrackId) as TotalTracks,
 avg(t.UnitPrice) as AverageTrackPrice
 from track as t
 join Album as al on t.AlbumId = al.AlbumId
 join artist as ar on al.ArtistId = ar.ArtistId
 group by ar.Name
 order by TotalTracks desc;
