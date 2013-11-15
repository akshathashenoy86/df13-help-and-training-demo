/**
 * Copyright (c) 2012, FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

public with sharing class HelpController 
{	
	/**
	 * eg 'en-us'
	 **/
	public String provideLanguage() 
	{
		return UserInfo.getLanguage().toLowerCase().replaceAll('_', '-');
	}
	
	/**
	 * eg 'warehouse'
	 */
	public String provideProductIndex()
	{
		return 'warehouse';
	}
	
	/**
	 * eg '2X'
	 */
	public String provideProductVersion()
	{
		return '2X';
	}
	
	/**
	 * eg '1007'
	 */
	public String provideTopicId()
	{	
		return ApexPages.currentPage().getParameters().get('topicid');
	}
	
	/**
	 * eg 'http://en-us.help.mycompany.com/warehouse/2X/Default_CSH.htm#1007'
	 */
	public string buildHelpUrl(String language, String product, String version, String topic)
	{
		// Construct the URL (if the location does not support a default language for none translated langauges, it can be done here)
		return 
			'https://googledrive.com/host/0B2W47xOYuG8eOFNiT2VFNjN2cWM/' + 
			language +
			'/Default_CSH.htm#' +
			topic;
		/*
		return
			'http://'
			+ language
			+ '.help.mycompany.com/'
			+ product
			+ '/'
			+ version
			+ '/Default_CSH.htm#'
			+ topic;
		*/
	}
	
	/**
	 * Redirects to hosted help on Amazon S3.
	 */
	public PageReference doRedirect()
	{
		String url = this.buildHelpUrl(
			this.provideLanguage(),
			this.provideProductIndex(),
			this.provideProductVersion(),
			this.provideTopicId()
		);
		
		PageReference pageReference = new PageReference(url); //PageReference drops the URI fragment when constructed
		pageReference.setAnchor(url.substringAfter('#')); //so we need to add the URI fragment back in like this
		return pageReference;
	}	
}