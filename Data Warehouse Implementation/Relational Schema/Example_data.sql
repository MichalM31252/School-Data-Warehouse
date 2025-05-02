INSERT INTO Student (PESEL, FullName, isCurrent, ParticipatesInExtraActivity) VALUES
('12345678901', 'Alice Kowalska', 1, 'participates'),
('12345678902', 'Bob Nowak', 1, 'does not participate'),
('12345678903', 'Celina Mazur', 0, 'participates'),
('12345678904', 'Daniel Wójcik', 1, 'participates'),
('12345678905', 'Ewa Kaczmarek', 1, 'does not participate'),
('12345678906', 'Filip Zieliński', 0, 'participates'),
('12345678907', 'Gosia Król', 1, 'does not participate'),
('12345678908', 'Hubert Wiśniewski', 1, 'participates'),
('12345678909', 'Iga Duda', 1, 'does not participate'),
('12345678910', 'Janusz Pawlak', 0, 'participates');

INSERT INTO Teacher (PESEL, FullName) VALUES
('22222222201', 'Maria Kowal'),
('22222222202', 'Piotr Grabowski'),
('22222222203', 'Anna Kamińska'),
('22222222204', 'Tomasz Zając'),
('22222222205', 'Natalia Nowicka'),
('22222222206', 'Krzysztof Wojciechowski'),
('22222222207', 'Joanna Kubiak'),
('22222222208', 'Marek Szymański'),
('22222222209', 'Agnieszka Lewandowska'),
('22222222210', 'Paweł Lis');

INSERT INTO Subject (SubjectName) VALUES
('math'),
('science'),
('history'),
('english'),
('art'),
('literature'),
('music'),
('physical education'),
('computer science'),
('geography');

INSERT INTO Class (ClassName, YearOfCreation) VALUES
('1A', 2021),
('2B', 2020),
('3C', 2019),
('4D', 2018),
('5E', 2017),
('6A', 2016),
('7B', 2015),
('8C', 2014),
('1D', 2023),
('2E', 2022);

INSERT INTO Semester (SemesterName) VALUES
('Summer2021'),
('Winter2021'),
('Summer2022'),
('Winter2022'),
('Summer2023'),
('Winter2023'),
('Summer2024'),
('Winter2024'),
('Summer2025'),
('Winter2025');

INSERT INTO Dates (Year, Month, MonthNo, Day, DayOfWeek, DayOfWeekNo, WorkingDay, Vacation, Holiday) VALUES
(2023, 'January', 1, 9, 'Monday', 1, 'Working day', 'Winter holiday', NULL),
(2023, 'February', 2, 14, 'Tuesday', 2, 'Working day', 'none', NULL),
(2023, 'March', 3, 8, 'Wednesday', 3, 'Working day', 'none', NULL),
(2023, 'April', 4, 1, 'Saturday', 6, 'day off', 'none', NULL),
(2023, 'May', 5, 1, 'Monday', 1, 'day off', 'none', 'Labour Day'),
(2023, 'June', 6, 10, 'Saturday', 6, 'day off', 'Summer holiday', NULL),
(2023, 'July', 7, 15, 'Saturday', 6, 'day off', 'Summer holiday', NULL),
(2023, 'August', 8, 20, 'Sunday', 7, 'day off', 'Summer holiday', NULL),
(2023, 'September', 9, 4, 'Monday', 1, 'Working day', 'none', NULL),
(2023, 'December', 12, 25, 'Monday', 1, 'day off', 'none', 'Christmas Day');

INSERT INTO Activity (ActivityType, ActivityName, Frequency, Location) VALUES
('sports', 'basketball', '3-5 times a week', 'Gymnasium'),
('sports', 'football', '1-2 times a week', 'Sports Field'),
('arts', 'painting classes', 'each week', 'Art Room'),
('volunteering', 'community cleanup', 'each month', 'Courtyard'),
('music', 'choir', '3-5 times a week', 'Music Room'),
('music', 'school band', '1-2 times a week', 'Auditorium'),
('sports', 'running', '6-7 times a week', 'Playground'),
('arts', 'chess club', 'each week', 'Library'),
('arts', 'painting classes', 'each month', 'Art Room'),
('sports', 'volleyball', '1-2 times a week', 'Gymnasium');

INSERT INTO Assignment (AssignmentName, AssignmentType) VALUES
('exam#1', 'exam'),
('homework#2', 'homework'),
('quiz#3', 'quiz'),
('project#4', 'project'),
('exam#5', 'exam'),
('homework#6', 'homework'),
('quiz#7', 'quiz'),
('project#8', 'project'),
('exam#9', 'exam'),
('homework#10', 'homework');

INSERT INTO StudentGrade (ID_Student, ID_Teacher, ID_Subject, ID_Date, ID_Semester, ID_Class, ID_Assignment, GradeValue, WeightOfGrade) VALUES
(1, 1, 1, 1, 1, 1, 1, 5.00, 3),
(2, 2, 2, 2, 2, 2, 2, 4.75, 2),
(3, 3, 3, 3, 3, 3, 3, 4.50, 1),
(4, 4, 4, 4, 4, 4, 4, 3.25, 4),
(5, 5, 5, 5, 5, 5, 5, 5.75, 6),
(6, 6, 6, 6, 6, 6, 6, 6.00, 3),
(7, 7, 7, 7, 7, 7, 7, 3.75, 2),
(8, 8, 8, 8, 8, 8, 8, 2.50, 1),
(9, 9, 9, 9, 9, 9, 9, 5.00, 5),
(10, 10, 10, 10, 10, 10, 10, 4.25, 2);

INSERT INTO StudentActivity (ID_Student, ID_Activity, ID_StartDate, ID_EndDate) VALUES
(1, 1, 1, 5),
(2, 2, 2, 6),
(3, 3, 3, 7),
(4, 4, 4, 8),
(5, 5, 5, 9),
(6, 6, 6, 10),
(7, 7, 7, 9),
(8, 8, 8, 10),
(9, 9, 9, 10),
(10, 10, 10, 10);
