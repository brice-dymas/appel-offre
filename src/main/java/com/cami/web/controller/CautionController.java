package com.cami.web.controller;

import com.cami.persistence.model.AppelOffre;
import com.cami.persistence.model.Banque;
import com.cami.persistence.model.Caution;
import com.cami.persistence.service.IAppelOffreService;
import com.cami.persistence.service.IBanqueService;
import com.cami.persistence.service.ICautionService;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.WebRequest;

@Controller
@RequestMapping("/caution")
public class CautionController
{

    @Autowired
    ICautionService cautionService;

    @Autowired
    IBanqueService banqueService;

    @Autowired
    IAppelOffreService appelOffreService;

    public String getTrueDate(final Date date)
    {
        return new SimpleDateFormat("dd-MM-yyyy").format(date);
    }

    @RequestMapping(value = "/{id}/show", method = RequestMethod.GET)
    public String ShowAction(@PathVariable("id") final Long id,
            final ModelMap model)
    {
        final Caution caution = cautionService.findOne(id);
        final AppelOffre appelOffre = appelOffreService.findOne(caution
                .getAppelOffre().getId());
        caution.setAppelOffre(appelOffre);
        model.addAttribute("caution", caution);
        return "caution/show";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String searchAction(@Valid final Caution caution,
            final BindingResult result, final ModelMap model)
    {
        return "redirect:/caution?query=" + caution.getBanque()
                + "&page=1&size=2";
    }

    @RequestMapping(method = RequestMethod.GET)
    public String indexAction(final ModelMap model, final WebRequest webRequest)
    {
        // The next line is used to generate the final report
        final List<AppelOffre> appelOffres = cautionService.getThemComplete();

        final String banque = webRequest.getParameter("querybanque") != null
                ? webRequest.getParameter("querybanque")
                : "";
        final Integer page = webRequest.getParameter("page") != null
                ? Integer
                .valueOf(webRequest.getParameter("page"))
                : 0;
        final Integer size = webRequest.getParameter("size") != null
                ? Integer
                .valueOf(webRequest.getParameter("size"))
                : 5;
        final Page<Caution> resultPage = cautionService.filterByBank(banque,
                page, size);

        final Caution caution = new Caution();
        model.addAttribute("cautionsReport", appelOffres); //for the report
        model.addAttribute("caution", caution);
        model.addAttribute("page", page);
        model.addAttribute("Totalpage", resultPage.getTotalPages());
        model.addAttribute("size", size);
        model.addAttribute("cautions", resultPage.getContent());
        return "caution/index";
    }

    @ModelAttribute("todayDate")
    public Date getTodayDate()
    {
        return new Date();
    }

    @ModelAttribute("banques")
    public Map<Long, String> populateBanqueFields()
    {
        final Map<Long, String> results = new HashMap<>();
        final List<Banque> banques = banqueService.findAll();
        for (final Banque banque : banques) {
            results.put(banque.getId(), banque.getLibelle());
        }
        return results;
    }
}
