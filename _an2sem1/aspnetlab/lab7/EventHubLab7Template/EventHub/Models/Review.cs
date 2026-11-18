using System.ComponentModel.DataAnnotations;

namespace EventHub.Models;

public class Review
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Conținutul recenziei este obligatoriu")]
    public string Content { get; set; } = string.Empty;

    // data la care a fost postată recenzia
    public DateTime Date { get; set; }

    public int EventId { get; set; }

    public virtual Event Event { get; set; } = null!;
}
