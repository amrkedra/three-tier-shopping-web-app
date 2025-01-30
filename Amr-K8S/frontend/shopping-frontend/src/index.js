import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css'; // Optional CSS for styling
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root')); // Linking to <div id="root">
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
