-- create database ABD_SQL_Assignment_1

-- need to give it a better name?
create table organisation_units (

    ou_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,

)

-- need to give it a better name?
create table sub_organisation_units (

    sou_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    ou_PK char(15) unique not NUll,

    FOREIGN KEY (ou_PK) REFERENCES organisation_units(ou_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table staff (

    staff_PK char(15) PRIMARY key not NUll,
    staff_ID char(15) unique not NUll,
    ou_PK char(15) unique not NUll,
    sou_PK_PK char(15) unique not NUll,

    FOREIGN KEY (ou_PK) REFERENCES sub_organisation_units(ou_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (sou_PK) REFERENCES organisation_units(sou_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table course_cord (

    cc_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    staff_pk char(15) unique not NUll,

    FOREIGN KEY (staff_pk) REFERENCES staff(staff_pk) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table program_convin (

    pc_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    staff_pk char(15) unique not NUll,

    FOREIGN KEY (staff_pk) REFERENCES staff(staff_pk) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table acad_program (

    acad_pro_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,

)

create table major_minor (

    major_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    acad_pro_PK char(15) unique not NUll,

    FOREIGN KEY (acad_pro_PK) REFERENCES acad_program(acad_pro_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table locations (

    loc_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,

)


create table faclilties (

    fac_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    loc_PK char(15) unique not NUll,

    FOREIGN KEY (loc_PK) REFERENCES locations(loc_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table sems_period (

    sp_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,

)


create table course (

    cor_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    sp_PK char(15) unique not NUll,
    fac_PK char(15) unique not NUll,

    FOREIGN KEY (sp_PK) REFERENCES sems_period(sp_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,
    FOREIGN KEY (fac_PK) REFERENCES faclilties(fac_PK) ON UPDATE NO ACTION ON DELETE NO ACTION,

)

create table student (

    stu_PK char(15) PRIMARY key not NUll,
    _ID char(15) unique not NUll,
    stu_no char(15) unique not NUll,

    -- FKs to courses they are doing or some shit

)