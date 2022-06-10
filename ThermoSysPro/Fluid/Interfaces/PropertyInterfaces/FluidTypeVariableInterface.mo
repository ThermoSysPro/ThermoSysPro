within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
partial model FluidTypeVariableInterface "Interface to display the fluid type after simulation"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

public
  FluidType ftype "fluid type";
  Integer fluid1=Integer(ftype) "Fluid number";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{78,98},{98,78}},
          lineColor= DynamicSelect({255,255,255},
          if fluid1==1 then {0,0,255}
          else if fluid1==2 then {238,46,47}
          else if fluid1==3 then {0,140,72}
          else if fluid1==4 then {217,67,180}
          else if fluid1==5 then {162,29,33}
          else if fluid1==6 then {244,125,35}
          else if fluid1==7 then {102,44,145}
          else {213,255,170}),
          fillColor= DynamicSelect({255,255,255},
          if fluid1==1 then {0,0,255}
          else if fluid1==2 then {238,46,47}
          else if fluid1==3 then {0,140,72}
          else if fluid1==4 then {217,67,180}
          else if fluid1==5 then {162,29,33}
          else if fluid1==6 then {244,125,35}
          else if fluid1==7 then {102,44,145}
          else {213,255,170}),
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FluidTypeVariableInterface;
