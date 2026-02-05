document.addEventListener("turbo:load", () => {
  const wizard = document.getElementById("diagnosisWizard");
  if (!wizard) return;

  const steps = Array.from(wizard.querySelectorAll(".diag-step"));
  let idx = steps.findIndex(s => s.classList.contains("active"));
  if (idx < 0) idx = 0;

  const show = (i) => {
    steps.forEach((s, k) => s.classList.toggle("active", k === i));
    idx = i;
  };

  const currentStep = () => steps[idx];
  const requiredName = () => currentStep().dataset.requiredName;

  const selected = (name) => !!wizard.querySelector(`input[name="${name}"]:checked`);

  const setError = (msg) => {
    const el = currentStep().querySelector(".diag-error");
    if (el) el.textContent = msg || "";
  };

  wizard.addEventListener("click", (e) => {
    if (e.target.classList.contains("diag-next")) {
      if (!selected(requiredName())) {
        setError("どれか1つ選んでください");
        return;
      }
      setError("");
      if (idx < steps.length - 1) show(idx + 1);
    }

    if (e.target.classList.contains("diag-back")) {
      setError("");
      if (idx > 0) show(idx - 1);
    }
  });

  wizard.addEventListener("change", (e) => {
    if (e.target.name === requiredName()) setError("");
  });
});
