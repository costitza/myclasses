using EventHub.Data;
using EventHub.Models;
using Microsoft.AspNetCore.Mvc;

namespace EventHub.Controllers;

public class ReviewsController : Controller
{
    private readonly ApplicationDbContext db;

    public ReviewsController(ApplicationDbContext context)
    {
        db = context;
    }

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

        if (ModelState.IsValid)
        {
            rev.Content = requestReview.Content;
            await db.SaveChangesAsync();
            return Redirect("/Events/Show/" + rev.EventId);
        }
        else
        {
            requestReview.Id = id;
            requestReview.EventId = rev.EventId;
            return View(requestReview);
        }
    }
}
