package net.usermanager.dao;

import net.usermanager.model.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {
    private static final Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        user.setCreatedDate();
        session.persist(user);
        logger.info("Пользователь успешно добавлен: " + user);
    }

    @Override
    public void updateUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        user.setCreatedDate();
        session.update(user);
        logger.info("Пользователь успешно изменён: " + user);
    }

    @Override
    public void deleteUser(int id) {
        Session session =  this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));

        if (user != null) {
            session.delete(user);
        }
        logger.info("Пользователь успешно удалён: " + user);
    }

    @Override
    public User getUserById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        User user = (User) session.load(User.class, new Integer(id));
        logger.info("Пользователь успешно загружен: " + user);
        return user;
    }

    @Override
    public List<User> getNotAll(String name) {
        Session session = sessionFactory.getCurrentSession();
        Query q = session.createQuery("SELECT e FROM User e WHERE e.name = :name");
        q.setParameter("name", name);
        List<User> result = q.list();
        return result;
    }

    @Override
    public List<User> userList() {
        Session session = this.sessionFactory.getCurrentSession();
        List<User> userList = session.createQuery("from User").list();

        for (User user : userList) {
            logger.info("Список пользователей: " + user);
        }
        return userList;
    }
}