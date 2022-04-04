package com.spring.codelog.board.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UploadVO {
   private int imgId;
   private int boardId;
   private String imgPath;
}

