---DML Data Manupulation Language
--- insert into tabloAdi(kolon1,kolon2)
---values de�erler (de�er1,de�er2)
---metinsel, tarih tek t�rnak

--�r; �r�nler tablosuna veriler ekleyelim

use CafeDB
insert into Urunler(Birim_Fiyati, Kategori_Id, Urun_Adi)
values(10.5,2,'�ay')

insert into Urunler(Urun_Adi,Kategori_Id,Birim_Fiyati)
values('Limonata',2,30), --Ayn� anda birden fazla �r�n ekleme
('S�cak �ikolata',2,20),
('Portakal suyu',2,25)

---DQL Data Query Language
--Select komutu secme, listeleme yapar.
---Select kolanAd� from tabloAd�
-- b�t�n tablo ad�n� alak istersek = select * from tabloAdi

select * from Urunler --b�t�n urunler
select top 2 * from Urunler  --ilk 2 urun
select Urun_Adi,Birim_Fiyati from Urunler


--no lock => sistemde beklemek yerine son verileri verir
select * from Urunler (nolock)
select * from Urunler with (nolock)


--Takma isim ALIAS
--1.Neden => tbloya takma isim vererek kolonlara daha kolay ula�mak
--2.Nede => JOIN konusunda ac�klanacak
--3.Neden => Subquerylerde drived table'� isimlendirmek i�indir

select u.Birim_Fiyati from Urunler as u --as'den sonra takma isim gelir
select u.Birim_Fiyati from Urunler  u --as yazmadanda takma isim yaz�l�r

--Kolonlarla ��lem Yapma
-------------------------
select 10+10 As sonuc  --3'�de ayn� sonucu verir
select 10+10 sonuc
select 10 +'10' sonuc 
-------------------------
--Urununadi birim fiyat� �zerinde  %10 zam tek kolonda tut
select u.Urun_Adi,u.Birim_Fiyati[ Fiyat�],
u.Birim_Fiyati*1.10[%10 eklenmi� yeni fiyat tl]
from Urunler u


--LIKE Komutu
--% i�areti herhangi bir karakter anlam�na gelir
-- _ i�areti tek bir karekter anlam�na gelir
select * from Kitaplar (nolock) k
 where k.KitapAdi like 'C%'    --C ile ba�layan kitaplar

select * from Kitaplar (nolock) k
 where k.KitapAdi like 'C%r%'    --C ile ba�las�n i�erisinde R olsun

select * from Kitaplar (nolock) k
 where k.KitapAdi like '%en%'    --Herhangi bir yerde en yan yana olsun

 select * from Kitaplar (nolock) k
 where k.KitapAdi like '_r%'    --2.harfi r olsun

 select * from Kitaplar (nolock) k
 where k.KitapAdi like 's_r%'    --ilk harfi s ,3 .harfi r olsun

 select * from Kitaplar (nolock) k
 where k.KitapAdi like '____%'    -- _ kadar karekterli olanlar listelenecek

 --[] Aral�k belirtmek i�in
  select * from Kitaplar (nolock) k
  where k.KitapAdi like '[a-k]___e_[b-z]%' --ilk harfi a ile k aras�da bir harf olsun.

-- ^ de�ili
  select * from Kitaplar (nolock) k
  where k.KitapAdi like '[^a-k]%' --a'dan k harfine kadar olanlar haricini listeler 

  select * from Kitaplar (nolock) k
  where k.KitapAdi like '[^a]%' -- a ile ba�lamayanlar� listeler

--Like Not kullan�m�
  select * from Kitaplar (nolock) k
  where k.KitapAdi  not like 'a%' -- a ile ba�layan ve 4 hanelileri getirmeyecek

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
--Sorgu sonucunda gelen kolonun i�inde ayn� de�erler tekrar etmesin istersek, 
--o kolonun �n�ne distinct(tekille�tirme) komutunu ekleriz
select distinct turId from Kitaplar (nolock)
select distinct SayfaSayisi from Kitaplar (nolock)
select distinct turId,SayfaSayisi from Kitaplar (nolock)
------------------------------------------------------------------------
