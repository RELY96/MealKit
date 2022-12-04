package com.green.meal.service;

import com.green.meal.domain.ReviewVO;
import com.green.meal.paging.SearchCriteria;

import java.util.List;

public interface ReviewService {

    // 상세페이지 ReviewList 출력
    List<ReviewVO> itemReview(SearchCriteria cri, ReviewVO vo);

    // Reviewlist 출력
    List<ReviewVO> reviewlist(SearchCriteria cri);
    int searchCount(SearchCriteria cri);
    int searchCount2(String userId);
    int searchCount3(ReviewVO vo);

    // Reviewlist(MyPage) 출력
    List<ReviewVO> myReview(SearchCriteria cri, String userId);

    // Review Detail 출력
    ReviewVO reviewdetail(ReviewVO vo);

    // Review insert+후기중복체크
    void reviewinsert(ReviewVO vo) throws Exception;
    ReviewVO dupCheck(ReviewVO vo);

    // Review 수정
    int reviewupdate(ReviewVO vo);

    // Review 답변작성
    int reviewrinsert(ReviewVO vo);

    // Review 답변 출력+답변DupCheck
    ReviewVO reviewrDetail(ReviewVO vo);

    // Review 삭제
    int reviewdelete(ReviewVO vo);

    // Review 답변 업데이트
    int reviewRupdate(ReviewVO vo);

}
