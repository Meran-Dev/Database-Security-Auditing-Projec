# Database Security & Auditing Project

This repository contains the database scripts, security auditing documentation, and presentation materials for the **Database Security & Auditing** project.

---

## 📁 Repository Structure

.
├── ccp.sql                   # Main database setup / schema script
├── ccp1.sql                  # Security & auditing script 1
├── ccp2.sql                  # Security & auditing script 2
├── ccp3.sql                  # Security & auditing script 3
├── ccp4.sql                  # Security & auditing script 4
├── report.docx               # Comprehensive project report
└── Database Security & Auditing Project.pptx  # Project presentation


---

## 🛠 Prerequisites

Before executing the SQL scripts, ensure you have the following installed:

- **Microsoft SQL Server** (or your designated database engine)
- **SQL Server Management Studio (SSMS)** or **Azure Data Studio**
- **Microsoft Office** (Word and PowerPoint) to view project reports and slides

---

## 🚀 Setup & Execution Instructions

1. **Clone or Download the Repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git](https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git)
   cd YOUR_REPOSITORY_NAME
Open SQL Server Management Studio (SSMS):

Connect to your SQL Server instance.

Execute SQL Scripts in Order:
Run the scripts sequentially to set up the database and apply auditing configurations:

Run ccp.sql to initialize the database schema.

Run ccp1.sql through ccp4.sql in numerical order to apply security policies, roles, permissions, and audit logs.

Verify Execution:

Ensure all scripts complete with Command(s) completed successfully.

Check the Audit Logs in SQL Server Management Studio under Security > Audit Specifications.

📄 Documentation & Presentation
Project Report: Open report.docx for the detailed system architecture, audit design, and security policies.

Presentation: Open Database Security & Auditing Project.pptx for the project overview and key deliverables.

👤 Author
Developed as part of the Database Security & Auditing coursework.


---

### How to add this file to your GitHub repository:

1. Create a new file called `README.md` inside your project folder.
2. Paste the text above (make sure to replace `YOUR_USERNAME/YOUR_REPOSITORY_NAME` with your actual GitHub repository URL).
3. Push the file to GitHub using your terminal:

```bash
git add README.md
git commit -m "Add README setup instructions"
git push
