const pay = () => {
  const publicKey = gon.public_key;
  const payjp = Payjp(publicKey);
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

    if (document.querySelector('input[name="token"]')) {
      form.submit();
      return;
    }

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        alert('カード情報が正しくありません');
      } else {
        const token = response.id;
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        form.submit();
      }
    });
  });
};

document.addEventListener("turbo:load", pay);
document.addEventListener("turbo:render", pay);
