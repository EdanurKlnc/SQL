--ORDER BY--
--Artan yada azalan s�ralama yapar
--ORDER BY ifadesinden Tek bir kolon varsa tek kolona g�re,birden �ok kolon varsa �nce ilki sonra di�erine g�re s�ralar

use OduncKitapDB
select * from Kitaplar order by StokAdeti --Stok adetine g�re s�ralama

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi

select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc --desc =tersten s�ralama 


select * from  Kitaplar
where KitapAdi like '%harry%'
order by KitapAdi desc , SayfaSayisi asc --asc = d�z s�ralama

select * from Kitaplar order by StokAdeti ,KitapAdi desc ,TurId --yazma s�ras�na g�re s�ralar
