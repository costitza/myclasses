import re

def search_extension(ext):
    return{
        "gif" : "image/gif",
        "jpg" : "image/jpeg",
        "jpeg" : "image/jpeg",
        "png" : "image/png",
        "pdf" : "application/pdf",
        "zip" : "application/zip",
        "txt" : "text/plain"
    }.get(ext, "application/octet-stream")

def main():
    file = input("File name: ")
    file = file.lower().strip()

    index = file.rfind('.')

    if index is not None:
        print(search_extension(file[index + 1:]))
    else:
        print("application/octet-stream")

main()
