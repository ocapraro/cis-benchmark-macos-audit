const http = require('http');
const fs = require('fs').promises;
const path = require('path');
const { execSync } = require("child_process");

const PORT = process.env.PORT || 3000;

const readData = async () => {
  const resultsPath = path.join(__dirname, 'data', 'tests.json');
  const file_data = await fs.readFile(resultsPath, 'utf8');
  return file_data;
}

const writeData = async (data) => {
  const resultsPath = path.join(__dirname, 'data', 'tests.json');
  await fs.writeFile(resultsPath, data, 'utf8');
}

const server = http.createServer(async (req, res) => {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'application/json' });
    const data = await readData();
    res.end(data);
  }
});


const main = async () => {
  const data = await readData();
  const formattedData = JSON.parse(data);
  formattedData.forEach(e=>{
    console.log(`Running ${e.title}...`);
    const now = Date.now();
    let output = execSync(`bash ./scripts/${e.id}/detect.sh`);
    try {
      output = execSync("sudo whoami", { encoding: "utf-8" });
      const pattern = new RegExp(e.regex);
      if(pattern.test(output))
        e.result = "success";
      else
        e.result = "fail";
    } catch (err) {
      e.result = "error";
    }
    e.time = Date.now() - now;
  });
  await writeData(JSON.stringify(formattedData));
  server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
}

main();