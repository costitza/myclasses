
from PIL import Image, ImageOps
import sys
import os

def check_ending(index):
    return sys.argv[index].endswith(".jpeg") \
        or sys.argv[index].endswith(".jpg") \
        or sys.argv[index].endswith(".png")

def check_args():
    if len(sys.argv) != 3:
        sys.exit("Too many or too few command-line arguments")
    if not check_ending(1) or not check_ending(2):
        sys.exit("Not a png, jpeg, or jpg file")
    ext1 = os.path.splitext(sys.argv[1])[1].lower()
    ext2 = os.path.splitext(sys.argv[2])[1].lower()

    if ext1 != ext2:
        sys.exit("File types are not the same")
    if os.path.exists(sys.argv[1]) is False:
        sys.exit("File does not exist")

def main():
    check_args()

    shirt = Image.open("shirt.png")
    print(shirt.size)
    image = Image.open(sys.argv[1])
    image = ImageOps.fit(
        image,
        (shirt.width, shirt.height),
        method=Image.BICUBIC,
        bleed = 0.0,
        centering=(0.5, 0.5)
    )
    # shirt.convert("RGBA")
    # crpd_img.convert("RGBA")
    image.paste(shirt, (0, 0), shirt)
    image.save(sys.argv[2])


if __name__ == "__main__":
    main()