create login usuarioSistema2
with password = 'P@ssw0rd'

create user usuarioSistema2 for login usuarioSistema2

Exec sp_addrolemember 'db_datareader' , 'usuarioSistema2'
Exec sp_addrolemember 'db_datawriter' , 'usuarioSistema2'

Exec sp_addrolemember 'db_datareader' , 'usuario_Sistema'
Exec sp_addrolemember 'db_datawriter' , 'usuario_Sistema'