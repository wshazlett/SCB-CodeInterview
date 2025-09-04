<p align="center">
  <a href="https://stylecraft.com" target="_blank" alt="Stylecraft Builders Home"><img src="../img/scb_white-background.png" width="450" /></a>
</p>

# Challenge 2: Domain Blocklist Parsing

## DISCLAIMER

The `blocklist.txt` file was generated using the Python `faker` synthetic data library. This means that this is not real data, and none of the domains, subdomains, email addresses, or IP addresses were meant to have any relation to real data. Any resemblance to real domains, subdomains, email addresses, or IP addresses is coincidental.

**The only exception are the Top-Level Domains, which are from a list of commonly blocked Top-Level Domains based on current threat data.**

If this file contains real information, please open an issue on this repository so that we can remove that information from this file.

## Scenario

You are preparing to migrate from one email system to another, and you'd like to somehow take your blocklist with you. Unfortunately, the originating system only lets you export a mix of blocklist items, while your new system needs them split out into categories.

Here is an excerpt from your blocklist:

```
*.pl
burton.carlson-cruz.xyz
jrice@frazier.net
mack-peterson.graham-chavez.realestate
teresa28@harrell.net
219.247.26.45
georgetracy@hickman.com
allen.ca
millertodd@spence.com
donnaarroyo@baker.biz
8a0f:4efb:edcd:465e:3638:6822:f6e0:7cc0
jenniferross@santos.com
*.walker.com
adrianzimmerman@perez.com
*.palmer.info
jenniferkhan@kennedy.com
hopkinsmichael@owens-daniel.com
zchandler@wright.net
ltaylor@ford-baxter.com
```

## Task

Write a Powershell script to ingest the `blocklist.txt` file and create new files with lists from the following categories:

1. Country Code TLDs
    1. *.ru
    2. *.cn
    3. *.in
    4. *.br
2. Top Level Domains
    1. *.info
    2. *.solutions
    3. *.dad
    4. *.hello
3. Domain-Subdomain
    1. example.com
    2. *.example.com
    3. account-office-protections.example.biz
    4. *@*.example.com, etc.
4. Email Addresses
    1. servers.mail.relay@tweetigniter.com
    2. example123456@gmail.com
5. IPv4 Addresses
    1. 96.142.114.238
    2. 78.149.226.163
    3. 178.141.167.230
    4. 169.227.59.103
    5. 61.4.172.164
6. IPv6 Addresses
    1. bacf:b3d0:b1f:9163:ce9f:f580:43b7:a3a6
    2. f91e:1d4c:1ff4:9b78:8946:3e86:759c:de66
    3. 8d52:88f1:142c:3fe8:60e7:a114:ec1b:8ca1
    4. 9e57:4f7a:a0ee:89ae:d453:dd33:4b0d:bb41
    5. 93cd:59bf:5c94:1cf0:dc98:d2c2:e2ac:f72f

Each new file should have **one entry per line** and should be in .txt format.

Please thoroughly comment and document your code.

### Bonus

You determine that you will be using Exchange Online Transport Rules to block these items.

For the TLDs and domains/subdomains file, create a file that contains properly formatted and efficient blocking rules that conform to the limitations of EXO Transport Rules for filtering sender addresses.

There are character limits for **each line (each entry)**, and for **each rule.** Try using a regular expression such as `\.(first|second|third)\.com$` to describe each line.

## Example

You don't have to use these exact categories, but you should be able to justify how you split your blocklist.

```PowerShell
>>> .\Parse-BlockList -Path blocklist.txt
.\output\ccTLD-blocklist.txt has been created with 78 items
.\output\TLD-blocklist.txt has been created with 44 items
.\output\domain-subdomain-blocklist.txt has been created with 2918 items
.\output\email-blocklist.txt has been created with 3028 items
.\output\ipv4-blocklist.txt has been created with 13 items
.\output\ipv6-blocklist.txt has been created with 2 items
```