'''This script generates synthetic data for Challenge 2, which is splitting a list of random IP addresses, domain names, and full emails into separate files.

While we are looking for some individual creativity, in general here are the categories that we expect to surface from the blocklist.txt given.

    Expected Categories:
        1. Country Code TLDs
            a. *.ru
            b. *.cn
            c. *.in
            d. *.br
        2. Top Level Domains
            a. *.info
            b. *.solutions
            c. *.dad
            d. *.hello
        3. Domain-Subdomain
            a. example.com
            b. *.example.com
            c. account-office-protections.example.biz
            d. *@*.example.com, etc.
        4. Email Addresses
            a. servers.mail.relay@tweetigniter.com
            b. example123456@gmail.com
        5. IPv4 Addresses
            a. 96.142.114.238
            b. 78.149.226.163
            c. 178.141.167.230
            d. 169.227.59.103
            e. 61.4.172.164
        6. IPv6 Addresses
            a. bacf:b3d0:b1f:9163:ce9f:f580:43b7:a3a6
            b. f91e:1d4c:1ff4:9b78:8946:3e86:759c:de66
            c. 8d52:88f1:142c:3fe8:60e7:a114:ec1b:8ca1
            d. 9e57:4f7a:a0ee:89ae:d453:dd33:4b0d:bb41
            e. 93cd:59bf:5c94:1cf0:dc98:d2c2:e2ac:f72f
'''
# imports
from faker import Faker
from faker.providers import internet
import pandas as pd
import random, argparse

# helper functions
def create_argparse() -> argparse.ArgumentParser:
    '''Create an ArgumentParser with specific details and return the object.

    This is just a way to bundle the ArgumentParser instantiation out of the __main__ function.

    There are no arguments, just edit the function itself to change values.

    Args:
        None

    Returns:
        argparse.ArgumentParser: an ArgumentParser object with the defined parameters and arguments.

    Example:
        >>> parser = create_argparse()
        >>> type(parser)
        <class 'argparse.ArgumentParser'>
    '''
    # parse arguments
    parser = argparse.ArgumentParser(
        prog='ChallengeDataGenerator',
        description='This script generates internet/email related data for use in coding challenges.',
        epilog='For more information, see https://faker.readthedocs.io/en/master/locales/en_US.html'
        )

    # add expected arguments    
    parser.add_argument('-e', '--entries', default=3000, type=int, choices=[x for x in range(1,100001)], help='The number of rows of fake emails/domains/IP addresses to generate (default: %(default)s)')

    return parser

class ExtendedFaker(Faker):
    '''Extends the faker.Faker() class to include custom generation functions.

    Specifically, adds a variation of generating domains and subdomains, as well as top-level domains. No base class functions are overridden

    Attributes:
        _tld_list (list[str]): Private list of top-level domains parsed from file `tld.txt` which should reside in the same directory.
    '''
    def __init__(self):
        '''Extended __init__ method from base Faker class.

        This method simply calls the super __init__ method and then tries to populate the private _tld_list attribute for later use.
        '''
        Faker.__init__(self) # call base Faker class first

        # populate the built-in TLD list that will be needed for self.gen_topleveldomain()
        try:
            self._tld_list = [item[0] for item in pd.read_csv('./tld.txt', header=None, encoding='utf-8').values]
        except Exception as err:
            print("An unexpected error occurred. `tld.txt` probably doesn't exist or is the wrong encoding.")
            print(err)
            self._tld_list = ['*.corp', '*.ai', '*.co', '*.ml', '*.ru', '*.biz', '*.co.uk', '*.cn', '*.in', '*.service', '*.education']

    def gen_domain_subdomain(self) -> str:
        '''Generates a random domain or subdomain of a few different varieties.

        This function could generate domains and subdomains of a few different types, meant to replicate how the block list used to look and see how candidates deal with the various forms of this.

        e.g. acumatica.com, *.actualtechevents.com, account-office-protections.microsoft.biz, *@*.actualtechevents.com, etc.

        There could be 1 or 2 levels of nesting, and potentially has the * character as the subdomain, or even *@* as the start of the address.

        Args:
            None

        Returns:
            str: The generated domain or subdomain string.

        Example:
            >>> ExtendedFaker.seed(42)
            >>> fake = ExtendedFaker()
            >>> fake.add_provider(internet)
            >>> for _ in range(5):
            >>>     print(fake.gen_domain_subdomain())
            *.johnson-friedman.info
            *@*.hardy.com
            *.hoffman.robinson.com
            *.guerrero-hicks.com
            pennington.com
        '''
        rand_choice = random.choices(population=[0,1,2,3], weights=[0.3, 0.25, 0.25, 0.2], k=1)

        domain_string = ''

        match rand_choice[0]:
            case 0:
                # domain.TLD
                if random.random() > 0.65:
                    # generates random domain word and pulls random TLD or ccTLD
                    domain_string = f'{self.domain_word()}.{random.choice(self._tld_list)}'
                else:
                    # generates random domain name and TLD of algorithm choice
                    domain_string = self.domain_name()
            case 1:
                # *.domain.TLD
                if random.random() > 0.65:
                    # generates random domain word and pulls random TLD or ccTLD
                    domain_string = f'*.{self.domain_word()}.{random.choice(self._tld_list)}'
                else:
                    # generates random domain name prefixed with wildcard
                    domain_string = f'*.{self.domain_name()}'
            case 2:
                # subdomain.domain.TLD
                if random.random() > 0.65:
                    # generates random domain words and pulls random TLD or ccTLD
                    domain_string = f'{self.domain_word()}.{self.domain_word()}.{random.choice(self._tld_list)}'
                else:
                    # generates random domain name prefixed with wildcard
                    domain_string = f'*.{self.domain_name(levels=2)}'
            case 3:
                # *@*.domain.TLD OR *@*.domain.TLD
                if random.random() > 0.65:
                    # generates random domain word and pulls random TLD or ccTLD
                    domain_string = f'*@*.{self.domain_word()}.{random.choice(self._tld_list)}'
                else:
                    # generates random domain name prefixed with wildcard
                    domain_string = f'*@*.{self.domain_name()}'
            case _:
                domain_string = self.domain_name() # basic
        
        return domain_string

    def gen_topleveldomain(self) -> str:
        '''Generates a random country code Top Level Domain (ccTLD) or Top Level Domain (TLD) from a list.

        Returns:
            str: The generated ccTLD or TLD.

        Example:
            >>> ExtendedFaker.seed(42)
            >>> fake = ExtendedFaker()
            >>> fake.add_provider(internet)
            >>> print(fake.gen_topleveldomain())
            *.ai
        '''
        return f"*.{random.choice(self._tld_list)}"

if __name__ == '__main__':
    # create argparse and return arguments object
    parser = create_argparse()
    args = parser.parse_args()  # -e or --entries

    # initialize ExtendedFaker
    ExtendedFaker.seed(42)
    fake = ExtendedFaker()
    fake.add_provider(internet) # all functions used are from the internet provider specifically

    # function and weights list
    func_list = [fake.ascii_company_email, fake.ascii_email, fake.ascii_free_email, fake.gen_domain_subdomain, fake.ipv4_public, fake.gen_topleveldomain, fake.ipv6]
    func_weights = [0.19, 0.19, 0.2, 0.3, 0.01, 0.1, 0.01]  # based on actual distribution of blocklist entries

    # use Pandas Series to generate CSV of blocklist items for Challenge 2
    fake_data = pd.Series([random.choices(population=func_list, weights=func_weights, k=1)[0]() for _ in range(args.entries + 1)])

    fake_data.drop_duplicates(inplace=True)

    fake_data.to_csv('../Challenge2/blocklist.txt', index=False, header=False)