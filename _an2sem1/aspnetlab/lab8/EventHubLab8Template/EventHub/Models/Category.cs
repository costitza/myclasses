using System.ComponentModel.DataAnnotations;

namespace EventHub.Models;

public class Category
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Numele categoriei este obligatoriu")]
    public string CategoryName { get; set; } = string.Empty;

    public virtual ICollection<Event>? Events { get; set; } = new List<Event>();
}
