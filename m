Return-Path: <linux-hyperv+bounces-1815-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0932A886EFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 15:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D54B2302A
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB4C481C2;
	Fri, 22 Mar 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQmxwaKq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AA48790
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Mar 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118784; cv=none; b=HRm+PeiO/w8LMZg807HQh5QCHb46pUFpdwwUryMdi5ZJEIoRzTM+h9NOVXUAIACRE8h7PdUv3pxpZEeRGkWHwLCmuNW7g0mC3MNFUuFBFMT+RebvfcexI4LmRCGLebKP2L9kv8DAac/BbG6xA4iRaXgSWNsT/TTDFabuhEeRcTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118784; c=relaxed/simple;
	bh=2OLBSmKbfWl0mQMfplJ+EOUjrlXFxoKD3AFdSuW0tt4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Kmy9qoCVYZZmVMDO2oMmFq/CZrC2CrcBJ3qGkBVPElRqB0ES+QCBA8JkCVMWZw6g+qP37QfPH58P2WhCuUmEnHfmtV1wb6Jk4S3kxGo2LfnlkevrzcZGr3DAZwLKxKx9jnUDZWceaOncXGAPgh47VVRjN1acVO1BgHRBi3hthx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQmxwaKq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711118780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYy4v+/sbdKYlL+/8ZdK/bGpwxS4+Wt4hNJ2lCaZCH4=;
	b=DQmxwaKqDt7CPNkqheH2CaLUC+s8l5wEObGRMHE/NnmZa/SByoDKOW4F56uQyEU6ql/1Un
	b94eTpkfYpVQ89Q0fuVIwdnRTaccXZgQBJlqOnWQREJRXjGbNnW2840i1BBzU7+9Bv9tSp
	k2ZuTMapYmTyihKnZGU07CZ6poaVK1M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-8lw4WSHTN0CdY7SrAFM-Nw-1; Fri, 22 Mar 2024 10:46:19 -0400
X-MC-Unique: 8lw4WSHTN0CdY7SrAFM-Nw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29b8f702cbfso1479954a91.1
        for <linux-hyperv@vger.kernel.org>; Fri, 22 Mar 2024 07:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118778; x=1711723578;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYy4v+/sbdKYlL+/8ZdK/bGpwxS4+Wt4hNJ2lCaZCH4=;
        b=To3tuw2v79CRqiq0/rKMxLleNqgkiUst9y/DE1JuK8xwRB0y8voJrxCrwjY3dmymbL
         e+d7nwB5t7tKpqLtnDid9y3OEv3BWxiKSn+nkYZFdFLeXHKLx3FLxKn3JpNiTc+vUU23
         2HDWgmSetQGqR1gbUgZi1ubQojzkFGlYok7UwyO/OU+pZwlvC3a10CE8iQ/YcU5skp7I
         PFOSje/45MxhlOP1pZWU+EbxcGA1RUZroehwncbYKQyiN39RNqwTOlwqzyxtXX8NRhUd
         5DHAQ4zWy8gV+N103ww+o44pHMaKZmMvt2eUHqX1IqeDznJLLaJqW/mvKCboCEkg7YMQ
         NSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgOKqxeN4NdzJ8bnKqg02SJv1XNBq5M/VDoxMz6olAhTXdTDWZHkqYKuBcFBzfSEer//4J8VWzjTbaM540StOPiTsZ289hFdxQlTJg
X-Gm-Message-State: AOJu0YxqRlY+2LFmbjlKldH5k8rWsgqvjt0wAJwkzL41p20J7nbQwOKH
	aY+sl73j0tBFS5WXXwAeAC0STIIYpbslGEiviKaHznxLB6kIHCHNMhu6r8npEyV/OQI0yAHtTEH
	wDRVCnzXgcgZupGCkYHlJu7H90A7yV4HtLhAHMSlCPQmZegR5L/qFokw5hBOKlQ==
X-Received: by 2002:a17:90a:38e5:b0:29d:51ce:607d with SMTP id x92-20020a17090a38e500b0029d51ce607dmr2360069pjb.27.1711118778070;
        Fri, 22 Mar 2024 07:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSjp+uaT2DD87oSORZR5+2BC3aOkH3HGNr8n5s8pOXFfO0noAQeF10rj+7LdHcJuM02X8MOA==
X-Received: by 2002:a17:90a:38e5:b0:29d:51ce:607d with SMTP id x92-20020a17090a38e500b0029d51ce607dmr2360049pjb.27.1711118777573;
        Fri, 22 Mar 2024 07:46:17 -0700 (PDT)
Received: from smtpclient.apple ([115.96.118.209])
        by smtp.gmail.com with ESMTPSA id sm17-20020a17090b2e5100b002a027bf39a7sm1970543pjb.43.2024.03.22.07.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2024 07:46:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v5] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1711115162-11629-1-git-send-email-shradhagupta@linux.microsoft.com>
Date: Fri, 22 Mar 2024 20:16:02 +0530
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
Message-Id: <8767986C-0984-45ED-85E9-8F2271A16CCE@redhat.com>
References: <1711115162-11629-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 22 Mar 2024, at 19:16, Shradha Gupta =
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
>=20
> Co-developed-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Tested-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> Changes in v5
> * Included Ani's proposed patch and added him as co-author
> ---
> tools/hv/hv_kvp_daemon.c | 213 +++++++++++++++++++++++++++++++--------
> 1 file changed, 172 insertions(+), 41 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..ae57bf69ad4a 100644
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
> - int error, i =3D 0;
> + int error =3D 0, i =3D 0;
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
> @@ -1233,17 +1323,16 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
> memset(subnet_addr, 0, sizeof(subnet_addr));
> }
>=20
> - return 0;
> + return error;
> }
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
> @@ -1421,52 +1510,94 @@ static int kvp_set_ip_info(char *if_name, =
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
> * Now we populate the keyfile format
> + *
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
> + /*
> + * As dhcp_enabled is only valid for ipv4, we do not set dhcp
> + * methods for ipv6 based on dhcp_enabled flag.
> + *
> + * For ipv4, set method to manual only when dhcp_enabled is
> + * false and specific ipv4 addresses are configured. If neither
> + * dhcp_enabled is true and no ipv4 addresses are configured,
> + * set method to 'disabled'.
> + *
> + * For ipv6, set method to manual when we configure ipv6
> + * addresses. Otherwise set method to 'auto' so that SLAAC from
> + * RA may be used.
> + */
> + if (ip_ver =3D=3D IPV4) {
> + if (new_val->dhcp_enabled) {
> + error =3D kvp_write_file(nmfile, "method", "",
> +       "auto");
> + if (error < 0)
> + goto setval_error;
> + } else if (error) {
> + error =3D kvp_write_file(nmfile, "method", "",
> +       "manual");
> + if (error < 0)
> + goto setval_error;
> + } else {
> + error =3D kvp_write_file(nmfile, "method", "",
> +       "disabled");
> + if (error < 0)
> + goto setval_error;
> + }
> + } else if (ip_ver =3D=3D IPV6) {
> + if (error) {
> + error =3D kvp_write_file(nmfile, "method", "",
> +       "manual");
> + if (error < 0)
> + goto setval_error;
> + } else {
> + error =3D kvp_write_file(nmfile, "method", "",
> +       "auto");
> + if (error < 0)
> + goto setval_error;
> + }
> + }
>=20
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


