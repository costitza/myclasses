using EventHub.Data;
using EventHub.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace EventHub.Controllers;

public class EventsController : Controller
{
    private readonly ApplicationDbContext db;

    public EventsController(ApplicationDbContext context)
    {
        db = context;
    }

    public async Task<IActionResult> Index()
    {
        var events = await db.Events
                             .Include(e => e.Category)
                             .OrderBy(e => e.Date)
                             .ToListAsync();

        ViewBag.Events = events;

        if (TempData.ContainsKey("message"))
        {
            ViewBag.Message = TempData["message"];
        }

        return View();
    }

    [HttpPost]
    public async Task<IActionResult> Show(int id)
    {
        Event? ev = await db.Events
                            .Include(e => e.Category)
                            .Include(e => e.Reviews)
                            .Where(e => e.Id == id)
                            .FirstOrDefaultAsync();

        if (ev is null)
        {
            return NotFound();
        }

        return View(ev);
    }

    [HttpPost]
    public async Task<IActionResult> Show([FromForm] Review rev)
    {
        rev.Date = DateTime.Now;

        if (ModelState.IsValid)
        {
            db.Reviews.Add(rev);
            await db.SaveChangesAsync();
            return Redirect("/Events/Show/" + rev.EventId);
        }
        else
        {
            Event? ev = await db.Events
                                .Include(e => e.Category)
                                .Include(e => e.Reviews)
                                .Where(e => e.Id == rev.EventId)
                                .FirstOrDefaultAsync();

            if (ev is null)
            {
                return NotFound();
            }

            return View(ev);
        }
    }

    public async Task<IActionResult> New()
    {
        Event ev = new Event();

        ev.Categ = await GetAllCategories();

        return View(ev);
    }

    [HttpPost]
    public async Task<IActionResult> New(Event ev)
    {
        if (ModelState.IsValid)
        {
            db.Events.Add(ev);
            await db.SaveChangesAsync();
            TempData["message"] = "Evenimentul a fost adăugat";
            return RedirectToAction("Index");
        }
        else
        {
            ev.Categ = await GetAllCategories();
            return View(ev);
        }
    }

    public async Task<IActionResult> Edit(int id)
    {
        Event? ev = await db.Events
                            .Include(e => e.Category)
                            .FirstOrDefaultAsync(e => e.Id == id);

        if (ev is null)
        {
            return NotFound();
        }

        ev.Categ = await GetAllCategories();

        return View(ev);
    }

    [HttpPost]
    public async Task<IActionResult> Edit(int id, Event requestEvent)
    {
        Event? ev = await db.Events.FindAsync(id);

        if (ev is null)
        {
            return NotFound();
        }

        if(ModelState.IsValid)
        {
            ev.Title = requestEvent.Title;
            ev.Description = requestEvent.Description;
            ev.Date = requestEvent.Date;
            ev.Location = requestEvent.Location;
            ev.CategoryId = requestEvent.CategoryId;

            await db.SaveChangesAsync();
            TempData["message"] = "Evenimentul a fost modificat";
            return RedirectToAction("Index");
        }
        else
        {
            requestEvent.Categ = await GetAllCategories();
            return View(requestEvent);
        }
    }

    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        Event? ev = await db.Events.FindAsync(id);

        if (ev is null)
        {
            return NotFound();
        }

        db.Events.Remove(ev);
        await db.SaveChangesAsync();
        TempData["message"] = "Evenimentul a fost șters";
        return RedirectToAction("Index");
    }

    public IActionResult IndexNou()
    {
        return View();
    }

    [NonAction]
    public async Task<IEnumerable<SelectListItem>> GetAllCategories()
    {
        var selectList = new List<SelectListItem>();

        var categories = await (from cat in db.Categories
                                orderby cat.CategoryName
                                select cat).ToListAsync();

        foreach (var category in categories)
        {
            selectList.Add(new SelectListItem
            {
                Value = category.Id.ToString(),
                Text = category.CategoryName
            });
        }

        return selectList;
    }
}
