public class Event
{
 public int Id { get ; set ; }
 public string Title { get ; set ; } = string .Empty;
 public string Description { get ; set ; } = string .Empty;
 // data și ora la care are loc evenimentul
 public DateTime Date { get ; set ; }
 public string Location { get ; set ; } = string .Empty;
}