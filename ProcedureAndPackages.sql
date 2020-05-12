CREATE OR REPLACE PROCEDURE update_dept AS
    I_emp_id employee.emp_id%TYPE:=1;
BEGIN
    UPDATE employee
        set emp_dept_id=2 where emp_id=I_emp_id;
    commit;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        ROLLBACK;
        RAISE;
END update_dept;

CREATE OR REPLACE PROCEDURE GIVE_HIKE AS

BEGIN 
  FOR cur_get_employees_var in (select emp_id from employee) LOOP
    update employee set emp_sal = emp_sal * 1.1 where emp_id = cur_get_employees_var.emp_id;
  END LOOP;
  commit;
END;  

execute GIVE_HIKE