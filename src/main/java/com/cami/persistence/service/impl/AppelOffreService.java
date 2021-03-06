package com.cami.persistence.service.impl;

import com.cami.persistence.dao.IAppelOffreDao;
import com.cami.persistence.dao.IBanqueDao;
import com.cami.persistence.dao.ICautionDao;
import com.cami.persistence.dao.IFilialeDao;
import com.cami.persistence.dao.ILigneAppelDao;
import com.cami.persistence.dao.IMaterielDao;
import com.cami.persistence.dao.IRoleDao;
import com.cami.persistence.dao.ITypeCautionDao;
import com.cami.persistence.model.AppelOffre;
import com.cami.persistence.model.Caution;
import com.cami.persistence.model.LigneAppel;
import com.cami.persistence.service.IAppelOffreService;
import com.cami.persistence.service.common.AbstractService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("appelOffreService")
@Transactional
public class AppelOffreService
        extends AbstractService<AppelOffre>
        implements IAppelOffreService
{

    @Autowired
    private IAppelOffreDao dao;

    @Autowired
    private IBanqueDao banqueDao;

    @Autowired
    private ILigneAppelDao ligneAppelDao;

    @Autowired
    private ICautionDao cautionDao;

    @Autowired
    private IMaterielDao materielDao;

    @Autowired
    private ITypeCautionDao typeCautionDao;

    @Autowired
    private IRoleDao roleDao;

    @Autowired
    private IFilialeDao filialeDao;

    public AppelOffreService()
    {
        super();
    }

    // API
    @Override
    protected PagingAndSortingRepository<AppelOffre, Long> getDao()
    {
        return dao;
    }

    @Override
    public AppelOffre retrieveByName(final String name)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<AppelOffre> filterByNom(final String nom)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Page<AppelOffre> findPaginated(final String query, final int i,
            final Integer size)
    {
        return super.findPaginated(i, size);
    }

    @Override
    @Transactional
    public AppelOffre create(AppelOffre appelOffre)
    {
        System.out.println("DEBUT SAVE");
        appelOffre.setFiliale(filialeDao.findOne(appelOffre.getFiliale().getId()));
        appelOffre = dao.save(appelOffre);

        System.out.println("Debut Caution - size : " + appelOffre.getCautions().size());
        for (final Caution caution : appelOffre.getCautions()) {
            System.out.println("tour caution 1");
            caution.setAppelOffre(appelOffre);
            caution.setCommercial(roleDao.findOne(caution.getCommercial().getId()));
            caution.setBanque(banqueDao.findOne(caution.getBanque().getId()));
            caution.setTypeCaution(typeCautionDao.findOne(caution.getTypeCaution().getId()));
            cautionDao.save(caution);
        }

        System.out.println("Debut LigneAppel - size : " + appelOffre.getLigneAppels().size());
        for (final LigneAppel ligneAppel : appelOffre.getLigneAppels()) {
            System.out.println("tour ligne 1");
            if (ligneAppel == null) {
                System.out.println("Ligne Appel null");
            }
            else {
                System.out.println("Ligne Appel correct");
                ligneAppel.setAppelOffre(appelOffre);
                ligneAppel.setMateriel(materielDao.findOne(ligneAppel.getMateriel().getId()));
                ligneAppelDao.save(ligneAppel);
            }
        }
        System.out.println("FIN SAVE");
        return appelOffre;
    }

    @Override
    @Transactional
    public AppelOffre update(final AppelOffre appelOffre)
    {

        System.out.println("DEBUT UPDATE");
        AppelOffre editAppelOffre = dao.findOne(appelOffre.getId());

        editAppelOffre.setFiliale(filialeDao.findOne(appelOffre.getFiliale().getId()));
        editAppelOffre.setIntitule(appelOffre.getIntitule());
        editAppelOffre.setEtat("En cours");
        editAppelOffre.setDelaiDeValidite(appelOffre.getDelaiDeValidite());
        editAppelOffre.setNumero(appelOffre.getNumero());
        editAppelOffre.setMaitreDouvrage(appelOffre.getMaitreDouvrage());
        editAppelOffre.setDateDepot(appelOffre.getDateDepot());
        editAppelOffre = dao.save(editAppelOffre);

        cautionDao.deleteInBatch(cautionDao.filterByAppelOffre(editAppelOffre
                .getId()));

        for (final Caution caution : appelOffre.getCautions()) {
            Caution editCaution = new Caution();

            editCaution.setAppelOffre(editAppelOffre);
            editCaution.setBanque(banqueDao.findOne(caution.getBanque().getId()));
            editCaution.setCommercial(roleDao.findOne(caution.getCommercial().getId()));
            editCaution.setDateDebut(caution.getDateDebut());
            editCaution.setDateFin(caution.getDateFin());
            editCaution.setMontant(caution.getMontant());
            editCaution.setNumero(caution.getNumero());
            editCaution.setReferenceMarche(caution.getReferenceMarche());
            editCaution.setMontantMarche(caution.getMontantMarche());
            editCaution.setTypeCaution(typeCautionDao.findOne(caution.getTypeCaution().getId()));

            System.out.println(editCaution.getReferenceMarche() + "-" + editCaution.getMontantMarche());
            System.out.println("caution saving ... ");
            cautionDao.save(editCaution);
            System.out.println("caution saved ");
        }

        System.out.println("Debut LigneAppel - size : "
                + appelOffre.getLigneAppels().size());
        ligneAppelDao.deleteInBatch(ligneAppelDao
                .filterByAppelOffre(editAppelOffre.getId()));
        for (final LigneAppel ligneAppel : appelOffre.getLigneAppels()) {
            System.out.println("tour ligne 1");
            if (ligneAppel == null) {
                System.out.println("Ligne Appel null");
            }
            else {
                System.out.println("Ligne Appel correct ");
                LigneAppel lg = new LigneAppel();
                lg.setAppelOffre(editAppelOffre);
                System.out.println("Ligne Appel a son appelDoffre");
                lg.setMateriel(materielDao.findOne(ligneAppel.getMateriel().getId()));
                System.out.println("Ligne Appel a son materiel");
                lg.setPrixUnitaire(ligneAppel.getPrixUnitaire());
                lg.setQuantite(ligneAppel.getQuantite());
                System.out.println("Ligne Appel correct= " + lg.getMateriel().getNom() + "-"
                        + lg.getPrixUnitaire() + "-" + lg.getQuantite() + "-"
                        + lg.getAppelOffre().getId());
                ligneAppelDao.save(lg);
                System.out.println("Ligne Appel est enregistré");
            }
        }

        System.out.println("FIN SAVE");
        return editAppelOffre;
    }

    @Override
    public Page<AppelOffre> findPaginated(final Long filialeId,
            final String numero, final String intitule,
            final String maitreDouvrage, final int page, final Integer size)
    {
        if (-1 == filialeId) {
            System.out.println("find-1");
            return dao.searchLike('%' + numero + '%', '%' + maitreDouvrage + '%', '%' + intitule + '%', new PageRequest(page, size, Sort.Direction.ASC, "numero"));
        }
        else {
            System.out.println("find-2");
            return dao.searchLikeWithFiliale(filialeId, '%' + numero + '%', '%' + maitreDouvrage + '%', '%' + intitule + '%', new PageRequest(page, size, Sort.Direction.ASC, "numero"));
        }
    }

}
