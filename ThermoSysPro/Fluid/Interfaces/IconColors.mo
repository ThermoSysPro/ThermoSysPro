within ThermoSysPro.Fluid.Interfaces;
partial model IconColors
  "Colors of the static, singular and dynamic model icons"

protected
  constant Integer fill_color_dynamic[:] = {85,170,255} "Light blue";
  constant Integer fill_color_singular[:] = {127,255,0} "Green";
  constant Integer fill_color_static[:] = {255,255,0} "Yellow";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end IconColors;
