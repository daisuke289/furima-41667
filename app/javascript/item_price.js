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

document.addEventListener("turbo:load", () => {
  console.log("turbo:load event triggered");
  price(); // 初回ロード時の関数実行
});

document.addEventListener("turbo:render", () => {
  console.log("turbo:render event triggered");

  // DOM要素の再取得
  const priceInput = document.getElementById("item-price");
  if (priceInput) {
    price(); // 再描画後の関数再実行
  }
});
