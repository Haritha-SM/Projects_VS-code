-- CREATE TABLE
CREATE TABLE job_applied(
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

-- Add values into the Table
INSERT INTO job_applied
            (job_id,
            application_sent_date,
            custom_resume,
            resume_file_name,
            cover_letter_sent,
            cover_letter_file_name,
            status)
VALUES      (1,
             '2024-02-01',
             true,
             'reume_01.pdf',
             true,
             'cover_letter_01.pdf',
             'submitted'),
             (2,
             '2024-02-02',
             false,
             'reume_02.pdf',
             false,
             NULL,
             'interview scheduled'),
             (3,
             '2024-02-03',
             true,
             'reume_03.pdf',
             true,
             'cover_letter_03.pdf',
             'ghosted'),
             (4,
             '2024-02-04',
             true,
             'reume_04.pdf',
             false,
             NULL,
             'submitted'),
             (5,
             '2024-02-05',
             false,
             'reume_05.pdf',
             true,
             'cover_letter_05.pdf',
             'rejected');


-- Alter Table Add, Rename column, Alter Column, Delete Column, Delete Table
ALTER TABLE job_applied
ADD contact VARCHAR(50);

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN column_name;

DROP TABLE table_name;


-- UPDATE data in a table
UPDATE job_applied
SET     contact = 'Erlich Bachman'
WHERE   job_id = 1;

UPDATE job_applied
SET     contact = 'Dinesh Chugtai'
WHERE   job_id = 2;

UPDATE job_applied
SET     contact = 'Bertram Gilfoyle'
WHERE   job_id = 3;

UPDATE job_applied
SET     contact = 'Jian Yang'
WHERE   job_id = 4;

UPDATE job_applied
SET     contact = 'Big Head'
WHERE   job_id = 5;



SELECT *
FROM job_applied;
