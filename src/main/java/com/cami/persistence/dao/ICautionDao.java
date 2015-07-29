package com.cami.persistence.dao;

import com.cami.persistence.model.Caution;
import com.cami.persistence.model.TypeMateriel;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ICautionDao extends JpaRepository<Caution, Long>, JpaSpecificationExecutor<TypeMateriel>
{

    @Query("SELECT c FROM Caution c WHERE c.appelOffre.id = :appelOffreId")
    List<Caution> filterByAppelOffre(@Param("appelOffreId") Long appelOffreId);

    @Query("SELECT c FROM Caution c WHERE c.appelOffre.id = :appelOffreId AND c.commercial.id= :idCommercial")
    List<Caution> filterByAppelOffreAndUser(@Param("appelOffreId") Long appelOffreId, @Param("idCommercial") Long idCommercial);

    @Query("SELECT c FROM Caution c WHERE c.dateDebut LIKE :dateDebut OR c.dateFin LIKE :dateFin OR c.banque LIKE :banque")
    Page<Caution> filterByPeriod(@Param("dateDebut") String dateDebut,
            @Param("dateFin") String dateFin, @Param("banque") String banque,
            Pageable pageable);

    @Query("SELECT c FROM Caution c WHERE c.banque.libelle LIKE :banque")
    Page<Caution> filterByBank(@Param("banque") String banque, Pageable pageable);

    @Query("SELECT c FROM Caution c WHERE c.banque.libelle LIKE :banque AND c.commercial.id= :idUser")
    Page<Caution> filterByBankAndUser(@Param("banque") String banque, @Param("idUser") long idUser, Pageable pageable);

    @Query("SELECT c FROM Caution c WHERE c.commercial.user.username LIKE :username")
    Page<Caution> filterByUsername(@Param("username") String username, Pageable pageable);
}
