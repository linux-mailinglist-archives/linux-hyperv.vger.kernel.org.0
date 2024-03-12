Return-Path: <linux-hyperv+bounces-1732-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9CE879688
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 15:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44C82844FA
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8157B3D2;
	Tue, 12 Mar 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx7jBqVl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D47A709
	for <linux-hyperv@vger.kernel.org>; Tue, 12 Mar 2024 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254356; cv=none; b=hJIdCVUinoeuA8rksLHqqhRckp3Sdr7VG91Lc/dN7lkm1aQKzGNGDAJPPI5c8yDOQpYU/2BfU49zHOKRRReh7z52zfLdRdJcueMeVL+7wlT5pLXI5nZMqA5OUbUcJMGj0zyk0pEh3Yfw/jInPiuKYa14VnJqlVP2A2SHqs9pTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254356; c=relaxed/simple;
	bh=6G228Lphk0rlkU29bdOENgX5OXrMOrVaqWm38EVzM0Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lpoHBjQ275VsawSAioBDJgVG/jt5gfFSn2uxJ7S/81tDMCJmKmkwg+ivRMlo6+zFY3pmBaTaYC7TFo5p5wvOcefWAH2Hjy2oLH2IJwOsFoEzkah+KyBELbCpDz9n1//ctKzewcqT5VgcjCzwMEcj0hzh2lcYaOJZv/UuBmmXdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx7jBqVl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710254353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XMJRtZVN7j/hb0lf5DmhVFdq1TvSh1Jy4166EHZPeco=;
	b=Gx7jBqVlQWzGYSQKGIlmDPECiPZntPxp3oBfAxBUt4p9N0YhLeBPa1SNuwGCWEAIE+Hp+Y
	WiYRGtmiDVeeIQ6/B31Wr+Nwy70TYLXBJWHpMJn271fueLK2+cznSpCaCpDP/NmpnO823M
	viucHErMvbHFLvEJutYfSVYAEidx+0M=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-qOBmVXdbPL2E_DwHd6bh5Q-1; Tue, 12 Mar 2024 10:39:12 -0400
X-MC-Unique: qOBmVXdbPL2E_DwHd6bh5Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso3473679a12.3
        for <linux-hyperv@vger.kernel.org>; Tue, 12 Mar 2024 07:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254351; x=1710859151;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMJRtZVN7j/hb0lf5DmhVFdq1TvSh1Jy4166EHZPeco=;
        b=YjmrTp+qO0ZM5kItZ2NURKmxhEQvTBamvjxMgtDVfI3pVce3n07xFN1wX0HXRSAcYY
         vH22rX1Hv79bDK4U+KSNIOwhqy1kut2kiaGVZJ3udirFRGkJG+EfwVK7oZIqEQ/4OCyI
         CpgIzK/q/UOz9l4emkN5kTh+oLeepXUthhpI3eHziKhuKkDi7zXmcYAazwtNs5hHMmn2
         2xQoLbcp3qSkranuZc/GSvqwaLGK2WO7rOTtu7s0gzbVW41O2+CNh7ZtzNvRq5TOXfkc
         fP61V4sm4uflP7uCbOjaE7TdD2f9OlaDunuyh6NuRFMV/bN2k0rwqg0aXyAErEJygpHz
         X5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVVW2Iy27EHp1VUtHPDiOYVpIUZUrlZq1gMuX3Bae9h3IqNQxmPM2N07wCZO4cbg5Fr0znNj4qTSHvDYzYmn4/deykJCe54kQRH6wMM
X-Gm-Message-State: AOJu0Yzri9CuWU2n672BnYtzhuA8y5fI0Y27611VBS6IZZAGHmRRyJTD
	s2nywGGfgbnJPmmA0KDKJF6HCIPJS1yyG0gRVEVUyNf5ms0uN7S97gqjN2nKN242T9t3x+am41I
	lLuzNUYprJHs6vBNcD5Rn6YzkqyvNf3ErdvStfJTCGATag/anDbULVFuZU6i5BQ==
X-Received: by 2002:a05:6a20:3b86:b0:1a1:484b:bb72 with SMTP id b6-20020a056a203b8600b001a1484bbb72mr5382593pzh.51.1710254351260;
        Tue, 12 Mar 2024 07:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPP5p51xPHF2DD8z81UogPopL+7AvbfQe8qKjS8v04/Cfcqoeaa+s5PtsgFBJjF90oaSKGoQ==
X-Received: by 2002:a05:6a20:3b86:b0:1a1:484b:bb72 with SMTP id b6-20020a056a203b8600b001a1484bbb72mr5382568pzh.51.1710254350762;
        Tue, 12 Mar 2024 07:39:10 -0700 (PDT)
Received: from fc37-ani ([27.6.216.53])
        by smtp.googlemail.com with ESMTPSA id q66-20020a17090a17c800b0029bb1631819sm694127pja.0.2024.03.12.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 07:39:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 20:09:03 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Michael Kelley <mikelley@microsoft.com>, Olaf Hering <olaf@aepfle.de>, 
    Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
In-Reply-To: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
Message-ID: <2d4aeba3-79db-67f7-9d38-5a55788e7cc7@redhat.com>
References: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 12 Mar 2024, Shradha Gupta wrote:

> If the network configuration strings are passed as a combination of IPv and
> IPv6 addresses, the current KVP daemon doesnot handle it for the keyfile
> configuration format.
> With these changes, the keyfile config generation logic scans through the
> list twice to generate IPv4 and IPv6 sections for the configuration files
> to handle this support.
>
> Built-on: Rhel9
> Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
>  Changes in v2
>  * Use calloc to avoid initialization later
>  * Return standard error codes
>  * Free the output_str pointer on completion
>  * Add out-of bound checks while writing to buffers
> ---
>  tools/hv/hv_kvp_daemon.c | 173 +++++++++++++++++++++++++++++----------
>  1 file changed, 132 insertions(+), 41 deletions(-)
>
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..ae65be004eb1 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -76,6 +76,12 @@ enum {
>  	DNS
>  };
>
> +enum {
> +	IPV4 = 1,
> +	IPV6,
> +	IP_TYPE_MAX
> +};
> +
>  static int in_hand_shake;
>
>  static char *os_name = "";
> @@ -102,6 +108,7 @@ static struct utsname uts_buf;
>
>  #define MAX_FILE_NAME 100
>  #define ENTRIES_PER_BLOCK 50
> +#define MAX_IP_ENTRIES 64
>
>  struct kvp_record {
>  	char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> @@ -1171,6 +1178,18 @@ static int process_ip_string(FILE *f, char *ip_string, int type)
>  	return 0;
>  }
>
> +int ip_version_check(const char *input_addr)
> +{
> +	struct in6_addr addr;
> +
> +	if (inet_pton(AF_INET, input_addr, &addr))
> +		return IPV4;
> +	else if (inet_pton(AF_INET6, input_addr, &addr))
> +		return IPV6;
> +	else
> +		return -EINVAL;
> +}
> +
>  /*
>   * Only IPv4 subnet strings needs to be converted to plen
>   * For IPv6 the subnet is already privided in plen format
> @@ -1197,14 +1216,71 @@ static int kvp_subnet_to_plen(char *subnet_addr_str)
>  	return plen;
>  }
>
> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> +				  int ip_sec)
> +{
> +	char addr[INET6_ADDRSTRLEN], *output_str;
> +	int ip_offset = 0, error = 0, ip_ver;
> +	char *param_name;
> +
> +	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
> +				    sizeof(char));

Can we define INET6_ADDRSTRLEN * MAX_IP_ENTRIES as something like
OUTSTR_BUF_SZ or some such? Then it becomes more readable here and below.

> +
> +	if (!output_str)
> +		return -ENOMEM;
> +
> +	memset(addr, 0, sizeof(addr));


> +
> +	if (type == DNS) {
> +		param_name = "dns";
> +	} else if (type == GATEWAY) {
> +		param_name = "gateway";
> +	} else {
> +		error = -EINVAL;
> +		goto cleanup;
> +	}

If you move the above check before you allocate memory for output_str, you
can return right away without doing a free().

> +
> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +				   (MAX_IP_ADDR_SIZE * 2))) {
> +		ip_ver = ip_version_check(addr);
> +		if (ip_ver < 0)
> +			continue;
> +
> +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
> +			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
> +			    (strlen(addr))) {
> +				strcat(output_str, addr);
> +				strcat(output_str, ",");

Your bound check does not take into consideration one additional character
(the ","). It should be

(INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str) > strlen(addr) + 1

> +			}
> +			memset(addr, 0, sizeof(addr));
> +
> +		} else {
> +			memset(addr, 0, sizeof(addr));

if you do memset() at the beginning of the loop, you do not need to do
this separately for both branches. Plus there would be no need to do this
at the beginning of the function as well.
So you could do something like:

while(1) {
  memset(addr ...);
  if (!parse_ip_val_buffer(...))
      break;
  ...
}


> +			continue;
> +		}
> +	}
> +
> +	if (strlen(output_str)) {

                // remove the last comma character

> +		output_str[strlen(output_str) - 1] = '\0';
> +		error = fprintf(f, "%s=%s\n", param_name, output_str);
> +		if (error <  0)
> +			goto cleanup;

You need to free memory regardless of whether there is an error or not.

> +	}
> +
> +cleanup:
> +	free(output_str);
> +	return error;
> +}
> +
>  static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
> -				int is_ipv6)
> +				int ip_sec)
>  {
>  	char addr[INET6_ADDRSTRLEN];
>  	char subnet_addr[INET6_ADDRSTRLEN];
>  	int error, i = 0;
>  	int ip_offset = 0, subnet_offset = 0;
> -	int plen;
> +	int plen, ip_ver;
>
>  	memset(addr, 0, sizeof(addr));
>  	memset(subnet_addr, 0, sizeof(subnet_addr));
> @@ -1216,10 +1292,16 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
>  						       subnet_addr,
>  						       (MAX_IP_ADDR_SIZE *
>  							2))) {
> -		if (!is_ipv6)
> +		ip_ver = ip_version_check(addr);
> +		if (ip_ver < 0)
> +			continue;
> +
> +		if (ip_ver == IPV4 && ip_sec == IPV4)
>  			plen = kvp_subnet_to_plen((char *)subnet_addr);
> -		else
> +		else if (ip_ver == IPV6 && ip_sec == IPV6)
>  			plen = atoi(subnet_addr);
> +		else
> +			continue;
>
>  		if (plen < 0)
>  			return plen;
> @@ -1238,12 +1320,11 @@ static int process_ip_string_nm(FILE *f, char *ip_string, char *subnet,
>
>  static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  {
> -	int error = 0;
> +	int error = 0, ip_type;
>  	char if_filename[PATH_MAX];
>  	char nm_filename[PATH_MAX];
>  	FILE *ifcfg_file, *nmfile;
>  	char cmd[PATH_MAX];
> -	int is_ipv6 = 0;
>  	char *mac_addr;
>  	int str_len;
>
> @@ -1421,52 +1502,62 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
>  	if (error)
>  		goto setval_error;
>
> -	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> -		error = fprintf(nmfile, "\n[ipv6]\n");
> -		if (error < 0)
> -			goto setval_error;
> -		is_ipv6 = 1;
> -	} else {
> -		error = fprintf(nmfile, "\n[ipv4]\n");
> -		if (error < 0)
> -			goto setval_error;
> -	}
> -
>  	/*
> -	 * Now we populate the keyfile format
> +	 * The keyfile format expects the IPv6 and IPv4 configuration in
> +	 * different sections. Therefore we iterate through the list twice,
> +	 * once to populate the IPv4 section and the next time for IPv6
>  	 */
> +	ip_type = IPV4;
> +	do {
> +		if (ip_type == IPV4) {
> +			error = fprintf(nmfile, "\n[ipv4]\n");
> +			if (error < 0)
> +				goto setval_error;
> +		} else {
> +			error = fprintf(nmfile, "\n[ipv6]\n");
> +			if (error < 0)
> +				goto setval_error;
> +		}
>
> -	if (new_val->dhcp_enabled) {
> -		error = kvp_write_file(nmfile, "method", "", "auto");
> -		if (error < 0)
> -			goto setval_error;
> -	} else {
> -		error = kvp_write_file(nmfile, "method", "", "manual");
> +		/*
> +		 * Now we populate the keyfile format
> +		 */
> +
> +		if (new_val->dhcp_enabled) {
> +			error = kvp_write_file(nmfile, "method", "", "auto");
> +			if (error < 0)
> +				goto setval_error;
> +		} else {
> +			error = kvp_write_file(nmfile, "method", "", "manual");
> +			if (error < 0)
> +				goto setval_error;
> +		}
> +
> +		/*
> +		 * Write the configuration for ipaddress, netmask, gateway and
> +		 * name services
> +		 */
> +		error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +					     (char *)new_val->sub_net,
> +					     ip_type);
>  		if (error < 0)
>  			goto setval_error;
> -	}
>
> -	/*
> -	 * Write the configuration for ipaddress, netmask, gateway and
> -	 * name services
> -	 */
> -	error = process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> -				     (char *)new_val->sub_net, is_ipv6);
> -	if (error < 0)
> -		goto setval_error;
> -
> -	/* we do not want ipv4 addresses in ipv6 section and vice versa */
> -	if (is_ipv6 != is_ipv4((char *)new_val->gate_way)) {
> -		error = fprintf(nmfile, "gateway=%s\n", (char *)new_val->gate_way);
> +		error = process_dns_gateway_nm(nmfile,
> +					       (char *)new_val->gate_way,
> +					       GATEWAY, ip_type);
>  		if (error < 0)
>  			goto setval_error;
> -	}
>
> -	if (is_ipv6 != is_ipv4((char *)new_val->dns_addr)) {
> -		error = fprintf(nmfile, "dns=%s\n", (char *)new_val->dns_addr);
> +		error = process_dns_gateway_nm(nmfile,
> +					       (char *)new_val->dns_addr, DNS,
> +					       ip_type);
>  		if (error < 0)
>  			goto setval_error;
> -	}
> +
> +		ip_type++;
> +	} while (ip_type < IP_TYPE_MAX);
> +
>  	fclose(nmfile);
>  	fclose(ifcfg_file);
>
> --
> 2.34.1
>
>


