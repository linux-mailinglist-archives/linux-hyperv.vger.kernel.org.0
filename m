Return-Path: <linux-hyperv+bounces-1762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E621887CE82
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Mar 2024 15:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7216B281D24
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Mar 2024 14:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE108364D9;
	Fri, 15 Mar 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GMfy8FA5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FAE1BF28;
	Fri, 15 Mar 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511761; cv=none; b=PerM/1jrZZdZxFefnqdP2lh1AHpOLOmRsh0I9fFP/s77Bx82kxWOAxWTmL1OqeJKp17E7tJk/uy51ZRsIUPzg6qFllcUBZ8g1tQ3AdSB/8B860sh+Tdlvcwb5JkndMUQT1uftM3N0jhsAocKNXQ/NavONr7gAXJRy/EaoAxk0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511761; c=relaxed/simple;
	bh=+80NF6M/ccn4BkFumd8sbKKEzf080dOQ87GcTcUi+7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cW40g8VZH5qAm2M4dlfGD85wCIPyWHu2rCqcsyxHOBmnCBuIMuY9w1BSZqovvYKzvc84WzEqv5ckm2An2L7zFQxHMaoVym1XwTjCkZMFPxco2rsiUBkDLjEZyGRyn/D+axbNBpp76fgZ6kjFi79qGc35NUSiKXPGmJFd3DMMSAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GMfy8FA5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C63AD20B74C0; Fri, 15 Mar 2024 07:09:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C63AD20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710511754;
	bh=4+AAib52IJ6d/7D5JTyP0xeLIwO9U0JM0O87i60Cwpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMfy8FA5CglkxAUpz90SFDaXwS0kKZV8GBQdHccIXWKdmb1/aJSAyat8GdyLbiEqY
	 3uLo1Ix8LEqS6Eki201QwdHPfdGKMMJjOV3FdfBC94pzR2Gie7hpsTUAo9ACbUQGvW
	 cYMrVHJVYGH3cl/BTQatpfA0Di6N0TJsy2jOuF2c=
Date: Fri, 15 Mar 2024 07:09:14 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>, Ani Sinha <anisinha@redhat.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
Message-ID: <20240315140914.GA14685@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
 <3bf8844a-3e19-4105-8cce-2b1f8f98d3bc@linux.microsoft.com>
 <20240313052212.GB22465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313052212.GB22465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Mar 12, 2024 at 10:22:12PM -0700, Shradha Gupta wrote:
> On Tue, Mar 12, 2024 at 09:58:03AM -0700, Easwar Hariharan wrote:
> > On 3/12/2024 5:38 AM, Shradha Gupta wrote:
> > > If the network configuration strings are passed as a combination of IPv and
> > 
> >                                                                       *IPv4*
> > 
> > > IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile
> >                                          *does not/doesn't*
> > > configuration format.
> > > With these changes, the keyfile config generation logic scans through the
> > > list twice to generate IPv4 and IPv6 sections for the configuration files
> > > to handle this support.
> > > 
> > > Built-on: Rhel9
> > > Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> > 
> > As mentioned by Jakub[1], what value does this information provide?
> > Please follow Haiyang's suggestion [2] and put SKU and test information, or just
> > skip it.
> > 
> > [1] https://lore.kernel.org/all/20240307072923.6cc8a2ba@kernel.org/
> > [2] https://lore.kernel.org/all/DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com/
> Hi Easwar, unlike the other patch this one has details about the tests that were performed.
> Since this is Hyper-v VMs specific, I could not add details around SKU or LISA tests(as it
> could not be tested using LISA). In the last patch we had missed the IPv4, IPv6 combination
> testing(which had some design issues). That's why I feel it is important to call it out in
> this patch.
> > 
> > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > ---
> > >  Changes in v2
> > >  * Use calloc to avoid initialization later
> > >  * Return standard error codes
> > >  * Free the output_str pointer on completion
> > >  * Add out-of bound checks while writing to buffers
> > > ---
> > >  tools/hv/hv_kvp_daemon.c | 173 +++++++++++++++++++++++++++++----------
> > >  1 file changed, 132 insertions(+), 41 deletions(-)
> > > 
> > > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > > index 318e2dad27e0..ae65be004eb1 100644
> > > --- a/tools/hv/hv_kvp_daemon.c
> > > +++ b/tools/hv/hv_kvp_daemon.c
> > > @@ -76,6 +76,12 @@ enum {
> > >  	DNS
> > >  };
> > >  
> > > +enum {
> > > +	IPV4 = 1,
> > > +	IPV6,
> > > +	IP_TYPE_MAX
> > > +};
> > > +
> > >  static int in_hand_shake;
> > >  
> > >  static char *os_name = "";
> > > @@ -102,6 +108,7 @@ static struct utsname uts_buf;
> > >  
> > >  #define MAX_FILE_NAME 100
> > >  #define ENTRIES_PER_BLOCK 50
> > > +#define MAX_IP_ENTRIES 64
> > 
> > Is this a limitation defined by hv_kvp? If so, is it possible it may change in a later
> > version? A comment would help here
> Sure, would update accordingly
> > 
> > >  
> > >  struct kvp_record {
> > >  	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> > > @@ -1171,6 +1178,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
> > >  	return 0;
> > >  }
> > >  
> > > +int ip_version_check(const char *input_addr)
> > > +{
> > > +	struct in6_addr addr;
> > > +
> > > +	if (inet_pton(AF_INET, input_addr, &addr))
> > > +		return IPV4;
> > > +	else if (inet_pton(AF_INET6, input_addr, &addr))
> > > +		return IPV6;
> > 
> > You can skip the else here...
> > 
> > > +	else
> > > +		return -EINVAL;
> > 
> > ...and you can skip the else here as well and just return -EINVAL
> right, will change this in the next version.
> > 
> > > +}
> > > +
> > >  /*
> > >   * Only IPv4 subnet strings needs to be converted to plen
> > >   * For IPv6 the subnet is already privided in plen format
> > > @@ -1197,14 +1216,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
> > >  	return plen;
> > >  }
> > >  
> > > +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> > > +				  int ip_sec)
> > > +{
> > > +	char addr[INET6_ADDRSTRLEN], *output_str;
> > > +	int ip_offset = 0, error = 0, ip_ver;
> > > +	char *param_name;
> > > +
> > > +	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
> > > +				    sizeof(char));
> > > +
> > > +	if (!output_str)
> > > +		return -ENOMEM;
> > > +
> > > +	memset(addr, 0, sizeof(addr));
> > > +
> > > +	if (type == DNS) {
> > > +		param_name = "dns";
> > > +	} else if (type == GATEWAY) {
> > > +		param_name = "gateway";
> > > +	} else {
> > > +		error = -EINVAL;
> > > +		goto cleanup;
> > > +	}
> > > +
> > > +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> > > +				   (MAX_IP_ADDR_SIZE * 2))) {
> > > +		ip_ver = ip_version_check(addr);
> > > +		if (ip_ver < 0)
> > > +			continue;
> > > +
> > > +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> > > +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
> > > +			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
> > > +			    (strlen(addr))) {
> > > +				strcat(output_str, addr);
> > > +				strcat(output_str, ",");
> > 
> > Prefer strncat() here
Is this needed with the bound check above. I am trying to keep parity with the rest of the 
file.
> > 
> > > +			}
> > > +			memset(addr, 0, sizeof(addr));
> > > +
> > > +		} else {
> > > +			memset(addr, 0, sizeof(addr));
> > > +			continue;
> > > +		}
> > > +	}
> > > +
> > > +	if (strlen(output_str)) {
> > > +		output_str[strlen(output_str) - 1] = '\0';
> > > +		error = fprintf(f, "%s=%s\n", param_name, output_str);
> > > +		if (error <  0)
> > > +			goto cleanup;
> > > +	}
> > > +
> > > +cleanup:
> > > +	free(output_str);
> > > +	return error;
> > > +}
> > > +
> > >  static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> > > -				int is_ipv6)
> > > +				int ip_sec)
> > >  {
> > >  	char addr[INET6_ADDRSTRLEN];
> > >  	char subnet_addr[INET6_ADDRSTRLEN];
> > >  	int error, i = 0;
> > >  	int ip_offset = 0, subnet_offset = 0;
> > > -	int plen;
> > > +	int plen, ip_ver;
> > >  
> > >  	memset(addr, 0, sizeof(addr));
> > >  	memset(subnet_addr, 0, sizeof(subnet_addr));
> > > @@ -1216,10 +1292,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> > >  						       subnet_addr,
> > >  						       (MAX_IP_ADDR_SIZE *
> > >  							2))) {
> > > -		if (!is_ipv6)
> > > +		ip_ver = ip_version_check(addr);
> > > +		if (ip_ver < 0)
> > > +			continue;
> > > +
> > > +		if (ip_ver == IPV4 && ip_sec == IPV4)
> > >  			plen = kvp_subnet_to_plen((char *)subnet_addr);
> > > -		else
> > > +		else if (ip_ver == IPV6 && ip_sec == IPV6)
> > >  			plen = atoi(subnet_addr);
> > > +		else
> > > +			continue;
> > >  
> > >  		if (plen < 0)
> > >  			return plen;
> > > @@ -1238,12 +1320,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> > >  
> > >  static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> > >  {
> > > -	int error = 0;
> > > +	int error = 0, ip_type;
> > 
> > nit: Can we keep ip_ver through all the functions for consistency
> sure.
> > 
> > <snip>
> > 
> > Thanks,
> > Easwar

