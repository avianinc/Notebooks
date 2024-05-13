import com

from com.nomagic.magicdraw.automaton import AutomatonMacroAPI
from com.nomagic.magicdraw.core import Application
from com.nomagic.magicdraw.openapi.uml import SessionManager
from com.nomagic.uml2.ext.magicdraw.classes.mdkernel import VisibilityKindEnum

try:
    SessionManager.getInstance().createSession("Automaton_Macro_Script_Execute")
    ele0 = AutomatonMacroAPI.getModelData()
    ele1 = AutomatonMacroAPI.createElement("LiteralReal")
    ele1.setVisibility(VisibilityKindEnum.getByName("public"))
    ele1.setValue(6.0)
    ele2 = ele0._getChild("Volume Model")._getChild("calculatedVolume")
    ele1.setOwner(ele2)
    ele2.setDefault_Value(ele1)
except:
    SessionManager.getInstance().closeSession()
    raise
else:
    SessionManager.getInstance().closeSession()
