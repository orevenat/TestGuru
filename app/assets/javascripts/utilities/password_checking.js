document.addEventListener('turbolinks:load', function () {
  var passwordField = document.querySelector('#user_password');
  var confirmationField = document.querySelector('#user_password_confirmation');

  if (passwordField && confirmationField) {
    passwordField.addEventListener('keyup', function () {
      checkPasswords(passwordField, confirmationField);
    });
    confirmationField.addEventListener('keyup', function() {
      checkPasswords(passwordField, confirmationField);
    });
  }
});

function checkPasswords(field1, field2) {
  console.log(12333);
  if (field1.value !== field2.value && field2.value.length > 0) {
    field1.classList.add('is-invalid');
    field2.classList.add('is-invalid');
  } else {
    field1.classList.remove('is-invalid');
    field2.classList.remove('is-invalid');
  }
}
