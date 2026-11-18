using EventHub.Data;
using EventHub.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore; // ToListAsync()

namespace EventHub.Controllers;

// EXERCIȚIUL 7 – de analizat și de rulat
// Același mod de lucru ca în EventsController: acțiuni asincrone, Model trimis către View,
// mesaje prin TempData
public class CategoriesController : Controller
{
    private readonly ApplicationDbContext db;

    public CategoriesController(ApplicationDbContext context)
    {
        db = context;
    }

    // lista categoriilor, ordonate alfabetic
    public async Task<IActionResult> Index()
    {
        // mesajul scris de New, Edit sau Delete
        if (TempData.ContainsKey("message"))
        {
            ViewBag.Message = TempData["message"];
        }

        var categories = await (from category in db.Categories
                                orderby category.CategoryName
                                select category).ToListAsync();

        ViewBag.Categories = categories;
        return View();
    }

    // o singură categorie, trimisă ca Model
    public async Task<IActionResult> Show(int id)
    {
        // FindAsync caută după cheia primară
        Category? category = await db.Categories.FindAsync(id);

        if (category is null)
        {
            return NotFound();
        }

        return View(category);
    }

    // formularul gol pentru o categorie nouă
    public IActionResult New()
    {
        return View();
    }

    [HttpPost]
    public async Task<IActionResult> New(Category cat)
    {
        try
        {
            db.Categories.Add(cat);
            await db.SaveChangesAsync();
            TempData["message"] = "Categoria a fost adăugată";
            return RedirectToAction("Index");
        }
        catch (Exception)
        {
            // formularul se afișează din nou, cu valoarea introdusă
            return View(cat);
        }
    }

    // formularul de editare, completat cu datele categoriei
    public async Task<IActionResult> Edit(int id)
    {
        Category? category = await db.Categories.FindAsync(id);

        if (category is null)
        {
            return NotFound();
        }

        return View(category);
    }

    [HttpPost]
    public async Task<IActionResult> Edit(int id, Category requestCategory)
    {
        Category? category = await db.Categories.FindAsync(id);

        if (category is null)
        {
            return NotFound();
        }

        try
        {
            category.CategoryName = requestCategory.CategoryName;
            await db.SaveChangesAsync();
            TempData["message"] = "Categoria a fost modificată";
            return RedirectToAction("Index");
        }
        catch (Exception)
        {
            return View(requestCategory);
        }
    }

    // La ștergerea unei categorii se șterg automat și toate evenimentele
    // din categoria respectivă (cheia externă CategoryId are ON DELETE CASCADE – VEZI Curs 6)
    [HttpPost]
    public async Task<IActionResult> Delete(int id)
    {
        Category? category = await db.Categories.FindAsync(id);

        if (category is null)
        {
            return NotFound();
        }

        db.Categories.Remove(category);
        await db.SaveChangesAsync();
        TempData["message"] = "Categoria a fost ștearsă";
        return RedirectToAction("Index");
    }
}
