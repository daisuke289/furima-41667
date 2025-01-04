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

      // 販売手数料を計算（10%）
      const tax = Math.floor(inputValue * 0.1);
      addTaxPrice.innerHTML = tax;

      // 販売利益を計算
      const profitValue = inputValue - tax;
      profit.innerHTML = profitValue;
    });
  }
});
