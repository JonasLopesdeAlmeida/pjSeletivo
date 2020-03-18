package dados;

public class Candidato {
private int id_candidato,id_cargo;
private String numinscricao,nomecandidato,genero,nacionalidade,estadocivil,datanasc,idade,rgnumero,rgorgao,rguf,rgdata,cpf,cnh,deficiencia,defqual,endereco,numero,bairro,uf,cidade,cep,email,fone,atesto;

private String dataregistro,categoria;



public boolean constroiGenero(String disema){
	if(genero!=null && !genero.isEmpty()){
	String[]exArray = genero.split(",");
	for(String e : exArray){
		if(e.trim().equalsIgnoreCase(disema.trim())){
	return true;
}
}
}
return false;
}


public boolean constroiNacionalidade(String disema){
	if(nacionalidade!=null && !nacionalidade.isEmpty()){
	String[]exArray = nacionalidade.split(",");
	for(String e : exArray){
		if(e.trim().equalsIgnoreCase(disema.trim())){
	return true;
}
}
}
return false;
}



public boolean constroiDeficiencia(String disema){
	if(deficiencia!=null && !deficiencia.isEmpty()){
	String[]exArray = deficiencia.split(",");
	for(String e : exArray){
		if(e.trim().equalsIgnoreCase(disema.trim())){
	return true;
}
}
}
return false;
}


public boolean constroiAtesto(String disema){
	if(atesto!=null && !atesto.isEmpty()){
	String[]exArray = atesto.split(",");
	for(String e : exArray){
		if(e.trim().equalsIgnoreCase(disema.trim())){
	return true;
}
}
}
return false;
}


public int getId_candidato() {
	return id_candidato;
}


public void setId_candidato(int id_candidato) {
	this.id_candidato = id_candidato;
}


public int getId_cargo() {
	return id_cargo;
}


public void setId_cargo(int id_cargo) {
	this.id_cargo = id_cargo;
}


public String getNuminscricao() {
	return numinscricao;
}


public void setNuminscricao(String numinscricao) {
	this.numinscricao = numinscricao;
}


public String getNomecandidato() {
	return nomecandidato;
}


public void setNomecandidato(String nomecandidato) {
	this.nomecandidato = nomecandidato;
}


public String getGenero() {
	return genero;
}


public void setGenero(String genero) {
	this.genero = genero;
}


public String getNacionalidade() {
	return nacionalidade;
}


public void setNacionalidade(String nacionalidade) {
	this.nacionalidade = nacionalidade;
}


public String getEstadocivil() {
	return estadocivil;
}


public void setEstadocivil(String estadocivil) {
	this.estadocivil = estadocivil;
}


public String getDatanasc() {
	return datanasc;
}


public void setDatanasc(String datanasc) {
	this.datanasc = datanasc;
}


public String getIdade() {
	return idade;
}


public void setIdade(String idade) {
	this.idade = idade;
}


public String getRgnumero() {
	return rgnumero;
}


public void setRgnumero(String rgnumero) {
	this.rgnumero = rgnumero;
}


public String getRgorgao() {
	return rgorgao;
}


public void setRgorgao(String rgorgao) {
	this.rgorgao = rgorgao;
}


public String getRguf() {
	return rguf;
}


public void setRguf(String rguf) {
	this.rguf = rguf;
}


public String getRgdata() {
	return rgdata;
}


public void setRgdata(String rgdata) {
	this.rgdata = rgdata;
}


public String getCpf() {
	return cpf;
}


public void setCpf(String cpf) {
	this.cpf = cpf;
}


public String getCnh() {
	return cnh;
}


public void setCnh(String cnh) {
	this.cnh = cnh;
}


public String getDeficiencia() {
	return deficiencia;
}


public void setDeficiencia(String deficiencia) {
	this.deficiencia = deficiencia;
}


public String getDefqual() {
	return defqual;
}


public void setDefqual(String defqual) {
	this.defqual = defqual;
}


public String getEndereco() {
	return endereco;
}


public void setEndereco(String endereco) {
	this.endereco = endereco;
}


public String getNumero() {
	return numero;
}


public void setNumero(String numero) {
	this.numero = numero;
}


public String getBairro() {
	return bairro;
}


public void setBairro(String bairro) {
	this.bairro = bairro;
}


public String getUf() {
	return uf;
}


public void setUf(String uf) {
	this.uf = uf;
}


public String getCidade() {
	return cidade;
}


public void setCidade(String cidade) {
	this.cidade = cidade;
}


public String getCep() {
	return cep;
}


public void setCep(String cep) {
	this.cep = cep;
}


public String getEmail() {
	return email;
}


public void setEmail(String email) {
	this.email = email;
}


public String getFone() {
	return fone;
}


public void setFone(String fone) {
	this.fone = fone;
}


public String getAtesto() {
	return atesto;
}


public void setAtesto(String atesto) {
	this.atesto = atesto;
}


public String getDataregistro() {
	return dataregistro;
}


public void setDataregistro(String dataregistro) {
	this.dataregistro = dataregistro;
}


public String getCategoria() {
	return categoria;
}


public void setCategoria(String categoria) {
	this.categoria = categoria;
}








}
