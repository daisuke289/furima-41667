document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");

  const profit = document.getElementById("profit");

  if (priceInput) {
      priceInput.addEventListener("input", () => {
          const inputValue = parseInt(priceInput.value);

          if (isNaN(inputValue) || inputValue <= 0) {
              addTaxPrice.innerHTML = 0;
              profit.innerHTML = 0;
              return;
          }

          const tax = Math.floor(inputValue * 0.1); // 販売手数料を計算
          addTaxPrice.innerHTML = tax;

          const profitValue = inputValue - tax; // 販売利益を計算
          profit.innerHTML = profitValue;
      });
  }
});
