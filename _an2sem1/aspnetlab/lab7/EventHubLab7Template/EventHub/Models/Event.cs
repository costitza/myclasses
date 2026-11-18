using Microsoft.AspNetCore.Mvc.Rendering;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EventHub.Models;

public class Event
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Titlul este obligatoriu")]
    public string Title { get; set; } = string.Empty;

    [Required(ErrorMessage = "Descrierea evenimentului este obligatorie")]
    public string Description { get; set; } = string.Empty;

    // data și ora la care are loc evenimentul
    public DateTime Date { get; set; }

    [Required(ErrorMessage = "Locația este obligatorie")]
    public string Location { get; set; } = string.Empty;

    // relație configurată folosind convențiile de nume din EF
    [Required(ErrorMessage = "Categoria este obligatorie")]
    public int CategoryId { get; set; }

    public virtual Category Category { get; set; } = null!;

    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();

    // lista categoriilor pentru dropdown-ul din formularele New și Edit
    // (id-ul categoriei și denumirea acesteia);
    // [NotMapped] – proprietatea nu devine coloană în baza de date
    [NotMapped]
    public IEnumerable<SelectListItem> Categ { get; set; } = Enumerable.Empty<SelectListItem>();


    /* dacă nu se respectă convențiile de nume, se folosește implementarea următoare
     *
    public int CategId { get; set; } // nume care nu respectă convenția

    [ForeignKey(nameof(CategId))]
    public virtual Category Category { get; set; } = null!;

    */
}
