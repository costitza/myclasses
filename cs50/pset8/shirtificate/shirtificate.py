from fpdf import FPDF

def create_pdf(name):
    pdf = FPDF(orientation="P", format="A4")

    pdf.add_page()
    pdf.set_font("Helvetica", "B", size=32)

    pdf.cell(0, 30, "CS50 Shirtificate", align="C")
    pdf.image("shirtificate.png", x=10, y=60, w=190)
    
    pdf.set_font("Helvetica", "B", size=24)
    pdf.set_xy(0, 130)
    pdf.set_text_color(255, 255, 255)
    pdf.cell(0, 10, f"{name} took CS50", align="C")

    pdf.output("shirtificate.pdf")

def main():
    name = input("Name: ")
    create_pdf(name)


if __name__ == "__main__":
    main()