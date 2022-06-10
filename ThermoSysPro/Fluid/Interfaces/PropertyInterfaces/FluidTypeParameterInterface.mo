within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
partial model FluidTypeParameterInterface "Interface to display the fluid type after parametrization"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter FluidType ftype=FluidType.WaterSteam "Fluid type" annotation(Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));

protected
  parameter Integer fluid=Integer(ftype) "Fluid number" annotation(Evaluate=true);
  parameter Boolean isCompressible=(ftype==FluidType.WaterSteam or ftype==FluidType.FlueGases or ftype==FluidType.DryAirIdealGas or ftype==FluidType.WaterSteamSimple) "Compressible fluid" annotation(Evaluate=true);

public
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
          fillPattern=FillPattern.Solid),
          Rectangle(
          extent={{-98,98},{-78,78}},
          lineColor= DynamicSelect({255,255,255},
          if fluid==1 then {0,0,255}
          else if fluid==2 then {238,46,47}
          else if fluid==3 then {0,140,72}
          else if fluid==4 then {217,67,180}
          else if fluid==5 then {162,29,33}
          else if fluid==6 then {244,125,35}
          else if fluid==7 then {102,44,145}
          else {213,255,170}),
          fillColor= DynamicSelect({255,255,255},
          if fluid==1 then {0,0,255}
          else if fluid==2 then {238,46,47}
          else if fluid==3 then {0,140,72}
          else if fluid==4 then {217,67,180}
          else if fluid==5 then {162,29,33}
          else if fluid==6 then {244,125,35}
          else if fluid==7 then {102,44,145}
          else {213,255,170}),
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FluidTypeParameterInterface;
