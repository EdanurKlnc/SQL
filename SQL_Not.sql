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

--WHERE komutunun KULLANIMLARI 
--Mevcut tablodaki baz� ko�ullar� uygulayarak filtreleme yap�l�r
   --1)Kar��la�t�rma ( <,> =,>=,<=,=!)
   --2)Mant�ksal (AND, OR, NOT)
   --3)Aral�k sorgulama (between...and)
   --4)Listesel sorgulama (in)
   --5)Like komutu
   --6)Null verileri sorgulama (is)

use OduncKitapDB
select * from Kitaplar
where  KitapAdi = 'Camdaki K�z'

--Sayfa say�s� 350'den fazla olan kitaplar
select * from Kitaplar
where SayfaSayisi >=350

--turId 6 olan ve sayfa say�s� 350den fazla olan kitaplar
select * from Kitaplar
where TurId = 6 and SayfaSayisi >350

--Farkl� operat�rleri ayn� anda kullan�rsak
select * from Kitaplar
where SayfaSayisi > 350  and (TurId = 6 or TurId = 8)

--E�it de�il operat�r�
select * from Kitaplar k(nolock)
where k.TurId !=6 --Sistemdeki turId si  6 olmayan kitaplar

--Farkl�d�r operat�r�
select * from Kitaplar k(nolock)
where k.TurId <>6

--Not operat�rleri yer seyi tersine cevirerek al�r
select * from Kitaplar
where not (SayfaSayisi > 350  and (TurId = 6 or TurId = 8))

select * from Kitaplar
where not (TurId = 6 or TurId = 8)

select * from Kitaplar
where not YazarId = 15

--and,or, not bir arada kullan�l�r. Ama parante �nceli�ine dikkat etmek gerekir
select * from Kitaplar
where not (YazarId=1 and SayfaSayisi>400) and StokAdeti >10

--Between 
select *from Kitaplar k(nolock) --turId 5 olan sayfa say�s� 200 ile 300 aras�nda olan kitaplar (sayfasay�s� >=200 ve <=300)
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

--2022 ocak ay�
select * from Kitaplar k (nolock)
where k.KayitTarihi > '20211231' and k.KayitTarihi < '20220201'

--Yeni kay�t ekleme
insert into Kitaplar(KayitTarihi,KitapAdi,TurId, YazarId,SayfaSayisi,StokAdeti,ResimLink,SilindiMi) 
values (GETDATE(),'deneme', 1,1,1,1,null,0) --GETDATA =>sistem tarihini ve saatini alan fonksiyon 

--UPDATE!!! yaparken cok dikkat etmek gerekir. where siz kullanma ,b�t�n tablo etkilensin istemiyoruz!!!
--update TabloAd� set Kolon1= yeniDe�eri ,Kolon2= yeniDe�eri ....
update Kitaplar set KayitTarihi ='20220114' , SilindiMi =1    --set= hangi alan� d�zenleyece�imizin bilgisi
where Id=67

select * from Kitaplar where Id=67

--2022'den �nceki y�llardki t�m kitaplar� silindiMi =1, stok=0 yap

select *from Kitaplar k(nolock)
where k.KayitTarihi < '20220101' --ka� data etkilenecek onu g�rmek i�in 

--Yedek Alma
--select * into KitaplarYedek from Kitaplar -- tabloyu yedekleme

select * from KitaplarYedek

update Kitaplar set StokAdeti =0 , SilindiMi = 1 where KayitTarihi <'20220101'

--listeleme sorgulama komutu in (e�itti gibi �al���r)
select * from Kitaplar
where  TurId in (6,8) -- where  TurId = 6 or TurId = 8

select * from Kitaplar k(nolock)
where k.KitapAdi in ('Camdaki K�z','Hayata D�n')

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

-----JOIN ��lemleri------
--Join birle�tirmek anlam�na gelir
--En az 2 tablonun birle�tirilmesi i�in kullan�l�r
--JOIN �e�itleri--
--inner join(kesis�im)
--left join
--right join
--outter (d��) join
--cross join (kartezyen)
--self join (joinin ayn� tablolar �zerinden yap�lm�� hali)
--composite join

--inner join
select * from Kitaplar k(nolock)
inner join Turler t(nolock) on k.TurId=t.Id -- on => hangi alanla �zerinden kesi�im yap�lacak

select  k.KitapAdi,k.SayfaSayisi, t.TurAdi from 
Kitaplar k(nolock)--tablo 1
inner join Turler t(nolock) --tablo 2
on k.TurId=t.Id --kesi�im sa�lanacak kolon

--Bir kitab�n ad�,t�r� ve yazar�n ad� soyad�
select k.KitapAdi,t.TurAdi,y.YazarAdi+''+y.YazarSoyadi as Yazar --yazar ad� soyad� tek sat�rda birle�ik yazma +
from Kitaplar k(nolock)
inner join Turler  t(nolock) on t.Id= k.TurId
join Yazarlar Y(nolock) on k.YazarId=y.Id
where k.SayfaSayisi >300

-- left join 
-- Kitaplar�n �d�n� al�nma durumu
select * from Kitaplar k (nolock)  -- table 1
 join OduncIslemler oi (nolock)  -- table 2
on k.Id=oi.KitapId

select * from OduncIslemler
--53 camdaki -- 2 �eker 
insert into OduncIslemler (KayitTarihi, KitapId, OduncAlinmaTarihi, OduncBitisTarihi, PersonelId, TeslimEttigiTarih, TeslimEttiMi, UyeId) values 
(getdate(), 53, getdate(), '2023-04-21 13:50:58.903',1,null,0,5),
(getdate(), 2, getdate(), '2023-05-21 13:50:58.903',1,null,0,2)
