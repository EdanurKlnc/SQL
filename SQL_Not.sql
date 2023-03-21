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

--WHERE komutunun KULLANIMLARI 
--Mevcut tablodaki bazý koþullarý uygulayarak filtreleme yapýlýr
   --1)Karþýlaþtýrma ( <,> =,>=,<=,=!)
   --2)Mantýksal (AND, OR, NOT)
   --3)Aralýk sorgulama (between...and)
   --4)Listesel sorgulama (in)
   --5)Like komutu
   --6)Null verileri sorgulama (is)

use OduncKitapDB
select * from Kitaplar
where  KitapAdi = 'Camdaki Kýz'

--Sayfa sayýsý 350'den fazla olan kitaplar
select * from Kitaplar
where SayfaSayisi >=350

--turId 6 olan ve sayfa sayýsý 350den fazla olan kitaplar
select * from Kitaplar
where TurId = 6 and SayfaSayisi >350

--Farklý operatörleri ayný anda kullanýrsak
select * from Kitaplar
where SayfaSayisi > 350  and (TurId = 6 or TurId = 8)

--Eþit deðil operatörü
select * from Kitaplar k(nolock)
where k.TurId !=6 --Sistemdeki turId si  6 olmayan kitaplar

--Farklýdýr operatörü
select * from Kitaplar k(nolock)
where k.TurId <>6

--Not operatörleri yer seyi tersine cevirerek alýr
select * from Kitaplar
where not (SayfaSayisi > 350  and (TurId = 6 or TurId = 8))

select * from Kitaplar
where not (TurId = 6 or TurId = 8)

select * from Kitaplar
where not YazarId = 15

--and,or, not bir arada kullanýlýr. Ama parante önceliðine dikkat etmek gerekir
select * from Kitaplar
where not (YazarId=1 and SayfaSayisi>400) and StokAdeti >10

--Between 
select *from Kitaplar k(nolock) --turId 5 olan sayfa sayýsý 200 ile 300 arasýnda olan kitaplar (sayfasayýsý >=200 ve <=300)
where k.SayfaSayisi between 200 and 300 and k.TurId = 1

select * from Kitaplar k (nolock) 
where k.KayitTarihi between '20220101' and '20220122'

select * from Kitaplar k (nolock) 
where k.KayitTarihi <= '20220114' and k.KayitTarihi>= '20220114'

--14 ocak 2022 
--insert 000 data
select * from Kitaplar k (nolock)
where k.KayitTarihi >= '20220114' and k.KayitTarihi < '20220115'

select * from Kitaplar k (nolock)
where k.KayitTarihi between '20220114' and '20220115'

--2022 ocak ayý
select * from Kitaplar k (nolock)
where k.KayitTarihi > '20211231' and k.KayitTarihi < '20220201'

--Yeni kayýt ekleme
insert into Kitaplar(KayitTarihi,KitapAdi,TurId, YazarId,SayfaSayisi,StokAdeti,ResimLink,SilindiMi) 
values (GETDATE(),'deneme', 1,1,1,1,null,0) --GETDATA =>sistem tarihini ve saatini alan fonksiyon 

--UPDATE!!! yaparken cok dikkat etmek gerekir. where siz kullanma ,bütün tablo etkilensin istemiyoruz!!!
--update TabloAdý set Kolon1= yeniDeðeri ,Kolon2= yeniDeðeri ....
update Kitaplar set KayitTarihi ='20220114' , SilindiMi =1    --set= hangi alaný düzenleyeceðimizin bilgisi
where Id=67

select * from Kitaplar where Id=67

--2022'den önceki yýllardki tüm kitaplarý silindiMi =1, stok=0 yap

select *from Kitaplar k(nolock)
where k.KayitTarihi < '20220101' --kaç data etkilenecek onu görmek için 

--Yedek Alma
--select * into KitaplarYedek from Kitaplar -- tabloyu yedekleme

select * from KitaplarYedek

update Kitaplar set StokAdeti =0 , SilindiMi = 1 where KayitTarihi <'20220101'

--listeleme sorgulama komutu in (eþitti gibi çalýþýr)
select * from Kitaplar
where  TurId in (6,8) -- where  TurId = 6 or TurId = 8

select * from Kitaplar k(nolock)
where k.KitapAdi in ('Camdaki Kýz','Hayata Dön')

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

-----JOIN Ýþlemleri------
--Join birleþtirmek anlamýna gelir
--En az 2 tablonun birleþtirilmesi için kullanýlýr
--JOIN Çeþitleri--
--inner join(kesisþim)
--left join
--right join
--outter (dýþ) join
--cross join (kartezyen)
--self join (joinin ayný tablolar üzerinden yapýlmýþ hali)
--composite join

--inner join
select * from Kitaplar k(nolock)
inner join Turler t(nolock) on k.TurId=t.Id -- on => hangi alanla üzerinden kesiþim yapýlacak

select  k.KitapAdi,k.SayfaSayisi, t.TurAdi from 
Kitaplar k(nolock)--tablo 1
inner join Turler t(nolock) --tablo 2
on k.TurId=t.Id --kesiþim saðlanacak kolon

--Bir kitabýn adý,türü ve yazarýn adý soyadý
select k.KitapAdi,t.TurAdi,y.YazarAdi+''+y.YazarSoyadi as Yazar --yazar adý soyadý tek satýrda birleþik yazma +
from Kitaplar k(nolock)
inner join Turler  t(nolock) on t.Id= k.TurId
join Yazarlar Y(nolock) on k.YazarId=y.Id
where k.SayfaSayisi >300

-- left join 
-- Kitaplarýn ödünç alýnma durumu
select * from Kitaplar k (nolock)  -- table 1
 join OduncIslemler oi (nolock)  -- table 2
on k.Id=oi.KitapId

select * from OduncIslemler
--53 camdaki -- 2 þeker 
insert into OduncIslemler (KayitTarihi, KitapId, OduncAlinmaTarihi, OduncBitisTarihi, PersonelId, TeslimEttigiTarih, TeslimEttiMi, UyeId) values 
(getdate(), 53, getdate(), '2023-04-21 13:50:58.903',1,null,0,5),
(getdate(), 2, getdate(), '2023-05-21 13:50:58.903',1,null,0,2)
