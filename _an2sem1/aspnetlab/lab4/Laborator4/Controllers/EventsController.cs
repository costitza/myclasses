using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Laborator4.Models;

namespace Laborator4.Controllers;

public class EventsController : Controller
{
    [NonAction]
    public Event[] getEvents()
    {
        Event[] events =
        [
            new Event { Id = 0, Title = "Hackathon FMI 2026",
                        Description = "Concurs de programare de 24 de ore, în echipe de câte 3 studenți.",
                        Date = new DateTime(2026, 11, 14, 10, 0, 0),
                        Location = "Facultatea de Matematică și Informatică" },
            new Event { Id = 1, Title = "Conferința Tech Week București",
                        Description = "Prezentări despre cloud, inteligență artificială și securitate.",
                        Date = new DateTime(2026, 10, 21, 9, 0, 0),
                        Location = "Romexpo" },
            new Event { Id = 2, Title = "Workshop ASP.NET Core MVC",
                        Description = "Se construiește pas cu pas o aplicație web cu Controller-e și View-uri.",
                        Date = new DateTime(2026, 10, 28, 16, 0, 0),
                        Location = "Laboratorul 308, FMI" },
            new Event { Id = 3, Title = "Concert de toamnă",
                        Description = "Concert în aer liber cu trupe studențești.",
                        Date = new DateTime(2026, 10, 31, 19, 0, 0),
                        Location = "Arenele Romane" },
            new Event { Id = 4, Title = "Crosul studenților",
                        Description = "Alergare de 5 km, deschisă tuturor studenților.",
                        Date = new DateTime(2026, 10, 17, 10, 0, 0),
                        Location = "Parcul Tineretului" }
        ];

        return events;
    }


    [NonAction]
    public Event? search(int? id)
    {

        if (id is null)
        {
            return null;
        }

        Event[] events = getEvents();

        foreach (Event item in events)
        {
            if (item.Id == id)
            {
                return item;
            }
        }

        return null;
    }


    [HttpGet]
    public IActionResult Index()
    {
        Event[] events = getEvents();

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


        Event[] events = getEvents();
        Event? ev = null;

        foreach (Event item in events)
        {
            if (item.Id == id)
            {
                ev = item;
                break;
            }
        }

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
        return View("NewPostMethod");
    }


    [HttpGet]
    public IActionResult Edit(int? id)
    {
        if (id == null)
        {
            ViewBag.ErrorMessage = "nu ai specificat id";
            return View();
        }

        if(search(id) == null)
        {
            Response.StatusCode = StatusCodes.Status404NotFound;
            ViewBag.ErrorMessage = "Nu există niciun eveniment cu id-ul " + id + ".";
            return View("Error");
        }
        
        Event ev = search(id);

        ViewBag.Event = ev;

        return View();
    }

    [HttpPost]
    public IActionResult Edit(Event ev)
    {
        // logica de editare

        return View("EditMethod");
    }


    [HttpPost]
    public IActionResult Delete(int id)
    {

        // logica de stergere 

        return RedirectToAction("Index");
    }

}