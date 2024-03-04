Return-Path: <linux-hyperv+bounces-1660-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325A870122
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 13:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C181C21AE0
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 12:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D8D3B193;
	Mon,  4 Mar 2024 12:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyzIQjI3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BC3C487
	for <linux-hyperv@vger.kernel.org>; Mon,  4 Mar 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554879; cv=none; b=qYt2ZvaQ49Eb+UeaN4+VWIu9fHfjZj5/uc2h4FQcRKdPWzxZn29d/0x8Q9hFsRU3lFxP4TfRgn7Gd7N244QPbgnkrcWqXsx/vxKc6imSZJSyrToxy6suZEeGDGUMUqo5poboAOwwKlQuMzua7lxrKVnbmbW9cEo6qZLWDwn64Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554879; c=relaxed/simple;
	bh=hWHdW5m5ePOJsUUws9lwg2D7HZz/q9aVYpBUEZOWnOQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NMwxeyStB/cO2V8E8vKoJRMzcqkAe7opGubW4hZZbplwYReZ3p1srJLkx0KdY8WhBDb8z03sTFfq32PT9jRsTlUK4xzTHqmzNZQ3J/DjYHcNOls/1hJ7umFNbGjqQxPyfuEWm4Rbm5xhyz+nIvsGW0Ll59eQ87hqSU427BDMyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyzIQjI3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709554876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JPRoL4xIPLzFOJH/TZjpS+iWhVmnOHxtzmR1jUZI8WA=;
	b=SyzIQjI3uiWIXk+9XBCPPKhMuLlYMfdX77IPui1OQg/tH2Pm0giMLIJts6SOlF2casGx3p
	7U8ALX0qkiGAJSan4eB83LnErL59N6FMa4WWEGt1ZYGGtI1637uvt6rzoZ8IevDzFhuCpl
	Eej293Xh0WEEH1zjD4WlEnJK4mpfECU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-4yD0vIjpPBSANUZ3F7Ti0g-1; Mon, 04 Mar 2024 07:21:15 -0500
X-MC-Unique: 4yD0vIjpPBSANUZ3F7Ti0g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-299c12daea5so4358359a91.1
        for <linux-hyperv@vger.kernel.org>; Mon, 04 Mar 2024 04:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709554874; x=1710159674;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPRoL4xIPLzFOJH/TZjpS+iWhVmnOHxtzmR1jUZI8WA=;
        b=rOGXveRpT3tc7t3Iv0RZ7F/VSosNfD9qPMc3BuczT/oznr3tDiSeWt9CHY5O4P+M+K
         CULfLqlgvCxJjZmANQBHvUIIuCYZqY429+f3V+LMVxXT4x+TS6DBsrwVR0DRJXItW82d
         kzcExelYDRGNhgVfuPOrV8x7M6L7ZA4iSAvWR+uVhDRI13zL0hKC/G7oISHRdxO1pVQl
         Ol64W3c0YLZyyjN83NeSHsUKFlEXscmAJbLXi+bQxBVwAbE/NnvlKpwLFim+TaZifaNw
         wVDhSzI1ytrEBS4AKUX4ZzPdH1pIYg0j8ObOeTc9+KdSdSjYColmDlA/eU7tid8+vVdu
         o/lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwOIfJUIWCG1ug/5x2n0KHy14cRSSMp+iRrTTW5bJiB4TW6f27PnBHLDFeoZMjEZkr2tSHNNx3+hF1ldrt1wjvBguLrEZFVhjEv3S9
X-Gm-Message-State: AOJu0YyosaBfRWdro6qK8F26LMM9o5JsG60nJuo/tbjw2vpfmVPaRoeT
	PNKQJxrE/gzC918C8qeVRm/Yi+Q4wXZXLyaivMHwp7krtUuCnmO3i1OMPyKxN6J+RqkPIwO1Us0
	Bdhmi+sJfXWWXojMFCwKK3P3L4KZdYAhrrIjt/s5XXxCSkXJ4fApJB0TqtE4NUQ==
X-Received: by 2002:a17:90a:d594:b0:29a:b654:49b with SMTP id v20-20020a17090ad59400b0029ab654049bmr12791698pju.18.1709554873949;
        Mon, 04 Mar 2024 04:21:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGAy98HJSP/gQbb1UlTm70tpZZ6iH5onEWvTpYCEKZ58ky9WanFN4QvGqW0GmjqtBSgbDIkA==
X-Received: by 2002:a17:90a:d594:b0:29a:b654:49b with SMTP id v20-20020a17090ad59400b0029ab654049bmr12791679pju.18.1709554873492;
        Mon, 04 Mar 2024 04:21:13 -0800 (PST)
Received: from smtpclient.apple ([115.96.159.226])
        by smtp.gmail.com with ESMTPSA id gx15-20020a17090b124f00b00298ca46547fsm7641143pjb.36.2024.03.04.04.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2024 04:21:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
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
Date: Mon, 4 Mar 2024 17:50:57 +0530
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
Message-Id: <57C0D59F-4256-49A8-9864-D45F0E4F4BD7@redhat.com>
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

We will test this patch internally and I will report back but after the =
following suggestions=20

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
> + IPV6,

How about adding IP_TYPE_MAX here? Then see below =E2=80=A6

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

Could we use calloc() here? Then ...

> +
> + if (!output_str)
> + return 1;
> +
> + output_str[0] =3D '\0';

We do not need to do this.

> +
> + if (type =3D=3D DNS)
> + param_name =3D "dns";
> + else
> + param_name =3D "gateway";
> +
> + while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +   (MAX_IP_ADDR_SIZE * 2))) {
> + ip_ver =3D ip_version_check(addr);

Maybe assert here that ip_ver is !=3D -EINVAL.

> +
> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
> + strcat(output_str, addr);
> + strcat(output_str, ",");
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

Ugh, this is ugly! How about,

ip_type =3D IPV4 ;


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

ip_type++ ;


> + } while (ip_sections_count < 2);

while (ip_type < IP_TYPE_MAX)

> +
> fclose(nmfile);
> fclose(ifcfg_file);
>=20
> --=20
> 2.34.1
>=20


