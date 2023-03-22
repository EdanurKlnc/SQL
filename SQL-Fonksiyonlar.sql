----FUNCTION----
--Matematik fonksiyonlarý
select PI()
select pi() Sonuc
select power(2,3) Sonuc --power => kuvvet alýr. 2'nin 3. kuvveti
select SQRT(81) -- sqrt => karekök 
select ceiling(9.0000001) --ceiling => verilen sayýyý yukarý yuvarlar
select round(9.20125,2) --round kaç basamak istersek(, den sonra yazdýðýmýz kadar) .'dan sonra o kadar basamaðý yazdýrýp kalanýný 00 yapar
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

----DateTime Function----
select getdate()
select year(getdate()) --sadece yýl 
select month(getdate())
select day(getdate()) 
select dateadd(day,3,getdate()) -- 3 gün eklenmiþ (þuandan 3 gün sonrasý)
select dateadd(year,-3,getdate()) -- 3 yýl öncesi
select dateadd(day,3,'20230322') -- bu tarihten 3 gün sonrasý


--ÖRNEK: Sipariþler verildiði tarihden itibaren tahmini 3 gün sonra kargolanacaktýr

use NORTHWND
select o.OrderID, o.OrderDate, 
DATEADD (day,3,o.OrderDate) TahminiKargoTarihi
from Orders o (nolock)

--dateddift 2 tarih arasýndaki farký alýr
select DATEDIFF(day,'20220322','20230322') -- Önce kücük tarih , daha sonra büyük tarih
select DATEDIFF(MONTH,'20220322','20230322') 
select DATEDIFF(year,'20220322','20230322') 

--ÖRNEK : Sipariþi verildiði ve kargolandýðý tarih arasýnda kaç gün geçmiþtir? 20 günü aþan kargolarý göster
select o.OrderID, o.OrderDate, o.ShippedDate,
DATEDIFF(day,o.OrderDate,o.ShippedDate) [Kaç günde kargolanmýþtýr?]
from Orders (nolock)o
where o.ShipVia = 3  and DATEDIFF(day,o.OrderDate,o.ShippedDate) > 20


select o.OrderID, o.OrderDate, o.ShippedDate,
c.CompanyName, c.ContactName, c.Phone,
DATEDIFF(day,o.OrderDate, o.ShippedDate) [Kaç Günde Kargolanmýþtýr? ]
from Orders (nolock) o
join Customers c on c.CustomerID=o.CustomerID
where o.ShipVia =3
and DATEDIFF(day,o.OrderDate, o.ShippedDate) > 20
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

----String Function----
select ASCII ('a') --a'nýn ilk bulunduð yerin indexsini alýr (sql'De indexs 1den baþlar)
select char (97)

select CHARINDEX('a' ,'ali ata bak') -- 1.indexs
select left ('betül',1) --soldan baþlayýp kaç harf istersek o kadarýný yazar
select left ('betül',3) --cýktý = bet
select left ('betül',4) --cýktý = betü
select right ('betül',3) --cýktý = tül

--trim ifadedeki sað ve soldaki boþluklarý siler
select trim  ('    edanur   ')
select ltrim ('    edanur   ') --sadece soldaki boþluðu siler
select rtrim ('    edanur   ') --sadece saðdaki boþluðu siler

--substring ifadenin içinden bir kýsmý keser/alýr
select SUBSTRING ('edanur kýlýnç',1,4) --cýktý =edan (1.indexsinden itibaren 4 harf yazdýr)
select SUBSTRING ('edanur kýlýnç',3,7) 

--replace yerine baþka deðer koymak
select replace ('edanur kýlýnç' ,'e','a') -- verilenin içindeki e'leri a ile deðiþtir cýktý = adanur kýlýnç
select replace ('edanur kýlýnç' ,'nur','eda')  --cýktý = edaeda kýlýnç


select len('e d a n u r') -- boþluklarýda sayarak kaç karakter olduðunu sayar .cýktý=11

--concat birleþtirme
select concat ('eda',' ','nur') --cýktý = eda nur

--str içinde yazýlan ifadeyi stringe ceviri
select str(GETDATE())
select str(12)
--fonk. içerisinde fonk. kullanýlabilir
select trim(str(GETDATE()))

--ÖRNEK:22/03/2023
select trim(str(day(o.OrderDate))),trim(str(month(o.OrderDate))),trim(str(year(o.OrderDate))) from Orders o  --cýktý 22   03   2023
select concat(trim(str(day(o.OrderDate))),trim(str(month(o.OrderDate))),trim(str(year(o.OrderDate)))) from Orders o --cýktý =22032023
select concat(trim(str(day(o.OrderDate))),'/',trim(str(month(o.OrderDate))),'/',trim(str(year(o.OrderDate)))) from Orders o --cýktý =22/03/2023
-----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

---Aggregate Function ---
--Tek baþýna veya group by ile berber kullanýlýr
--SUM :Bir sutündaki verileri toplar.
--MAX : Bir kolondaki veriler arasýndan en büyük olaný verir.
--MIN : Bir kolondaki veriler arasýndan en kücük olaný verir.
--AVG : Bir kolondaki verilerin ortalamasýný alýr.
--COUNT : Bir kolondaki verilerin sayýsýný verir.

--!!!DÝPNOT : Hesaplama fonk. null olan deðerleri dikkate almaz !!!

use NORTHWND
select count (*) from Customers  c(nolock)
select count (Region) from Customers  c(nolock)

select max (UnitPrice) [En pahalý ürün fiyatý] from  Products
select sum (UnitPrice) [Toplam ürün fiyatý] from  Products
select avg(UnitPrice) [Ortalama ürün fiyatý] from  Products

--null deðer ile iþle yapýlabiliyor mu ?
create table DenemeNull(
id int identity (1,1) primary key,
Deger int null
)
insert into DenemeNull (Deger) values(100),(null), (150), (200), (null),(50)
select * from DenemeNull

insert into DenemeNull (Deger) values(100),(null), (150), (200), (null),(50)
select avg (deger) from DenemeNull --null deðerleri dikkate almaz

select avg(isnull(Deger,0)) Sonuc from DenemeNull -- null degerleri 0 olarak alacak
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

-----ROWNUMBER()----
--Veriye satýr numarasý ekleyen fonksiyon
use NORTHWND
select ROW_NUMBER () over (order by p.ProductName) SýraNo,
p.ProductName, p.CategoryID ,p.UnitPrice
from Products p (nolock)

use OduncKitapDB
select ROW_NUMBER () over (order by k.SayfaSayisi desc) SýraNo, *
from Kitaplar k (nolock)

select ROW_NUMBER () over (order by k.SayfaSayisi desc) SýraNo, k.KitapAdi,t.TurAdi,
*
from Kitaplar k (nolock)
join Turler t on t.Id = k.TurId
join Yazarlar y on y.Id = k.YazarId

