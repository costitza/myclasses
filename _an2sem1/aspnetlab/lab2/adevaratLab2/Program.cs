namespace adevaratLab2;

class Program
{
    static void checkPal(int n)
    {
        int nr = 0, aux = n;
        while (aux != 0)
        {
            nr = nr * 10 + aux % 10;
            aux /= 10;
        }

        if(n == nr)
        {
            Console.WriteLine("este palindrom");
        }
        else
        {
            Console.WriteLine("nu este palindrom");
        }
    }

    static void checkPalString(string n)
    {
        int i = 0;
        while(i < n.Length / 2)
        {
            if(n[i] != n[n.Length - i - 1])
            {
                Console.WriteLine("nu este palindrom");
                return;
            }
            i ++;
        }


        Console.WriteLine("este palindrom");
    }

    static void Main(string[] args)
    {
        string n = Console.ReadLine();


        if(string.IsNullOrEmpty(n)) return;

        int numar;
        int.TryParse(n, out numar);

        checkPal(numar);

        string[] input = Console.ReadLine().Split(' ');
        int[] arr = Array.ConvertAll(input, int.Parse);


        for(int i = 1;i < arr.Length; i++)
        {
            if (arr[i - 1] % 2 == arr[i] % 2)
            {
                Console.WriteLine("nu");
                return;
            }
        }
        Console.WriteLine("da");
    }
}
