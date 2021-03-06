package com.cami.persistence.service;

import com.cami.persistence.IOperations;
import com.cami.persistence.model.AppelOffre;
import java.util.List;
import org.springframework.data.domain.Page;

public interface IAppelOffreService extends IOperations<AppelOffre>
{

    AppelOffre retrieveByName(String name);

    public List<AppelOffre> filterByNom(String nom);

    public Page<AppelOffre> findPaginated(String query, int page, Integer size);

    public Page<AppelOffre> findPaginated(Long filialeId,
            String numero, String intitule, String maitreDouvrage, int page,
            Integer size);

}
