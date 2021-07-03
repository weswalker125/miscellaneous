import os
import pandas
from shutil import copyfile
import datetime
import requests
from tqdm import tqdm
from openpyxl import load_workbook
import subprocess

# Primary working location 
rootDir = "/tmp/zack"
today = datetime.date.today()
workingDir = rootDir + "/" + today.strftime("%Y-%m-%d")
urlFormat = "https://www.zacks.com/{service_name}/download_trades.php"
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 6.0; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0"
}
downloadedFiles = []

# Names of services available to Zack's subscribers
services = [
    "etfinvestor",
    "homerun",
    "incomeinvestor",
    "valueinvestor",
    "top10",
    "blackboxtrader",
    "counterstrike",
    "headlinetrader",
    "insidertrader",
    "largecaptrader",
    "optionstrader",
    "shortlist",
    "surprisetrader",
    "tazr"
]

# Create working directory for today
os.makedirs(workingDir, exist_ok=True)

# Copy template
mainExcelFile = workingDir + "/" + "main.xlsx"
copyfile(rootDir + "/" + "template.xlsm", mainExcelFile)

# Download the trades
for service in services:
    url = urlFormat.format(service_name = service)
    try:
        filename = workingDir + "/" + service + ".xlsx"
        # Download the file if we don't have it
        if not os.path.isfile(filename):
            print("Downloading from " + url)
            r = requests.get(url, headers=headers, allow_redirects=True, stream=True)
            with open(filename, "wb") as f:
                for data in tqdm(r.iter_content()):
                    f.write(data)
        downloadedFiles.append({ "name": service, "file": filename })
    except Exception as err:
        print("Error occurred downloading for " + service)
        print(err)

# Open the main workbook (copied from the template)
mainWorkbook = load_workbook(filename=mainExcelFile)
# Copy the first sheet of each downloaded file into the main workbook
for f in downloadedFiles:
    try:
        # load workbook
        wb = load_workbook(f["file"])
        sheet = wb.worksheets[0]

        # Add sheet to main file
        newSheet = mainWorkbook.create_sheet(f["name"])

        # Copy data from each row in sheet
        for row in sheet:
            for cell in row:
                newSheet[cell.coordinate].value = cell.value
    except Exception as err:
        print("Failed to read file: " + f["file"])
        print(err)

mainWorkbook.save(mainExcelFile)
print("Today's workbook is at " + mainExcelFile)

print("Attempting to open workbook...")
subprocess.run(["open", mainExcelFile])