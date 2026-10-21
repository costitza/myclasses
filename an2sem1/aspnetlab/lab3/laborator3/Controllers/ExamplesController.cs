using Microsoft.AspNetCore.Mvc;


namespace laborator3.Controllers;


public class ExamplesController : Controller
{
    public string Concatenare(string str1, string str2)
    {
        
        return str1 + str2; 
    }

    public string Produs(int param1, int? param2)
    {
        
        if (param2 != null)
        {
            return (param1 * param2.Value).ToString();
        }

        return "Introdu si pe parametrul 2!";
    }


    public string Operatie(int? param1, string? oper, int? param2)
    {
        if(param1 == null)
        {
            return "ai uitat de param1";
        }

        if(param2 == null)
        {
            return "ai uitat de param2";
        }

        if(oper == null)
        {
            return "ai uitat de operatie";
        }

        switch (oper)
        {
            case "+":
                return param1.ToString() + "+" + param2.ToString() + "=" + (param1 + param2).ToString();
            case "-":
                return param1.ToString() + "-" + param2.ToString() + "=" + (param1 - param2).ToString();
            case "/":
                return param1.ToString() + "/" + param2.ToString() + "=" + (param1 / param2).ToString();
            case "*":
                return param1.ToString() + "*" + param2.ToString() + "=" + (param1 * param2).ToString();
            default:
                return "nu cunosc operatia";
        }
    }
}