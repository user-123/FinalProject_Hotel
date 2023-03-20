package idv.hotel.finalproject.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import idv.hotel.finalproject.dao.LoginDao;
import idv.hotel.finalproject.model.LoginBean;


@Service
public class LoginDetailsServiceImpl implements UserDetailsService {
	@Autowired
    private LoginDao loginDao;
	
//	@Autowired
//	private PasswordEncoder bCryptPasswordEncoder;
	
	@Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		LoginBean lb = loginDao.findByEmail(email);
        if (lb == null) {
            throw new UsernameNotFoundException("User not found with email: " + email);
        }
//        return new org.springframework.security.core.userdetails.User(lb.getEmail(), lb.getPassword(),
//                getAuthorities(lb));
        
        
        String password = lb.getPassword();
		String roles = lb.getRoles();
		return new User(email, password, AuthorityUtils.commaSeparatedStringToAuthorityList(roles));
    
        
    }
	
	
//	private Collection<? extends GrantedAuthority> getAuthorities(LoginBean lb) {
//        List<GrantedAuthority> authorities = new ArrayList<>();
//        for (String role : lb.getRoles().split(",")) {
//            authorities.add(new SimpleGrantedAuthority(role));
//        }
//        
//        
//        return authorities;
//    }
}
