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
