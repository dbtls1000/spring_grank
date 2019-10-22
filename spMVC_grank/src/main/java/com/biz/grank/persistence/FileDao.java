package com.biz.grank.persistence;

import java.util.List;

import com.biz.grank.domain.FileDto;

public interface FileDao {

	public void delete(int fno);

	public FileDto read(int fno);

	public void insert(FileDto fDto);

	public List<FileDto> readByBno(int bno);

	public void deletes(int bno);

}
