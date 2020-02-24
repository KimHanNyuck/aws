package kr.or.scoop.dao;

import java.util.List;

import kr.or.scoop.dto.Alarm;

public interface AlarmDao {
	public List<Alarm> getAlarm(String email);

}
