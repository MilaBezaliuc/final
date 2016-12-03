package com.endava.twitter.controller;

import com.endava.twitter.model.Comment;
import com.endava.twitter.model.Like;
import com.endava.twitter.model.Tweet;
import com.endava.twitter.model.User;
import com.endava.twitter.service.CommentServiceImpl;
import com.endava.twitter.service.LikeServiceImpl;
import com.endava.twitter.service.TweetServiceImpl;
import com.endava.twitter.service.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

@RestController
public class RestService {

    @Autowired
   private UserServiceImpl userService;

    @Autowired
    private TweetServiceImpl tweetService;

    @Autowired
    private LikeServiceImpl likeService;

    @Autowired
    private CommentServiceImpl commentService;

    @RequestMapping(value = "/allusers/", method = RequestMethod.GET)
    public ResponseEntity<List<User>> listAllTweets() {
        List<User> users = userService.getAllUsers();

        return new ResponseEntity<List<User>>(users, HttpStatus.OK);
    }

    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<User> getUser(@PathVariable("id") int id) {
        System.out.println("Fetching User with id " + id);
        User user = userService.getUserById(id);
        if (user == null) {
            System.out.println("User with id " + id + " not found");
            return new ResponseEntity<User>(user, HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<User>(user, HttpStatus.OK);
    }

    @RequestMapping(value = "/addLike", method = RequestMethod.POST)
    @ResponseBody
    public boolean addLike(@RequestParam int tweet_id, @RequestParam int user_id) {
        Like like = new Like(tweetService.getTweetById(tweet_id), userService.getUserById(user_id));
        if (likeService.thisTweetIsLikedByUser(tweet_id, user_id))
            return true;
        else {
            likeService.addLike(like);
            return false;
        }
    }

    @RequestMapping(value = "/getnexttweets/{count}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<Tweet>> getNextTweets(@PathVariable int count) {
        List<Tweet> tweets = userService.allTweetsToShow(count * 25, 25);

        return new ResponseEntity<>(tweets, HttpStatus.OK);
    }

    @RequestMapping(value = "/searchUser", method = RequestMethod.GET)
    public List<String> findUser(@RequestParam String username) {
        List<String> result = new ArrayList<>();
        for (String name : userService.listOfUsernames()) {
            if (name.toLowerCase().contains(username.toLowerCase())) {
                System.out.println(username + " " + name);
                result.add(name);
            }
        }
        return result;
    }

    @RequestMapping(value = "/uploadFile", method = RequestMethod.POST)
    @ResponseBody
    public String uploadFile(@RequestParam("file") MultipartFile file, HttpSession session) {
        String rootPath = System.getProperty("catalina.home") + File.separator + "webapps";

        String name = null;

        if (!file.isEmpty()) {
            try {
                name = file.getOriginalFilename();
                System.out.println(name);
                byte[] bytes = file.getBytes();
                File dir = new File(rootPath + File.separator + "images");
                System.out.println(dir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File uploadedFile = new File(dir.getAbsolutePath() + File.separator + name);
                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(uploadedFile));
                stream.write(bytes);
                stream.flush();
                stream.close();

                return name;

            } catch (Exception e) {}
        } else {
            return null;
        }
        return null;
    }

    @Transactional
    @RequestMapping(value = "unfollow/{username}", method = RequestMethod.GET)
    public void unfollow(@PathVariable String username) {
        User me = userService.getUserByName(getPrincipal());
        userService.removeUserFromUsersIFollow(me, username);
    }

    @Transactional
    @RequestMapping(value = "addfollower/{username}", method = RequestMethod.GET)
    public void addFollower(@PathVariable String username) {
        User me = userService.getUserByName(getPrincipal());
        User user = userService.getUserByName(username);
        userService.addUserToFollower(me, user);
    }


    @RequestMapping(value = "/addComment", method = RequestMethod.POST)
    public void addComment(@RequestParam int id, @RequestParam String text) {
        commentService.addComment(new Comment(userService.getUserByName(getPrincipal()), tweetService.getTweetById(id), text));
    }

    public String getPrincipal() {
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            userName = ((UserDetails) principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }

    @RequestMapping(value = "/getComments", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<Comment>> getCommentsById(@RequestParam int tweet_id) {
        List<Comment> comments = tweetService.getComments(tweet_id);

        return new ResponseEntity<>(comments, HttpStatus.OK);
    }

    @RequestMapping(value = "/addtweet", method = RequestMethod.POST)
    public String addTweet(@RequestParam String text, @RequestParam String image) {
        Tweet tweet = new Tweet(userService.getUserByName(getPrincipal()), text);
        if (image != null && !image.isEmpty()) {
            tweet.setImage(image);
        }
        tweetService.addTweet(tweet);
        return "redirect:/tweet";
    }

}