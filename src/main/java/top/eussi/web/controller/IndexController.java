package top.eussi.web.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import top.eussi.domain.Article;
import top.eussi.service.ArticleService;

import java.util.List;

@Controller
public class IndexController extends BaseController{

    @Autowired
    private ArticleService articleService;

    public void setArticleService(ArticleService articleService) {
        this.articleService = articleService;
    }

    @RequestMapping("/")
    public ModelAndView index(@RequestParam(required=true,defaultValue="1") Integer page, @RequestParam(required=false,defaultValue="5") Integer pageSize){
        ModelAndView modelAndView =new ModelAndView("index");
        PageHelper.startPage(page, pageSize);
        List<Article> articles=articleService.getAll();
        PageInfo<Article> pageInfo=new PageInfo<Article>(articles);
        modelAndView.addObject("articles",articles);
        modelAndView.addObject("pageInfo",pageInfo);
        return modelAndView;
    }

    @RequestMapping("/about")
    public String about(){
        return "about";
    }
}
