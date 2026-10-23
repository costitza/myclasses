namespace laborator2;

class Program
{
    static void Main(string[] args)
    {

        int nr = 100;
        string str = "Acesta este un text" ;
        double d = 12.35;
        char c = 'a' ;
        bool b = true ;
        object obj = 100;
        Console.WriteLine( "Numarul este " + nr);
        Console.WriteLine( " Stringul este: " + str);
        Console.WriteLine( "Numarul in virgula mobila este: " + d);
        Console.WriteLine( "Caracterul este: " + c);
        Console.WriteLine( "Valoarea de adevar este: " + b);
        Console.WriteLine( "Obiectul este: " + obj);
        Console.WriteLine("Hello, World!");


        Console.WriteLine($"Numarul este {nr}" );
        Console.WriteLine($"Stringul este: {str}" );
        Console.WriteLine($"Dublul numarului este: {nr * 2}" );

        
        var count = 10;
        var message = "Acesta este un text" ;
        Console.WriteLine(count.GetType());
        Console.WriteLine(message.GetType());


        DateTime now = DateTime .Now;
        DateTime eventDate = new DateTime (2026, 11, 14, 10, 0, 0);
        DateTime deadline = eventDate.AddDays( - 7);
        Console.WriteLine(eventDate.ToString( "dd.MM.yyyy HH:mm" ));
        Console.WriteLine(deadline.ToString( "dd.MM.yyyy" ));
        Console.WriteLine(eventDate > now ? "Evenimentul urmeaza": "Evenimentul a avut loc" );
    }
}
