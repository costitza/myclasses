using EventHub.Validations;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EventHub.Models;

public class Event 
{
    [Key]
    public int Id { get; set; }


    [Required(ErrorMessage = "Titlul este obligatoriu")]
    [StringLength(100)]
    [MinLength(5)]
    public string Title { get; set; } = string.Empty;

    [Required(ErrorMessage = "Descrierea evenimentului este obligatorie")]
    public string Description { get; set; } = string.Empty;

    [Required(ErrorMessage = "Data evenimentului este obligatorie")]
    [FutureDateValidation]
    public DateTime? Date { get; set; }

    [Required(ErrorMessage = "Locația este obligatorie")]
    public string Location { get; set; } = string.Empty;

    [Required(ErrorMessage = "Categoria este obligatorie")]
    public int? CategoryId { get; set; }

    public virtual Category? Category { get; set; } = null!;

    public virtual ICollection<Review>? Reviews { get; set; } = new List<Review>();

    [NotMapped]
    public IEnumerable<SelectListItem>? Categ { get; set; } = Enumerable.Empty<SelectListItem>();

    
}
