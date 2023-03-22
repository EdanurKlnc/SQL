---DML Data Manupulation Language
--- insert into tabloAdi(kolon1,kolon2)
---values deðerler (deðer1,deðer2)
---metinsel, tarih tek týrnak

--Ör; Ürünler tablosuna veriler ekleyelim

use CafeDB
insert into Urunler(Birim_Fiyati, Kategori_Id, Urun_Adi)
values(10.5,2,'Çay')

insert into Urunler(Urun_Adi,Kategori_Id,Birim_Fiyati)
values('Limonata',2,30), --Ayný anda birden fazla ürün ekleme
('Sýcak Çikolata',2,20),
('Portakal suyu',2,25)

---DQL Data Query Language
--Select komutu secme, listeleme yapar.
---Select kolanAdý from tabloAdý
-- bütün tablo adýný alak istersek = select * from tabloAdi

select * from Urunler --bütün urunler
select top 2 * from Urunler  --ilk 2 urun
select Urun_Adi,Birim_Fiyati from Urunler


--no lock => sistemde beklemek yerine son verileri verir
select * from Urunler (nolock)
select * from Urunler with (nolock)


--Takma isim ALIAS
--1.Neden => tbloya takma isim vererek kolonlara daha kolay ulaþmak
--2.Nede => JOIN konusunda acýklanacak
--3.Neden => Subquerylerde drived table'ý isimlendirmek içindir

select u.Birim_Fiyati from Urunler as u --as'den sonra takma isim gelir
select u.Birim_Fiyati from Urunler  u --as yazmadanda takma isim yazýlýr

--Kolonlarla Ýþlem Yapma
-------------------------
select 10+10 As sonuc  --3'üde ayný sonucu verir
select 10+10 sonuc
select 10 +'10' sonuc 
-------------------------
--Urununadi birim fiyatý üzerinde  %10 zam tek kolonda tut
select u.Urun_Adi,u.Birim_Fiyati[ Fiyatý],
u.Birim_Fiyati*1.10[%10 eklenmiþ yeni fiyat tl]
from Urunler u


--LIKE Komutu
--% iþareti herhangi bir karakter anlamýna gelir
-- _ iþareti tek bir karekter anlamýna gelir
select * from Kitaplar (nolock) k
 where k.KitapAdi like 'C%'    --C ile baþlayan kitaplar

select * from Kitaplar (nolock) k
 where k.KitapAdi like 'C%r%'    --C ile baþlasýn içerisinde R olsun

select * from Kitaplar (nolock) k
 where k.KitapAdi like '%en%'    --Herhangi bir yerde en yan yana olsun

 select * from Kitaplar (nolock) k
 where k.KitapAdi like '_r%'    --2.harfi r olsun

 select * from Kitaplar (nolock) k
 where k.KitapAdi like 's_r%'    --ilk harfi s ,3 .harfi r olsun

 select * from Kitaplar (nolock) k
 where k.KitapAdi like '____%'    -- _ kadar karekterli olanlar listelenecek

 --[] Aralýk belirtmek için
  select * from Kitaplar (nolock) k
  where k.KitapAdi like '[a-k]___e_[b-z]%' --ilk harfi a ile k arasýda bir harf olsun.

-- ^ deðili
  select * from Kitaplar (nolock) k
  where k.KitapAdi like '[^a-k]%' --a'dan k harfine kadar olanlar haricini listeler 

  select * from Kitaplar (nolock) k
  where k.KitapAdi like '[^a]%' -- a ile baþlamayanlarý listeler

--Like Not kullanýmý
  select * from Kitaplar (nolock) k
  where k.KitapAdi  not like 'a%' -- a ile baþlayan ve 4 hanelileri getirmeyecek

--Null verileri sorgulama (is)
select * from Kitaplar (nolock) k
where k.ResimLink is null 

--resmi olmayan kitaplar
select * from Kitaplar (nolock) k
where k.ResimLink is null or k.ResimLink='' 

--null olmayanlar is not null
select * from Kitaplar (nolock) k
where k.ResimLink is not null

--resmi olan kitaplar
select * from Kitaplar (nolock) k
where k.ResimLink is not null and k.ResimLink <>'' 

--distinct komutu
--Sorgu sonucunda gelen kolonun içinde ayný deðerler tekrar etmesin istersek, 
--o kolonun önüne distinct(tekilleþtirme) komutunu ekleriz
select distinct turId from Kitaplar (nolock)
select distinct SayfaSayisi from Kitaplar (nolock)
select distinct turId,SayfaSayisi from Kitaplar (nolock)
------------------------------------------------------------------------
