Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'DAILY - Backups Full in last 25 hours', @description=N'', @facet=N'Database', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>GE</OpType>
  <Count>2</Count>
  <Attribute>
    <TypeClass>DateTime</TypeClass>
    <Name>LastBackupDate</Name>
  </Attribute>
  <Function>
    <TypeClass>DateTime</TypeClass>
    <FunctionType>DateAdd</FunctionType>
    <ReturnType>DateTime</ReturnType>
    <Count>3</Count>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>HH</Value>
    </Constant>
    <Constant>
      <TypeClass>Numeric</TypeClass>
      <ObjType>System.Double</ObjType>
      <Value>-25</Value>
    </Constant>
    <Function>
      <TypeClass>DateTime</TypeClass>
      <FunctionType>GetDate</FunctionType>
      <ReturnType>DateTime</ReturnType>
      <Count>0</Count>
    </Function>
  </Function>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'DAILY - Backups Full in last 25 hours_ObjectSet', @facet=N'Database', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'DAILY - Backups Full in last 25 hours_ObjectSet', @type_skeleton=N'Server/Database', @type=N'DATABASE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0



Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'DAILY - Backups Full in last 25 hours', @condition_name=N'DAILY - Backups Full in last 25 hours', @policy_category=N'Daily Health Check', @description=N'Checks that each databsae has had a full backup in the last 25 hours', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'DAILY - Backups Full in last 25 hours_ObjectSet'
Select @policy_id


