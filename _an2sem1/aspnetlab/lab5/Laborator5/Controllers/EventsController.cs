using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Laborator5.Models;

namespace Laborator4.Controllers;

public class EventsController : Controller
{
    private readonly AppDbContext _db;

    public EventsController(AppDbContext context)
    {
        _db = context;
    }


    [HttpGet]
    public IActionResult Index()
    {
        var events = _db.Events.ToList();

        ViewBag.Events = events;

        return View();

    }

    [HttpGet]
    public IActionResult Show(int? id)
    {
        if (id == null)
        {
            ViewBag.ErrorMessage = "nu ai specificat id";
            return View();
        }


        var ev = _db.Events.Find(id);

        if (ev is null)
        {
            Response.StatusCode = StatusCodes.Status404NotFound;
            ViewBag.ErrorMessage = "Nu există niciun eveniment cu id-ul " + id + ".";
            return View("Error");
        }

        ViewBag.Event = ev;
        return View();
    }


    [HttpGet]
    public IActionResult New()
    {
        return View();
    }

    [HttpPost]
    public IActionResult New(Event ev)
    {
        _db.Events.Add(ev);
        _db.SaveChanges();

        return RedirectToAction("Index");;
    }


    [HttpGet]
    public IActionResult Edit(int? id)
    {
        if (id == null)
        {
            ViewBag.ErrorMessage = "nu ai specificat id";
            return View();
        }
        
        var ev = _db.Events.Find(id);

        if(ev is null)
        {
            return NotFound();
        }

        ViewBag.Event = ev;

        return View();
    }

    [HttpPost]
    public IActionResult Edit(int id, Event requestEvent)
    {
        var ev = _db.Events.Find(id);

        if (ev != null)
        {
            ev.Title = requestEvent.Title;
            ev.Description = requestEvent.Description;
            ev.Date = requestEvent.Date;
            ev.Location = requestEvent.Location;

            _db.SaveChanges();

            return RedirectToAction("Index");
        }
        
        return RedirectToAction("Edit", new {id});
    }


    [HttpPost]
    public IActionResult Delete(int id)
    {

        var ev = _db.Events.Find(id);

        if (ev is not null)
        {
            _db.Events.Remove(ev);
            _db.SaveChanges();
        }

        return RedirectToAction("Index");
    }

}