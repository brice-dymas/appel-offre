package com.cami.web.controller;

import com.cami.persistence.model.AppelOffre;
import com.cami.persistence.model.Banque;
import com.cami.persistence.model.Caution;
import com.cami.persistence.model.Filiale;
import com.cami.persistence.model.LigneAppel;
import com.cami.persistence.model.Materiel;
import com.cami.persistence.model.Role;
import com.cami.persistence.model.TypeCaution;
import com.cami.persistence.service.IAppelOffreService;
import com.cami.persistence.service.IBanqueService;
import com.cami.persistence.service.ICautionService;
import com.cami.persistence.service.IFilialeService;
import com.cami.persistence.service.ILigneAppelService;
import com.cami.persistence.service.IMaterielService;
import com.cami.persistence.service.IRoleService;
import com.cami.persistence.service.ITypeCautionService;
import com.cami.web.form.AppelOffreForm;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/appeloffre")
public class AppelOffreController
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

    public TreeMap<String, String> getBreadcrumb()
    {
        final TreeMap<String, String> breadcrumb = new TreeMap<String, String>();
        breadcrumb
                .put("breadcrumb.appeloffre.index", "/appeloffre/appeloffre/");
        return breadcrumb;
    }

    // API
    // read - one
    @RequestMapping(value = "/{id}/show", method = RequestMethod.GET)
    public String ShowAction(@PathVariable("id") final Long id,
            final ModelMap model)
    {
        AppelOffre appelOffre = new AppelOffre();
        appelOffre = appelOffreService.findOne(id);
        final List<LigneAppel> ligneAppels = ligneAppelService.filterByAppelOffre(appelOffre.getId());
        final List<Caution> cautions = cautionService.filterByAppelOffre(appelOffre.getId());
        appelOffre.setCautions(cautions);
        appelOffre.setLigneAppels(ligneAppels);
        final TreeMap<String, String> breadcrumb = getBreadcrumb();
        breadcrumb.put("breadcrumb.appeloffre.show", "");
        model.addAttribute("breadcrumbs", breadcrumb);
        model.addAttribute("appelOffre", appelOffre);
        model.addAttribute("ligneAppels", ligneAppels);
        model.addAttribute("cautions", cautions);
        return "appeloffre/show";
    }

    @RequestMapping(value = "{id}/edit", method = RequestMethod.GET)
    public String editAction(@PathVariable("id") final Long id,
            final ModelMap model)
    {
        final AppelOffre appelOffre = appelOffreService.findOne(id);
        final List<LigneAppel> ligneAppels = ligneAppelService.filterByAppelOffre(appelOffre.getId());
        final List<Caution> cautions = cautionService.filterByAppelOffre(appelOffre.getId());
        final AppelOffreForm appelOffreForm = new AppelOffreForm();
        final TreeMap<String, String> breadcrumb = getBreadcrumb();
        breadcrumb.put("breadcrumb.appeloffre.edit", "");
        model.addAttribute("breadcrumbs", breadcrumb);
        appelOffreForm.setAppelOffre(appelOffre);
        appelOffreForm.setCautions(cautions);
        appelOffreForm.setLigneAppels(ligneAppels);
        model.addAttribute("appelOffreForm", appelOffreForm);
        return "appeloffre/edit";
    }

    // read - all
    /**
     *
     * @param webRequest
     * @param model
     * <p>
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String indexAction(final ModelMap model, final WebRequest webRequest)
    {

        final Long filialeId = (webRequest.getParameter("queryfiliale") != null && !webRequest.getParameter("queryfiliale").equals(""))
                ? Long.valueOf(webRequest.getParameter("queryfiliale"))
                : -1;
        final String numero = webRequest.getParameter("querynumero") != null
                ? webRequest.getParameter("querynumero")
                : "";
        final String intitule = webRequest.getParameter("queryintitule") != null
                ? webRequest.getParameter("queryintitule")
                : "";
        final String maitreDouvrage = webRequest.getParameter("querymaitredouvrage") != null
                ? webRequest.getParameter("querymaitredouvrage")
                : "";
        final Integer page = webRequest.getParameter("page") != null
                ? Integer.valueOf(webRequest.getParameter("page"))
                : 0;
        final Integer size = webRequest.getParameter("size") != null
                ? Integer.valueOf(webRequest.getParameter("size"))
                : 5;

        final Page<AppelOffre> resultPage = appelOffreService.findPaginated(filialeId, numero, intitule, maitreDouvrage, page, size);

        final AppelOffre appelOffre = new AppelOffre();
        appelOffre.setIntitule(intitule);
        appelOffre.setMaitreDouvrage(maitreDouvrage);
        appelOffre.setNumero(numero);
        appelOffre.setFiliale(new Filiale(filialeId));
        final TreeMap<String, String> breadcrumb = getBreadcrumb();
        breadcrumb.put("breadcrumb.appeloffre.index", "");
        model.addAttribute("breadcrumbs", breadcrumb);
        model.addAttribute("appelOffre", appelOffre);
        model.addAttribute("page", page);
        model.addAttribute("Totalpage", resultPage.getTotalPages());
        model.addAttribute("size", size);
        model.addAttribute("appelOffres", resultPage.getContent());
        return "appeloffre/index";
    }

    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public String newAction(final ModelMap model)
    {
        final TreeMap<String, String> breadcrumb = getBreadcrumb();
        AppelOffreForm appelOffreForm = new AppelOffreForm();
        AppelOffre appelOffre = new AppelOffre();
        appelOffreForm.setAppelOffre(appelOffre);
        breadcrumb.put("breadcrumb.appeloffre.new", "");
        model.addAttribute("appelOffreForm", appelOffreForm);
        model.addAttribute("breadcrumbs", breadcrumb);
        return "appeloffre/new";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createAction(@Valid AppelOffreForm appelOffreForm,
            final BindingResult result, final ModelMap model,
            final RedirectAttributes redirectAttributes)
    {

        if (result.hasErrors()) {
            System.out.println("nul ou erreur");
            model.addAttribute("error", "error");
            model.addAttribute("appelOffreForm", appelOffreForm);
//            AppelOffre pp = appelOffreForm.getAppelOffre();
//            System.out.println(pp.getNumero() + "-" + pp.getDelaiDeValidite() + "-" + pp.getIntitule() + "-" + pp.getMaitreDouvrage() + "-" + pp.getDateDepot());
            final TreeMap<String, String> breadcrumb = getBreadcrumb();
            breadcrumb.put("breadcrumb.appeloffre.create", "");
            model.addAttribute("breadcrumbs", breadcrumb);
            return "appeloffre/new";
        }
        else {
            try {
                processData(appelOffreForm.getAppelOffre());
            }
            catch (IllegalStateException |
                    IOException e) {
                System.out.println(e.getMessage());
            }
            System.out.println("non nul");
            redirectAttributes.addFlashAttribute("info", "alert.success.new");
            appelOffreService.create(appelOffreForm.getAppelOffre());
            return "redirect:/appeloffre/" + appelOffreForm.getAppelOffre().getId() + "/show";

        }

    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateAction(final ModelMap model,
            @Valid final AppelOffreForm appelOffreForm,
            final BindingResult result,
            final RedirectAttributes redirectAttributes)
    {
        System.out.println("enter");
        if (result.hasErrors()) {
            System.out.println("il ya eu erreur de modification");
            final TreeMap<String, String> breadcrumb = getBreadcrumb();
            breadcrumb.put("breadcrumb.appeloffre.create", "");
            model.addAttribute("breadcrumbs", breadcrumb);
            model.addAttribute("appelOffre", appelOffreForm);
            model.addAttribute("error", "error");
            return "appeloffre/edit";
        }
        else {
            redirectAttributes.addFlashAttribute("info", "alert.success.new");
            appelOffreService.update(appelOffreForm.getAppelOffre());
            return "redirect:/appeloffre/" + appelOffreForm.getAppelOffre().getId() + "/show";
        }
    }

//    @ModelAttribute("appelOffreForm")
//    public AppelOffreForm getAppelOffreForm()
//    {
//        AppelOffre appelOffre = new AppelOffre();
////        appelOffre.setIntitule("voyons");
//
//        AppelOffreForm appelOffreForm = new AppelOffreForm();
//        appelOffreForm.setAppelOffre(appelOffre);
//        return appelOffreForm;
//    }
    @ModelAttribute("todayDate")
    public Date getDate()
    {
        return new Date();
    }

    @ModelAttribute("filiales")
    public Map<Long, String> populateFilialesFields()
    {
        final Map<Long, String> results = new HashMap<>();
        final List<Filiale> filiales = filialeService.findAll();
        for (final Filiale filiale : filiales) {
            results.put(filiale.getId(), filiale.getNom());
        }
        return results;
    }

    @ModelAttribute("materiels")
    public Map<Long, String> populateMaterielFields()
    {
        final Map<Long, String> results = new HashMap<>();
        final List<Materiel> materiels = materielService.findAll();
        for (final Materiel materiel : materiels) {
            results.put(materiel.getId(), materiel.getNom());
        }

        return results;
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

    @ModelAttribute("commerciaux")
    public Map<Long, String> populateCommerciauxFileds()
    {
        final Map<Long, String> results = new HashMap<>();
        final List<Role> roles = roleService.retrieveCommerciaux();
        for (Role role : roles) {
            results.put(role.getId(), role.getUser().getNom());
        }
        return results;
    }

    @ModelAttribute("typeCautions")
    public Map<Long, String> populateTypeCautionFields()
    {
        final Map<Long, String> results = new HashMap<>();
        final List<TypeCaution> typeCautions = typeCautionService.findAll();
        for (final TypeCaution typeCaution : typeCautions) {
            results.put(typeCaution.getId(), typeCaution.getNom());
        }

        return results;
    }

    private void processData(AppelOffre appelOffre)
            throws IllegalStateException,
            IOException
    {
        MultipartFile file = appelOffre.getPieceJointe1Data();
        appelOffre.setPieceJointe1(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe1());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe2Data();
        appelOffre.setPieceJointe2(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe2());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe3Data();
        appelOffre.setPieceJointe3(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe3());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe4Data();
        appelOffre.setPieceJointe4(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe4());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe5Data();
        appelOffre.setPieceJointe5(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe5());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe6Data();
        appelOffre.setPieceJointe6(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe6());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe7Data();
        appelOffre.setPieceJointe7(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe7());
        processFileData(file, "documents");

        file = appelOffre.getPieceJointe8Data();
        appelOffre.setPieceJointe8(file.getOriginalFilename());
        System.out.println("PJ = " + appelOffre.getPieceJointe8());
        processFileData(file, "documents");
    }

    private String getSavedFileName(MultipartFile file, String uploadDir)
    {
        String webappRoot = servletContext.getRealPath("/");
        String relativeFolder = File.separator + "resources" + File.separator + "bootstrap" + File.separator
                + uploadDir + File.separator;
        String filename = webappRoot + relativeFolder + file.getOriginalFilename();
        System.out.println(filename);
        return filename;
    }

    private void processFileData(MultipartFile file, String uploadDir)
            throws IllegalStateException,
            IOException
    {

        String filename = getSavedFileName(file, uploadDir);
        file.transferTo(new File(filename));

    }

}
