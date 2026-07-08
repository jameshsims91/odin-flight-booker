import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container", "template" ]

  connect() {
    this.recalculatePassengerNumbers()
  }

  add(event) {
    event.preventDefault()

    const currentCount = this.containerTarget.querySelectorAll(".passenger-fields").length
    const nextIndex = currentCount

    const content = this.templateTarget.content.cloneNode(true)
    
    content.querySelectorAll("input").forEach((element) => {
      if (element.hasAttribute("name")) {
        element.setAttribute("name", element.getAttribute("name").replace(/INDEX/g, nextIndex))
      }
    })

    this.containerTarget.appendChild(content)
    this.recalculatePassengerNumbers()
  }

  remove(event) {
    event.preventDefault()

    const wrapper = event.target.closest(".passenger-wrapper")
    const destroyFlag = wrapper.querySelector(".destroy-flag")

    if (destroyFlag) {
      destroyFlag.value = "1"
      wrapper.style.display= "none"
      wrapper.querySelectorAll("input[required]").forEach(input => input.removeAttribute("required"))
    } else {
      wrapper.remove()
    }
    this.recalculatePassengerNumbers()
  }

  recalculatePassengerNumbers() {
    let index = 1
    const activeWrappers = Array.from(this.containerTarget.querySelectorAll(".passenger-wrapper"))
      .filter(wrapper => wrapper.style.display !== "none")

      activeWrappers.forEach((wrapper) => {
        const legendNum = wrapper.querySelector(".passenger-number")
      if (legendNum) {
        legendNum.textContent = index
      } else {
        const legend = wrapper.querySelector("legend strong")
        if (legend) legend.textContent = `Passenger #${index}`
      }

      const removeButton = wrapper.querySelector("button[data-action='click->nested-form#remove']")
      if (removeButton) {
        if (activeWrappers.length === 1) {
          removeButton.disabled = true
          removeButton.style.opacity = "0.5"
          removeButton.style.cursor = "not-allowed"
          removeButton.title = "A booking must have at least one passenger."
        } else {
          removeButton.disabled = false
          removeButton.style.opacity = "1"
          removeButton.style.cursor = "pointer"
          removeButton.removeAttribute("title")
        }
      }

      index++
    })

    // 3. Update the ticket counter in the flight summary card
    const finalCount = index - 1
    const ticketsCountSpan = document.getElementById("tickets-count")
    if (ticketsCountSpan) {
      ticketsCountSpan.textContent = finalCount
    }
  }
}