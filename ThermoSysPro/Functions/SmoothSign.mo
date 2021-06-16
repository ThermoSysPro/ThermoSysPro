within ThermoSysPro.Functions;
function SmoothSign "Smooth sign function"
  input Real x;
  input Real alpha=100;

  output Real y;

algorithm
  y := SmoothStep(x, alpha) - SmoothStep(-x, alpha);

  annotation (smoothOrder=2, Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b> </p>
<p><b>ThermoSysPro Version 3.0</h4>
</html>"));
end SmoothSign;
