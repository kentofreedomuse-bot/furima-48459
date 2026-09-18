const pay = () => {
  const form = document.getElementById('charge-form');
  if (!form || form.dataset.payjpInitialized === 'true') return;

  const publicKey = form.dataset.payjpPublicKey;
  if (!publicKey) {
    console.warn('PAYJP_PUBLIC_KEY is not set.');
    return;
  }

  if (!window.Payjp) {
    console.warn('Payjp script is not loaded.');
    return;
  }

  const payjp = window.payjp || (window.payjp = Payjp(publicKey));
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  form.dataset.payjpInitialized = 'true';

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        return;
      }

      const token = response.id;
      const renderDom = document.getElementById("charge-form");
      const tokenObj = `<input value=${token} name='token' type="hidden">`;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      renderDom.submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);