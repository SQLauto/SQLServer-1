Declare @condition_id int
EXEC msdb.dbo.sp_syspolicy_add_condition @name=N'REG - Orphan User Count', @description=N'', @facet=N'Database', @expression=N'<Operator>
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
      <Value>SELECT  COUNT (*)&lt;?char 13?&gt;
FROM    sys.sysusers&lt;?char 13?&gt;
WHERE   sid IS NOT NULL&lt;?char 13?&gt;
        AND sid &lt;&gt; 0X0&lt;?char 13?&gt;
        AND islogin = 1&lt;?char 13?&gt;
        AND sid NOT IN ( SELECT sid&lt;?char 13?&gt;
                         FROM   sys.syslogins )</Value>
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
EXEC msdb.dbo.sp_syspolicy_add_object_set @object_set_name=N'REG - Orphan User Count_ObjectSet', @facet=N'Database', @object_set_id=@object_set_id OUTPUT
Select @object_set_id

Declare @target_set_id int
EXEC msdb.dbo.sp_syspolicy_add_target_set @object_set_name=N'REG - Orphan User Count_ObjectSet', @type_skeleton=N'Server/Database', @type=N'DATABASE', @enabled=True, @target_set_id=@target_set_id OUTPUT
Select @target_set_id

EXEC msdb.dbo.sp_syspolicy_add_target_set_level @target_set_id=@target_set_id, @type_skeleton=N'Server/Database', @level_name=N'Database', @condition_name=N'', @target_set_level_id=0



Declare @policy_id int
EXEC msdb.dbo.sp_syspolicy_add_policy @name=N'REG - Orphan User Count', @condition_name=N'REG - Orphan User Count', @policy_category=N'Regular Health Check', @description=N'Gather more details via:

SELECT  name ,
        createdate ,
        ( CASE WHEN isntgroup = 0
                    AND isntuser = 0 THEN ''SQL LOGIN''
               WHEN isntgroup = 1 THEN ''NT GROUP''
               WHEN isntgroup = 0
                    AND isntuser = 1 THEN ''NT LOGIN''
          END ) [LOGIN TYPE]
FROM    sys.sysusers
WHERE   sid IS NOT NULL
        AND sid <> 0X0
        AND islogin = 1
        AND sid NOT IN ( SELECT sid
                         FROM   sys.syslogins );', @help_text=N'', @help_link=N'', @schedule_uid=N'00000000-0000-0000-0000-000000000000', @execution_mode=0, @is_enabled=False, @policy_id=@policy_id OUTPUT, @root_condition_name=N'', @object_set=N'REG - Orphan User Count_ObjectSet'
Select @policy_id


