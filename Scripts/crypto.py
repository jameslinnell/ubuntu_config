import requests

from rich.table import Table
from rich.console import Console
from rich.align import Align

portfolio = {
    "algorand": 178.2,
    "bitcoin": 1.301949,
    "cardano": 351.6,
    "casper-network": 490.60,
    "crypto-com-chain": 3875.26,
    "ethereum": 0.09851,
    "hedera-hashgraph": 516.5,
    "moonbeam": 101.68,
    "ripple": 390.34,
    "shiba-inu": 3850044,
    "solana": 1.1295,
    "stellar": 6037.84,
}

current_portfolio = dict(
    crypto = []
)

def fetch_crypto_prices():
    url = "https://api.coingecko.com/api/v3/simple/price"
    ids = ""
    for key, value in portfolio.items():
        ids = f"{ids},{key}"
    params = {
        "ids": ids,
        "vs_currencies": "usd,gbp"
    }
    total = 0
    try:
        # Make the GET request to the API
        response = requests.get(url, params=params)
        response.raise_for_status()  # Raise an HTTPError for bad responses
        # Parse the JSON response into a dictionary
        response_data = response.json()
        for key, value in portfolio.items():
            current = response_data[key]['gbp']
            this_crypto = dict(
                position = value,
                current_value = f"£{current:.2f}",
                total = f"£{current * value:.2f}"
            )
            if key == "crypto-com-chain":
                current_portfolio['crypto'].append({"Crypto.com": this_crypto})
            elif key == "casper-network":
                current_portfolio['crypto'].append({"Casper": this_crypto})
            elif key == "hedera-hashgraph":
                current_portfolio['crypto'].append({"Hedera": this_crypto})
            elif key == "shiba-inu":
                current_portfolio['crypto'].append({"Shiba Inu": this_crypto})
            else:
                current_portfolio['crypto'].append({key: this_crypto})
            total = total + (current * value)
        current_portfolio['total'] = f"£{total:.2f}"
        return current_portfolio
    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")
        return None

def sort_data(data, key, reverse=False):
    return sorted(
        data,
        key=lambda item: float(item[next(iter(item))][key].strip('£')),
        reverse=reverse
    )

def output_data(data):
    data['crypto'] = sort_data(data['crypto'], "total", reverse=True)
    console = Console()
    table = Table(title="Cryptocurrency Prices", width=int(console.size.width * 0.5))

    # Add columns with optional styling
    table.add_column("Name", style="white")
    table.add_column("Position", style="cyan")
    table.add_column("Price (GBP)", style="yellow", justify="right")
    table.add_column("Total (GBP)", style="green", justify="right")
    
    for value in data['crypto']:
        for key, inner_dict in value.items():
            table.add_row(key.capitalize(), str(inner_dict['position']), str(inner_dict['current_value']), str(inner_dict['total']))
    table.add_section()
    table.add_row("", "", "Total", data['total'])
    centered_table = Align.center(table)
    console.print(centered_table)

if __name__ == "__main__":
    crypto_prices = fetch_crypto_prices()
    if crypto_prices:
        output_data(crypto_prices)

