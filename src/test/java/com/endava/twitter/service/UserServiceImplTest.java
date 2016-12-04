package com.endava.twitter.service;

import com.endava.twitter.dao.UserDaoImpl;
import com.endava.twitter.model.User;
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

    private static final String username = "Superman";
    private static final String password = "123456";
    private static final String first_name = "Toster";
    private static final String last_name = "Monster";
    private static final String email = "ssoulessa@gmail.com";
    private User user;
    private User updateUser = new User();
    private User deleteUser = new User();

    @Autowired
    UserDaoImpl userDao;

    @Before
    public void setUp() {
        user = new User();
        user.setUsername(username);
        user.setFirst_name(first_name);
        user.setPassword(password);
        user.setEmail(email);
    }


    @Test
    public void testAddUser() throws Exception {
        userDao.addUser(user);
        Assert.assertNotNull(userDao.findByUsername(username));
    }

    @Test
    public void testUpdateUser() throws Exception {
        userDao.addUser(user);
        user.setFirst_name("Vovan");
        userDao.updateUser(user);

        Assert.assertEquals(user, userDao.findByUsername(username));
    }

    @Test
    public void testDeleteUser() throws Exception {
        userDao.addUser(user);
        userDao.deleteUser(userDao.findByUsername(username));

        Assert.assertNull(userDao.findByUsername(username));
    }

    @Test
    public void testGetUserById() throws Exception {
        userDao.addUser(user);

        Assert.assertEquals(user, userDao.getUserById(user.getId()));
    }

    @Test
    public void testGetUserByName() throws Exception {
        userDao.addUser(user);

        Assert.assertEquals(user, userDao.findByUsername(username));
    }

    @Test
    public void testGetIdByName() throws Exception {
        userDao.addUser(user);

        Assert.assertEquals(user.getId(), userDao.getIdByName(username));
    }

    @Test
    public void testGetAllUsers() throws Exception {

    }

    @Test
    public void testGetUsersIFollow() throws Exception {

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
