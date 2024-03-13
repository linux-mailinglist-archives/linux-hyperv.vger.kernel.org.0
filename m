Return-Path: <linux-hyperv+bounces-1741-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AEC87A297
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 06:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A6F1C20A56
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Mar 2024 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56E71170D;
	Wed, 13 Mar 2024 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bkBgiC6w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856AF11193;
	Wed, 13 Mar 2024 05:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710306970; cv=none; b=NNCExNX3CJ8JkFPUm/6pW5hvdk07BKTua3/v8SV3sKnESKjtn0AXX0Mu8pX4XCG/GuEfNwFhUdEifQG8T3TAYUXMv6aKP9DSra+kYmIXGXsXNvKSdMeUkpXPjAMY5nloCc06etiBLM3kHWAb86r5t6JIPxBJ3/UK36JJw1LLUtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710306970; c=relaxed/simple;
	bh=w/7hFZlEMmyjxS8NBrreAYFeSzvXsZf3yn7t2zFJWeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJI2liK1Wz+qtd/X26aYnCaVuUuCkMnna+l7DyByxlu8NWJBGsRPjbMXAAJY2hUhwOmV6xreYEQHp+imgc55Qc7hrxxQu/1S3UiafX3z9S+0nGOMR+J5gC4LwYQMSNle0Flra0inj/WlRsnQpJqA7fPYw6J8XJGXxZvr3W8nrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bkBgiC6w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 1045A20B74C0; Tue, 12 Mar 2024 22:16:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1045A20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710306966;
	bh=sn4l0VbyyrXH7eTsx2DsP0hWVuPE9zYtzOeBraJDAUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkBgiC6wsPWmDxBXWYqexPdf3Zgpd1tXvsedfNVxM+i3Cf2NfO1j5Vre1e5623n2H
	 /WhBOgz4xs28DsMMIeKqlf8CJPXkN2PcRLBbdxNmZmDqkGwhZwNYVuFnmZzcO1MP/f
	 0n6x74Mo4sM9z3PLPVUucgCoBHAPKoishiNm33Fw=
Date: Tue, 12 Mar 2024 22:16:06 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
Message-ID: <20240313051605.GA22465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
 <2d4aeba3-79db-67f7-9d38-5a55788e7cc7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d4aeba3-79db-67f7-9d38-5a55788e7cc7@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Mar 12, 2024 at 08:09:03PM +0530, Ani Sinha wrote:
> 
> 
> On Tue, 12 Mar 2024, Shradha Gupta wrote:
> 
> > If the network configuration strings are passed as a combination of IPv and
> > IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile
> > configuration format.
> > With these changes, the keyfile config generation logic scans through the
> > list twice to generate IPv4 and IPv6 sections for the configuration files
> > to handle this support.
> >
> > Built-on: Rhel9
> > Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > ---
> >  Changes in v2
> >  * Use calloc to avoid initialization later
> >  * Return standard error codes
> >  * Free the output_str pointer on completion
> >  * Add out-of bound checks while writing to buffers
> > ---
> >  tools/hv/hv_kvp_daemon.c | 173 +++++++++++++++++++++++++++++----------
> >  1 file changed, 132 insertions(+), 41 deletions(-)
> >
> > diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> > index 318e2dad27e0..ae65be004eb1 100644
> > --- a/tools/hv/hv_kvp_daemon.c
> > +++ b/tools/hv/hv_kvp_daemon.c
> > @@ -76,6 +76,12 @@ enum {
> >  	DNS
> >  };
> >
> > +enum {
> > +	IPV4 = 1,
> > +	IPV6,
> > +	IP_TYPE_MAX
> > +};
> > +
> >  static int in_hand_shake;
> >
> >  static char *os_name = "";
> > @@ -102,6 +108,7 @@ static struct utsname uts_buf;
> >
> >  #define MAX_FILE_NAME 100
> >  #define ENTRIES_PER_BLOCK 50
> > +#define MAX_IP_ENTRIES 64
> >
> >  struct kvp_record {
> >  	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> > @@ -1171,6 +1178,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
> >  	return 0;
> >  }
> >
> > +int ip_version_check(const char *input_addr)
> > +{
> > +	struct in6_addr addr;
> > +
> > +	if (inet_pton(AF_INET, input_addr, &addr))
> > +		return IPV4;
> > +	else if (inet_pton(AF_INET6, input_addr, &addr))
> > +		return IPV6;
> > +	else
> > +		return -EINVAL;
> > +}
> > +
> >  /*
> >   * Only IPv4 subnet strings needs to be converted to plen
> >   * For IPv6 the subnet is already privided in plen format
> > @@ -1197,14 +1216,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
> >  	return plen;
> >  }
> >
> > +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> > +				  int ip_sec)
> > +{
> > +	char addr[INET6_ADDRSTRLEN], *output_str;
> > +	int ip_offset = 0, error = 0, ip_ver;
> > +	char *param_name;
> > +
> > +	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
> > +				    sizeof(char));
> 
> Can we define INET6_ADDRSTRLEN * MAX_IP_ENTRIES as something like
> OUTSTR_BUF_SZ or some such? Then it becomes more readable here and below.
sure, that makes sense.
> 
> > +
> > +	if (!output_str)
> > +		return -ENOMEM;
> > +
> > +	memset(addr, 0, sizeof(addr));
> 
> 
> > +
> > +	if (type == DNS) {
> > +		param_name = "dns";
> > +	} else if (type == GATEWAY) {
> > +		param_name = "gateway";
> > +	} else {
> > +		error = -EINVAL;
> > +		goto cleanup;
> > +	}
> 
> If you move the above check before you allocate memory for output_str, you
> can return right away without doing a free().
Right, I'll do that
> 
> > +
> > +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> > +				   (MAX_IP_ADDR_SIZE * 2))) {
> > +		ip_ver = ip_version_check(addr);
> > +		if (ip_ver < 0)
> > +			continue;
> > +
> > +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> > +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
> > +			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
> > +			    (strlen(addr))) {
> > +				strcat(output_str, addr);
> > +				strcat(output_str, ",");
> 
> Your bound check does not take into consideration one additional character
> (the ","). It should be
> 
> (INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str) > strlen(addr) + 1
> 
> > +			}
> > +			memset(addr, 0, sizeof(addr));
> > +
> > +		} else {
> > +			memset(addr, 0, sizeof(addr));
> 
> if you do memset() at the beginning of the loop, you do not need to do
> this separately for both branches. Plus there would be no need to do this
> at the beginning of the function as well.
> So you could do something like:
> 
> while(1) {
>   memset(addr ...);
>   if (!parse_ip_val_buffer(...))
>       break;
>   ...
> }
makes sense.
> 
> 
> > +			continue;
> > +		}
> > +	}
> > +
> > +	if (strlen(output_str)) {
> 
>                 // remove the last comma character
> 
> > +		output_str[strlen(output_str) - 1] = '\0';
> > +		error = fprintf(f, "%s=%s\n", param_name, output_str);
> > +		if (error <  0)
> > +			goto cleanup;
> 
> You need to free memory regardless of whether there is an error or not.
Right, no need for the above check. Thanks
> 
> > +	}
> > +
> > +cleanup:
> > +	free(output_str);
> > +	return error;
> > +}
> > +
> >  static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> > -				int is_ipv6)
> > +				int ip_sec)
> >  {
> >  	char addr[INET6_ADDRSTRLEN];
> >  	char subnet_addr[INET6_ADDRSTRLEN];
> >  	int error, i = 0;
> >  	int ip_offset = 0, subnet_offset = 0;
> > -	int plen;
> > +	int plen, ip_ver;
> >
> >  	memset(addr, 0, sizeof(addr));
> >  	memset(subnet_addr, 0, sizeof(subnet_addr));
> > @@ -1216,10 +1292,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >  						       subnet_addr,
> >  						       (MAX_IP_ADDR_SIZE *
> >  							2))) {
> > -		if (!is_ipv6)
> > +		ip_ver = ip_version_check(addr);
> > +		if (ip_ver < 0)
> > +			continue;
> > +
> > +		if (ip_ver == IPV4 && ip_sec == IPV4)
> >  			plen = kvp_subnet_to_plen((char *)subnet_addr);
> > -		else
> > +		else if (ip_ver == IPV6 && ip_sec == IPV6)
> >  			plen = atoi(subnet_addr);
> > +		else
> > +			continue;
> >
> >  		if (plen < 0)
> >  			return plen;
> > @@ -1238,12 +1320,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> >
> >  static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >  {
> > -	int error = 0;
> > +	int error = 0, ip_type;
> >  	char if_filename[PATH_MAX];
> >  	char nm_filename[PATH_MAX];
> >  	FILE *ifcfg_file, *nmfile;
> >  	char cmd[PATH_MAX];
> > -	int is_ipv6 = 0;
> >  	char *mac_addr;
> >  	int str_len;
> >
> > @@ -1421,52 +1502,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
> >  	if (error)
> >  		goto setval_error;
> >
> > -	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> > -		error = fprintf(nmfile, "\n[ipv6]\n");
> > -		if (error < 0)
> > -			goto setval_error;
> > -		is_ipv6 = 1;
> > -	} else {
> > -		error = fprintf(nmfile, "\n[ipv4]\n");
> > -		if (error < 0)
> > -			goto setval_error;
> > -	}
> > -
> >  	/*
> > -	 * Now we populate the keyfile format
> > +	 * The keyfile format expects the IPv6 and IPv4 configuration in
> > +	 * different sections. Therefore we iterate through the list twice,
> > +	 * once to populate the IPv4 section and the next time for IPv6
> >  	 */
> > +	ip_type = IPV4;
> > +	do {
> > +		if (ip_type == IPV4) {
> > +			error = fprintf(nmfile, "\n[ipv4]\n");
> > +			if (error < 0)
> > +				goto setval_error;
> > +		} else {
> > +			error = fprintf(nmfile, "\n[ipv6]\n");
> > +			if (error < 0)
> > +				goto setval_error;
> > +		}
> >
> > -	if (new_val->dhcp_enabled) {
> > -		error = kvp_write_file(nmfile, "method", "", "auto");
> > -		if (error < 0)
> > -			goto setval_error;
> > -	} else {
> > -		error = kvp_write_file(nmfile, "method", "", "manual");
> > +		/*
> > +		 * Now we populate the keyfile format
> > +		 */
> > +
> > +		if (new_val->dhcp_enabled) {
> > +			error = kvp_write_file(nmfile, "method", "", "auto");
> > +			if (error < 0)
> > +				goto setval_error;
> > +		} else {
> > +			error = kvp_write_file(nmfile, "method", "", "manual");
> > +			if (error < 0)
> > +				goto setval_error;
> > +		}
> > +
> > +		/*
> > +		 * Write the configuration for ipaddress, netmask, gateway and
> > +		 * name services
> > +		 */
> > +		error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> > +					     (char *)new_val->sub_net,
> > +					     ip_type);
> >  		if (error < 0)
> >  			goto setval_error;
> > -	}
> >
> > -	/*
> > -	 * Write the configuration for ipaddress, netmask, gateway and
> > -	 * name services
> > -	 */
> > -	error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> > -				     (char *)new_val->sub_net, is_ipv6);
> > -	if (error < 0)
> > -		goto setval_error;
> > -
> > -	/* we do not want ipv4 addresses in ipv6 section and vice versa */
> > -	if (is_ipv6 != is_ipv4((char *)new_val->gate_way)) {
> > -		error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
> > +		error = process_dns_gateway_nm(nmfile,
> > +					       (char *)new_val->gate_way,
> > +					       GATEWAY, ip_type);
> >  		if (error < 0)
> >  			goto setval_error;
> > -	}
> >
> > -	if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
> > -		error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
> > +		error = process_dns_gateway_nm(nmfile,
> > +					       (char *)new_val->dns_addr, DNS,
> > +					       ip_type);
> >  		if (error < 0)
> >  			goto setval_error;
> > -	}
> > +
> > +		ip_type++;
> > +	} while (ip_type < IP_TYPE_MAX);
> > +
> >  	fclose(nmfile);
> >  	fclose(ifcfg_file);
> >
> > --
> > 2.34.1
> >
> >

