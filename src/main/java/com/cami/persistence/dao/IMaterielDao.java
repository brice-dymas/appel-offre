/**
 *
 * @author fabrice
 */
package com.cami.persistence.dao;

import com.cami.persistence.model.Materiel;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface IMaterielDao extends JpaRepository<Materiel, Long>, JpaSpecificationExecutor<Materiel> {

    @Query("SELECT m FROM Materiel m WHERE m.nom = :nom")
    Materiel retrieveByName(@Param("nom") String nom);
    
    @Query("SELECT m FROM Materiel m WHERE m.nom LIKE :nom and m.code LIKE :code")
    Page<Materiel> searchLike(@Param("code") String code, @Param("nom") String nom,Pageable pageable);
    
    @Query("SELECT m FROM Materiel m WHERE m.typeMateriel.id = :typeMaterielId and m.nom LIKE :nom and m.code LIKE :code")
    Page<Materiel> searchLikeWithTypeMateriel(@Param("typeMaterielId") Long typeMaterielId, @Param("code") String code, @Param("nom") String nom,Pageable pageable);
    
    Page<Materiel> findByNomLike(String nom, Pageable pageable);
    

}
