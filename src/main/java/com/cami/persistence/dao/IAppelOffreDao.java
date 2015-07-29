package com.cami.persistence.dao;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.cami.persistence.model.AppelOffre;
import com.cami.persistence.model.TypeMateriel;

public interface IAppelOffreDao extends JpaRepository<AppelOffre, Long>, JpaSpecificationExecutor<TypeMateriel> {

	@Query("SELECT a FROM AppelOffre a WHERE a.numero = :numero")
	TypeMateriel retrieveByNumero(@Param("numero") String numero);

	Page<AppelOffre> findByNumeroLike(String numero, Pageable pageable);

	List<AppelOffre> findByNumeroLike(String numero);

	@Query("SELECT a FROM AppelOffre a WHERE a.numero LIKE :numero and a.maitreDouvrage LIKE :maitreDouvrage and a.intitule LIKE :intitule")
	Page<AppelOffre> searchLike(@Param("numero") String numero, @Param("maitreDouvrage") String maitreDouvrage, @Param("intitule") String intitule,Pageable pageable);

	@Query("SELECT a FROM AppelOffre a WHERE a.filiale.id = :filialeId and a.numero LIKE :numero and a.maitreDouvrage LIKE :maitreDouvrage and a.intitule LIKE :intitule")
	Page<AppelOffre> searchLikeWithFiliale(@Param("filialeId") Long filialeId,
			@Param("numero") String numero,
			@Param("maitreDouvrage") String maitreDouvrage,
			@Param("intitule") String intitule, Pageable pageable);


}
