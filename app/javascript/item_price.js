document.addEventListener('turbo:load', () => {
    const priceInput = document.getElementById("item-price");
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
  
    if (priceInput) {
      priceInput.addEventListener("input", () => {
        const inputValue = parseInt(priceInput.value, 10);
        if (isNaN(inputValue) || inputValue <= 0) {
          addTaxPrice.innerHTML = 0;
          profit.innerHTML = 0;
          return;
        }
        const tax = Math.floor(inputValue * 0.1);
        const profitValue = inputValue - tax;
        addTaxPrice.innerHTML = tax;
        profit.innerHTML = profitValue;
      });
    }
  });
  