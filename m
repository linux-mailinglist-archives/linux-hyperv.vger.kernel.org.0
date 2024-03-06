Return-Path: <linux-hyperv+bounces-1666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 725A18730B1
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Mar 2024 09:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1DE1F21232
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Mar 2024 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6B25D753;
	Wed,  6 Mar 2024 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs81fquF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F685C8F9
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Mar 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713802; cv=none; b=I0aLSeEchhYiWUF4QsD7Pb+c9jVMcnBQkm48Ga2j6tvO3PuxzebBqXxB2mPJtDyyDEz7+B7676Oa5yFeYAwn8lPr0eCf1UDL1pSqxfzJ+FpsYz7nZwDsUL+XkvkKr+AbQClqFGoKNHFsEJ5m04zw8uyk3ElaCFbDPFd6JozxRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713802; c=relaxed/simple;
	bh=DOd0e1qjzkpyS4tW500IeyPTqixPd5HrKxj3s3+PnVo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bd4IJ6A/TXdx5UxPOOi+jm1EYRLDG+hn4yE+ukrmRJ0Ql9t+kKFT8c3UfwF7KEWN49WjrmJpPrIwmrhuQWbM4ibnvpEyRRFgwBlX6vUmsO3AMyjPOQE4l229K4e5ASIQA0neuxwfMUeenFPJbh7t0x28MevXzyyYBmR0KvCTT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs81fquF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709713799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cvBKIBBn0ajnJwbxQfkWgazzuuPofMjnZR/FlSgY4/c=;
	b=Vs81fquFhG20sUpAPgd3fAyb9RE+TBPrkQerIjQlRsjHjKWB2b2blM1hhlJ1+UIGt00gnd
	0xfUnQIwCJt0W9jZfaBfAIb12cuMK9UXtuTQ5ducUHEG749uhuba+PaeKqhESB9938wPT6
	olZVn15hOYNBzJvwPcsXOHFvm3BOiuE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-f2zQLv7LMgSjwe8Wdkuhng-1; Wed, 06 Mar 2024 03:29:58 -0500
X-MC-Unique: f2zQLv7LMgSjwe8Wdkuhng-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1dcf7b4daf8so9690485ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 06 Mar 2024 00:29:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713492; x=1710318292;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvBKIBBn0ajnJwbxQfkWgazzuuPofMjnZR/FlSgY4/c=;
        b=otTRS9vfQndnakzJtRTTx2syaHWaNlNDDy/EqGGa61bds79z3AnKcAfekUev4G7Srv
         3yjKifNzfboFMbcsQzR/jBTR/qdtBoh1qfErGrGvm8tNVN6jEqvzoi0r5nYIB4IK0KD0
         tBlXpmZr9BvBeu+d6WQqbbTXigEnR/zxBcDwDqCics0hw6p73kM3nJoYeUqpyL4YNJrd
         GldCeSjrNxQXBejGoWTPXeM1/mSq6dVh3tJxJA3mdOZnS0EhtQdqgdxkdBBp/JgWrMuy
         zGDofSJx7wm53wo9dBO7oUFe1Pbgq/xtnwfS4fY/gW43TTGqWx9/9D8biCob7KRXwI3S
         MG3w==
X-Forwarded-Encrypted: i=1; AJvYcCX0PACb5kGnOfJM8XCqa4tLY1Y4iYP2pyAthPAiCI2VW+IGDGMTGPu1PHWcSRTssxO+R5P4ib0bXbJI0elg3UaMLBnAXsU5MqQwPprN
X-Gm-Message-State: AOJu0YwmRl0iVbuZgFskchoKpZPLvUs93nt59XJvUIRM8fQP/lKymNmH
	vLjleseCnhqB0TEhkeY09O4KzTzJEIK22TZSgceuISwhw0H6AaX8CDQhkgZp3YeL8CB9913hfz6
	Jd4p0/38BKpIoyov0LbSpquhU3t7ROs1izT+4KajYvKpa31KvgundyIghXq4FMg==
X-Received: by 2002:a17:902:eb82:b0:1dc:f0d7:d8d7 with SMTP id q2-20020a170902eb8200b001dcf0d7d8d7mr5495616plg.41.1709713492530;
        Wed, 06 Mar 2024 00:24:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIG4JUnFIAwPpLMYuiF/5sLVoJQXWOC0Z7C1a/2buy1bIQVOkgiNpxkDp+VYEoC1+R9xNcaw==
X-Received: by 2002:a17:902:eb82:b0:1dc:f0d7:d8d7 with SMTP id q2-20020a170902eb8200b001dcf0d7d8d7mr5495595plg.41.1709713492147;
        Wed, 06 Mar 2024 00:24:52 -0800 (PST)
Received: from smtpclient.apple ([115.96.30.47])
        by smtp.gmail.com with ESMTPSA id mq12-20020a170902fd4c00b001dc8f1e06eesm11932415plb.291.2024.03.06.00.24.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2024 00:24:51 -0800 (PST)
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
Date: Wed, 6 Mar 2024 13:54:36 +0530
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
Message-Id: <AE3A11C5-5EAA-4929-8FE2-BB1B2BDE57CE@redhat.com>
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

We tried to test this but seems some memory corruption is happening.
Some more feedbacks follows ...

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

Shouldn=E2=80=99t you be returning -ENOMEM or some such here?

> +
> + output_str[0] =3D '\0';
> +
> + if (type =3D=3D DNS)
> + param_name =3D "dns";
> + else

Please be more explicit here and check for type =3D=3D GATEWAY

> + param_name =3D "gateway";

Else, if neither, it should return error.

> +
> + while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> +   (MAX_IP_ADDR_SIZE * 2))) {
> + ip_ver =3D ip_version_check(addr);
> +
> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
> + strcat(output_str, addr);
> + strcat(output_str, ",");

I prefer strncat() here.

> + } else {
> + continue;
> + }
> + }
> +
> + if (strlen(output_str)) {
> + output_str[strlen(output_str) - 1] =3D '\0';
> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);

Please do not forget to free output_str.

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

But you return +ve from this function so this will never be true.

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


