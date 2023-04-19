package kr.or.ddit.vo;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

public class PortletVO {
	private int poCd;
	private int memCd;
	private String poCate;
	private String poGb;
	private int poX;
	private int poYn;
	private int poY;
	private int poW;
	private int poH;
	public int getPoCd() {
		return poCd;
	}
	public void setPoCd(int poCd) {
		this.poCd = poCd;
	}
	public int getMemCd() {
		return memCd;
	}
	public void setMemCd(int memCd) {
		this.memCd = memCd;
	}
	public String getPoCate() {
		return poCate;
	}
	public void setPoCate(String poCate) {
		this.poCate = poCate;
	}
	public String getPoGb() {
		return poGb;
	}
	public void setPoGb(String poGb) {
		this.poGb = poGb;
	}
	public int getPoX() {
		return poX;
	}
	public void setPoX(int poX) {
		this.poX = poX;
	}
	public int getPoYn() {
		return poYn;
	}
	public void setPoYn(int poYn) {
		this.poYn = poYn;
	}
	public int getPoY() {
		return poY;
	}
	public void setPoY(int poY) {
		this.poY = poY;
	}
	public int getPoW() {
		return poW;
	}
	public void setPoW(int poW) {
		this.poW = poW;
	}
	public int getPoH() {
		return poH;
	}
	public void setPoH(int poH) {
		this.poH = poH;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.DEFAULT_STYLE);
	}
}
