--ORDER BY--
--Artan yada azalan sýralama yapar
--ORDER BY ifadesinden Tek bir kolon varsa tek kolona göre,birden çok kolon varsa önce ilki sonra diðerine göre sýralar

use OduncKitapDB
select * from Kitaplar order by StokAdeti --Stok adetine göre sýralama

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc --desc =tersten sýralama 


select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc , SayfaSayisi asc --asc = düz sýralama

select * from Kitaplar order by StokAdeti ,KitapAdi desc ,TurId --yazma sýrasýna göre sýralar
