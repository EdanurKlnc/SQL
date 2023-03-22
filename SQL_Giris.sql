 ---Database olusturma /F5
 --büyük kücük harfe duyarlý deðil. Ýstediðimiz gibi yazabiliriz
-- create database VeritabaniOlusturma
 
 use CafeDB
 create table CalisanTipleri(
 Id int not null identity(1,1) primary key,
 Tip_Adi nvarchar(50) not null
 ) 

 create table Calisanlar(
 Id int not null identity(1,1) primary key,
 Calisan_Tipi_Id int not null ,
 Eklenme_Tarihi datetime2(7) not null,
 IseBaslamaTarihi  datetime2(7) not null,
 Ad nvarchar(50) not null,
 Soyad nvarchar(50) not null,
 Dogum_Tarihi date,
 Cep char(10),
 AktifMi bit,
 )
 create table Cafe_Kat(
 Id int,
 CafeId int,
 KatId int,
 KatAcikMi bit,
 )
 alter table Cafe_Kat 
 Alter column CafeId  int not null
 alter table Cafe_Kat 
 Alter column KatId  int not null 
 alter table Cafe_Kat 
 Alter column KatAcikMi  bit not null

 alter table Cafe_Kat 
 Alter column Id  bit not null

 Alter table Cafe_Kat
 ADD CONSTRAINT PK_Cafe_Kat primary Key (Id);