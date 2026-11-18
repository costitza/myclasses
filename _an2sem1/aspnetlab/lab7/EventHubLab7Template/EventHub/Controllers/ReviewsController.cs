using EventHub.Data;
using EventHub.Models;
using Microsoft.AspNetCore.Mvc;

namespace EventHub.Controllers;

// EXERCIȚIUL 8 – de analizat
// Recenziile nu au pagini proprii de listare: se afișează în pagina evenimentului (Events/Show),
// iar după fiecare operație se revine la acea pagină
public class ReviewsController : Controller
{
    private readonly ApplicationDbContext db;

    public ReviewsController(ApplicationDbContext context)
    {
        db = context;
    }

    // Adăugarea unei recenzii asociate unui eveniment în baza de date
    // Cererea vine din formularul din Events/Show; EventId vine din câmpul ascuns al formularului
    [HttpPost]
    public async Task<IActionResult> New(Review rev)
    {
        // data se completează pe server, nu în formular
        rev.Date = DateTime.Now;

        try
        {
            db.Reviews.Add(rev);
            await db.SaveChangesAsync();
        }
        catch (Exception)
        {
            // recenzia nu s-a salvat (de exemplu, conținut gol); se revine la eveniment
        }

        // se revine la pagina evenimentului, unde apare recenzia nouă
        return Redirect("/Events/Show/" + rev.EventId);
    }

    // Ștergerea unei recenzii asociate unui eveniment din baza de date
    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        Review? rev = await db.Reviews.FindAsync(id);

        if (rev is null)
        {
            return NotFound();
        }

        db.Reviews.Remove(rev);
        await db.SaveChangesAsync();
        return Redirect("/Events/Show/" + rev.EventId);
    }

    // În acest moment, editarea se implementează într-un View separat
    // Se editează o recenzie existentă; recenzia se trimite ca Model
    public async Task<IActionResult> Edit(int id)
    {
        Review? rev = await db.Reviews.FindAsync(id);

        if (rev is null)
        {
            return NotFound();
        }

        return View(rev);
    }

    [HttpPost]
    public async Task<IActionResult> Edit(int id, Review requestReview)
    {
        Review? rev = await db.Reviews.FindAsync(id);

        if (rev is null)
        {
            return NotFound();
        }

        try
        {
            rev.Content = requestReview.Content;
            await db.SaveChangesAsync();
        }
        catch (Exception)
        {
            // modificarea nu s-a salvat; se revine la eveniment
        }

        return Redirect("/Events/Show/" + rev.EventId);
    }
}
