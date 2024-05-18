from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
from twilio.rest import Client

# Set the path to the ChromeDriver executable
# chrome_driver_path = '/home/dibin/dibin/learning/chrome-drivers/chromedriver-linux64/chromedriver' 
# chrome_driver_path = 'https://github.com/dibinxavier/ticket-booking-alert/blob/main/chromedriver' 
chrome_driver_path = './chromedriver' 

# Set up Chrome options
chrome_options = Options()
chrome_options.add_argument('--headless')  # Run Chrome in headless mode if needed
# chrome_options.add_argument('--disable-gpu')  # Disable GPU acceleration if needed
chrome_options.add_argument('--no-sandbox')  # Bypass OS security model, useful for CI environments
chrome_options.add_argument('--disable-dev-shm-usage')  # Overcome limited resource problems

# Create a new instance of the Chrome driver
service = Service(chrome_driver_path)
driver = webdriver.Chrome(service=service, options=chrome_options)


def sendTwilioMessage(message):
    account_sid = 'ACf349f16d4c1d42453b115c4f78804831'
    auth_token = 'b522abf69803a697dc4b8ba5038f5587 test'
    # auth_token = 'b522abf69803a697dc4b8ba5038f5587'
    fromNumber= '+16363227054'
    toNumber= '+918714812137'
    client = Client(account_sid, auth_token)
    message = client.messages.create(
        from_=fromNumber,
        body=message,
        to=toNumber
    )
    message = client.messages(message.sid).fetch()
    if message is not None and message != "":
        print(f"Message sent successfully! - SID = {message.sid}")
        print(f"Message Status: {message.status}")

def scriptFromMainPage():
    try:
        # Navigate to the webpage
        driver.get('https://insider.in/ipl-indian-premier-league')

        # Wait for the span element to be present and clickable
        WebDriverWait(driver, 10).until(
            EC.element_to_be_clickable((By.CLASS_NAME, 'css-12lpvy4'))
        )

        # Find the span element by its class name and click it
        skip_button = driver.find_element(By.CLASS_NAME, 'css-12lpvy4')
        skip_button.click()
        # time.sleep(5)

        # Execute a script in the browser's console
        script = """
        var anchorElement = document.querySelector("a[href='/tata-ipl-2024-qualifier-2-24may-24/event']");
        if (!(anchorElement && anchorElement.innerHTML.includes("COMING SOON"))) {
            console.log("COMING SOON text not found within the anchor tag or anchor tag does not exist.");
            return true;
        } else {
            return false;
        }
        """
        result=driver.execute_script(script)
        print (result)
        if result!=True:
            message='Playoff 2 tickets available!'
            # sendTwilioMessage(message)
            with open("bookings_open", 'x') as f:
                f.write(message)
        input("Press Enter to close the browser...")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        print ("test success finally")


def scriptFromPlayoff2Page():
    try:
        driver.get('https://insider.in/tata-ipl-2024-qualifier-2-24may-24/event')
        time.sleep(5)

        # Execute a script in the browser's console
        script = """
            var anchorElement = document.querySelector("a[href='/event/tata-ipl-2024-qualifier-2-24may-24/buy-page']");

            if ((anchorElement && anchorElement.innerHTML.includes("BUY NOW"))) {
                console.log("BUY NOW text found within the anchor tag or anchor tag does not exist.");
                return true;
            }else {
                return false;
            }
            """
        result=driver.execute_script(script)
        print (result)
        if result:
            message='TEST message : Playoff 2 tickets available!'
            sendTwilioMessage(message)
        print ("test success")
        input("Press Enter to close the browser...")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        print ("test success finally")


scriptFromMainPage()
# scriptFromPlayoff2Page()
