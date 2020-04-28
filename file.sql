Create table dbo.Students
(
     Id int primary key identity,
     StudentName nvarchar(50)
)
Go

Create table dbo.Courses
(
     Id int primary key identity,
     CourseName nvarchar(50)
)
Go

Create table dbo.StudentCourses
(
     StudentId int not null foreign key references Students(Id),
     CourseId int not null foreign key references Courses(Id)
)
GO


Alter table dbo.StudentCourses
Add Constraint PK_StudentCourses
Primary Key Clustered (CourseId, StudentId)


Declare @StudentName nvarchar(50) = 'Gary'
Declare @CourseName nvarchar(50) = 'SQL Server'

Declare @StudentId int
Declare @CourseId int

-- If the student already exists, use the existing student ID
Select @StudentId = Id from dbo.Students where StudentName = @StudentName
-- If the course already exists, use the existing course ID
Select @CourseId = Id from dbo.Courses where CourseName = @CourseName

SELECT @StudentId
SELECT @CourseId



-- If the student does not exist in the Students table
If (@StudentId is null)
Begin
     -- Insert the student
     Insert into Students values(@StudentName)
     -- Get the Id of the student
     Select @StudentId = SCOPE_IDENTITY()  -- returns scoped row id of the new row inserted
End

-- If the course does not exist in the Courses table
If (@CourseId is null)
Begin
     -- Insert the course
     Insert into Courses values(@CourseName)
     -- Get the Id of the course
     Select @CourseId = SCOPE_IDENTITY()
End

-- Insert StudentId & CourseId in StudentCourses table

BEGIN TRY
Insert into StudentCourses values(@StudentId, @CourseId)
END TRY
BEGIN CATCH
PRINT ERROR_MESSAGE()
END CATCH
