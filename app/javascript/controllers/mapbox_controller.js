import { Controller } from "stimulus";
import "mapbox-gl/dist/mapbox-gl.css";
import mapboxgl from "mapbox-gl";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";

export default class extends Controller {
  connect() {
    mapboxgl.accessToken = this.element.dataset.mapboxApiKey;

    const map = new mapboxgl.Map({
      container: "map",
      style: "mapbox://styles/mapbox/dark-v10",
    });

    const markers = JSON.parse(this.element.dataset.markers);

    const fitMapToMarkers = (map, markers) => {
      const bounds = new mapboxgl.LngLatBounds();
      markers.forEach((marker) => bounds.extend([marker.lng, marker.lat]));
      map.fitBounds(bounds, { padding: 200, maxZoom: 15, duration: 2000 });
    };

    markers.forEach((marker) => {
      // Create info popup
      const popup = new mapboxgl.Popup().setHTML(marker.info_window);

      // Create HTML element for custom marker
      const element = document.createElement("div");
      element.innerHTML = marker.marker_html.trim();

      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });

    if (markers.length) {
      fitMapToMarkers(map, markers);
    }

    // Add search input field
    map.addControl(
      new MapboxGeocoder({
        accessToken: mapboxgl.accessToken,
        mapboxgl: mapboxgl,
      })
    );
  }
}
