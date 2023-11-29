CREATE TYPE roleTypes AS ENUM('VIEWER', 'EDITOR', 'ADMIN', 'OWNER');

CREATE TABLE role (
	id SERIAL PRIMARY KEY NOT NULL,
	title VARCHAR(256) NOT NULL,
	description VARCHAR(256) NOT NULL,
	roleType roleTypes NOT NULL
);

CREATE TABLE company (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(256) NOT NULL
);

CREATE TABLE auth_user (
	id SERIAL PRIMARY KEY NOT NULL,
	login VARCHAR(256) NOT NULL,
	password VARCHAR(256) NOT NULL,
	salt VARCHAR(256) NOT NULL,
	email VARCHAR(256) NOT NULL
);

CREATE TABLE tokens (
	id SERIAL PRIMARY KEY NOT NULL,
	userId INT NOT NULL,
	token VARCHAR(256) NOT NULL,
	FOREIGN KEY(userId) REFERENCES auth_user(id)
);

CREATE TABLE employeeAccount (
    id SERIAL PRIMARY KEY NOT NULL,
	userId INT NOT NULL,
	companyId INT NOT NULL,
    firstName VARCHAR(256) NOT NULL,
	secondName VARCHAR(256) NOT NULL,
    surname VARCHAR(256) NOT NULL,
    telephoneNumber VARCHAR(256) NOT NULL,
	avatarUrl VARCHAR(256) NOT NULL,
	dateOfBirth DATE NOT NULL,
	job VARCHAR(256) NOT NULL,
	UNIQUE (userId, companyId),
	FOREIGN KEY(userId) REFERENCES auth_user(id),
	FOREIGN KEY(companyId) REFERENCES company(id)
);

CREATE TABLE department (
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(256) NOT NULL,
	parentDepartmentId INT,
	companyId INT NOT NULL,
	supervisorId INT NOT NULL,
	FOREIGN KEY(parentDepartmentId) REFERENCES department(id),
	FOREIGN KEY(companyId) REFERENCES company(id),
	FOREIGN KEY(supervisorId) REFERENCES employeeAccount(id)
);

CREATE TABLE employee_roles (
	accountId INT NOT NULL,
	roleId INT NOT NULL,
    FOREIGN KEY(accountId) REFERENCES employeeAccount(id),
    FOREIGN KEY(roleId) REFERENCES role(id),
	PRIMARY KEY(accountId, roleId)
);

CREATE TABLE employee_department (
	accountId INT NOT NULL,
	departmentId INT NOT NULL,
    FOREIGN KEY(accountId) REFERENCES employeeAccount(id),
	FOREIGN KEY(departmentId) REFERENCES department(id),
	PRIMARY KEY (accountId, departmentId)
);