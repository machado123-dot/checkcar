{
  "name": "checkcar",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "cors": "^2.8.5",
    "express": "^4.18.2"
  }
}
const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());

// simulação de dados (depois podes ligar a API real)
function gerarDados() {
  const hoje = new Date();

  const ipo = new Date();
  ipo.setMonth(hoje.getMonth() + (Math.random() > 0.5 ? 2 : -2));

  const seguro = new Date();
  seguro.setMonth(hoje.getMonth() + (Math.random() > 0.5 ? 3 : -3));

  return {
    ipo: {
      data: ipo.toISOString().split("T")[0],
      valido: ipo > hoje
    },
    seguro: {
      data: seguro.toISOString().split("T")[0],
      valido: seguro > hoje
    }
  };
}

app.get("/api/:matricula", (req, res) => {
  res.json({
    matricula: req.params.matricula,
    ...gerarDados()
  });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log("API online"));
