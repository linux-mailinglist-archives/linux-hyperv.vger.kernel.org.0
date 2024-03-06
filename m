Return-Path: <linux-hyperv+bounces-1668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF4587329C
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Mar 2024 10:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A6E9B2137E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Mar 2024 09:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD25D919;
	Wed,  6 Mar 2024 09:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFxACi2z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC975D8FB
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Mar 2024 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709717252; cv=none; b=P+nZeq8ZrazYl+fuupnF31LNqqMb12i4bN2fK5FKF7HisA8P6v9BpHkKlZIiGP8on2sQtFTZaThf7CjQ0ySaB32fRdXaqtKkx5PQMB1w6lnbXxuWKns7oM6p0qoEH5yCoLMosZO7VJLrKXKaNYm2lDVr/jplkLF0H7SBoKGoQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709717252; c=relaxed/simple;
	bh=HvXNosOI8PBmaGV32V3/Wd/i++F5cG42M+SR7Lu+Z+U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=awsBp68/qlnvJ64w42VLRB8ds2zNX7LTN+CfXXNB9gwSfoPkC11RmCAF86oHxqtgxekWlan9Ia286kVb/8gfOzN45waVkAXBCn+yni48IZyGvsfVvWQKKe3XMqy+Ew4RjwWe4SxaYQPJq0xkMkIq6CudPFvRCQ1PnccBjbBLJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFxACi2z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709717250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aS/2iq54TyvTFJNOfej37LI9H38zniQqeQDzeMNsmjI=;
	b=XFxACi2zXVxcdSFg9ASSRxgrS8ve4wdK/AXqDakXyHcZvZQ1zA+rEQ0lYlucPZUobhFkx9
	0bCd+/nIljIvFWp62hm+RUibCRf3X2Yn1gf5GNu41sqmaCcxi4DdCQV4dFMXXlnVBI1yFp
	cmDcTYIj4fQyQcA1bYL5kgYx1xfyRiY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-I3jEMEzxOeuVlEH-XtbN5A-1; Wed, 06 Mar 2024 04:27:28 -0500
X-MC-Unique: I3jEMEzxOeuVlEH-XtbN5A-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dd129acd2aso34834825ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Mar 2024 01:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709717248; x=1710322048;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aS/2iq54TyvTFJNOfej37LI9H38zniQqeQDzeMNsmjI=;
        b=cBOPq2wke0lXB0QwDqqqpfVhRtoNxXvs8vtlgXEEfYOee5foPVL0XF5VBb2KviKah6
         tU6qAEhIzCS18w81swIjEzjvtEXoMyDDltwNWfHPf6ohQ2L8+vaiYiBp6Xu//NgF3SKK
         sb+P1jLpNisj7m3aA2aejeJ1lYb9WL4uBFNKpKIQ8fqV2JSx1T1/A37DOusIX2+tQZJX
         TT3uOaEYkIxx2NdFb3TfzpQaZaYaBAsoi8mZjIBIqvcoKWmh1eFKMns/mw02lwFNynuP
         ieymV+3O713XqaLqXCQviBJvQBGRrnPl5LcNVm4ZnSX8cQhuE6lWk/9zgzdSiIBqsCdH
         UAcg==
X-Forwarded-Encrypted: i=1; AJvYcCUe6cuAmfC/n5o5hpj2smveQLXr/YRSe/HRUqZHpNJ7DXQc6d92LIWu28Ur7udvTc9UNjnfVSujMNpchkKdln9LXRCALKH0vIJFOirC
X-Gm-Message-State: AOJu0Ywbs6dwgz+nKIUTj8eDApH7paWkTA+IZNZTgqOcQGVdEd5PT5XP
	YpeDWOKiJrpoF3nB/1iswWpvcZRqRrC+zkzp0vFkh0LfYHkEIgm+USkebjDzXvdWZaWXlagULZo
	sogINui6DKQiVBzU4PfBCl0UGb/hiJFrE22v8hDQNika9rP95gQDXykpZlIfqbg==
X-Received: by 2002:a17:902:e883:b0:1dc:78bc:ad0a with SMTP id w3-20020a170902e88300b001dc78bcad0amr5594447plg.36.1709717247966;
        Wed, 06 Mar 2024 01:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjLULHrANw7xNSwvW+pqGBlzjXXuCu94BOTxa2Wq7PjapZbbs08OjU+s8864KgO2p5it9NMQ==
X-Received: by 2002:a17:902:e883:b0:1dc:78bc:ad0a with SMTP id w3-20020a170902e88300b001dc78bcad0amr5594431plg.36.1709717247597;
        Wed, 06 Mar 2024 01:27:27 -0800 (PST)
Received: from smtpclient.apple ([115.96.30.47])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902b08600b001dc30f13e6asm12024747plr.137.2024.03.06.01.27.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 01:27:26 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <1709297778-20420-1-git-send-email-shradhagupta@linux.microsoft.com>
Date: Wed, 6 Mar 2024 14:57:12 +0530
Cc: linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Olaf Hering <olaf@aepfle.de>,
 Shradha Gupta <shradhagupta@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4547D425-64EF-4974-A131-56811F25B9E6@redhat.com>
References: <1709297778-20420-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.400.31)



> On 01-Mar-2024, at 18:26, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> If the network configuration strings are passed as a combination of =
IPv and
> IPv6 addresses, the current KVP daemon doesnot handle it for the =
keyfile
> configuration format.
> With these changes, the keyfile config generation logic scans through =
the
> list twice to generate IPv4 and IPv6 sections for the configuration =
files
> to handle this support.
>=20
> Built-on: Rhel9
> Tested-on: Rhel9(IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> ---
> tools/hv/hv_kvp_daemon.c | 152 ++++++++++++++++++++++++++++-----------
> 1 file changed, 112 insertions(+), 40 deletions(-)
>=20
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index 318e2dad27e0..7e84e40b55fb 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -76,6 +76,11 @@ enum {
> DNS
> };
>=20
> +enum {
> + IPV4 =3D 1,
> + IPV6
> +};
> +
> static int in_hand_shake;
>=20
> static char *os_name =3D "";
> @@ -1171,6 +1176,18 @@ static int process_ip_string(FILE *f, char =
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
> + else
> + return -EINVAL;
> +}
> +
> /*
>  * Only IPv4 subnet strings needs to be converted to plen
>  * For IPv6 the subnet is already privided in plen format
> @@ -1197,14 +1214,56 @@ static int kvp_subnet_to_plen(char =
*subnet_addr_str)
> return plen;
> }
>=20
> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> +  int ip_sec)
> +{
> + char addr[INET6_ADDRSTRLEN], *output_str;
> + int ip_offset =3D 0, error, ip_ver;
> + char *param_name;
> +
> + output_str =3D malloc(strlen(ip_string));
> +
> + if (!output_str)
> + return 1;
> +
> + output_str[0] =3D '\0';
> +
> + if (type =3D=3D DNS)
> + param_name =3D "dns";
> + else
> + param_name =3D "gateway";
> +
> + while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +   (MAX_IP_ADDR_SIZE * 2))) {
> + ip_ver =3D ip_version_check(addr);
> +
> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
> + strcat(output_str, addr);
> + strcat(output_str, ",");

We need to check if we are not going out of bounds here. So existing =
length of output_str + length of addr + 1 should be < strlen(ip_string) =
which is the length of the buffer. See parse_ip_val_buffer() how it does =
out of bounds check.

> + } else {
> + continue;
> + }
> + }
> +
> + if (strlen(output_str)) {
> + output_str[strlen(output_str) - 1] =3D '\0';
> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);
> + if (error <  0)
> + return error;
> + }
> +
> + return 0;
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
> @@ -1216,10 +1275,13 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>       subnet_addr,
>       (MAX_IP_ADDR_SIZE *
> 2))) {
> - if (!is_ipv6)
> + ip_ver =3D ip_version_check(addr);
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
> @@ -1242,8 +1304,8 @@ static int kvp_set_ip_info(char *if_name, struct =
hv_kvp_ipaddr_value *new_val)
> char if_filename[PATH_MAX];
> char nm_filename[PATH_MAX];
> FILE *ifcfg_file, *nmfile;
> + int ip_sections_count;
> char cmd[PATH_MAX];
> - int is_ipv6 =3D 0;
> char *mac_addr;
> int str_len;
>=20
> @@ -1421,52 +1483,62 @@ static int kvp_set_ip_info(char *if_name, =
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
> + ip_sections_count =3D 1;
> + do {
> + if (ip_sections_count =3D=3D 1) {
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
> + }
> +
> + /*
> + * Write the configuration for ipaddress, netmask, gateway and
> + * name services
> + */
> + error =3D process_ip_string_nm(nmfile, (char *)new_val->ip_addr,
> +     (char *)new_val->sub_net,
> +     ip_sections_count);
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
> +       GATEWAY, ip_sections_count);
> if (error < 0)
> goto setval_error;
> - }
>=20
> - if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
> - error =3D fprintf(nmfile, "dns=3D%s\n", (char *)new_val->dns_addr);
> + error =3D process_dns_gateway_nm(nmfile,
> +       (char *)new_val->dns_addr, DNS,
> +       ip_sections_count);
> if (error < 0)
> goto setval_error;
> - }
> +
> + ip_sections_count++;
> + } while (ip_sections_count <=3D 2);
> +
> fclose(nmfile);
> fclose(ifcfg_file);
>=20
> --=20
> 2.34.1
>=20


