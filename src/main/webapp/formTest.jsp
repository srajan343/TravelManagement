<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Multi-file Upload Form</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
    <form id="formData" enctype="multipart/form-data">
        <table id="fileTable">
            <thead>
                <tr>
                    <th>Employee Name</th>
                    <th>File Upload (PDF only)</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><input type="text" name="employeeName[]" placeholder="Employee Name" required></td>
                    <td>
                        <input type="file" name="file[]" accept=".pdf" required>
                    </td>
                    <td>
                        <button type="button" class="add-row">+</button>
                    </td>
                </tr>
            </tbody>
        </table>
        <button type="submit" id="submit-btn">Submit</button>
    </form>

    <script>
        $(document).ready(function () {
            // Add new row
            $(document).on("click", ".add-row", function () {
                let newRow = `
                    <tr>
                        <td><input type="text" name="employeeName[]" placeholder="Employee Name" required></td>
                        <td>
                            <input type="file" name="file[]" accept=".pdf" required>
                        </td>
                        <td>
                            <button type="button" class="remove-row">-</button>
                        </td>
                    </tr>`;
                $("#fileTable tbody").append(newRow);
            });

            // Remove row
            $(document).on("click", ".remove-row", function () {
                $(this).closest("tr").remove();
            });

            // Submit form via AJAX
            $("#formData").on("submit", function (event) {
                event.preventDefault();

                let formData = new FormData(this);

                $.ajax({
                    url: 'formDataServlet',
                    method: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        console.log("Success:", response);
                        window.location.href = "formData1.jsp";
                    },
                    error: function (xhr, status, error) {
                        console.error("Error:", status, error);
                    }
                });
            });
        });
    </script>
</body>
</html>
