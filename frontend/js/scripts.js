window.onload = ()=>{
  // Add event listeners for action buttons
  document.getElementById('run-all-checks').addEventListener('click', () => {
    const button = document.getElementById('run-all-checks');
    button.disabled = true;
    button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12a9 9 0 1 1-6.219-8.56"/></svg>Running...';
    
    fetch(`${API_BASE_URL}/run-all`, {
      method: 'POST'
    })
    .then(res => res.json())
    .then(() => {
      window.location.reload();
    })
    .catch(error => {
      console.error('Error running all checks:', error);
      button.disabled = false;
      button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21.5 2v6h-6M2.5 22v-6h6M2 11.5a10 10 0 0 1 18.8-4.3M22 12.5a10 10 0 0 1-18.8 4.2"/></svg>Run All Checks';
    });
  });

  document.getElementById('run-all-fixes').addEventListener('click', () => {
    const button = document.getElementById('run-all-fixes');
    button.disabled = true;
    button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12a9 9 0 1 1-6.219-8.56"/></svg>Fixing...';
    
    fetch(`${API_BASE_URL}/fix-all`, {
      method: 'POST'
    })
    .then(res => res.json())
    .then(() => {
      window.location.reload();
    })
    .catch(error => {
      console.error('Error running all fixes:', error);
      button.disabled = false;
      button.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>Fix All Failed Tests';
    });
  });

  fetch(API_BASE_URL)
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
        row.addEventListener("click",_=>{
          document.querySelectorAll("#expand").forEach(e=>e.remove());
          if (row.classList.contains("expanded")) {
            row.classList.remove("expanded");
            return;
          }
          document.querySelectorAll(".expanded.row").forEach(e=>e.classList.remove("expanded"));
          row.classList.add("expanded");
          const expand = document.createElement("div");
          expand.id = "expand";
            expand.innerHTML = `
            <section>
              <h4>Description:</h4>
              <p>${e.description}</p>
            </section>
            <div class="button-box">
              <button class="primary rerun-btn">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-rotate-ccw w-4 h-4"><path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path><path d="M3 3v5h5"></path></svg>
              Rerun Test
              </button>
              <button class="secondary fix-btn">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-wrench w-4 h-4"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"></path></svg>
              Implement Control
              </button>
            </div>
            `;
            expand.querySelector('.rerun-btn').onclick = () => {
            fetch(`${API_BASE_URL}/run/${e.id}`, {
              method: 'POST'
            })
            .then(res => window.location.reload());
            };
            expand.querySelector('.fix-btn').onclick = () => {
            fetch(`${API_BASE_URL}/fix/${e.id}`, {
              method: 'POST'
            })
            .then(res => window.location.reload());
            };
          row.after(expand);
        });
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