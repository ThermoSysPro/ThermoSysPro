within ThermoSysPro.Functions;
function SmoothMin "Smooth min function"
  input Real x1;
  input Real x2;
  input Real alpha=100;

  output Real y;

algorithm
  y := SmoothStep(x1 - x2, alpha)*x2 + SmoothStep(x2 - x1, alpha)*x1;

  annotation (smoothOrder=2, Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b> </p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>"));
end SmoothMin;
