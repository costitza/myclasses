var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseRouting();

app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}")
    .WithStaticAssets();

// concatenare/str1/str2
app.MapControllerRoute(
    name: "Concatenare",
    pattern: "concatenare/{str1}/{str2}",
    defaults: new { controller = "Examples", action = "Concatenare"}
);

// produs/param1/param2
app.MapControllerRoute(
    name: "Produs",
    pattern: "produs/{param1}/{param2?}",
    defaults: new { controller = "Examples", action = "Produs" }
);

// operatie/param1/param2/oper
app.MapControllerRoute(
    name : "Operatie",
    pattern: "operatie/{param1?}/{param2?}/{oper?}",
    defaults: new { controller = "Examples", action = "Operatie" }
);


app.Run();
