--- делаем бд текущей
USE DB_Test

-- создание таблицы с двумя полями
 CREATE TABLE NEW (ID INT NOT NULL, name VARCHAR(30) NOT NULL)

-- большие сомнения у меня в корректности оформления следующих 20(!!) строк кода
INSERT INTO NEW (ID, name)
	VALUES (1, 'запись 1')
INSERT INTO NEW (ID, name)
	VALUES (2, 'запись 2')
INSERT INTO NEW (ID, name)
	VALUES (3, 'запись 3')
INSERT INTO NEW (ID, name)
	VALUES (4, 'запись 4')
INSERT INTO NEW (ID, name)
	VALUES (5, 'запись 5')
INSERT INTO NEW (ID, name)
	VALUES (6, 'запись 6')
INSERT INTO NEW (ID, name)
	VALUES (7, 'запись 7')
INSERT INTO NEW (ID, name)
	VALUES (8, 'запись 8')
INSERT INTO NEW (ID, name)
	VALUES (9, 'запись 9')
INSERT INTO NEW (ID, name)
	VALUES (10, 'запись 10')

--select * from [NEW]
SELECT COUNT(*) FROM [NEW]

-- создание ролей
CREATE ROLE r_reader
CREATE ROLE r_writer

-- назначение привилегий на роли
GRANT SELECT ON [dbo].[NEW] TO [r_reader]
GRANT INSERT, UPDATE ON [dbo].[NEW] TO [r_writer]

--создане логинов и назначение ролей на них
CREATE USER [u_reader] FOR LOGIN [u_reader]
ALTER ROLE [r_reader] ADD MEMBER [u_reader]

CREATE USER [u_writer] FOR LOGIN [u_writer]
ALTER ROLE [r_writer] ADD MEMBER [u_writer]
