/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cami.persistence.service.impl;

import com.cami.persistence.dao.IAppelOffreDao;
import com.cami.persistence.dao.ICautionDao;
import com.cami.persistence.dao.ILigneAppelDao;
import com.cami.persistence.model.AppelOffre;
import com.cami.persistence.model.Caution;
import com.cami.persistence.service.ICautionService;
import com.cami.persistence.service.common.AbstractService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author gervais
 */
@Service("cautionService")
@Transactional
public class CautionService
        extends AbstractService<Caution>
        implements
        ICautionService
{

    // This method returns a list of appeloffre complete with their cautions and ligneAppel
//    this will be used to generate the final report for excel and pdf format
    @Override
    public List<AppelOffre> getThemComplete()
    {
        List<Caution> cautions = new ArrayList<>();
        List<AppelOffre> appelOffres = offreDao.findAll();

        for (AppelOffre appelOffre : appelOffres)
        {
            appelOffre.setCautions(dao.filterByAppelOffre(appelOffre.getId()));
            appelOffre.setLigneAppels(ligneAppelDao.filterByAppelOffre(appelOffre.getId()));
        }
        return appelOffres;
    }

    @Autowired
    private ICautionDao dao;

    @Autowired
    private IAppelOffreDao offreDao;

    @Autowired
    private ILigneAppelDao ligneAppelDao;

    @Override
    protected PagingAndSortingRepository<Caution, Long> getDao()
    {
        return dao;
    }

    @Override
    public List<Caution> filterByAppelOffre(final Long appelOffreId)
    {
        return dao.filterByAppelOffre(appelOffreId);
    }

    @Override
    public Page<Caution> findPaginated(final String query, final int i,
            final Integer size)
    {
        return super.findPaginated(i, size);
    }

    @Override
    public Page<Caution> findPaginated(final String dateDebut,
            final String dateFin, final String banque, final int page,
            final Integer size)
    {
        return dao.filterByPeriod('%' + dateDebut + '%', '%' + dateFin + '%',
                '%' + banque + '%', new PageRequest(page, size,
                        Sort.Direction.ASC, "numero"));
    }

    @Override
    public Page<Caution> filterByBank(final String banque, final int page,
            final Integer size)
    {
        return dao.filterByBank('%' + banque + '%', new PageRequest(page, size,
                Sort.Direction.DESC, "dateFin"));
    }

    @Override
    public Caution findOne(final long id)
    {
        return dao.findOne(id);
    }

    @Override
    public List<Caution> findAll()
    {
        return dao.findAll();
    }

}
