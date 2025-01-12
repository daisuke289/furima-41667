document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  // 要素がない場合は処理をスキップ
  if (!priceInput || !addTaxPrice || !profit) return;

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value, 10);

    // 入力が空や0以下の場合の処理
    if (isNaN(inputValue) || inputValue <= 0) {
      addTaxPrice.innerHTML = "0";
      profit.innerHTML = "0";
      return;
    }

    // 販売手数料と利益を計算
    const tax = Math.floor(inputValue * 0.1);
    const profitValue = inputValue - tax;

    // 計算結果をDOMに反映
    addTaxPrice.innerHTML = tax.toLocaleString();
    profit.innerHTML = profitValue.toLocaleString();
  });
});
