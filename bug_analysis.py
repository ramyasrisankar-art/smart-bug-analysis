import pandas as pd

df = pd.read_excel("smart_bug_analysis (2).xlsx", sheet_name="Bug_Data")

print(df.head())

print("Total Bugs:", len(df))
print(df["Severity"].value_counts())
print(df["Status"].value_counts())
print("Average Resolution Days:", df["Resolution_Days"].mean())
print(df["Developer"].value_counts())
print(df["Project_Name"].value_counts())
print(df["Priority"].value_counts())
print(df[df["Priority"].isna()][["Bug_Id", "Bug_Description", "Severity", "Status", "Module"]])
print(df["Module"].value_counts())
print("Duplicate Bug IDs:", df["Bug_Id"].duplicated().sum())
print(df.isna().sum())
print(df.columns.tolist())
print("Analysis Completed Successfully")

print("\nSeverity Analysis")
print(df["Severity"].value_counts())

print("\nStatus Analysis")
print(df["Status"].value_counts())

print("\nDeveloper Analysis")
print(df["Developer"].value_counts())

print("\nProject Analysis")
print(df["Project_Name"].value_counts())

print("\nAverage Resolution Days")
print(df["Resolution_Days"].mean())

print("\nPriority Analysis")
print(df["Priority"].value_counts())

summary = pd.DataFrame({
    "Metric": [
        "Total Bugs",
        "Closed Bugs",
        "Open Bugs",
        "In Progress Bugs",
        "Average Resolution Days"
    ],
    "Value": [
        len(df),
        (df["Status"] == "Closed").sum(),
        (df["Status"] == "Open").sum(),
        (df["Status"] == "In Progress").sum(),
        round(df["Resolution_Days"].mean(), 2)
    ]
})

summary.to_excel("Bug_Analysis_Result.xlsx", index=False)

print("\nExcel Result File Created Successfully")