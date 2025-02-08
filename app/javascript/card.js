const pay = () => {
  Payjp.setPublicKey('pk_test_1531ed87509bb0ccd7919597'); // PAY.JPのテスト公開鍵に置き換えてください
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    
    const formResult = new FormData(form);
    const card = {
      number: formResult.get("card-number"),
      cvc: formResult.get("card-cvc"),
      exp_month: formResult.get("card-exp-month"),
      exp_year: `20${formResult.get("card-exp-year")}`,
    };

    Payjp.createToken(card, (status, response) => {
      if (status === 200) {
        console.log(response.id); // トークンが作成されたらコンソールに表示されます
        form.insertAdjacentHTML('beforeend', `<input value=${response.id} name='token' type="hidden">`);
        
        // カード情報を削除してからフォームを送信
        document.getElementById("card-number").removeAttribute("name");
        document.getElementById("card-cvc").removeAttribute("name");
        document.getElementById("card-exp-month").removeAttribute("name");
        document.getElementById("card-exp-year").removeAttribute("name");

        form.submit();
      } else {
        alert("カード情報が正しくありません。");
      }
    });
  });
};

window.addEventListener("turbo:load", pay);
