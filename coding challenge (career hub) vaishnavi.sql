1.Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
2. Create tables for Companies, Jobs, Applicants and Applications. 
3. Define appropriate primary keys, foreign keys, and constraints. 
4. Ensure the script handles potential errors, such as if the database or tables already exist

create database CareerHub;
use Careerhub;


Create Table Companies(
CompanyID int primary key auto_increment,
CompanyName Varchar(30),
Location varchar (30));

Create Table Jobs(
JobID INT PRIMARY KEY AUTO_INCREMENT,
CompanyID INT,
JobTitle varchar(50)not null,
JobDescription Text,
JoblOcation varchar (50) not null,
Salary Decimal(10,2) check(salary>=0),
JobType Varchar(50) not null,
PostedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
foreign key (CompanyID) references COMPANIES(CompanyID) on Delete cascade);

create table applicants (
ApplicantID int Primary Key auto_increment,
 FirstName varchar (250),
 LastName varchar (250),
Email varchar (250),
Phone varchar (250),
 Resume text );
 
 
 Create Table Applications(
 ApplicationID int Primary Key auto_increment,
 JobID int ,
  ApplicantID  int,
  ApplicationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
  CoverLetter text,
  foreign key (JobID ) references Jobs(JobID ) on Delete cascade,
  foreign key ( ApplicantID ) references applicants( ApplicantID ) on Delete cascade
  );
  
  
INsert into  companies(CompanyName,Location) values 
('Hexaware','Mumbai') ,
('tcs','pune'),
('CyberEdge','Banglore');

Insert into jobs(CompanyId,JobTitle,JobDescription,JobLocation,salary,JobType) Values 
(1,'Software Developer','Develop Software Application','Mumbai',70000,'Full-time'),
(2,'Data Analyst','Analyze company data','Pune',65000,'Fulltime'),
(3,'Cybersecurity engineer','Protect company Networks ','Banglore',80000,'Fulltime');


insert into applicants (Firstname ,lastname,Email,Phone,Resume)Values
('Vaishnavi','Patil','Vaishnavi@exmp.com',8976543210,'Experience software developer'),
('john','doe','John@ernut.com',4526788890,'good in data analysist'),
('Ram','Sharma','Ram123@ecxg.com',6543217891,'cybersequrity expert'); 
 
 
 insert into applications (JobID ,ApplicantID,CoverLetter) values
 (1,1,'I am excited to apply .'),
 (2,2,'Looking Forward for the new opportunity'),
 (3,3,'Passionate about cybersequrity');
 
 
 select * from applications ;
 
 
 
 Write an SQL query to count the number of applications received for each job listing in the 
"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all 
jobs, even if they have no applications.
 --
 Select j.jobtITLE,COUNT(A.APPLICATIONid) 
 as applicationcount 
 from jobs j
 left join applications a on j.jobID = a.jobID
 group by j.jobtITLE;
-- 
Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary 
range. Allow parameters for the minimum and maximum salary values. Display the job title, 
company name, location, and salary for each matching job.

 Select j.jobTitle,c.CompanyName,j.jobLocation,j.salary
 from jobs j
 join companies c on j.companyID = c.CompanyID
 where j.salary between 50000 and 90000;
 --
 Write an SQL query that retrieves the job application history for a specific applicant. Allow a 
parameter for the ApplicantID, and return a result set with the job titles, company names, and 
application dates for all the jobs the applicant has applied to


 Select j.jobTitle,c.CompanyName,a.applicationDate
 from applications a
 join jobs j on a.jobID = j.JobiD 
 JOIN Companies c on j.companyid = c.CompanyId
 where a.ApplicantID = 2;
 
 Create an SQL query that calculates and displays the average salary offered by all companies for 
job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.
 
Select AVG(Salary) AVGSALARY 
from jobs 
where salary>0;

Write an SQL query to identify the company that has posted the most job listings. Display the 
company name along with the count of job listings they have posted. Handle ties if multiple 
companies have the same maximum count.


SELECT C.COMPANYname , count(j.jobID) as jobCount
from companies c
join  jobs j on c.companyID = J.companyID
group by c.companyID,c.COMPANYname
order by JobCount desc;

Find the applicants who have applied for positions in companies located in 'CityX' and have at 
least 3 years of experience.

select distinct a.firstName,a.LastName,a.Email 
from 
applications ap
join jobs j on ap.jobID = J.jobID
join companies c on j.companyID=c.companyID
where c.Location = 'mumbai' and a.Resume like '%3YEARS%';


Find the jobs that have not received any applications
select jobTitle 
from jobs j
left join applications a on j.Jobid=a.jobID
where a.applicationID is null;


--
Retrieve a list of distinct job titles with salaries between $60,000 and $80,000
select distinct jobTitle
from jobs 
where salary between 60000 and 80000;

Retrieve a list of job applicants along with the companies they have applied to and the positions 
they have applied for.

select a.firstname,a.lastname,c.companyname,j.jobtitle
from applications ap 
join applicants a on ap.applicantid=a.applicantid
join Jobs j on ap.jobID=j.jobID
join companies c on j.companyID=c.CompanyID;

Find companies that have posted jobs with a salary higher than the average salary of all jobs.

select distinct c.companyName
from companies c
join jobs j on c.companyID = j.companyID
where j.salary>(select avg(salary)from jobs where salary>0);

Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.
select jobTitle
from jobs 
where jobTitle like '%Developer%' or jobTitle like '%Engineer%';
 Retrieve a list of applicants and the jobs they have applied for, including those who have not 
applied and jobs without applicants.
select a.Firstname,a.Lastname,j.jobTitle
from applicants a 
left join applications ap on a.applicantid=ap.applicantid
left join jobs j on ap.jobID = j.JobID;


List all combinations of applicants and companies where the company is in a specific city and the 
applicant has more than 2 years of experience. For example: city=Chenna

select a.Firstname,a.Lastname,c.Companyname
from applicants a 
cross join companies c 
where c.location='banglore'


