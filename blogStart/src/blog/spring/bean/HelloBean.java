package blog.spring.bean;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import dto.listDTO;

@Controller
public class HelloBean {
	@Autowired
	private SqlSessionTemplate sqlMap=null;

	@RequestMapping("form.do")
	public String form() {
		return "form";
	}
	
	@RequestMapping("list.do")
	public String list(Model model, String pageNum) {
		List articleList = null;
		
		if (pageNum == null) {
            pageNum = "1";
        }
        int pageSize = 3;//한 페이지의 글의 개수
        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * pageSize + 1;//한 페이지의 시작글 번호
        int endRow = currentPage * pageSize;//한 페이지의 마지막 글번호
        int total = 0;
        int number=0;

        total = (Integer)sqlMap.selectOne("li.get_total");//전체 글의 수
		
        int pageCount = 0;
        int result;
        int startPage;
        int endPage;
        
        if(total > 0) {    		
    		Map map = new HashMap<>();
    		map.put("startRow", startRow);
    		map.put("endRow", endRow);
    		articleList = sqlMap.selectList("li.list_rowSize",map);
        }
        model.addAttribute("total", total);
		model.addAttribute("list", articleList);
		model.addAttribute("currentPage", currentPage);
        model.addAttribute("startRow", startRow);
        model.addAttribute("endRow", endRow);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("list",articleList);
		return "list";
	}
	
	@RequestMapping("write.do")
	public String write() {
		return "write";
	}
	
	@RequestMapping("write_con.do")
	public String write_con(String pageNum, int list_num, Model model) {
		listDTO dto = sqlMap.selectOne("li.list_one",list_num);
		
		model.addAttribute("dto",dto);
		model.addAttribute("pageNum",pageNum);
		return "write_con";
	}
	
	@RequestMapping("writePro.do")
	public String writePro(MultipartHttpServletRequest mhsr, listDTO dto, HttpSession session) {
		String r_path = session.getServletContext().getRealPath("/");
		String img_path = "\\resources\\img\\";
		StringBuffer filePath = new StringBuffer();
        filePath.append(r_path).append(img_path);
        
        int n = sqlMap.selectOne("li.list_maxNum");
        String savName = "img_"+(n+1); // 중복방지를 위한 파일명 지정
        MultipartFile mf = mhsr.getFile("save"); // 업로드 파일 원본 정보 
		String orgName = mf.getOriginalFilename(); // 원본 파일명
		
		if(orgName != "") {
			String ext = orgName.substring(orgName.lastIndexOf(".")); //원본 확장자
			savName +=ext;
		}
		
		System.out.println(mf.getOriginalFilename());
		
		try {
			mf.transferTo(new File(filePath.toString()+savName)); // 파일 복사
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		dto.setList_num(n+1);
		dto.setImg(savName);
		sqlMap.insert("li.list_add",dto);
		System.out.println("fileFullPath => "+filePath+savName);
		
		return "redirect:/list.do";
	}
	
/*	@RequestMapping(value="/imageUpload.do")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response,
			 @RequestParam MultipartFile upload ) throws Exception{
		OutputStream out = null;
        PrintWriter printWriter = null;
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
 
        try{
            String fileName = upload.getOriginalFilename();
            byte[] bytes = upload.getBytes();
            String uploadPath = "저장경로/" + fileName;//저장경로
 
            out = new FileOutputStream(new File(uploadPath));
            out.write(bytes);
            String callback = request.getParameter("CKEditorFuncNum");
 
            printWriter = response.getWriter();
            String fileUrl = "저장한 URL경로/" + fileName;//url경로
 
            printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    + callback
                    + ",'"
                    + fileUrl
                    + "','이미지를 업로드 하였습니다.'"
                    + ")</script>");
            printWriter.flush();
 
        }catch(IOException e){
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
                if (printWriter != null) {
                    printWriter.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return;
	}*/
}