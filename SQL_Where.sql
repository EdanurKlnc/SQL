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
