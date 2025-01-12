const price = () => {
  console.log("price function initialized"); // 確認用
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput || !addTaxPrice || !profit) {
    console.log("Required elements not found"); // 確認用
    return;
  }

  console.log("Adding event listener to priceInput"); // 確認用
  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value, 10);
    if (isNaN(inputValue) || inputValue <= 0) {
      addTaxPrice.innerHTML = "0";
      profit.innerHTML = "0";
      return;
    }
    const tax = Math.floor(inputValue * 0.1);
    const profitValue = inputValue - tax;

    addTaxPrice.innerHTML = tax.toLocaleString();
    profit.innerHTML = profitValue.toLocaleString();
  });
};

// Turboイベントリスナー
document.addEventListener("turbo:load", () => {
  console.log("turbo:load event triggered"); // 確認用
  price();
});

document.addEventListener("turbo:render", () => {
  console.log("turbo:render event triggered"); // 確認用
  price();
});
