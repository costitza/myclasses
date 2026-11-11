using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using EventHub.Models; // <-- Asigură-te că namespace-ul modelelor este inclus!

namespace EventHub.Data;

public class ApplicationDbContext : IdentityDbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    // FĂRĂ ACESTEA, EF CORE NU ȘTIE SĂ CREEZE TABELELE:
    public DbSet<Event> Events { get; set; }
    public DbSet<Category> Categories { get; set; }
    public DbSet<Review> Reviews { get; set; }
}