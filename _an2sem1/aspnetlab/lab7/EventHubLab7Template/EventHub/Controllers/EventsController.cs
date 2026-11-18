using EventHub.Data;
using EventHub.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering; // SelectListItem (lista pentru dropdown)
using Microsoft.EntityFrameworkCore; // Include(), ToListAsync(), FirstOrDefaultAsync() etc.

namespace EventHub.Controllers;

// Din Laboratorul 7, acțiunile care lucrează cu baza de date sunt asincrone
// (async Task<IActionResult> + await + metodele ...Async din Entity Framework Core).
// VEZI Curs 7 – secțiunea Trimiterea datelor către View → Model.
// Locurile de completat sunt marcate cu TODO (numărul exercițiului din Laboratorul 7).
public class EventsController : Controller
{
    private readonly ApplicationDbContext db;

    public EventsController(ApplicationDbContext context)
    {
        db = context;
    }

    // EXERCIȚIUL 2 – de analizat
    // Se afișează lista tuturor evenimentelor, împreună cu categoria
    // din care fac parte, în ordinea în care au loc
    // HttpGet implicit
    public async Task<IActionResult> Index()
    {
        // se construiește interogarea (nu se execută încă):
        // Include aduce și categoria fiecărui eveniment (JOIN), OrderBy ordonează după dată
        var query = db.Events
                      .Include(e => e.Category)
                      .OrderBy(e => e.Date);

        // ToListAsync() execută interogarea în baza de date;
        // await așteaptă rezultatul fără să blocheze firul de execuție
        var events = await query.ToListAsync();

        // lista ajunge în View prin ViewBag (VEZI Curs 7 – ViewBag)
        ViewBag.Events = events;

        // mesajul scris de New, Edit sau Delete în TempData (cheia "message")
        // este citit aici și trimis către View prin ViewBag.Message
        // TempData se păstrează doar până la prima citire (VEZI Curs 7 – TempData)
        if (TempData.ContainsKey("message"))
        {
            ViewBag.Message = TempData["message"];
        }

        return View();
    }

    // EXERCIȚIUL 3a
    // Se afișează un singur eveniment în funcție de id-ul său,
    // împreună cu categoria din care face parte și cu recenziile lui
    // HttpGet implicit
    // TODO (exercițiul 3a): metoda devine asincronă – public async Task<IActionResult> Show(int id) –
    // pentru că interogarea se execută cu await ... FirstOrDefaultAsync()
    public async Task<IActionResult> Show(int id)
    {
        // TODO (exercițiul 3a): se completează interogarea (Include pentru categorie și pentru recenzii,
        // condiția din Where), se decomentează, se verifică rezultatul (NotFound)
        // și se trimite Modelul către View: return View(ev);
        
        Event? ev = await db.Events
                            .Include(ev => ev.Category)
                            .Include(ev => ev.Reviews)
                            .Where(ev => ev.Id == ev.Id)
                            .FirstOrDefaultAsync();
        
        if(ev == null)
        {
            return NotFound();
        }

        return View(ev);

        /* Metoda FirstOrDefaultAsync() este necesară pentru a obține un singur eveniment din colecția
           returnată de metoda Where. Fără ea, codul ar returna o colecție de evenimente care respectă
           condiția din Where (chiar dacă un singur eveniment îndeplinește condiția), în loc să returneze
           direct obiectul Event.
           FirstOrDefaultAsync() execută interogarea imediat și returnează primul (și singurul) eveniment
           care îndeplinește condiția, sau null dacă nu există niciunul.
        */
    }

    // EXERCIȚIUL 4c
    // Se afișează formularul în care se completează datele unui eveniment,
    // împreună cu selectarea categoriei din care face parte
    // HttpGet implicit
    public async Task<IActionResult> New()
    {
        var categories = await (from categ in db.Categories
                                select categ).ToListAsync();

        ViewBag.Categories = categories;

        // TODO (exercițiul 4c): în locul variabilei ViewBag.Categories se folosește metoda
        // GetAllCategories() (se află la finalul clasei) și se trimite către View un obiect de tip Event

        return View();
    }

    // EXERCIȚIUL 4e
    // Se adaugă evenimentul în baza de date
    [HttpPost]
    public async Task<IActionResult> New(Event ev)
    {
        try
        {
            db.Events.Add(ev);
            await db.SaveChangesAsync();
            // TODO (exercițiul 4e): aici se scrie mesajul "Evenimentul a fost adăugat" în TempData
            // Unde se va afișa acest mesaj? (VEZI acțiunea Index)
            return RedirectToAction("Index");
        }
        catch (Exception)
        {
            // TODO (exercițiul 4e): ce trebuie să returnăm pe această ramură?
            // (formularul se afișează din nou, cu datele completate – ce trebuie să conțină din nou Categ?)
            return View();
        }
    }

    // EXERCIȚIUL 5a
    // Se editează un eveniment existent în baza de date, împreună cu categoria din care face parte
    // Categoria se selectează dintr-un dropdown
    // HttpGet implicit
    // Se afișează formularul împreună cu datele evenimentului din baza de date
    public async Task<IActionResult> Edit(int id)
    {
        Event? ev = await db.Events
                            .Include(e => e.Category)
                            .FirstOrDefaultAsync(e => e.Id == id);

        if (ev is null)
        {
            return NotFound();
        }

        // TODO (exercițiul 5a): se preiau categoriile cu GetAllCategories() (în ev.Categ)
        // ce trebuie să returnăm în View?

        ev.Categ = await GetAllCategories();
        return View(ev);
    }

    // EXERCIȚIUL 5c
    // Se adaugă evenimentul modificat în baza de date
    [HttpPost]
    // TODO (exercițiul 5c): care sunt parametrii de intrare ai metodei Edit()?
    // (id-ul din URL și obiectul Event cu valorile din formular)
    public async Task<IActionResult> Edit(int id, Event requestEvent)
    {
        // TODO (exercițiul 5c): se caută evenimentul în baza de date (FindAsync) și se verifică
        // dacă există (NotFound)
        Event? ev = await db.Events.FindAsync(id);

        if (ev is null)
        {
            return NotFound();
        }

        try
        {
            // TODO (exercițiul 5c): se modifică evenimentul din baza de date, primind noile valori
            // (cele venite din formular)
            // commit -> se salvează obiectul în baza de date
            ev.Title = requestEvent.Title;
            ev.Description = requestEvent.Description;
            ev.Date = requestEvent.Date;
            ev.Location = requestEvent.Location;
            ev.CategoryId = requestEvent.CategoryId;
                
            await db.SaveChangesAsync();
            // TODO (exercițiul 5c): cum se afișează mesajul "Evenimentul a fost modificat"?
            TempData["message"] = "evenimentul a fost salvat";
            return RedirectToAction("Index");
        }
        catch (Exception)
        {
            // TODO (exercițiul 5c): ce se întâmplă pe această ramură?
            return View();
        }
    }

    // EXERCIȚIUL 6 – de analizat
    // Se șterge un eveniment din baza de date
    // Cererea vine din formularul POST din View-ul Show (asp-route-id="@Model.Id")
    // Recenziile evenimentului se șterg automat (ștergere în cascadă – VEZI Curs 6)
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

    // EXERCIȚIUL 4a – de analizat
    // Metodă ajutătoare: lista categoriilor pentru dropdown-ul din formularele New și Edit
    // [NonAction] – metoda nu este o acțiune, deci nu poate fi apelată din browser
    [NonAction]
    public async Task<IEnumerable<SelectListItem>> GetAllCategories()
    {
        // generăm o listă de tipul SelectListItem, fără elemente
        var selectList = new List<SelectListItem>();

        // extragem toate categoriile din baza de date
        // ToListAsync() execută interogarea; categoriile sunt ordonate alfabetic
        var categories = await (from cat in db.Categories
                                orderby cat.CategoryName
                                select cat).ToListAsync();

        // iterăm prin categorii
        foreach (var category in categories)
        {
            // adăugăm în listă elementele necesare pentru dropdown:
            // id-ul categoriei (Value) și denumirea acesteia (Text)
            selectList.Add(new SelectListItem
            {
                Value = category.Id.ToString(),
                Text = category.CategoryName
            });
        }

        /* Sau se poate implementa astfel:
         *
        foreach (var category in categories)
        {
            var listItem = new SelectListItem();
            listItem.Value = category.Id.ToString();
            listItem.Text = category.CategoryName;

            selectList.Add(listItem);
        }
        */

        // returnăm lista de categorii
        return selectList;
    }
}
