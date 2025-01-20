import React from 'react';
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
  months: ({ count }) => {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months.slice(0, count);
  },
  numbers: (inputs) => {
    const { min, max, count, decimals } = inputs;
    const randomNumbers = [];
    for (let i = 0; i < count; i++) {
      randomNumbers.push(parseFloat((Math.random() * (max - min) + min).toFixed(decimals)));
    }
    return randomNumbers;
  },
  transparentize: (color) => {
    const colorParts = color.match(/\d+/g);
    return `rgba(${colorParts[0]}, ${colorParts[1]}, ${colorParts[2]}, 0.2)`;
  },
  CHART_COLORS: {
    red: 'rgb(255, 99, 132)',
    orange: 'rgb(255, 159, 64)',
    yellow: 'rgb(255, 205, 86)',
    green: 'rgb(75, 192, 192)',
    blue: 'rgb(54, 162, 235)',
    purple: 'rgb(153, 102, 255)',
    grey: 'rgb(201, 203, 207)',
  }
};

const inputs = {
  min: 8,
  max: 16,
  count: 8,
  decimals: 2,
  continuity: 1,
};

const generateLabels = () => {
  return Utils.months({ count: inputs.count });
};

const generateData = () => {
  const values = Utils.numbers(inputs);
  inputs.from = values;
  return values;
};

const data = {
  labels: generateLabels(),
  datasets: [
    {
      label: 'D0',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.red,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.red),
    },
    {
      label: 'D1',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.orange,
      hidden: true,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.orange),
      fill: '-1',
    },
    {
      label: 'D2',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.yellow,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.yellow),
      fill: 1,
    },
    {
      label: 'D3',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.green,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.green),
      fill: false,
    },
    {
      label: 'D4',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.blue,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.blue),
      fill: '-1',
    },
    {
      label: 'D5',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.purple,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.purple),
      fill: '-1',
    },
    {
      label: 'D6',
      data: generateData(),
      borderColor: Utils.CHART_COLORS.grey,
      backgroundColor: Utils.transparentize(Utils.CHART_COLORS.grey),
      fill: { value: 85 },
    },
  ],
};

// Chart configuration
const config = {
  type: 'radar',
  data: data,
  options: {
    animation: {
      duration: 1500, // Animation duration (ms)
      easing: 'easeOutBounce', // Easing function
    },
    maintainAspectRatio: false, // Allow resizing based on parent container
    plugins: {
      title: {
        display: false, // Disable the title (the label on top)
      },
      filler: {
        propagate: false,
      },
      'samples-filler-analyser': {
        target: 'chart-analyser',
      },
    },
    interaction: {
      intersect: false,
    },
    layout: {
      padding: {
        top: 0, // Remove padding from the top to shift the graph upwards
      },
    },
  },
};

const RadarChart = ({ width = 400, height = 300 }) => {
  return (
    <div className="bg-white" style={{ width: width, height: height }}>
      <Radar data={data} options={config.options} />
    </div>
  );
};

export default RadarChart;
