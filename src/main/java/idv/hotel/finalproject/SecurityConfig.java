package idv.hotel.finalproject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import idv.hotel.finalproject.service.impl.LoginDetailsServiceImpl;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

	@Autowired
	private LoginDetailsServiceImpl userDetailsService;

//	@Autowired
//	private LoginAuthenticationSuccessHandler loginAuthenticationSuccessHandler;

	@Bean
	public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.formLogin().usernameParameter("email").passwordParameter("password")
				// loginpage.html 表單 action 內容
				.loginProcessingUrl("/public/loginpage")
				// 自定義登入頁面
				.loginPage("/public/loginpage")
				// 登入成功之後要造訪的頁面
				.successHandler((request, response, authentication) -> {
					request.getSession().setAttribute("email", authentication.getName());
					response.sendRedirect("/main");
				})
				// 登入失敗後要造訪的頁面
				.failureUrl("/public/loginpage?error=true").and().logout().logoutUrl("/logout")
				.logoutSuccessHandler((request, response, authentication) -> {
					request.getSession().setAttribute("login", "");
					response.sendRedirect("/main");
				}).deleteCookies("JSESSIONID")

				.and().rememberMe().rememberMeParameter("remember-me").userDetailsService(userDetailsService)
				.tokenValiditySeconds(60*60*24*7);

//		http.csrf().ignoringAntMatchers("/");

		http.authorizeHttpRequests()
				.antMatchers("/public/**", "/", "/javascript/**", "/loginpage", "/assets/**", "/uploadProduct/**", "/uploadDir/**", "/images/**", "/roomId/**", "/fonts/**", "/attractionPhoto/**").permitAll()
				.antMatchers("/admin/**").hasAuthority("admin").anyRequest().authenticated();

		// 權限判斷
		// 必須要有 admin 權限才可以訪問
//		.antMatchers("/adminpage").hasAuthority("admin")
//		// 必須要有 manager 角色才可以訪問
//		.antMatchers("/managerpage").hasRole("manager")
//		// 其他指定任意角色都可以訪問
//		.antMatchers("/employeepage").hasAnyRole("manager", "employee")
//		// 其他的都要被認證
//		.anyRequest().authenticated();
		http.csrf().disable();
		return http.build();
	}

	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService);
	}

	@Bean
	public PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
