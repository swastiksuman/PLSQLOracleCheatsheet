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