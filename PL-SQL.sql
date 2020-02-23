--Anonymous Block
--Declaration of Variables
DECLARE
	I_Counter NUMBER;
/*
Execution Block
*/
BEGIN
	I_Counter:=0;
EXCEPTION
	WHEN OTHERS THEN
	null;
END;

--LOOP WITH GOTO
DECLARE
    I_Counter NUMBER:=0;
/*
Execution Block
*/
BEGIN	
    LOOP
    I_Counter:=I_Counter+1;
    dbms_output.put_line('NUMBER ' || I_Counter);
    IF I_Counter > 9 THEN
        GOTO out_of_loop;
    END IF;
    END LOOP;
    <<out_of_loop>>
    null;
END;

--FOR LOOP IN PLSQL
DECLARE
    I_Counter NUMBER:=0;
/*
Execution Block
*/
BEGIN	
    FOR loop_counter in 1..10 LOOP
    I_Counter:=I_Counter+1;
        If MOD(I_Counter, 2) =0 THEN
            dbms_output.put_line('NUMBER ' || I_Counter);
        END IF;
    END LOOP;
    <<out_of_loop>>
    null;
END;

create table departments (dept_id NUMBER NOT NULL PRIMARY KEY, dept_name varchar2(60));

create table employee (emp_id number not null primary key, emp_name varchar2(60), emp_dept_id NUMBER, emp_loc varchar2(60), emp_sal NUMBER,
    CONSTRAINT emp_dept_fk foreign key(emp_dept_id) references departments(dept_id));
commit;    
    
/*
IMPLICIT CURSOR
*/
DECLARE

i_dept_id departments.dept_id%TYPE;
i_dept_name departments.dept_name%TYPE;
BEGIN
    select dept_id, dept_name INTO i_dept_id, i_dept_name from departments where dept_id >2;
    IF SQL%FOUND THEN 
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    END IF;
END;

/*
Explicit Cursor - Single Row Assignment
*/
DECLARE
    I_dept_id departments.dept_id%TYPE;
    I_dept_name departments.dept_name%TYPE;
    
    CURSOR cur_get_departments IS
        select dept_id, dept_name from departments where dept_id=1;
    
    BEGIN
        open cur_get_departments;
        fetch cur_get_departments
            into I_dept_id, I_dept_name;
         dbms_output.put_line(I_dept_id || ' ' || I_dept_name);
         close cur_get_departments;
    END;     

/*
EXPLICIT CURSOR - MULTI ROW SELECT
*/
DECLARE
    CURSOR cur_get_employees IS
        select emp_id, emp_sal * 0.11 bonus from employee;
    cur_get_employees_var cur_get_employees%ROWTYPE; --ROWTYPE
    BEGIN
        open cur_get_employees;
        loop
            fetch cur_get_employees into cur_get_employees_var;
            exit when cur_get_employees%NOTFOUND; --and also cur_get_employees%FOUND
            dbms_output.put_line(cur_get_employees_var.emp_id || ' ' || cur_get_employees_var.bonus);
            dbms_output.put_line(cur_get_employees%ROWCOUNT); --Current ROW NUM
        end loop;
    If cur_get_employees%ISOPEN THEN    
        close cur_get_employees;
    End If;    
END;    

/*
Cursor Parameters
*/

DECLARE
    CURSOR cur_get_employees(p_rows NUMBER DEFAULT 5) IS
        select emp_id, emp_sal * 0.11 bonus from employee where rownum <=p_rows;
    cur_get_employees_var cur_get_employees%ROWTYPE; --ROWTYPE
    BEGIN
        open cur_get_employees(3);
        loop
            fetch cur_get_employees into cur_get_employees_var;
            exit when cur_get_employees%NOTFOUND; --and also cur_get_employees%FOUND
            dbms_output.put_line(cur_get_employees_var.emp_id || ' ' || cur_get_employees_var.bonus);
            dbms_output.put_line(cur_get_employees%ROWCOUNT); --Current ROW NUM
        end loop;
    If cur_get_employees%ISOPEN THEN    
        close cur_get_employees;
    End If;    
END;    