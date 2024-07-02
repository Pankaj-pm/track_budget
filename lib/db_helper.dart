
/*

CREATE TABLE "track_budget" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT,
	"category"	INTEGER NOT NULL,
	"type"	INTEGER NOT NULL,
	"amount"	REAL NOT NULL,
	"date"	TEXT NOT NULL,
	"user_id"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);



// get all data
`SELECT * FROM `student`;

get single record
SELECT * FROM `student` WHERE email==harsh@gmail.com


add data to table
INSERT INTO `student` (`name`,...) VALUES ('abc',..)
INSERT INTO "track_budget"("id","name","category","type","amount","date","user_id") VALUES (1,NULL,0,0,'','',0);

update data to table
UPDATE `student` SET `name`='xyz',` WHERE 1
UPDATE "track_budget" SET "date"="10-5-2025" WHERE "id"='1'


delete or remove record from table
DELETE FROM `student` WHERE mark<30


* */