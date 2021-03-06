Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'SEC - Check Pulic role permissions', @description=N'', @facet=N'Database', @expression=N'<Operator>
  <TypeClass>Bool</TypeClass>
  <OpType>EQ</OpType>
  <Count>2</Count>
  <Function>
    <TypeClass>Numeric</TypeClass>
    <FunctionType>ExecuteSql</FunctionType>
    <ReturnType>Numeric</ReturnType>
    <Count>2</Count>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>numeric</Value>
    </Constant>
    <Constant>
      <TypeClass>String</TypeClass>
      <ObjType>System.String</ObjType>
      <Value>SELECT COUNT(*)&lt;?char 13?&gt;
FROM sys.objects AS o&lt;?char 13?&gt;
LEFT JOIN sys.database_permissions AS p ON o.object_id = p.major_id &lt;?char 13?&gt;
JOIN sys.database_principals AS  pr 		ON p.grantee_principal_id = pr.principal_id&lt;?char 13?&gt;
WHERE o.type IN ( ''''U'''', ''''P'''', ''''SN'''', ''''FN'''' )&lt;?char 13?&gt;
AND pr.name = ''''Public''''&lt;?char 13?&gt;
AND o.is_ms_shipped = 0&lt;?char 13?&gt;
AND o.name NOT IN (&lt;?char 13?&gt;
''''sp_helpdiagrams'''',&lt;?char 13?&gt;
''''sp_helpdiagramdefinition'''',&lt;?char 13?&gt;
''''sp_creatediagram'''',&lt;?char 13?&gt;
''''sp_renamediagram'''',&lt;?char 13?&gt;
''''sp_alterdiagram'''',&lt;?char 13?&gt;
''''sp_dropdiagram'''',&lt;?char 13?&gt;
''''fn_diagramobjects''''&lt;?char 13?&gt;
)</Value>
    </Constant>
  </Function>
  <Constant>
    <TypeClass>Numeric</TypeClass>
    <ObjType>System.Double</ObjType>
    <Value>0</Value>
  </Constant>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'SEC - Check Pulic role permissions_ObjectSet', @facet=N'Database', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'SEC - Check Pulic role permissions_ObjectSet', @type_skeleton=N'Server/Database', @type=N'DATABASE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0



Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'SEC - Check Public role permissions', @condition_name=N'SEC - Check Pulic role permissions', @policy_category=N'Security', @description=N'checks if the public role has been given extra permissions', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'SEC - Check Pulic role permissions_ObjectSet'
Select @policy_id


