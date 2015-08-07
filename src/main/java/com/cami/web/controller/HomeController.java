package com.cami.web.controller;

import com.cami.persistence.model.AppelOffre;
import com.cami.persistence.model.Caution;
import com.cami.persistence.model.LigneAppel;
import com.cami.persistence.model.Role;
import com.cami.persistence.service.IAppelOffreService;
import com.cami.persistence.service.IBanqueService;
import com.cami.persistence.service.ICautionService;
import com.cami.persistence.service.IFilialeService;
import com.cami.persistence.service.ILigneAppelService;
import com.cami.persistence.service.IMaterielService;
import com.cami.persistence.service.IRoleService;
import com.cami.persistence.service.ITypeCautionService;
import java.util.List;
import java.util.TreeMap;
import javax.servlet.ServletContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController
{

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private IAppelOffreService appelOffreService;

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IBanqueService banqueService;

    @Autowired
    private ILigneAppelService ligneAppelService;

    @Autowired
    private ICautionService cautionService;

    @Autowired
    private IMaterielService materielService;

    @Autowired
    private ITypeCautionService typeCautionService;

    @Autowired
    private IFilialeService filialeService;

  
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String indexAction(final ModelMap model)
    {
        
        return "user/home";
    }
    
    @RequestMapping(value = "/index.html", method = RequestMethod.GET)
    public String homeAction(final ModelMap model)
    {
        
        return "user/home";
    }

   

}
