using System.ComponentModel.DataAnnotations;

namespace EventHub.Models;

public class Review
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Conținutul recenziei este obligatoriu")]
    public string Content { get; set; }

    public DateTime Date { get; set; }

    // Cheie externă către Event
    public int EventId { get; set; }

    // Proprietate de navigare către Event
    public virtual Event? Event { get; set; }
}