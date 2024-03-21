Return-Path: <linux-hyperv+bounces-1808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB715885B47
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 16:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B4E1F211A5
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078085C48;
	Thu, 21 Mar 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCMnKNNS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DE85958
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2024 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033221; cv=none; b=k7vmelHpmVf/UY56RdZ9t3Xznm6UVTVgSyOnWibE703wTdtWdhsEcdediFMndgANiTf+qRkG7GHbEdjQSS2xHYcEVccVyMxIpqXNyZvDi3hhe+Q3FZOCNiO+dySw5XuIz1lN4Uh1Glne79bXusO4xYzXHz/Ir+BH0bZRp9Slt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033221; c=relaxed/simple;
	bh=WCiVePd3QqKF+DdCIwvV1oNxrx4byfzyt9IeWKvVDXg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=G4GVoJG0us5y8JEesr5yzcfQPq+IpgbHUIVuCd+ZkvYq0P0qMOgizxfBWCAo+dL9Qdwh6D752gQX9SOL/3pDzL1LKwYd2lE1IszJb/MV/HFPrI10dISlVnBtrSw1XyEOZ3SyqO3EXJNDxVjjcmxWxkybnn58EnCaHioyUhdz7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCMnKNNS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711033218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0q/xukp+HK2n2qb38JTdm8WelCgNmtQ3QKlXESyN2k=;
	b=cCMnKNNSIvGlM2nZhWerGJSljuGASww3k7fKUnfwLUnzhpC0ROrwkxxOaOkM3u4/HjbMmn
	gMtT15xp2AhHQE54v/wL/eOdiUZBobQ4LPMAa50YPvJRhcCLaisgU98JkE9sSmzwQ+xs5X
	lPvfV7svbr/N8R0sqe2+me8UNdqQA+I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-9nBfRlg2PyGrJ-pjhXkCnA-1; Thu, 21 Mar 2024 11:00:16 -0400
X-MC-Unique: 9nBfRlg2PyGrJ-pjhXkCnA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e0310bb981so10505155ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 21 Mar 2024 08:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033215; x=1711638015;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0q/xukp+HK2n2qb38JTdm8WelCgNmtQ3QKlXESyN2k=;
        b=FS2fyTpHs3e5dZZUyZS6cMcjVSEmoLVyOKnBAHjUd9gUaWOUV93BElYiI6goDxFqWW
         K+2abCR83bhTMRIRDGtr28ryAmfSkREIKsdFqWulpMR7o9FxjShofU7YzYyuamJ6PxWs
         mXgDlIM6VfeAAIwPEFe0gQmGJElNtCwcXLUCy12swlmjrjpyhIvCM9nNt2FdxT26FA7b
         gIq1UPnZIZmaSnanmYoNyXIVYMpxZq38S7LdxkJF+KpvW7dDjlGs51i6dQP1mkjOP2DF
         sn3Aj4sJDrEO8U8BxVr+y/Ogl6YiLRtaRz/vj6gvet4yA3NkBig+zbmDDArShep/RSsZ
         7CPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO8Oo23DMbWP7jZ4PNTkMBcY1b8Czr1Zy/SRzas9hjK3wzyzUG6LGJjcSB8qWgCcC3uvkLU2hxLHETZ+tr0gHTyFaIsTahRjzsK47u
X-Gm-Message-State: AOJu0YzKC6xIROMlXqX7XbtbGs+pkpaBzeQHoGEyTcBSBVUxxnMUWFN6
	l5IAEGThms6YoDkDr2C2knLDCKiqf7uvmyf+Ku+5AuDn5ENQ+Bj+ypNn62VyXanjd03AUaqXrqh
	90h/94r7aTY46ZZcwQ61R9e7thCBxUAKJAwqcQLrbVXwcRkMNqanOlH2BBtORtw==
X-Received: by 2002:a17:902:f60d:b0:1dd:7485:b4c9 with SMTP id n13-20020a170902f60d00b001dd7485b4c9mr2692611plg.22.1711033215530;
        Thu, 21 Mar 2024 08:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeL5+1Wc4MTbo373X65xgXIF3+TsMqx8+2hDoJJ095AA4SuuWtWqWP4EBNhyuTg+/1wTxiTg==
X-Received: by 2002:a17:902:f60d:b0:1dd:7485:b4c9 with SMTP id n13-20020a170902f60d00b001dd7485b4c9mr2692538plg.22.1711033214763;
        Thu, 21 Mar 2024 08:00:14 -0700 (PDT)
Received: from smtpclient.apple ([115.96.142.122])
        by smtp.gmail.com with ESMTPSA id k8-20020a170902c40800b001defa2df4efsm12724543plk.155.2024.03.21.08.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2024 08:00:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v4] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination for
 keyfile format
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240321131042.GA2731@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Thu, 21 Mar 2024 20:29:58 +0530
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
Message-Id: <94FF7ECA-9D84-4626-BD72-EB0530AE22DC@redhat.com>
References: <1710933451-6312-1-git-send-email-shradhagupta@linux.microsoft.com>
 <9879EB6C-FEC4-42AD-8B40-90457455F0DD@redhat.com>
 <A940B76F-8409-4147-8C09-DB2B3FD2EAF5@redhat.com>
 <0aef5a81-8b8c-6165-d05d-77c9cf639ebd@redhat.com>
 <20240321131042.GA2731@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On 21 Mar 2024, at 18:40, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Thu, Mar 21, 2024 at 05:36:05PM +0530, Ani Sinha wrote:
>>=20
>>=20
>> On Thu, 21 Mar 2024, Ani Sinha wrote:
>>=20
>>>=20
>>>=20
>>>> On 21 Mar 2024, at 09:25, Ani Sinha <anisinha@redhat.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 20 Mar 2024, at 16:47, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>>>>=20
>>>>> If the network configuration strings are passed as a combination =
of IPv4
>>>>> and IPv6 addresses, the current KVP daemon does not handle =
processing for
>>>>> the keyfile configuration format.
>>>>> With these changes, the keyfile config generation logic scans =
through the
>>>>> list twice to generate IPv4 and IPv6 sections for the =
configuration files
>>>>> to handle this support.
>>>>>=20
>>>>> Testcases ran:Rhel 9, Hyper-V VMs
>>>>>            (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
>>>>> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
>>>>> ---
>>>>> Changes in v4
>>>>> * Removed the unnecessary memset for addr in the start
>>>>> * Added a comment to describe how we erase the last comma =
character
>>>>> * Fixed some typos in the commit description
>>>>> * While using strncat, skip copying the '\0' character.
>>>>> ---
>>>>> tools/hv/hv_kvp_daemon.c | 181 =
++++++++++++++++++++++++++++++---------
>>>>> 1 file changed, 140 insertions(+), 41 deletions(-)
>>>>>=20
>>>>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>>>>> index 318e2dad27e0..d64d548a802f 100644
>>>>> --- a/tools/hv/hv_kvp_daemon.c
>>>>> +++ b/tools/hv/hv_kvp_daemon.c
>>>>> @@ -76,6 +76,12 @@ enum {
>>>>> DNS
>>>>> };
>>>>>=20
>>>>> +enum {
>>>>> + IPV4 =3D 1,
>>>>> + IPV6,
>>>>> + IP_TYPE_MAX
>>>>> +};
>>>>> +
>>>>> static int in_hand_shake;
>>>>>=20
>>>>> static char *os_name =3D "";
>>>>> @@ -102,6 +108,11 @@ static struct utsname uts_buf;
>>>>>=20
>>>>> #define MAX_FILE_NAME 100
>>>>> #define ENTRIES_PER_BLOCK 50
>>>>> +/*
>>>>> + * Change this entry if the number of addresses increases in =
future
>>>>> + */
>>>>> +#define MAX_IP_ENTRIES 64
>>>>> +#define OUTSTR_BUF_SIZE ((INET6_ADDRSTRLEN + 1) * MAX_IP_ENTRIES)
>>>>>=20
>>>>> struct kvp_record {
>>>>> char key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
>>>>> @@ -1171,6 +1182,18 @@ static int process_ip_string(FILE *f, char =
*ip_string, int type)
>>>>> return 0;
>>>>> }
>>>>>=20
>>>>> +int ip_version_check(const char *input_addr)
>>>>> +{
>>>>> + struct in6_addr addr;
>>>>> +
>>>>> + if (inet_pton(AF_INET, input_addr, &addr))
>>>>> + return IPV4;
>>>>> + else if (inet_pton(AF_INET6, input_addr, &addr))
>>>>> + return IPV6;
>>>>> +
>>>>> + return -EINVAL;
>>>>> +}
>>>>> +
>>>>> /*
>>>>> * Only IPv4 subnet strings needs to be converted to plen
>>>>> * For IPv6 the subnet is already privided in plen format
>>>>> @@ -1197,14 +1220,75 @@ static int kvp_subnet_to_plen(char =
*subnet_addr_str)
>>>>> return plen;
>>>>> }
>>>>>=20
>>>>> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int =
type,
>>>>> +  int ip_sec)
>>>>> +{
>>>>> + char addr[INET6_ADDRSTRLEN], *output_str;
>>>>> + int ip_offset =3D 0, error =3D 0, ip_ver;
>>>>> + char *param_name;
>>>>> +
>>>>> + if (type =3D=3D DNS)
>>>>> + param_name =3D "dns";
>>>>> + else if (type =3D=3D GATEWAY)
>>>>> + param_name =3D "gateway";
>>>>> + else
>>>>> + return -EINVAL;
>>>>> +
>>>>> + output_str =3D (char *)calloc(OUTSTR_BUF_SIZE, sizeof(char));
>>>>> + if (!output_str)
>>>>> + return -ENOMEM;
>>>>> +
>>>>> + while (1) {
>>>>> + memset(addr, 0, sizeof(addr));
>>>>> +
>>>>> + if (!parse_ip_val_buffer(ip_string, &ip_offset, addr,
>>>>> + (MAX_IP_ADDR_SIZE * 2)))
>>>>> + break;
>>>>> +
>>>>> + ip_ver =3D ip_version_check(addr);
>>>>> + if (ip_ver < 0)
>>>>> + continue;
>>>>> +
>>>>> + if ((ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4) ||
>>>>> +    (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)) {
>>>>> + /*
>>>>> + * do a bound check to avoid out-of bound writes
>>>>> + */
>>>>> + if ((OUTSTR_BUF_SIZE - strlen(output_str)) >
>>>>> +    (strlen(addr) + 1)) {
>>>>> + strncat(output_str, addr,
>>>>> + OUTSTR_BUF_SIZE -
>>>>> + strlen(output_str) - 1);
>>>>> + strncat(output_str, ",",
>>>>> + OUTSTR_BUF_SIZE -
>>>>> + strlen(output_str) - 1);
>>>>> + }
>>>>> + } else {
>>>>> + continue;
>>>>> + }
>>>>> + }
>>>>> +
>>>>> + if (strlen(output_str)) {
>>>>> + /*
>>>>> + * This is to get rid of that extra comma character
>>>>> + * in the end of the string
>>>>> + */
>>>>> + output_str[strlen(output_str) - 1] =3D '\0';
>>>>> + error =3D fprintf(f, "%s=3D%s\n", param_name, output_str);
>>>>> + }
>>>>> +
>>>>> + free(output_str);
>>>>> + return error;
>>>>> +}
>>>>> +
>>>>> static int process_ip_string_nm(FILE *f, char *ip_string, char =
*subnet,
>>>>> - int is_ipv6)
>>>>> + int ip_sec)
>>>>> {
>>>>> char addr[INET6_ADDRSTRLEN];
>>>>> char subnet_addr[INET6_ADDRSTRLEN];
>>>>> int error, i =3D 0;
>>>>> int ip_offset =3D 0, subnet_offset =3D 0;
>>>>> - int plen;
>>>>> + int plen, ip_ver;
>>>>>=20
>>>>> memset(addr, 0, sizeof(addr));
>>>>> memset(subnet_addr, 0, sizeof(subnet_addr));
>>>>> @@ -1216,10 +1300,16 @@ static int process_ip_string_nm(FILE *f, =
char *ip_string, char *subnet,
>>>>>     subnet_addr,
>>>>>     (MAX_IP_ADDR_SIZE *
>>>>> 2))) {
>>>>> - if (!is_ipv6)
>>>>> + ip_ver =3D ip_version_check(addr);
>>>>> + if (ip_ver < 0)
>>>>> + continue;
>>>>> +
>>>>> + if (ip_ver =3D=3D IPV4 && ip_sec =3D=3D IPV4)
>>>>> plen =3D kvp_subnet_to_plen((char *)subnet_addr);
>>>>> - else
>>>>> + else if (ip_ver =3D=3D IPV6 && ip_sec =3D=3D IPV6)
>>>>> plen =3D atoi(subnet_addr);
>>>>> + else
>>>>> + continue;
>>>>>=20
>>>>> if (plen < 0)
>>>>> return plen;
>>>>> @@ -1238,12 +1328,11 @@ static int process_ip_string_nm(FILE *f, =
char *ip_string, char *subnet,
>>>>>=20
>>>>> static int kvp_set_ip_info(char *if_name, struct =
hv_kvp_ipaddr_value *new_val)
>>>>> {
>>>>> - int error =3D 0;
>>>>> + int error =3D 0, ip_ver;
>>>>> char if_filename[PATH_MAX];
>>>>> char nm_filename[PATH_MAX];
>>>>> FILE *ifcfg_file, *nmfile;
>>>>> char cmd[PATH_MAX];
>>>>> - int is_ipv6 =3D 0;
>>>>> char *mac_addr;
>>>>> int str_len;
>>>>>=20
>>>>> @@ -1421,52 +1510,62 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>>>> if (error)
>>>>> goto setval_error;
>>>>>=20
>>>>> - if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>>>>> - error =3D fprintf(nmfile, "\n[ipv6]\n");
>>>>> - if (error < 0)
>>>>> - goto setval_error;
>>>>> - is_ipv6 =3D 1;
>>>>> - } else {
>>>>> - error =3D fprintf(nmfile, "\n[ipv4]\n");
>>>>> - if (error < 0)
>>>>> - goto setval_error;
>>>>> - }
>>>>> -
>>>>> /*
>>>>> - * Now we populate the keyfile format
>>>>> + * The keyfile format expects the IPv6 and IPv4 configuration in
>>>>> + * different sections. Therefore we iterate through the list =
twice,
>>>>> + * once to populate the IPv4 section and the next time for IPv6
>>>>> */
>>>>> + ip_ver =3D IPV4;
>>>>> + do {
>>>>> + if (ip_ver =3D=3D IPV4) {
>>>>> + error =3D fprintf(nmfile, "\n[ipv4]\n");
>>>>> + if (error < 0)
>>>>> + goto setval_error;
>>>>> + } else {
>>>>> + error =3D fprintf(nmfile, "\n[ipv6]\n");
>>>>> + if (error < 0)
>>>>> + goto setval_error;
>>>>> + }
>>>>>=20
>>>>> - if (new_val->dhcp_enabled) {
>>>>> - error =3D kvp_write_file(nmfile, "method", "", "auto");
>>>>> - if (error < 0)
>>>>> - goto setval_error;
>>>>> - } else {
>>>>> - error =3D kvp_write_file(nmfile, "method", "", "manual");
>>>>> + /*
>>>>> + * Now we populate the keyfile format
>>>>> + */
>>>>> +
>>>>> + if (new_val->dhcp_enabled) {
>>>>> + error =3D kvp_write_file(nmfile, "method", "", "auto");
>>>>> + if (error < 0)
>>>>> + goto setval_error;
>>>>> + } else {
>>>>> + error =3D kvp_write_file(nmfile, "method", "", "manual");
>>>>> + if (error < 0)
>>>>> + goto setval_error;
>>>>=20
>>>> There is a problem with this code. dhcp_enabled is only valid for =
ipv4. =46rom looking at ifcfg files that were generated before, I do not =
see IPV6_AUTOCONF related settings.
>>>=20
>>> So dhcp_enabled comes from running hv_get_shcp_info.sh which greps =
for ???dhcp??? in ifcfg files. If it is a hit, it sets dhcp_enabled to =
true.
>>> The ifcfg files will have ???dhcp??? only if it???s set in =
BOOTPROTO=3Ddhcp. So it is indeed ipv4 specific.
>>>=20
>>>> So maybe we should set method only for ipv4 and not for ipv6.
>>=20
>> After some internal testing, it seems we need to set some method for =
both,
>> otherwise, nm is complaining. Therefore, I propose the following =
patch
>>=20
>>> =46rom e1c3f4ece2c4bd191369582d84b8b508db5b5510 Mon Sep 17 00:00:00 =
2001
>> From: Ani Sinha <anisinha@redhat.com>
>> Date: Thu, 21 Mar 2024 10:00:26 +0530
>> Subject: [PATCH] Handle dhcp configuration properly for ipv4 and ipv6
>>=20
>> dhcp_enabled is only valid for ipv4. So do not set dhcp methods for =
ipv6 based
>> on dhcp_enabled flag. For ipv4, set method to manual only when =
dhcp_enabled is
>> false and specific ipv4 addresses are configured. If neither =
dhcp_enabled is
>> true and no ipv4 addresses are configured, set method to 'disabled'.
>>=20
>> For ipv6, set method to manual when we configure ipv6 addresses. =
Otherwise set
>> method to 'auto' so that SLAAC from RA may be used.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> hv_kvp_daemon.c | 57 =
+++++++++++++++++++++++++++++++++++--------------
>> 1 file changed, 41 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/hv_kvp_daemon.c b/hv_kvp_daemon.c
>> index b368d3d..a0e6e4a 100644
>> --- a/hv_kvp_daemon.c
>> +++ b/hv_kvp_daemon.c
>> @@ -1286,7 +1286,7 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>> {
>> char addr[INET6_ADDRSTRLEN];
>> char subnet_addr[INET6_ADDRSTRLEN];
>> - int error, i =3D 0;
>> + int error =3D 0, i =3D 0;
>> int ip_offset =3D 0, subnet_offset =3D 0;
>> int plen, ip_ver;
>>=20
>> @@ -1323,7 +1323,7 @@ static int process_ip_string_nm(FILE *f, char =
*ip_string, char *subnet,
>> memset(subnet_addr, 0, sizeof(subnet_addr));
>> }
>>=20
>> - return 0;
>> + return error;
>> }
>>=20
>> static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value =
*new_val)
>> @@ -1511,6 +1511,8 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> goto setval_error;
>>=20
>> /*
>> +  * Now we populate the keyfile format
>> +  *
>>  * The keyfile format expects the IPv6 and IPv4 configuration in
>>  * different sections. Therefore we iterate through the list twice,
>>  * once to populate the IPv4 section and the next time for IPv6
>> @@ -1527,20 +1529,6 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> goto setval_error;
>> }
>>=20
>> - /*
>> -  * Now we populate the keyfile format
>> -  */
>> -
>> - if (new_val->dhcp_enabled) {
>> - error =3D kvp_write_file(nmfile, "method", "", "auto");
>> - if (error < 0)
>> - goto setval_error;
>> - } else {
>> - error =3D kvp_write_file(nmfile, "method", "", "manual");
>> - if (error < 0)
>> - goto setval_error;
>> - }
>> -
>> /*
>>  * Write the configuration for ipaddress, netmask, gateway and
>>  * name services
>> @@ -1551,6 +1539,43 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> if (error < 0)
>> goto setval_error;
>>=20
>> + if (ip_ver =3D=3D IPV4) {
>> + if (new_val->dhcp_enabled) {
>> + error =3D kvp_write_file(nmfile, "method", "", "auto");
>> + if (error < 0)
>> + goto setval_error;
>> + } else if (error) {
>> + /* if ipv4 addresses were written, set method to 'manual' */
>> + error =3D kvp_write_file(nmfile, "method", "", "manual");
>> + if (error < 0)
>> + goto setval_error;
>> + } else {
>> + /*
>> +  * if no ipv4 addresses were set and dhcp was not enabled,
>> +  * disable ipv4 configuration.
>> +  */
>> + error =3D kvp_write_file(nmfile, "method", "", "disabled");
>> + if (error < 0)
>> + goto setval_error;
>> + }
>> +
>> + } else if (ip_ver =3D=3D IPV6) {
>> + if (error) {
>> + /* if ipv6 addresses were written, set method to 'manual' */
>> + error =3D kvp_write_file(nmfile, "method", "", "manual");
>> + if (error < 0)
>> + goto setval_error;
>> + } else {
>> + /*
>> +  * By default for ipv6, set method to 'auto' so that
>> +  * SLAAC in RA can be used to configure the interface
>> +  */
>> + error =3D kvp_write_file(nmfile, "method", "", "auto");
>> + if (error < 0)
>> + goto setval_error;
>> + }
>> + }
>> +
>> error =3D process_dns_gateway_nm(nmfile,
>>        (char *)new_val->gate_way,
>>        GATEWAY, ip_ver);
>> --=20
> Hi Ani,
> Thanks, the proposed patch looks clean and would fix the problem at =
hand.
> I was wondering if it would make more sense to implement the distro =
specific script
> hv_get_dhcp_info.sh to include dhcp configuration for Ipv6 specific =
configuration
> instead.

The way I see it is that the daemon should provide some =E2=80=9Creasonabl=
e=E2=80=9D configuration for both ipv4 and ipv6. Then the distro =
specific script can override it in any way they see fit if required. =
Leaving out ipv6 would make it incomplete and half baked.

>=20
> I see for IPv6 the older ifcfg format also did not honor dhcp_enable =
flag, but how about
> we add support for it starting with the keyfile format in the script.
>=20
> That way distro vendors could have more control over the logic to get =
dhcp_enable data
> and it would be easier to change
> Thoughts? Hope I am making sense :)
>=20
> Regards,
> Shradha.



