const pay = () => {
  console.log("カード.js 読み込み開始"); // スクリプトの動作確認

  const publicKey = gon.public_key; // gon から公開鍵を取得
  console.log("Pay.jp Public Key:", publicKey); // 公開鍵の値をログ出力

  if (!publicKey) {
    console.error("Pay.jp Public Key が取得できません。環境変数の設定を確認してください。");
    return; // 以降の処理を停止
  }

  const payjp = Payjp(publicKey); // Pay.jp を初期化
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    console.log("フォーム送信開始");

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error("トークン作成エラー:", response.error);
        return false;
      }

      const token = response.id;
      console.log("生成されたトークン:", token); // 取得したトークンをログ出力

      const renderDom = document.getElementById('charge-form');
      const tokenObj = `<input value="${token}" name="order_form[token]" type="hidden">`;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);

      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();

      console.log("トークンを送信し、フォームを再送信");
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
