using System.ComponentModel.DataAnnotations;

namespace EventHub.Models;

public class Category
{
    [Key]
    public int Id { get; set; }

    [Required(ErrorMessage = "Numele categoriei este obligatoriu")]
    public string CategoryName { get; set; }

    // Relație 1 -> M: O categorie conține o colecție de evenimente
    public virtual ICollection<Event>? Events { get; set; }
}