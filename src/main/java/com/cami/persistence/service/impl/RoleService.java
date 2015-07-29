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
    public Role updateUser(Role role) throws Exception
    {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        User userToUpdate = userDao.findByUsername(role.getUser().getUsername());
        userToUpdate.setEnabled(true);
        userToUpdate.setNom(role.getUser().getNom());
        userToUpdate.setUsername(role.getUser().getUsername());
        userToUpdate.setPassword(passwordEncoder.encode(role.getUser().getPassword()));
        userToUpdate = userDao.save(userToUpdate);

        Role roleToUpdate = roleDao.findOne(role.getId());
        roleToUpdate.setUser(userToUpdate);
        roleToUpdate.setRole(getTheRealRoleOf(role.getRole()));
        role = roleDao.save(roleToUpdate);
        return role;
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

    @Override
    public void deleteRole(long id)
    {
        roleDao.delete(id);
    }

    private String getTheRealRoleOf(String roleToBuildFrom)
    {
        String role = "ros";
        if ("2".equals(roleToBuildFrom)) {
            role = "ROLE_TRESORIER";
        }
        if (roleToBuildFrom.equals("1")) {
            role = "ROLE_ADMIN";
        }
        if (roleToBuildFrom.equals("3")) {
            role = "ROLE_COMMERCIAL";
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
//        boolean exist;
//        Role existed ;
//        existed= roleDao.retrieveAUser(user.getUsername());
//        exist = existed == null;
//        return exist;
        return roleDao.retrieveAUser(user.getUsername()) instanceof Role;
    }
}
