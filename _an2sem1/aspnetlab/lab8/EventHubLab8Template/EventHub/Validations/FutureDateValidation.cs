using System.ComponentModel.DataAnnotations;

namespace EventHub.Validations;

public class FutureDateValidation : ValidationAttribute
{
    protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
    {
        if (value is null)
        {
            return ValidationResult.Success;
        }

        if (value is DateTime date && date > DateTime.Now)
        {
            return ValidationResult.Success;
        }

        return new ValidationResult("Data evenimentului trebuie să fie în viitor");
    }
}
