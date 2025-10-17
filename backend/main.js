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
  }else if (req.url.includes("/run/") && req.method === "POST") {
    const id = req.url.split("/run/")[1];
    const data = await readData();
    const tests = JSON.parse(data);
    const test = tests.find(e => e.id === id);
    if (!test) {
      res.writeHead(404, { "Content-Type": "application/json" });
      res.end(JSON.stringify({ error: "Test not found" }));
      return;
    }
    console.log(`Running ${test.title}...`);
    const now = Date.now();
    try {
      const output = execSync(`bash ./scripts/${test.id}/detect.sh`, { encoding: "utf-8" });
      const pattern = new RegExp(test.regex, "m");
      if (pattern.test(output))
        test.result = "success";
      else
        test.result = "fail";
    } catch (err) {
      test.result = "error";
    }
    test.time = Date.now() - now;
    await writeData(JSON.stringify(tests));
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify(test));
  }else if (req.url.includes("/fix/") && req.method === "POST") {
    const id = req.url.split("/fix/")[1];
    const data = await readData();
    const tests = JSON.parse(data);
    const test = tests.find(e => e.id === id);
    if (!test) {
      res.writeHead(404, { "Content-Type": "application/json" });
      res.end(JSON.stringify({ error: "Test not found" }));
      return;
    }
    console.log(`Running ${test.title}...`);
    try{
      execSync(`bash ./scripts/${test.id}/fix.sh`, { encoding: "utf-8" });
    }catch(err) {
      console.log("Fix Failed");
      return;
    }
    const now = Date.now();
    try {
      const output = execSync(`bash ./scripts/${test.id}/detect.sh`, { encoding: "utf-8" });
      const pattern = new RegExp(test.regex, "m");
      if (pattern.test(output))
        test.result = "success";
      else
        test.result = "fail";
    } catch (err) {
      test.result = "error";
    }
    test.time = Date.now() - now;
    await writeData(JSON.stringify(tests));
    res.writeHead(200, { "Content-Type": "application/json" });
    res.end(JSON.stringify(test));
  }
});


const main = async () => {
  const data = await readData();
  const formattedData = JSON.parse(data);
  // formattedData.forEach(e=>{
  //   console.log(`Running ${e.title}...`);
  //   const now = Date.now();
  //   try {
  //     const output = execSync(`bash ./scripts/${e.id}/detect.sh`, { encoding: "utf-8" });
  //     const pattern = new RegExp(e.regex,"m");
  //     if(pattern.test(output))
  //       e.result = "success";
  //     else
  //       e.result = "fail";
  //   } catch (err) {
  //     e.result = "error";
  //   }
  //   e.time = Date.now() - now;
  // });
  await writeData(JSON.stringify(formattedData));
  server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
}

main();