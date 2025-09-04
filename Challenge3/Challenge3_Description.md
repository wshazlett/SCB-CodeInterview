<p align="center">
  <a href="https://stylecraft.com" target="_blank" alt="Stylecraft Builders Home"><img src="../img/scb_white-background.png" width="450" /></a>
</p>

# Challenge 3: API Calls

## Scenario

In your daily work, you may be tasked with using REST APIs for different services. Knowing this, you will need to be comfortable requesting and retrieving data using a REST API.

For this task, I would suggest using the Federal Reserve Bank of St. Louis's FRED API. You can freely obtain an API key by creating a free account. **You can use another API if you already have an API key for it and can justify its usage.**

## Task

Write a Powershell script (only PowerShell) that calls out to an API **using an API key** or other form of **authenticated** request, and return the data as a JSON formatted file. You MUST make authenticated requests for this challenge, and cannot make unauthenticated reuqests.

For example, you may want to make a request to get data from a FRED series using your API key, then display that result in a JSON file.

**This is not a data analysis challenge. You do not need to perform any analytics on the data you pull from this API.**

Please make sure to address suboptimal scenarios, such as:

- Network is unavailable
- API is unavailable
- API calls have been rate limited due to excessive use (if applicable)
- Monitoring for and avoiding overusing API calls
- Unexpected failures elsewhere

## Helpful Resources

- [FRED API Documentation](https://fred.stlouisfed.org/docs/api/fred/)
- [Request or View FRED API Keys](https://fred.stlouisfed.org/docs/api/api_key.html)