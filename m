Return-Path: <linux-hyperv+bounces-710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1756E7E3440
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 04:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D771C203C0
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Nov 2023 03:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166AB23DB;
	Tue,  7 Nov 2023 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpNNiBwt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44779A20
	for <linux-hyperv@vger.kernel.org>; Tue,  7 Nov 2023 03:41:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC546D47
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Nov 2023 19:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699328466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/objqiOqc8rOZeftx45k4hz0QbDrfEnyUw5mk2OXW0=;
	b=KpNNiBwtbRiZEVCIWNM9YZNFatvqlIvOJr6OjwDkPVTA89yslP7arIihcLQaw7kGujgMta
	MImLlxjrjqBmSosqJcZXT4agyoM7v9Gi+Hn/srPkZmmcBF8xTR3+sOEFftXYi+OuyNHI2c
	wt8VYxhQtQV1ydZD/iardPzghgzO5LM=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-4Y43NXyAMYmMVOiEQmT_TQ-1; Mon, 06 Nov 2023 22:40:49 -0500
X-MC-Unique: 4Y43NXyAMYmMVOiEQmT_TQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3b2e7ae47d1so7884491b6e.0
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Nov 2023 19:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699328449; x=1699933249;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/objqiOqc8rOZeftx45k4hz0QbDrfEnyUw5mk2OXW0=;
        b=NCi5q1cbh1vEIZpOmZNc9pk7QZwVk71Pr8fs5K3lgTTk0EhNsxSw7kZJEzC8bIKo3/
         GEQCwzSUwb1P8tZjwj5ckrFzGCPbpNtJergJIv6Ty3/eOgdVQdhP+BKUCbmHP6heRHZy
         U7HxozzGrwMLilWkkHwRD97JtB2r/LswQ1ugt+YD63j4w6od1iDnQnvDS17x+QNwijRL
         /K83TgnYP5fKohDN7jWNoe95YVSpBe11bgsM+E+HYAuulJRJYpfbVEKa0pgi0yaO+fmZ
         meFkc8iKkM9ojE2b8KPuy7ELlEZWt28oRN/HcDFNZXzoCdY+w0xtrYIco/JVUZVa59v4
         4c0Q==
X-Gm-Message-State: AOJu0YzAK/hpbDxHnrcQtf1fewEUNWaXzSjRcay5RaOsaBi8PuaY9q9Q
	GrVGTb3mEcdYgzgvoZYZapRxAHEay0MUNUbdRosNHXk2Ldypd+oM9qq+kcEOunTWHfWyjoLCxB2
	a2JikmMp47haDfZij05y8C742
X-Received: by 2002:a05:6808:14c4:b0:3b5:663c:9b91 with SMTP id f4-20020a05680814c400b003b5663c9b91mr25811110oiw.12.1699328449189;
        Mon, 06 Nov 2023 19:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMGTYxK/HZxGKY3L0S3GbNNZ/EC6n9a4m3WUGhPB5VEAdGD9voUf1lVcBOeJk2sYQMF/7lsg==
X-Received: by 2002:a05:6808:14c4:b0:3b5:663c:9b91 with SMTP id f4-20020a05680814c400b003b5663c9b91mr25811099oiw.12.1699328448914;
        Mon, 06 Nov 2023 19:40:48 -0800 (PST)
Received: from smtpclient.apple ([115.96.144.207])
        by smtp.gmail.com with ESMTPSA id h15-20020aa786cf000000b006c06779e593sm6480721pfo.16.2023.11.06.19.40.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Nov 2023 19:40:48 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
Date: Tue, 7 Nov 2023 09:10:43 +0530
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D793B43-B5DB-4BA2-9F1E-B01D5E2487D2@redhat.com>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On 30-Oct-2023, at 10:45 AM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
>=20
>=20
>> On 23-Oct-2023, at 11:07 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>>=20
>> On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
>>> Some small fixes:
>>> - lets make sure we are not adding ipv4 addresses in ipv6 section in
>>>  keyfile and vice versa.
>>> - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead of
>>>  checking the whole value of addr_family.
>>> - Some trivial fixes in hv_set_ifconfig.sh.
>>>=20
>>> These fixes are proposed after doing some internal testing at Red =
Hat.
>>>=20
>>> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
>>> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
>>> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based =
connection profile")
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>>> tools/hv/hv_set_ifconfig.sh |  4 ++--
>>> 2 files changed, 14 insertions(+), 10 deletions(-)
>>>=20
>>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>>> index 264eeb9c46a9..318e2dad27e0 100644
>>> --- a/tools/hv/hv_kvp_daemon.c
>>> +++ b/tools/hv/hv_kvp_daemon.c
>>> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>> 	if (error)
>>> 		goto setval_error;
>>>=20
>>> -	if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>>> +	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>>> 		error =3D fprintf(nmfile, "\n[ipv6]\n");
>>> 		if (error < 0)
>>> 			goto setval_error;
>>> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>>> 	if (error < 0)
>>> 		goto setval_error;
>>>=20
>>> -	error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>> -	if (error < 0)
>>> -		goto setval_error;
>>> -
>>> -	error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>> -	if (error < 0)
>>> -		goto setval_error;
>>> +	/* we do not want ipv4 addresses in ipv6 section and vice versa =
*/
>>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>>> +		error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>>> +		if (error < 0)
>>> +			goto setval_error;
>>> +	}
>>>=20
>>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>>> +		error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>>> +		if (error < 0)
>>> +			goto setval_error;
>>> +	}
>>> 	fclose(nmfile);
>>> 	fclose(ifcfg_file);
>>>=20
>>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>>> index ae5a7a8249a2..440a91b35823 100755
>>> --- a/tools/hv/hv_set_ifconfig.sh
>>> +++ b/tools/hv/hv_set_ifconfig.sh
>>> @@ -53,7 +53,7 @@
>>> #                       or "manual" if no boot-time protocol should =
be used)
>>> #
>>> # address1=3Dipaddr1/plen
>>> -# address=3Dipaddr2/plen
>>> +# address2=3Dipaddr2/plen
>>> #
>>> # gateway=3Dgateway1;gateway2
>>> #
>>> @@ -61,7 +61,7 @@
>>> #
>>> # [ipv6]
>>> # address1=3Dipaddr1/plen
>>> -# address2=3Dipaddr1/plen
>>> +# address2=3Dipaddr2/plen
>>> #
>>> # gateway=3Dgateway1;gateway2
>>> #
>>> --=20
>>> 2.39.2
>> Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>
>=20
> Ping. Can anyone please queue this?
>>=20

Ping again =E2=80=A6 Please pick this up.

>=20


