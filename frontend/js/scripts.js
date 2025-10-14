window.onload = ()=>{
  fetch('http://localhost:3000')
    .then(response => response.json())
    .then(data => {
      let [successes, fails, errors] = [0,0,0];
      data.forEach(e => {
        const row = document.createElement("div");
        switch (e.result) {
          case "success":
            successes ++;
            break;
          case "fail":
            fails ++;
            break;
          case "error":
            errors ++;
            break;
        }
        row.className = "row "+e.result;
        row.innerHTML = `<div class="group">
            <div class="icon"></div>
            <h3>${e.title}</h3>
          </div>
          <div class="group">
            <div class="subtitle">${e.time}ms</div>
            <img src="./assets/chevron.svg" alt="chevron">
          </div>`;
        document.getElementById("results").appendChild(row);
      });
      document.querySelector("#passed-tests .number").innerText = successes;
      document.querySelector("#failed-tests .number").innerText = fails;
      document.querySelector("#error-tests .number").innerText = errors;
    })
    .catch(error => {
      console.error('Error loading JSON:', error);
    });
};