/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cami.spring.core;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

/**
 *
 * @author Brice GUEMKAM <briceguemkam@gmail.com>
 * this class will load the springSecurityFilterChain automatically so no need
 * to write it again in rh web.xml file
 */
public class SpringSecurityInitializer extends AbstractSecurityWebApplicationInitializer
{

}
