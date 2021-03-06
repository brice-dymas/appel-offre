/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cami.persistence.service.impl;

import com.cami.persistence.dao.IRoleDao;
import com.cami.persistence.dao.IUserDao;
import com.cami.persistence.model.Role;
import com.cami.persistence.model.User;
import com.cami.persistence.service.IRoleService;
import com.cami.persistence.service.common.AbstractService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

/**
 *
 * @author Brice GUEMKAM <briceguemkam@gmail.com>
 */
@Service("roleService")
public class RoleService extends AbstractService<Role> implements IRoleService
{

    @Autowired
    IRoleDao roleDao;

    @Autowired
    IUserDao userDao;

    @Override
    protected PagingAndSortingRepository<Role, Long> getDao()
    {
        return roleDao;
    }

    @Override
    public Role findByUserParam(User user)
    {
        return roleDao.findByUserParam(user);
    }

    @Override
    public Role findByUser(User user)
    {
        return roleDao.findByUser(user);
    }

    @Override
    public Role createRole(final Role role) throws Exception
    {
        if (exists(role.getUser())) {
            throw new Exception("exist");
        }
        User user = role.getUser();
        user.setEnabled(true);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        role.setRole(getTheRealRoleOf(role.getRole()));
        System.out.println("Role Service et role of this user befor save= " + role.getRole());
        user = userDao.save(user);
//        System.out.println("Role Service et role of this user befor save= " + role.getRole());
        role.setUser(user);
        return roleDao.save(role);
    }

    @Override
    public Role updateUser(final Role role) throws Exception
    {
        System.out.println("updating user with ID " + role.getId());
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

        User userToUpdate = role.getUser();
        userToUpdate.setEnabled(true);
        userToUpdate.setNom(role.getUser().getNom());
        userToUpdate.setUsername(role.getUser().getUsername());
        userToUpdate.setPassword(passwordEncoder.encode(role.getUser().getPassword()));
        userToUpdate = userDao.save(userToUpdate);

        final Role roleToUpdate = roleDao.findOne(role.getId());
        final String vraiRole = getTheRealRoleOf(role.getRole());
        roleToUpdate.setUser(userToUpdate);
        roleToUpdate.setRole(vraiRole);
        System.out.println("in update service user role= " + roleToUpdate.getRole());
        System.out.println("updating ... ");
        Role r = roleDao.save(roleToUpdate);
        System.out.println("update finished");
        System.out.println("userToUpdate's username is " + r.getUser().getUsername());
        return r;
    }

    @Override
    public Page<Role> findPaginated(String nom, int page, Integer size)
    {
        System.out.println("debut find");
        if (nom.length() < 1) {
            System.out.println("find sans param");
            return roleDao.findAll(new PageRequest(page, size, Sort.Direction.ASC, "id"));
        }
        else {
            System.out.println("find- avec nomParam=" + nom);
            return roleDao.findPaginated('%' + nom + '%', new PageRequest(page, size, Sort.Direction.ASC, "id"));
        }
    }

    /**
     * on ne doit pas supprimer un utilisateur car on doit garder son historique
     * aussi cette méthode va juste crypter le username de façon à ce que
     * l'utilisateur que l'on veut supprimer ne puisse plus avoir accès à son
     * compte (puisqu'il ne connaitra plus son username car celui est encrypté)
     * à moins qu'un administrateur ne modifie son compte pour cela
     *
     * @param id: the id of the user to delete
     */
    @Override
    public void deleteRole(final long id)
    {
        Role roleToDelete = roleDao.findOne(id);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        roleToDelete.getUser().setUsername(passwordEncoder.encode(roleToDelete.getUser().getUsername()));
        roleDao.save(roleToDelete);
    }

    private String getTheRealRoleOf(String roleToBuildFrom)
    {
        String role = "ros";
        System.out.println("in the getTheRealRoleOf method and roleToBuildFrom is " + roleToBuildFrom);
        if (roleToBuildFrom.equals("2") | roleToBuildFrom.equals("ROLE_TRESORIER")) {
            role = "ROLE_TRESORIER";
            System.out.println("roleToBuildFrom=2 donc role =" + role);
        }
        if (roleToBuildFrom.equals("1") | roleToBuildFrom.equals("ROLE_ADMIN")) {
            role = "ROLE_ADMIN";
            System.out.println("roleToBuildFrom=1 donc role =" + role);
        }
        if (roleToBuildFrom.equals("3") | roleToBuildFrom.equals("ROLE_COMMERCIAL")) {
            role = "ROLE_COMMERCIAL";
            System.out.println("roleToBuildFrom=3 donc role =" + role);
        }
        return role;
    }

    @Override
    public Page<Role> retrieveUsers(String nom, int page, Integer size)
    {
        if (nom.length() < 1) {
            System.out.println("find sans param");
            return roleDao.findAll(new PageRequest(page, size, Sort.Direction.ASC, "role"));
        }
        else {
            System.out.println("find- avec nomParam=" + nom);
            return roleDao.retrieveUsers('%' + nom + '%', new PageRequest(page, size, Sort.Direction.ASC, "role"));
        }
    }

    @Override
    public List<Role> retrieveCommerciaux()
    {
        return roleDao.retrieveCommerciaux();
    }

    @Override
    public Role retrieveAUser(String username)
    {
        return roleDao.retrieveAUser(username);
    }

    public boolean exists(User user)
    {
        return roleDao.retrieveAUser(user.getUsername()) instanceof Role;
    }
}
