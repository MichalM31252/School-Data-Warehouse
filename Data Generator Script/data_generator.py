import random
import string
import pandas as pd
import names
from datetime import datetime, timedelta
import numpy as np
import os

base_path = r"C:\Users\Michal\Desktop\warehouses\warehouses"  # Your working directory

def generate_random_pesel():
    return ''.join(random.choices(string.digits, k=11))

def generate_random_date(start_year=2020, end_year=2025):
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    delta_days = (end_date - start_date).days
    random_days = random.randint(0, delta_days)
    return start_date + timedelta(days=random_days)

def generate_random_datetime_in_semester(semester_start, semester_end):
    delta = (semester_end - semester_start).days
    random_offset = random.randint(0, delta)
    return semester_start + timedelta(days=random_offset,
                                      hours=random.randint(0, 23),
                                      minutes=random.randint(0, 59))

def generate_random_grade():
    valid_values = np.arange(1.0, 6.1, 0.25)
    return float(random.choice(valid_values))

def generate_random_weight():
    return random.randint(0, 6)

def random_assignment_name():
    prefix = random.choice(["Homework", "Quiz", "Project", "Test", "Exam"])
    return f"{prefix}"

class_ids = []
def generate_class():
    prefix = random.choice(["1", "2", "3", "4", "5", "6", "7", "8"])
    suffix = random.choice(["A", "B", "C", "D", "E"])
    class_ids.append(f"{prefix}{suffix}")
    return f"{prefix}{suffix}"

def generate_phone_number():
    return f"+48{random.randint(100000000, 999999999)}"

subjects_list = [
    'Math', 'Science', 'History', 'English', 'Art', 'Literature',
    'Music', 'Physical Education', 'Computer Science', 'Geography', 'Biology'
]

activity_types = ["sports", "arts", "volunteering", "music", "debate club"]
activity_names = ["Basketball", "Choir", "Community Cleanup", "School Band", "Chess Club"]
locations = ["School Gym", "Art Room", "Local Park", "Auditorium", "Online"]

def get_data_snapshot_T1(num_students, num_teachers):
    # STUDENTS
    student_data = []
    for _ in range(num_students):
        pesel = generate_random_pesel()
        fname = names.get_first_name()
        lname = names.get_last_name()
        guardian_contact = random.choice([generate_phone_number(), f"{lname.lower()}@gmail.com"])
        class_id = generate_class()

        student_data.append({
            "PESEL": pesel,
            "FirstName": fname,
            "LastName": lname,
            "GuardianContact": guardian_contact,
            "ClassID": class_id
        })

    df_students = pd.DataFrame(student_data)

    # TEACHERS
    teacher_data = []
    for _ in range(num_teachers):
        pesel = generate_random_pesel()
        fname = names.get_first_name()
        lname = names.get_last_name()
        teacher_data.append({
            "PESEL": pesel,
            "FirstName": fname,
            "LastName": lname
        })
    df_teachers = pd.DataFrame(teacher_data)

    # CLASS
    class_data = []
    year_base = 2024
    for num in range(1, 9):
        for letter in ['A', 'B', 'C', 'D', 'E']:
            class_id = f"{num}{letter}"
            year_of_creation = year_base - (num - 1)
            class_data.append({
                "ClassID": class_id,
                "YearOfCreation": year_of_creation
            })
    df_class = pd.DataFrame(class_data)

    # SUBJECT
    subject_data = []
    for i, subj in enumerate(subjects_list, start=1):
        subject_data.append({
            "SubjectID": i,
            "SubjectName": subj
        })
    df_subject = pd.DataFrame(subject_data)

    # TCS 
    tcs_data = []
    tcs_id_counter = 1
    for row in df_teachers.itertuples():
        teacher_pesel = row.PESEL
        classes_taught = random.sample(class_ids, k=random.randint(1, 3))
        possible_subject_ids = list(df_subject['SubjectID'])
        subjects_taught = random.sample(possible_subject_ids, k=random.randint(1, 3))

        for cls in classes_taught:
            for sbj in subjects_taught:
                tcs_data.append({
                    "TcsID": tcs_id_counter,
                    "TeacherID": teacher_pesel,
                    "ClassID": cls,
                    "SubjectID": sbj
                })
                tcs_id_counter += 1
    df_tcs = pd.DataFrame(tcs_data)

    # SEMESTER
    semester_data = []
    for sem_id in [1, 2]:
        if sem_id == 1:
            name = "Fall 2024"
            start_date = datetime(2024, 9, 1)
            end_date   = datetime(2024, 12, 20)
            year = 2024
        else:
            name = "Spring 2025"
            start_date = datetime(2025, 2, 1)
            end_date   = datetime(2025, 6, 20)
            year = 2025

        semester_data.append({
            "SemesterID": sem_id,
            "Name": name,
            "StartDate": start_date,
            "EndDate": end_date,
            "Year": year
        })
    df_semester = pd.DataFrame(semester_data)

    # CLASS-SEMESTER
    class_sem_data = []
    used_combinations = set()
    for c_id in class_ids:
        for sem_id in df_semester["SemesterID"].tolist():
            combination = (c_id, sem_id)
            if combination not in used_combinations:
                class_sem_data.append({
                    "ClassID": c_id,
                    "SemesterID": sem_id
                })
                used_combinations.add(combination)
    df_class_semester = pd.DataFrame(class_sem_data)

    # ASSIGNMENT
    assignment_data = []
    assignment_id_counter = 1
    for row in df_tcs.itertuples():
        how_many = random.randint(1, 4)
        sem_id = random.choice(df_semester["SemesterID"].tolist())
        semester_info = df_semester.loc[df_semester['SemesterID'] == sem_id].iloc[0]
        sem_start = semester_info["StartDate"]
        sem_end   = semester_info["EndDate"]

        for _ in range(how_many):
            aname = random_assignment_name()
            deadline = generate_random_datetime_in_semester(sem_start, sem_end)
            assignment_data.append({
                "AssignmentID": assignment_id_counter,
                "AssignmentName": aname,
                "Deadline": deadline,
                "TcsID": row.TcsID,
                "SemesterID": sem_id
            })
            assignment_id_counter += 1
    df_assignment = pd.DataFrame(assignment_data)

    # GRADE
    df_grade = pd.DataFrame(columns=[
        "GradeID", "GradeValue", "WeightOfGrade", "Date"
    ])

    # STUDENT-ASSIGNMENT
    stud_assign_data = []
    grade_rows = []
    grade_id_counter = 1

    tcs_lookup = {
        rec.TcsID: rec.ClassID
        for rec in df_tcs.itertuples()
    }

    for asg_row in df_assignment.itertuples():
        class_id = tcs_lookup[asg_row.TcsID]
        class_students = df_students[df_students["ClassID"] == class_id]
        if class_students.empty:
            continue

        how_many_students = random.randint(
            int(0.7 * len(class_students)), len(class_students)
        )
        chosen_students = class_students.sample(how_many_students)

        for st_row in chosen_students.itertuples():
            sub_date = asg_row.Deadline - timedelta(days=random.randint(0, 5))
            grade_val = generate_random_grade()
            weight_val = generate_random_weight()
            grade_date = asg_row.Deadline + timedelta(days=random.randint(0, 3))

            grade_rows.append({
                "GradeID": grade_id_counter,
                "GradeValue": grade_val,
                "WeightOfGrade": weight_val,
                "Date": grade_date
            })

            stud_assign_data.append({
                "StudentID": st_row.PESEL,
                "AssignmentID": asg_row.AssignmentID,
                "SubmissionDate": sub_date,
                "GradeID": grade_id_counter
            })

            grade_id_counter += 1
    df_grade = pd.concat([df_grade, pd.DataFrame(grade_rows)], ignore_index=True)
    df_student_assignment = pd.DataFrame(stud_assign_data)

    return {
        "Student": df_students,
        "Teacher": df_teachers,
        "Class": df_class,
        "Subject": df_subject,
        "TCS": df_tcs,
        "Semester": df_semester,
        "ClassSemester": df_class_semester,
        "Assignment": df_assignment,
        "Grade": df_grade,
        "StudentAssignment": df_student_assignment,
    }

# Bulk loading
def add_data_to_CSV_files(data_dict, suffix):
    files = {
        "Subject": "Subject.csv",
        "Teacher": "Teacher.csv",
        "Grade": "Grade.csv",
        "Class": "Class.csv",
        "Semester": "Semester.csv",
        "Student": "Student.csv",
        "TCS": "TCS.csv",
        "ClassSemester": "ClassSemester.csv",
        "Assignment": "Assignment.csv",
        "StudentAssignment": "StudentAssignment.csv"
    }

    for key, file_name in files.items():
        # Append suffix to the file name
        new_file_name = file_name.replace(".csv", f"_{suffix}.csv")
        file_path = os.path.join(base_path, new_file_name)  # Full file path
        
        if not os.path.exists(file_path):  # Check if file exists
            print(f"{new_file_name} does not exist, creating it.")
            data_dict[key].to_csv(file_path, index=False)
        else:
            print(f"{new_file_name} already exists, skipping creation.")

# CSV generation
def generate_random_activity():
    activity_map = {
        "sports": ["Basketball", "Football", "Volleyball", "Tennis", "Swimming"],
        "arts": ["Painting", "Sculpture", "Photography", "Dance", "Choir"],
        "volunteering": ["Community Cleanup", "Food Drive", "Charity Run", "Volunteer Tutoring", "Animal Shelter Work"],
        "music": ["School Band", "Orchestra", "Choir", "Jazz Ensemble", "Rock Band"],
        "debate club": ["Debate Championship", "Public Speaking", "Model United Nations", "Argumentation Workshops"]
    }
    act_type = random.choice(list(activity_map.keys()))
    act_name = random.choice(activity_map[act_type])
    freq = random.choice(["1/week", "2/week", "3/week", "Once", ""])
    start_date = generate_random_date(2018, 2025).strftime("%Y-%m-%d")
    if random.random() < 0.3:
        end_date_val = generate_random_date(2018, 2025)
        end_date = end_date_val.strftime("%Y-%m-%d")
    else:
        end_date = ""
    
    achievements = random.choice(["", "Won a local competition", "Certificate earned", "Volunteer hours"])
    location = random.choice(["School Gym", "Art Room", "Local Park", "Auditorium", "Online"])

    return {
        "ActivityType": act_type,
        "ActivityName": act_name,
        "Frequency": freq,
        "StartDate": start_date,
        "EndDate": end_date,
        "AchievementsOrRemarks": achievements,
        "Location": location
    }

def generate_excel(data_dict, excel_filename):
    
    # Combine the base path with the file name to get the full file path
    full_path = os.path.join(base_path, excel_filename)

    # Check if the file already exists
    if os.path.exists(full_path):
        print(f"File {full_path} already exists. The file will not be overwritten.")
        return  # Exit the function to prevent overwriting the file

    # If the file does not exist, proceed with file creation
    print(f"File {full_path} does not exist. It will be created.")

    df_students = data_dict["Student"]
    sheet1_data = []
    
    for st in df_students.itertuples():
        dob = generate_random_date(2000, 2010).strftime("%Y-%m-%d")  # Random DOB for each student (for illustration)
        sheet1_data.append({
            "PESEL": st.PESEL,
            "FirstName": st.FirstName,
            "LastName": st.LastName,
            "DateOfBirth": dob,
            "Class": st.ClassID,
            "GuardianContact": st.GuardianContact
        })
    
    df_sheet1 = pd.DataFrame(sheet1_data)
    sheet2_data = []
    
    for st in df_students.itertuples():
        how_many_activities = random.randint(0, 3)
        for _ in range(how_many_activities):
            activity = generate_random_activity()
            sheet2_data.append({
                "PESEL": st.PESEL,
                **activity
            })

    df_sheet2 = pd.DataFrame(sheet2_data)
    
    # Create the Excel file since it does not exist
    with pd.ExcelWriter(full_path, engine='openpyxl') as writer:
        df_sheet1.to_excel(writer, sheet_name='Sheet1', index=False)
        df_sheet2.to_excel(writer, sheet_name='Sheet2', index=False)

    print(f"Excel file {full_path} has been created.")

def get_data_snapshot_T2(data_T1, num_additional_students=10, num_additional_teachers=2):
    # Copy the data from T1 to create T2, so we don't modify the original data
    df_students = data_T1["Student"].copy()
    df_teachers = data_T1["Teacher"].copy()
    df_class = data_T1["Class"].copy()
    df_subject = data_T1["Subject"].copy()
    df_tcs = data_T1["TCS"].copy()
    df_semester = data_T1["Semester"].copy()
    df_class_semester = data_T1["ClassSemester"].copy()
    df_assignment = data_T1["Assignment"].copy()
    df_grade = data_T1["Grade"].copy()
    df_student_assignment = data_T1["StudentAssignment"].copy()

    # Adding students
    new_students = []
    for _ in range(num_additional_students):
        pesel = generate_random_pesel()
        fname = names.get_first_name()
        lname = names.get_last_name()
        guardian_contact = random.choice([generate_phone_number(), f"{lname.lower()}@gmail.com"])
        class_id = generate_class()
        new_students.append({
            "PESEL": pesel,
            "FirstName": fname,
            "LastName": lname,
            "GuardianContact": guardian_contact,
            "ClassID": class_id
        })
    df_students = pd.concat([df_students, pd.DataFrame(new_students)], ignore_index=True)

    # Adding teachers
    new_teachers = []
    for _ in range(num_additional_teachers):
        pesel = generate_random_pesel()
        fname = names.get_first_name()
        lname = names.get_last_name()
        new_teachers.append({
            "PESEL": pesel,
            "FirstName": fname,
            "LastName": lname
        })
    df_teachers = pd.concat([df_teachers, pd.DataFrame(new_teachers)], ignore_index=True)

    # Re-assign TCS (Teacher-Class-Subject) mappings for new teachers
    tcs_data = []
    tcs_id_counter = df_tcs['TcsID'].max() + 1 if not df_tcs.empty else 1
    for row in df_teachers.itertuples():
        if row.PESEL in [teacher['PESEL'] for teacher in new_teachers]:  # Only for new teachers
            classes_taught = random.sample(class_ids, k=random.randint(1, 3))
            possible_subject_ids = list(df_subject['SubjectID'])
            subjects_taught = random.sample(possible_subject_ids, k=random.randint(1, 3))

            for cls in classes_taught:
                for sbj in subjects_taught:
                    tcs_data.append({
                        "TcsID": tcs_id_counter,
                        "TeacherID": row.PESEL,
                        "ClassID": cls,
                        "SubjectID": sbj
                    })
                    tcs_id_counter += 1
    df_tcs = pd.concat([df_tcs, pd.DataFrame(tcs_data)], ignore_index=True)

    # Adding Assignments for new TCS
    assignment_data = []
    assignment_id_counter = df_assignment['AssignmentID'].max() + 1 if not df_assignment.empty else 1
    for row in df_tcs.itertuples():
        if row.TeacherID in [teacher['PESEL'] for teacher in new_teachers]:  # Only for new TCS
            how_many = random.randint(1, 4)
            sem_id = random.choice(df_semester["SemesterID"].tolist())
            semester_info = df_semester.loc[df_semester['SemesterID'] == sem_id].iloc[0]
            sem_start = semester_info["StartDate"]
            sem_end = semester_info["EndDate"]

            for _ in range(how_many):
                aname = random_assignment_name()
                deadline = generate_random_datetime_in_semester(sem_start, sem_end)
                assignment_data.append({
                    "AssignmentID": assignment_id_counter,
                    "AssignmentName": aname,
                    "Deadline": deadline,
                    "TcsID": row.TcsID,
                    "SemesterID": sem_id
                })
                assignment_id_counter += 1
    df_assignment = pd.concat([df_assignment, pd.DataFrame(assignment_data)], ignore_index=True)

    # Adding Grades for new assignments
    grade_rows = []
    grade_id_counter = df_grade['GradeID'].max() + 1 if not df_grade.empty else 1
    tcs_lookup = {rec.TcsID: rec.ClassID for rec in df_tcs.itertuples()}
    
    for asg_row in df_assignment.itertuples():
        class_id = tcs_lookup[asg_row.TcsID]
        class_students = df_students[df_students["ClassID"] == class_id]
        if class_students.empty:
            continue

        how_many_students = random.randint(1, len(class_students))
        chosen_students = class_students.sample(how_many_students)

        for st_row in chosen_students.itertuples():
            sub_date = asg_row.Deadline - timedelta(days=random.randint(0, 5))
            grade_val = generate_random_grade()
            weight_val = generate_random_weight()
            grade_date = asg_row.Deadline + timedelta(days=random.randint(0, 3))

            grade_rows.append({
                "GradeID": grade_id_counter,
                "GradeValue": grade_val,
                "WeightOfGrade": weight_val,
                "Date": grade_date
            })

            grade_id_counter += 1
    df_grade = pd.concat([df_grade, pd.DataFrame(grade_rows)], ignore_index=True)

    # Adding Student-Assignments for new grades
    stud_assign_data = []
    for asg_row in df_assignment.itertuples():
        class_id = tcs_lookup[asg_row.TcsID]
        class_students = df_students[df_students["ClassID"] == class_id]
        if class_students.empty:
            continue

        for st_row in class_students.itertuples():
            sub_date = asg_row.Deadline - timedelta(days=random.randint(0, 5))
            grade_id = grade_id_counter - 1  # New grade just added
            stud_assign_data.append({
                "StudentID": st_row.PESEL,
                "AssignmentID": asg_row.AssignmentID,
                "SubmissionDate": sub_date,
                "GradeID": grade_id
            })
    df_student_assignment = pd.concat([df_student_assignment, pd.DataFrame(stud_assign_data)], ignore_index=True)

    return {
        "Student": df_students,
        "Teacher": df_teachers,
        "Class": df_class,
        "Subject": df_subject,
        "TCS": df_tcs,
        "Semester": df_semester,
        "ClassSemester": df_class_semester,
        "Assignment": df_assignment,
        "Grade": df_grade,
        "StudentAssignment": df_student_assignment,
    }

def delete_all_data_files():
    # Define the file names with potential suffixes (_1 and _2)
    files_to_delete = [
        "Subject.csv", "Teacher.csv", "Grade.csv", "Class.csv",
        "Semester.csv", "Student.csv", "TCS.csv", "ClassSemester.csv",
        "Assignment.csv", "StudentAssignment.csv", "t1_snapshot.xlsx", "t2_snapshot.xlsx"
    ]
    
    for file in files_to_delete:
        # Create paths for both _1 and _2 versions of the file
        file_1_path = os.path.join(base_path, file.replace(".csv", "_1.csv"))
        file_2_path = os.path.join(base_path, file.replace(".csv", "_2.csv"))
        
        # Try to delete both versions of the file
        for file_path in [file_1_path, file_2_path]:
            print(f"Attempting to delete: {file_path}")  # Print the full file path
            if os.path.exists(file_path):
                os.remove(file_path)
                print(f"Deleted: {file_path}")
            else:
                print(f"File not found: {file_path}")


if __name__ == "__main__":
    # Generate T1 snapshot
    data_T1 = get_data_snapshot_T1(num_students=100, num_teachers=11)  # Tu mozna zmienic liczbe uczniow i nauczycieli
    data_T2 = get_data_snapshot_T2(data_T1, num_additional_students=5, num_additional_teachers=2)

    generate_excel(data_T1, "t1_snapshot.xlsx")
    add_data_to_CSV_files(data_T1, "1")
    print("Done. Created T1 snapshot.")
    
    generate_excel(data_T2, "t2_snapshot.xlsx")
    add_data_to_CSV_files(data_T2, "2")
    print("Done. Created T2 snapshot.")

    # delete_all_data_files() # IMPORTANT - COMMENT THIS OUT AFTER TESTING

