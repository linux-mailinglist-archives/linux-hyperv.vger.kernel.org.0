Return-Path: <linux-hyperv+bounces-833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C817E7910
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 07:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11694B20F10
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85502538C;
	Fri, 10 Nov 2023 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEqiQQIb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6E5259
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 06:16:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFB5B81
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Nov 2023 22:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699596977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XggjIHp4vdoSOrTXOSQXEDRrxSR1328KQ7zU7pww/Uc=;
	b=TEqiQQIbqT0oNLAPMPxqRiCUX3mKO+/sY4xMMXqpcL3qq8Z93LD+oUw7PvXqIpXaPK1oso
	zE7vgndMZFcomwu6wSLeZwxc73amnwTr4mx0VZh7pIzAopac0gTldmI081o/iO2SLxpomQ
	ee4aCRYTo0iwYYqDeROgulH8JNZOxfE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-Sg_4Qu9SNBKFXXPRehR3lQ-1; Thu, 09 Nov 2023 23:02:19 -0500
X-MC-Unique: Sg_4Qu9SNBKFXXPRehR3lQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6c4d0b51c7fso586274b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 09 Nov 2023 20:02:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699588939; x=1700193739;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XggjIHp4vdoSOrTXOSQXEDRrxSR1328KQ7zU7pww/Uc=;
        b=aPtiuBp8tvC6uM1TTzogd0wjJ5wjHJO5vZlup9usO5LJXabic/NqGwDzWq5gtdELmF
         jltgBunf47cs/P2pxQS7HTF+usRR6H+uvieT+GMwlg9G8hBw9s0Pj5/axrThEDSgLFJC
         /jtrKpdJHXqLs0Sw6OOOoIJX62El0zLI7HUwdGkAO90IAKsDWAax9CuOTm460heHdyWv
         MuhtkLbGQ9VBVbbUjKYwuYqNZnH4G81GCpuXJE7mDNq7T4Jeidgxc2DC0GsdM3+YXoxz
         nDW3asLKQ5mWtB2b8yWEjJ6ArO58RmushFDOX0oHjPBeaSBz2owoBhF1yW45kmOpI8GF
         AObg==
X-Gm-Message-State: AOJu0Ywm8ThwTIsrmaFJO5GXRU+vlOnx6ul9rSyL0De/aDV7gpJQyH2G
	evw2flgCbC/L7aYOXL/Ad1cevt6iHAL9x02vQDTgA8wtxDJbwpcoueEpoQYRaiW2o9Nv9Gr9ngv
	klNpkXuNdb32XCEJIkkYJT9n/
X-Received: by 2002:a05:6a21:71c7:b0:181:b044:44a4 with SMTP id ay7-20020a056a2171c700b00181b04444a4mr6547129pzc.56.1699588938840;
        Thu, 09 Nov 2023 20:02:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+9lERQsAFmLd+Z6c2P3EzeChWGcKBVzTv5EsRL3ZyDe51TjlFWi1UE0nFOte7cklYcpUXkQ==
X-Received: by 2002:a05:6a21:71c7:b0:181:b044:44a4 with SMTP id ay7-20020a056a2171c700b00181b04444a4mr6547102pzc.56.1699588938394;
        Thu, 09 Nov 2023 20:02:18 -0800 (PST)
Received: from smtpclient.apple ([116.72.128.216])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aaa8500b0028031e87660sm573907pjq.16.2023.11.09.20.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2023 20:02:18 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
Date: Fri, 10 Nov 2023 09:32:03 +0530
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D09E6F5-9120-40D4-A365-AF04E9AA5587@redhat.com>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
 <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)



> On 07-Nov-2023, at 9:10=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 30-Oct-2023, at 10:45 AM, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 23-Oct-2023, at 11:07 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>>=20
>>> On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
>>>> Some small fixes:
>>>> - lets make sure we are not adding ipv4 addresses in ipv6 section =
in
>>>> keyfile and vice versa.
>>>> - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead =
of
>>>> checking the whole value of addr_family.
>>>> - Some trivial fixes in hv_set_ifconfig.sh.
>>>>=20
>>>> These fixes are proposed after doing some internal testing at Red =
Hat.
>>>>=20
>>>> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
>>>> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
>>>> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based =
connection profile")
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>> tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>>>> tools/hv/hv_set_ifconfig.sh |  4 ++--
>>>> 2 files changed, 14 insertions(+), 10 deletions(-)
>>>>=20
>>>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>>>> index 264eeb9c46a9..318e2dad27e0 100644
>>>> --- a/tools/hv/hv_kvp_daemon.c
>>>> +++ b/tools/hv/hv_kvp_daemon.c
>>>> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>>> if (error)
>>>> goto setval_error;
>>>>=20
>>>> - if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>>>> + if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>>>> error =3D fprintf(nmfile, "\n[ipv6]\n");
>>>> if (error < 0)
>>>> goto setval_error;
>>>> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>>> if (error < 0)
>>>> goto setval_error;
>>>>=20
>>>> - error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>>> - if (error < 0)
>>>> - goto setval_error;
>>>> -
>>>> - error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>>> - if (error < 0)
>>>> - goto setval_error;
>>>> + /* we do not want ipv4 addresses in ipv6 section and vice versa =
*/
>>>> + if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>>>> + error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>>> + if (error < 0)
>>>> + goto setval_error;
>>>> + }
>>>>=20
>>>> + if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>>>> + error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>>> + if (error < 0)
>>>> + goto setval_error;
>>>> + }
>>>> fclose(nmfile);
>>>> fclose(ifcfg_file);
>>>>=20
>>>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>>>> index ae5a7a8249a2..440a91b35823 100755
>>>> --- a/tools/hv/hv_set_ifconfig.sh
>>>> +++ b/tools/hv/hv_set_ifconfig.sh
>>>> @@ -53,7 +53,7 @@
>>>> #                       or "manual" if no boot-time protocol should =
be used)
>>>> #
>>>> # address1=3Dipaddr1/plen
>>>> -# address=3Dipaddr2/plen
>>>> +# address2=3Dipaddr2/plen
>>>> #
>>>> # gateway=3Dgateway1;gateway2
>>>> #
>>>> @@ -61,7 +61,7 @@
>>>> #
>>>> # [ipv6]
>>>> # address1=3Dipaddr1/plen
>>>> -# address2=3Dipaddr1/plen
>>>> +# address2=3Dipaddr2/plen
>>>> #
>>>> # gateway=3Dgateway1;gateway2
>>>> #
>>>> --=20
>>>> 2.39.2
>>> Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>
>>=20
>> Ping. Can anyone please queue this?
>>>=20
>=20
> Ping again =E2=80=A6 Please pick this up.

Ping =E2=80=A6


