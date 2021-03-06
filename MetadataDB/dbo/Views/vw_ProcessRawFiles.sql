CREATE VIEW [dbo].[vw_ProcessRawFiles]
AS
select ra.[File_Name],ra.[File_Time],ra.[Source],ra.[DataDomain]   from 
(select [File_Name],[File_Time],[Status_Flag],[Source],[DataDomain] from [dbo].[Log_DataFeedRepository] where Status_Flag =1)ra
left join
(select [File_Name],[File_Time],[Status_Flag],[Source],[DataDomain] from [dbo].[Log_DataFeedRepository] where Status_Flag =2)stg
on ra.[File_Name] = stg.[File_Name]
WHERE ra.Status_Flag =1 and stg.Status_Flag IS NULL --and ra.DataDomain = 'Material' 
