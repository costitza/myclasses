using Microsoft.AspNetCore.Mvc;
using EventHub.Data;
using EventHub.Models;


namespace EventHub.Controllers;

public class CategoriesController : Controller
{
    private readonly ApplicationDbContext _db;

    public CategoriesController(ApplicationDbContext context)
    {
        _db = context;
    }

    [HttpGet]
    public IActionResult Index()
    {
        ViewBag.Categories = _db.Categories.ToList();
        return View();
    }

    [HttpGet]
    public IActionResult Show(int? id)
    {
        if (id == null) return NotFound();
        var cat = _db.Categories.Find(id);
        if (cat == null) return NotFound();

        ViewBag.Category = cat;
        return View();
    }

    [HttpGet]
    public IActionResult New() => View();

    [HttpPost]
    public IActionResult New(Category cat)
    {
        _db.Categories.Add(cat);
        _db.SaveChanges();
        return RedirectToAction("Index");
    }

    [HttpGet]
    public IActionResult Edit(int? id)
    {
        if (id == null) return NotFound();
        var cat = _db.Categories.Find(id);
        if (cat == null) return NotFound();

        ViewBag.Category = cat;
        return View();
    }

    [HttpPost]
    public IActionResult Edit(int id, Category requestCat)
    {
        var cat = _db.Categories.Find(id);
        if (cat != null)
        {
            cat.CategoryName = requestCat.CategoryName;
            _db.SaveChanges();
        }
        return RedirectToAction("Index");
    }

    [HttpPost]
    public IActionResult Delete(int id)
    {
        var cat = _db.Categories.Find(id);
        if (cat != null)
        {
            _db.Categories.Remove(cat);
            _db.SaveChanges();
        }
        return RedirectToAction("Index");
    }
}