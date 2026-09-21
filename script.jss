function calculateGrade() {
    let marks = [];

    for (let i = 1; i <= 5; i++) {
        let mark = Number(document.getElementById("mark" + i).value);

        if (mark < 0 || mark > 100 || isNaN(mark)) {
            alert("Please enter marks between 0 and 100.");
            return;
        }

        marks.push(mark);
    }

    let total = marks.reduce((sum, mark) => sum + mark, 0);
    let percentage = total / 5;

    let grade;

    if (percentage >= 90) {
        grade = "A+";
    } else if (percentage >= 80) {
        grade = "A";
    } else if (percentage >= 70) {
        grade = "B";
    } else if (percentage >= 60) {
        grade = "C";
    } else if (percentage >= 50) {
        grade = "D";
    } else {
        grade = "F";
    }

    document.getElementById("result").innerHTML =
        "Total Marks: " + total + "/500<br>" +
        "Percentage: " + percentage.toFixed(2) + "%<br>" +
        "Grade: " + grade;
}
