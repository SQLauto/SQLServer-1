Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'STD - SQL Agent Auto Start', @description=N'', @facet=N'IServerSetupFacet', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>EQ</OpType>
  <Count>2</Count>
  <Attribute>
    <TypeClass>Numeric</TypeClass>
    <Name>AgentStartMode</Name>
  </Attribute>
  <Function>
    <TypeClass>Numeric</TypeClass>
    <FunctionType>Enum</FunctionType>
    <ReturnType>Numeric</ReturnType>
    <Count>2</Count>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>Microsoft.SqlServer.Management.Smo.ServiceStartMode</Value>
    </Constant>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>Auto</Value>
    </Constant>
  </Function>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'STD - SQL Agent Auto Start_ObjectSet', @facet=N'IServerSetupFacet', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'STD - SQL Agent Auto Start_ObjectSet', @type_skeleton=N'Server', @type=N'SERVER', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id




Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'STD - SQL Agent Auto Start', @condition_name=N'STD - SQL Agent Auto Start', @policy_category=N'Standard Configuration Check', @description=N'Checks that the SQL Agent is set to Auto Start
', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'STD - SQL Agent Auto Start_ObjectSet'
Select @policy_id


