Return-Path: <linux-hyperv+bounces-1801-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D705881BB1
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 04:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69141F21ABE
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 03:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0F5BA4B;
	Thu, 21 Mar 2024 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAgDtf/C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AD0BA22
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2024 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993362; cv=none; b=hZG2uSXzf1lheeJQTt4IXKiDAtzDnJvHZcrvDJWYckM7R98Ahr4fjX94gswnAc4/VWjHQjg4wQda7EYr5r2szyJHEZK+YhxSm49qPiIYKNqfOnLcgxAhX4wU/vlY/GZY3RfHisG6bWQD3zu86qUS8ZeBRRYENZ87CJWPkkXprZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993362; c=relaxed/simple;
	bh=r0fBW5aye32LjaWlKa2QSwnu95nVcNDYV/wru0cmp3w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D4LaKpJ21VtPTtEVx2belVkdk1ufmws0UIK4U15+4QeYw5T4XQVK//xjy7hnlmgd9Ml4Pr0J9dR5XWcmzPUeK2eMz6l/LYVGX1pcNq+/kJd+ZYlrjQ6MnDQVGSSBIVi1OknO2lcDwrsImZuRxiyYbwR0haY5F6fXuQXWw/1odEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAgDtf/C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710993359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLDaXjS944vu5ps0Y9+6g4qp34PG74kRIMEPH2hmsvc=;
	b=AAgDtf/C1ZQ7DbYCX61WScQ9tmOz+wLSyEdTXLsECoKxVM8slpVosMKX8nCKbQHXmK4vsi
	cPndC+X0Oqo4en5zxjCetg/5yKswlt0QrAE6KDHJpTbBIZKltH9VfXU7yournovcQZ1+Ld
	TtHvNg2xU+vUjfyaYtsgCbCOWcVo8xM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-16uUhOE6P4K_y7ja3Z1NOQ-1; Wed, 20 Mar 2024 23:55:57 -0400
X-MC-Unique: 16uUhOE6P4K_y7ja3Z1NOQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c385e8688dso589442b6e.0
        for <linux-hyperv@vger.kernel.org>; Wed, 20 Mar 2024 20:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710993356; x=1711598156;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLDaXjS944vu5ps0Y9+6g4qp34PG74kRIMEPH2hmsvc=;
        b=wV5s1IJrkzX5iN1s0TwxlOBDU9Y6YDirbxgLHv1K6yEnJktV9+8aejU2xZo/SxgrJ3
         nWtioe2eYWH6Qbjnb9O3YPJ/o4vw2n7K4K22m/d1BjBV4qFWgdjT0daNOaCy6bemhGxm
         41stNSusTYLUGHE51jVs54Ssqa/8RVpDIoVzg3YrsPW2sV1x5TZqHvWy0CDwClTxiL+f
         o/9W8pgajywgJnGj+71EMvlrF0xHQfzqFPiu1d1Rwi2+13dKLNLUmuO00GoTKdTDqTM7
         +W3VSkA260PzA/NUt2apQYQKiCWuHoWhOw4Z7X1it1HfSvEbzGXLQKmYkk9g1B0rbVxp
         GquA==
X-Forwarded-Encrypted: i=1; AJvYcCVBQ6nDfV2qQ56FF0/0krVHih71TAeBlTV3EaEILGjqv3V1lMjMVsjc+JGS4vz1FFcscAAV3UnzjxRcNLw8pqlkKrSkTpI6Q3X+OZfK
X-Gm-Message-State: AOJu0YwkxnXouQzgyoFqghByp3U29bPP0khP2C96PWoCC+IJHYQ9SOZj
	MMZk1fKRZNvH5i7MTnI2xsUzrUw6KO3r4m8MzgFWeKo1i3HKxt1bMlHa7LugiaLusHQR6gSZRd4
	D8w3nhfMupZZSr0s3lAGqqa6U23lsNjijHw8guOtH0L5oYliuimC6pzVcBZwZWQ==
X-Received: by 2002:a05:6808:3207:b0:3c3:adaf:fd8f with SMTP id cb7-20020a056808320700b003c3adaffd8fmr482726oib.18.1710993356429;
        Wed, 20 Mar 2024 20:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXQ5LAAXEuTVh8EWAD92Jj9ZaaLnpn7U999yqqsWwSe9kHKkpKo+TREKJdI6hKBjcH1RwL/w==
X-Received: by 2002:a05:6808:3207:b0:3c3:adaf:fd8f with SMTP id cb7-20020a056808320700b003c3adaffd8fmr482712oib.18.1710993356050;
        Wed, 20 Mar 2024 20:55:56 -0700 (PDT)
Received: from smtpclient.apple ([115.96.142.122])
        by smtp.gmail.com with ESMTPSA id a26-20020a62e21a000000b006e6ae26625asm12353684pfi.68.2024.03.20.20.55.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2024 20:55:55 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
Date: Thu, 21 Mar 2024 09:25:40 +0530
Cc: linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>,
 Shradha Gupta <shradhagupta@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9879EB6C-FEC4-42AD-8B40-90457455F0DD@redhat.com>
References: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 20 Mar 2024, at 16:47, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> If the network configuration strings are passed as a combination of =
IPv4
> and IPv6 addresses, the current KVP daemon does not handle processing =
for
> the keyfile configuration format.
> With these changes, the keyfile config generation logic scans through =
the
> list twice to generate IPv4 and IPv6 sections for the configuration =
files
> to handle this support.
>=20
> Testcases ran:Rhel 9, Hyper-V VMs
>              (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> Changes in v4
> * Removed the unnecessary memset for addr in the start
> * Added a comment to describe how we erase the last comma character
> * Fixed some typos in the commit description
> * While using strncat, skip copying the '\0' character.
> ---
> tools/hv/hv_kvp_daemon.c | 181 ++++++++++++++++++++++++++++++---------
> 1 file changed, 140 insertions(+), 41 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..d64d548a802f 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -76,6 +76,12 @@ enum {
> DNS
> };
>=20
> +enum {
> + IPV4 =3D 1,
> + IPV6,
> + IP_TYPE_MAX
> +};
> +
> static int in_hand_shake;
>=20
> static char *os_name =3D "";
> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
>=20
> #define MAX_FILE_NAME 100
> #define ENTRIES_PER_BLOCK 50
> +/*
> + * Change this entry if the number of addresses increases in future
> + */
> +#define MAX_IP_ENTRIES 64
> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
>=20
> struct kvp_record {
> char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char =
*ip_string, int type)
> return 0;
> }
>=20
> +int ip_version_check(const char *input_addr)
> +{
> + struct in6_addr addr;
> +
> + if (inet_pton(AF_INET, input_addr, &addr))
> + return IPV4;
> + else if (inet_pton(AF_INET6, input_addr, &addr))
> + return IPV6;
> +
> + return -EINVAL;
> +}
> +
> /*
>  * Only IPv4 subnet strings needs to be converted to plen
>  * For IPv6 the subnet is already privided in plen format
> @@ -1197,14 +1220,75 @@ static int kvp_subnet_to_plen(char =
*subnet_addr_str)
> return plen;
> }
>=20
> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> +  int ip_sec)
> +{
> + char addr[INET6_ADDRSTRLEN], *output_str;
> + int ip_offset =3D 0, error =3D 0, ip_ver;
> + char *param_name;
> +
> + if (type =3D=3D DNS)
> + param_name =3D "dns";
> + else if (type =3D=3D GATEWAY)
> + param_name =3D "gateway";
> + else
> + return -EINVAL;
> +
> + output_str =3D (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
> + if (!output_str)
> + return -ENOMEM;
> +
> + while (1) {
> + memset(addr, 0, sizeof(addr));
> +
> + if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
> + (MAX_IP_ADDR_SIZE * 2)))
> + break;
> +
> + ip_ver =3D ip_version_check(addr);
> + if (ip_ver < 0)
> + continue;
> +
> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
> + /*
> + * do a bound check to avoid out-of bound writes
> + */
> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
> +    (strlen(addr) + 1)) {
> + strncat(output_str, addr,
> + OUTSTR_BUF_SIZE -
> + strlen(output_str) - 1);
> + strncat(output_str, ",",
> + OUTSTR_BUF_SIZE -
> + strlen(output_str) - 1);
> + }
> + } else {
> + continue;
> + }
> + }
> +
> + if (strlen(output_str)) {
> + /*
> + * This is to get rid of that extra comma character
> + * in the end of the string
> + */
> + output_str[strlen(output_str) - 1] =3D '\0';
> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);
> + }
> +
> + free(output_str);
> + return error;
> +}
> +
> static int process_ip_string_nm(FILE *f, char *ip_string, char =
*subnet,
> - int is_ipv6)
> + int ip_sec)
> {
> char addr[INET6_ADDRSTRLEN];
> char subnet_addr[INET6_ADDRSTRLEN];
> int error, i =3D 0;
> int ip_offset =3D 0, subnet_offset =3D 0;
> - int plen;
> + int plen, ip_ver;
>=20
> memset(addr, 0, sizeof(addr));
> memset(subnet_addr, 0, sizeof(subnet_addr));
> @@ -1216,10 +1300,16 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>       subnet_addr,
>       (MAX_IP_ADDR_SIZE *
> 2))) {
> - if (!is_ipv6)
> + ip_ver =3D ip_version_check(addr);
> + if (ip_ver < 0)
> + continue;
> +
> + if (ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4)
> plen =3D kvp_subnet_to_plen((char *)subnet_addr);
> - else
> + else if (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)
> plen =3D atoi(subnet_addr);
> + else
> + continue;
>=20
> if (plen < 0)
> return plen;
> @@ -1238,12 +1328,11 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>=20
> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value =
*new_val)
> {
> - int error =3D 0;
> + int error =3D 0, ip_ver;
> char if_filename[PATH_MAX];
> char nm_filename[PATH_MAX];
> FILE *ifcfg_file, *nmfile;
> char cmd[PATH_MAX];
> - int is_ipv6 =3D 0;
> char *mac_addr;
> int str_len;
>=20
> @@ -1421,52 +1510,62 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
> if (error)
> goto setval_error;
>=20
> - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
> - error =3D fprintf(nmfile, "\n[ipv6]\n");
> - if (error < 0)
> - goto setval_error;
> - is_ipv6 =3D 1;
> - } else {
> - error =3D fprintf(nmfile, "\n[ipv4]\n");
> - if (error < 0)
> - goto setval_error;
> - }
> -
> /*
> - * Now we populate the keyfile format
> + * The keyfile format expects the IPv6 and IPv4 configuration in
> + * different sections. Therefore we iterate through the list twice,
> + * once to populate the IPv4 section and the next time for IPv6
> */
> + ip_ver =3D IPV4;
> + do {
> + if (ip_ver =3D=3D IPV4) {
> + error =3D fprintf(nmfile, "\n[ipv4]\n");
> + if (error < 0)
> + goto setval_error;
> + } else {
> + error =3D fprintf(nmfile, "\n[ipv6]\n");
> + if (error < 0)
> + goto setval_error;
> + }
>=20
> - if (new_val->dhcp_enabled) {
> - error =3D kvp_write_file(nmfile, "method", "", "auto");
> - if (error < 0)
> - goto setval_error;
> - } else {
> - error =3D kvp_write_file(nmfile, "method", "", "manual");
> + /*
> + * Now we populate the keyfile format
> + */
> +
> + if (new_val->dhcp_enabled) {
> + error =3D kvp_write_file(nmfile, "method", "", "auto");
> + if (error < 0)
> + goto setval_error;
> + } else {
> + error =3D kvp_write_file(nmfile, "method", "", "manual");
> + if (error < 0)
> + goto setval_error;

There is a problem with this code. dhcp_enabled is only valid for ipv4. =
=46rom looking at ifcfg files that were generated before, I do not see =
IPV6_AUTOCONF related settings. So maybe we should set method only for =
ipv4 and not for ipv6.

If the user configures only ipv6, then we do not want to have a section =
with
method =3D manual for ipv4. method =3D manual without an IP address does =
not work. So I suggest that we set method =3D manual only after checking =
that ipv4 addresses were added. So maybe move this section a little =
below after call to process_ip_string_nm(). This function can return a =
specific value to indicate that address were indeed written to the if =
cfg/kefile. I am not sure what happens when dhcp_enabled is True and the =
user provides specific IP addresses.


> + }
> +
> + /*
> + * Write the configuration for ipaddress, netmask, gateway and
> + * name services
> + */
> + error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +     (char *)new_val->sub_net,
> +     ip_ver);
> if (error < 0)
> goto setval_error;
> - }
>=20
> - /*
> - * Write the configuration for ipaddress, netmask, gateway and
> - * name services
> - */
> - error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> -     (char *)new_val->sub_net, is_ipv6);
> - if (error < 0)
> - goto setval_error;
> -
> - /* we do not want ipv4 addresses in ipv6 section and vice versa */
> - if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
> - error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
> + error =3D process_dns_gateway_nm(nmfile,
> +       (char *)new_val->gate_way,
> +       GATEWAY, ip_ver);
> if (error < 0)
> goto setval_error;
> - }
>=20
> - if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
> - error =3D fprintf(nmfile, "dns=3D%s\n", (char *)new_val->dns_addr);
> + error =3D process_dns_gateway_nm(nmfile,
> +       (char *)new_val->dns_addr, DNS,
> +       ip_ver);
> if (error < 0)
> goto setval_error;
> - }
> +
> + ip_ver++;
> + } while (ip_ver < IP_TYPE_MAX);
> +
> fclose(nmfile);
> fclose(ifcfg_file);
>=20
> --=20
> 2.34.1
>=20


