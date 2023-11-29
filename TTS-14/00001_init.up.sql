CREATE TYPE rights_t AS ENUM('view', 'edit employee', 'edit department', 'edit roles');

CREATE TABLE roles (
	id SERIAL PRIMARY KEY NOT NULL,
	role_name VARCHAR(128) NOT NULL,
	description VARCHAR(255) NOT NULL,
	rights rights_t NOT NULL
);

CREATE TABLE employee (
    id UUID PRIMARY KEY NOT NULL,
	id_department INT,
	id_role INT NOT NULL,
    employee_name VARCHAR(128) NOT NULL,
    surname VARCHAR(128) NOT NULL,
    patronymic VARCHAR(128) NOT NULL,
	birthday DATE NOT NULL,
	email TEXT NOT NULL
);

CREATE TABLE department (
	id SERIAL PRIMARY KEY NOT NULL,
	id_department_parent INT,
	department_name VARCHAR(128) NOT NULL,
	id_employee_supervisor UUID NOT NULL,
	CONSTRAINT fk_department
		FOREIGN KEY(id_department_parent)
		REFERENCES department(id),
	CONSTRAINT fk_employee
		FOREIGN KEY(id_employee_supervisor)
		REFERENCES employee(id)
);

CREATE TABLE employee_role (
	id_employee UUID NOT NULL,
	id_role INT NOT NULL,
	CONSTRAINT fk_employee
        FOREIGN KEY(id_employee)
        REFERENCES employee(id),
	CONSTRAINT fk_role
        FOREIGN KEY(id_role)
        REFERENCES roles(id)
);

CREATE TABLE employee_department (
	id_employee UUID NOT NULL,
	id_department INT NOT NULL,
	CONSTRAINT fk_employee
        FOREIGN KEY(id_employee)
        REFERENCES employee(id),
	CONSTRAINT fk_department
        FOREIGN KEY(id_department)
        REFERENCES department(id)
);