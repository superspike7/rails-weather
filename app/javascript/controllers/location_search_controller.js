import { Controller } from "@hotwired/stimulus"
import { snakeCase } from "../helpers/snake_case";

// Connects to data-controller="location-search"
export default class extends Controller {
  static targets = ["input", "results"];
  static debounceTimeout = 800;

  connect() {
    this.debounceTimer = null;

    this.inputTarget.addEventListener("input", () => {
      this.clearResults();
      clearTimeout(this.debounceTimer);
      this.debounceTimer = setTimeout(() => {
        this.search();
      }, this.constructor.debounceTimeout);
    });

    this.resultsTarget.addEventListener("click", (event) => {
      const resultElement = event.target.closest("li");
      if (resultElement) {
        const name = snakeCase(resultElement.dataset.name);
        const lat = parseFloat(resultElement.dataset.lat);
        const lon = parseFloat(resultElement.dataset.lon);
        this.createLocation(name, lat, lon);
      }
    });
  }

  async search() {
    const term = this.inputTarget.value.trim();
    if (!term) return;

    try {
      const response = await fetch(`/locations?term=${term}`);
      if (!response.ok) {
        throw new Error("Error");
      }
      const data = await response.json();
      console.log('data', data)
      this.renderResults(data);
    } catch (error) {
      console.error("Error fetching search results:", error);
    }
  }

  renderResults(results) {
    this.clearResults();
    results.forEach((result) => {
      const listItem = document.createElement("li");
      listItem.textContent = result.data.display_name;
      listItem.setAttribute("data-name", result.data.name);
      listItem.setAttribute("data-lon", result.data.lon);
      listItem.setAttribute("data-lat", result.data.lat);
      listItem.classList.add('list-group-item', 'result');
      listItem.style.cursor = 'pointer';
      this.resultsTarget.appendChild(listItem);
    });
  }

  async createLocation(name, lat, lon) {
    try {
      const response = await fetch(`/locations`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').getAttribute("content")
        },
        body: JSON.stringify({ location: { name, lat , lon } })
      });
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      const data = await response.json();

      Turbo.visit(`/weathers/${data.name}`);
      console.log("Location created:", data);
    } catch (error) {
      console.error("Error creating location:", error);
    }
  }

  clearResults() {
    this.resultsTarget.innerHTML = "";
  }
}
