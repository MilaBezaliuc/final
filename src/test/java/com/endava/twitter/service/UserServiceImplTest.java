package com.endava.twitter.service;

import com.endava.twitter.dao.UserDaoImpl;
import com.endava.twitter.model.User;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/dispatcher-servlet.xml")
@Service
@Transactional
public class UserServiceImplTest {

    private static final int id = 666;
    private static final String username = "Tester";
    private static final String password = "qweqwe";
    private static final String first_name = "Toster";
    private static final String last_name = "Tister";
    private static final String email = "ssoulessa@gmail.com";
    private User addUser;
    private User updtUsr;
    private User deleteUser;

    @Autowired
    UserDaoImpl userDao;

    //ADD USER TEST

    @Before
    public void setUp() {
        addUser = new User();
        updtUsr = new User();
        deleteUser = new User();
    }

    @Test
    public void testAddUser() throws Exception {

        addUser.setUsername(username);
        addUser.setFirst_name(first_name);
        addUser.setPassword(password);
        addUser.setEmail(email);
        userDao.addUser(addUser);
        Assert.assertNotNull(userDao.findByUsername(username));
    }
    @After
    public void tearDown() {

        addUser.setUsername(username);
        addUser.setPassword(password);
        addUser.setEmail(email);

        userDao.deleteUser(addUser);
    }

    //UPDATE USER TEST

    @Test
    public void testUpdateUser() throws Exception {
        updtUsr = userDao.findByUsername(username);
        updtUsr.setFirst_name(last_name);
        userDao.updateUser(updtUsr);

        Assert.assertEquals(updtUsr, userDao.findByUsername(username));
    }

    //DELETE USER TEST

    @Test
    public void testDeleteUser() throws Exception {
        userDao.deleteUser(userDao.findByUsername(username));
        Assert.assertNull(userDao.findByUsername(username));
    }

    @Test
    public void testGetUserById() throws Exception {

    }

    @Test
    public void testGetUserByName() throws Exception {

    }

    @Test
    public void testGetIdByName() throws Exception {

    }

    @Test
    public void testGetAllUsers() throws Exception {

    }

    @Test
    public void testGetUsersIFollow() throws Exception {

    }

    @Test
    public void testGetUsersIFollow1() throws Exception {

    }

    @Test
    public void testGetFollowersOffers() throws Exception {

    }

    @Test
    public void testRemoveUserFromUsersIFollow() throws Exception {

    }

    @Test
    public void testAddUserToFollower() throws Exception {

    }

    @Test
    public void testGetAllUsersTweets() throws Exception {

    }

    @Test
    public void testGetAllTweetsOfUsersIFollow() throws Exception {

    }

    @Test
    public void testAllTweetsToShow() throws Exception {

    }

    @Test
    public void testAllTweetsToShow1() throws Exception {

    }

    @Test
    public void testSort() throws Exception {

    }

    @Test
    public void testListOfEmails() throws Exception {

    }

    @Test
    public void testListOfUsernames() throws Exception {

    }

    @Test
    public void testListOfPasswords() throws Exception {

    }

    @Test
    public void testGetUsersWhoFollowMe() throws Exception {

    }

    @Test
    public void testGetUsersWhoFollowMe1() throws Exception {

    }

    @Test
    public void testGetPrincipal() throws Exception {

    }

    @Test
    public void testAutologin() throws Exception {

    }
}