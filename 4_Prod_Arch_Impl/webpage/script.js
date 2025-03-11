document.addEventListener("DOMContentLoaded", function () {
  const downloadBtn = document.getElementById("downloadBtn");
  const progressBar = document.getElementById("progressBar");
  const progressContainer = document.querySelector(".progress-container");

  downloadBtn.addEventListener("click", function () {
    // Show progress bar
    progressContainer.style.display = "block";
    progressBar.style.width = "0%";

    let progress = 0;
    const interval = setInterval(() => {
      if (progress >= 100) {
        clearInterval(interval);

        // Simulate file download after progress completes
        const link = document.createElement("a");
        link.href = "Resume_Pritam_BLR__uploaded.pdf"; // Make sure the file is in the same folder
        link.download = "Pritam_Chakraborty_CV.pdf";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);

        setTimeout(() => {
          progressContainer.style.display = "none"; // Hide progress bar after download
        }, 500);
      } else {
        progress += 10;
        progressBar.style.width = progress + "%";
      }
    }, 200);
  });
});
