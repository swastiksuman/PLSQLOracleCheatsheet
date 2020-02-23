--Declaration of Variables
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
    
    
    
DECLARE

i_dept_id departments.dept_id%TYPE;
i_dept_name departments.dept_name%TYPE;
BEGIN
    select dept_id, dept_name INTO i_dept_id, i_dept_name from departments where dept_id >2;
    IF SQL%FOUND THEN 
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT);
    END IF;
END;

