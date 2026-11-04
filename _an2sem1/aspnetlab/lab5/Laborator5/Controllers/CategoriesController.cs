using Microsoft.AspNetCore.Mvc;
using Laborator5.Models;

namespace Laborator5.Controllers;

public class CategoriesController : Controller
{
    private readonly AppDbContext _db;

    public CategoriesController(AppDbContext context)
    {
        _db = context;
    }

    [HttpGet]
    public IActionResult Index()
    {
        var categories = _db.Categories.ToList();
        ViewBag.Categories = categories;
        return View();
    }

    [HttpGet]
    public IActionResult Show(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var category = _db.Categories.Find(id);
        if (category == null)
        {
            return NotFound();
        }

        ViewBag.Category = category;
        return View();
    }

    [HttpGet]
    public IActionResult New()
    {
        return View();
    }

    [HttpPost]
    public IActionResult New(Category category)
    {
        _db.Categories.Add(category);
        _db.SaveChanges();
        return RedirectToAction("Index");
    }


    [HttpGet]
    public IActionResult Edit(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var category = _db.Categories.Find(id);
        if (category == null)
        {
            return NotFound();
        }

        ViewBag.Category = category;
        return View();
    }

    [HttpPost]
    public IActionResult Edit(int id, Category requestCategory)
    {
        var category = _db.Categories.Find(id);

        if (category != null)
        {
            category.CategoryName = requestCategory.CategoryName;
            _db.SaveChanges();
            return RedirectToAction("Index");
        }
        else
        {
            return RedirectToAction("Edit", new { id });
        }
    }

    [HttpPost]
    public IActionResult Delete(int id)
    {
        var category = _db.Categories.Find(id);
        if (category != null)
        {
            _db.Categories.Remove(category);
            _db.SaveChanges();
        }

        return RedirectToAction("Index");
    }
}