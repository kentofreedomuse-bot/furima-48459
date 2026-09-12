import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "tax", "profit"]

  calculate() {
    const price = Number(this.inputTarget.value)

    if (!Number.isFinite(price) || price <= 0) {
      this.taxTarget.textContent = ""
      this.profitTarget.textContent = ""
      return
    }

    const tax = Math.floor(price * 0.1)
    this.taxTarget.textContent = tax
    this.profitTarget.textContent = price - tax
  }
}