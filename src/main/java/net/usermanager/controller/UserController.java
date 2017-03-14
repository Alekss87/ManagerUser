package net.usermanager.controller;

import net.usermanager.model.User;
import net.usermanager.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class UserController  {
    private UserService userService;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping(value = "users", method = RequestMethod.GET)
    public String userList(@RequestParam(value = "page",defaultValue = "0",required = false) int page,
                           @RequestParam Map<String, String> allRequestParams,
                           Model model) {

        if (allRequestParams.isEmpty()) allRequestParams.put("page",Integer.toString(page));

        List<User> allUsers = userService.userList();
        PagedListHolder<User> usersPages = new PagedListHolder<User>(allUsers);
        usersPages.setPageSize(10);
        usersPages.setPage(page);
        String nextPageRequest=pageRequestModifier(allRequestParams,page+1);
        String prevPageRequest=pageRequestModifier(allRequestParams,page-1);
        model.addAttribute("nextPageRequest",nextPageRequest);
        model.addAttribute("prevPageRequest",prevPageRequest);
        model.addAttribute("usersPages", usersPages);

        model.addAttribute("user", new User());
        model.addAttribute("userList", this.userService.userList());

        return "users";
    }

    private static String pageRequestModifier(Map<String, String> allRequestParams, int page) {
        if (allRequestParams != null && !allRequestParams.isEmpty() && allRequestParams.containsKey("page")) {
            allRequestParams.put("page", Integer.toString(page));
            StringBuilder stringBuilder = new StringBuilder("?");
            for (Map.Entry<String, String> entry : allRequestParams.entrySet()) {
                stringBuilder.append(entry.getKey()).append("=").append(entry.getValue()).append("&");
            }
            return   stringBuilder.substring(0, stringBuilder.length() - 1);

        } else return "";
    }

    @RequestMapping(value = "/users/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user) {
        if (user.getId() == 0) {

            this.userService.addUser(user);
        }
        else {

            this.userService.updateUser(user);
        }
        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String deleteUser(@PathVariable("id") int id) {
        this.userService.deleteUser(id);
        return "redirect:/users";
    }

    @RequestMapping("/edit/{id}")
    public String editUser(@PathVariable("id") int id, Model model) {
        model.addAttribute("user", this.userService.getUserById(id));
        model.addAttribute("userList", this.userService.userList());
        return "users";
    }

    @RequestMapping(value = "/users/filter", method = RequestMethod.GET)
    public String getFilter(Model model) {
        model.addAttribute("user", new User());
        return "filter";
    }
    @RequestMapping(value = "/users/filter", method = RequestMethod.POST)
    public String listFilter(@ModelAttribute("userAttribute") User user, Model model) {
        List<User> users = userService.getNotAll(user.getName());
        model.addAttribute("users", users);
        return "filterpage";
    }

    @RequestMapping("/userdata/{id]")
    public String userData(@PathVariable("id") int id, Model model) {
        model.addAttribute("user", this.userService.getUserById(id));
        return "userdata";
    }
}