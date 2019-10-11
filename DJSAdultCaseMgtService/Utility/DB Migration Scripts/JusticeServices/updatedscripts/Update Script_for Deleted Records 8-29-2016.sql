


begin transaction
update clientprofile set active=1 where id in (select c.id from clientprofile c,person p where c.updatedby='geratytf' and p.lastname='smith' and p.id=c.personid and dob > '1995-06-01 00:00:00.000' and c.updateddate='2016-06-28 12:31:13.960' )

commit



