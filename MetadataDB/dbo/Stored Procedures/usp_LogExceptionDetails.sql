
CREATE PROC [dbo].[usp_LogExceptionDetails] @PipelineName [VARCHAR](250),@PipelineID [VARCHAR](250),@Source [VARCHAR](300),@ActivityName [VARCHAR](250),@ActivityID [VARCHAR](250),@ErrorCode [VARCHAR](10),@ErrorDescription [VARCHAR](5000),@FailureType [VARCHAR](50),@ActivityStartTime [DATETIME],@PipelineStartTime [DATETIME],@BatchID [VARCHAR](100),@ErrorLoggedTime [DATETIME],@in_EntityName [VARCHAR](200) AS
BEGIN

INSERT INTO Audit.ExceptionLogDetails
(
[PipelineName],
[PipelineID],
[Source],
[ActivityName ],
[ActivityID ],
[ErrorCode ],
[ErrorDescription ],
[FailureType ],
[ActivityStartTime ],
[PipelineStartTime ],
[BatchID ],
[ErrorLogTime ],
EntityName
)
VALUES
(
@PipelineName ,
@PipelineID ,
@Source ,
@ActivityName ,
@ActivityID ,
@ErrorCode ,
@ErrorDescription ,
@FailureType ,
@ActivityStartTime ,
@PipelineStartTime ,
@BatchID ,
@ErrorLoggedTime,
@in_EntityName
)

/*Update IsRestart flag to 1 for any exception*/

UPDATE Config.ConfigurationDetails
SET IsRestart=1
WHERE  EntityName=@in_EntityName

UPDATE Audit.Pipelinestatusdetails
SET PipelineStatus='Failure'
WHERE  EntityName=@in_EntityName AND PipelineStatus='CopyToADLS Completed'

END
