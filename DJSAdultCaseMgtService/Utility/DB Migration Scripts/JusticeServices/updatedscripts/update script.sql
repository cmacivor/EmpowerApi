update  enrollment set enddate=null where enddate ='1900-01-01'
go
update  enrollment set begindate=null where begindate ='1900-01-01'
go
update servicecategory set active=1 where
name ='Community Based' or

name ='Group' or

name ='Monitoring/Surveillance'or

name='detention' or
name='in-home' or
name='Secure Confinement'
go
update serviceprogram set active=1 where name = 'Community Monitoring' or
name ='Community Service Hourly' or
name ='Community Service Weekend' or

name ='Detention' or
name ='Family Ties' or
name ='Evening Reporting Center (ERC)' or
name ='Law Related Education'or
name ='Outreach Phase II' or
name ='Post-D' or
name ='Re-entry' or
name ='Traffic Community Service' or
name='Juvenile Behavioral Health Docket (JBHD)'
go

UPDATE [JusticeServices].[dbo].[serviceprogramcategory]
set Active = (select Active from [JusticeServices].[dbo].serviceprogram
where [JusticeServices].[dbo].serviceprogramcategory.serviceprogramid = [JusticeServices].[dbo].[serviceprogram].id)




