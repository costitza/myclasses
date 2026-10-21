using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using laborator3.Models;

namespace laborator3.Controllers;

[Route("students")]
public class StudentsController : Controller
{
    [HttpGet("/all")]
    [HttpGet("/index")]
    public string StudentsAll()
    {
        return "afisare toti studentii";
    }

    [HttpGet("/show/{id?}")]
    public string StudentShow(string? id)
    {
        return "afisare studentul cu id: " + id;
    }

    [HttpGet("/new")]
    public string StudentCreate()
    {
        return "Crearea unui nou student";
    }

    // Răspunde la: /students/edit/5
    [HttpGet("/{id?}")]
    public string StudentEdit(string? id)
    {
        return $"Editarea studentului cu ID: {id}";
    }

    // Răspunde la: /students/delete/5
    [HttpGet("delete/{id:int}")]
    public string StudentDelete(int id)
    {
        return $"Ștergerea studentului cu ID: {id}";
    }
}
