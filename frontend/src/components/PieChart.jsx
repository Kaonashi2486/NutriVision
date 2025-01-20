import React, { useRef } from 'react';
import { Radar } from 'react-chartjs-2';
import { Chart as ChartJS, RadialLinearScale, CategoryScale, LinearScale, Title, Tooltip, Legend, Filler, LineElement, PointElement } from 'chart.js';

// Register necessary chart components
ChartJS.register(
  RadialLinearScale,
  CategoryScale,
  LinearScale,
  Title,
  Tooltip,
  Legend,
  Filler,
  LineElement,
  PointElement
);

// Utility functions to generate data
const Utils = {
  // Custom labels for nutrients
  nutrients: ['Calories', 'Fats', 'Proteins', 'Carbs', 'Fiber'],

  // Generate random numbers for each nutrient data value
  numbers: (inputs) => {
    const { min, max, count, decimals } = inputs;
    const randomNumbers = [];
    for (let i = 0; i < count; i++) {
      randomNumbers.push(parseFloat((Math.random() * (max - min) + min).toFixed(decimals)));
    }
    return randomNumbers;
  },

  transparentize: (color, opacity = 0.5) => {
    const colorParts = color.match(/\d+/g);
    return `rgba(${colorParts[0]}, ${colorParts[1]}, ${colorParts[2]}, ${opacity})`;
  },
  CHART_COLORS: {
    red: 'rgb(255, 99, 132)',
    blue: 'rgb(54, 162, 235)',
    green: 'rgb(75, 192, 192)',
    yellow: 'rgb(255, 205, 86)',
    orange: 'rgb(255, 159, 64)',
    purple: 'rgb(153, 102, 255)',
    grey: 'rgb(201, 203, 207)',
  },
};

// Constants and initial dataset configuration
const DATA_COUNT = 5;  // We are using 5 labels (nutrients)
const NUMBER_CFG = { count: DATA_COUNT, min: 0, max: 100 };  // Random values between 0 and 100

// Initial data and labels based on nutrient terms
const labels = Utils.nutrients;
const data = {
  labels: labels,
  datasets: [
    {
      label: 'Nutrient Data',
      data: Utils.numbers(NUMBER_CFG),  // Randomized data for each nutrient
      borderColor: Utils.CHART_COLORS.green,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.green, 0.5),
    }
  ]
};

// Chart configuration for the radar chart
const config = {
  type: 'radar',
  data: data,
  options: {
    responsive: true,
    scale: {
      ticks: {
        beginAtZero: true,
        max: 100,  // Set max value for the chart
      },
    },
  },
};

const PieChart = () => {
  const chartRef = useRef(null);

  return (
    <div className="bg-white" style={{ width: 400, height: 300 }}>
      {/* Radar chart itself with reduced size */}
      <Radar data={data} options={config.options} ref={chartRef} width={400} height={300} />
    </div>
  );
};

export default PieChart;
