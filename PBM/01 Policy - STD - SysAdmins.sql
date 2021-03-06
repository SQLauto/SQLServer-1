Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'STD - SysAdmins', @description=N'', @facet=N'IServerSecurityFacet', @expression=N'<Operator>
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
      <Value>SELECT COUNT(*) &lt;?char 13?&gt;
FROM sys.server_principals&lt;?char 13?&gt;
WHERE IS_SRVROLEMEMBER (''''sysadmin'''',name) = 1&lt;?char 13?&gt;
AND type_desc != ''''CERTIFICATE_MAPPED_LOGIN''''&lt;?char 13?&gt;
AND type_desc != ''''SERVER_ROLE''''&lt;?char 13?&gt;
AND name NOT LIKE ''''NT service%'''' &lt;?char 13?&gt;
AND name NOT LIKE ''''NT AUTHORITY%'''' &lt;?char 13?&gt;
AND name NOT LIKE ''''##MS_%''''&lt;?char 13?&gt;
AND is_disabled = 0 &lt;?char 13?&gt;
</Value>
    </Constant>
  </Function>
  <Constant>
    <TypeClass>Numeric</TypeClass>
    <ObjType>System.Double</ObjType>
    <Value>1</Value>
  </Constant>
</Operator>', @is_name_condition=0, @obj_name=N'', @condition_id=@condition_id OUTPUT
Select @condition_id


Declare @object_set_id int
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'STD - SysAdmins_ObjectSet', @facet=N'IServerSecurityFacet', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'STD - SysAdmins_ObjectSet', @type_skeleton=N'Server', @type=N'SERVER', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id




Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'STD - SysAdmins', @condition_name=N'STD - SysAdmins', @policy_category=N'Standard Configuration Check', @description=N'Counts the number of user accounts that are SysAdmin.', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'STD - SysAdmins_ObjectSet'
Select @policy_id


