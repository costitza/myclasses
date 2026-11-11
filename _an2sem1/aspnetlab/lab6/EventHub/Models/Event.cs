using System.ComponentModel.DataAnnotations;

namespace EventHub.Models;

public class Event
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Titlul este obligatoriu")]
    public string Title { get; set; }

    [Required(ErrorMessage = "Descrierea este obligatorie")]
    public string Description { get; set; }

    public DateTime Date { get; set; }

    [Required(ErrorMessage = "Locația este obligatorie")]
    public string Location { get; set; }

    // Cheie externă către Category
    [Required(ErrorMessage = "Categoria este obligatorie")]
    public int CategoryId { get; set; }

    // Proprietate de navigare către Category
    public virtual Category? Category { get; set; }

    // Relație 1 -> M: Un eveniment conține o colecție de recenzii
    public virtual ICollection<Review>? Reviews { get; set; }
}