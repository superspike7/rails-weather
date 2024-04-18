import { Controller } from "@hotwired/stimulus"

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
      listItem.classList.add('list-group-item', 'result');
      listItem.style.cursor = 'pointer';
      this.resultsTarget.appendChild(listItem);
    });
  }

  clearResults() {
    this.resultsTarget.innerHTML = "";
  }
}
