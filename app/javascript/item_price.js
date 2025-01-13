const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!addTaxPrice || !profit) {
    console.log("Required elements not found");
    return;
  }

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value, 10);

    // 金額が正しく入力されていない場合の処理
    if (isNaN(inputValue) || inputValue <= 0) {
      addTaxPrice.innerHTML = "0";
      profit.innerHTML = "0";
      return;
    }

    // 販売手数料と利益の計算
    const tax = Math.floor(inputValue * 0.1);
    const profitValue = inputValue - tax;

    // innerHTMLを使って値を更新
    addTaxPrice.innerHTML = tax.toLocaleString();
    profit.innerHTML = profitValue.toLocaleString();
  });
};

// turbo:load と turbo:render のイベントリスナーを追加
document.addEventListener("turbo:load", price);
document.addEventListener("turbo:render", price);
