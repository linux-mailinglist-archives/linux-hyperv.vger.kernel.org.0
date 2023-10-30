Return-Path: <linux-hyperv+bounces-645-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D977DB2A4
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 06:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9634AB20C74
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 05:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591F10FE;
	Mon, 30 Oct 2023 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqxZrV6q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075910F4
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Oct 2023 05:15:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481AC9
	for <linux-hyperv@vger.kernel.org>; Sun, 29 Oct 2023 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698642921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOIaKAX0ABCkjpkL5qEVgTbYedUADxo3ZoTcc0fB/Ks=;
	b=FqxZrV6qEYG8P4v8/msRD+qmZyKfqWstSxA3p8XkM+gm6fyxOG5FXk/UF/wXIP8K4GHx1S
	hlAz7fIMQ5g5HulYqjfokKaMMLSA7zXfWm7Yk6l/25KQy6iQlUc5+phacypY51gZSer6KX
	ct5XavAs9grj8BxUsrXSprex82Ase+4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-pqjtGtjiNVOjOtSQzQ6p_A-1; Mon, 30 Oct 2023 01:15:09 -0400
X-MC-Unique: pqjtGtjiNVOjOtSQzQ6p_A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc274dbbc6so25633215ad.2
        for <linux-hyperv@vger.kernel.org>; Sun, 29 Oct 2023 22:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698642908; x=1699247708;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IOIaKAX0ABCkjpkL5qEVgTbYedUADxo3ZoTcc0fB/Ks=;
        b=uHKviZdclHJvd9HAuxo0keJ1WsgplRi/3QlHGgofqYoyinMKSt2Lhp54xTyEzfs/Eh
         x9f9d/t4ZTBIgQfbkgz6cJjKXs4kqGekMz0ZZ2Xw/IkCFQ/PSKKnFkayCtrSguFlZFiU
         gYin6ZobfHrYnXVhL5OWSAqrC2T/4xUKmeyP8ICL3fPqwXb4sEhkvBE2SBr1WMdQRZeL
         8kEuEqjFzDP+ecInArdOTy2R/Ffg+KTsz0H7hvSV81Mi3y94aJ/JKKqPdb/zMKk0esTS
         bmBd3oJjHoZkRqHTKFq02W+mTYKMwwWAJrRj3AGCho5EoQnc+1kqON+Sq9AEiQmW9VO8
         Vwxw==
X-Gm-Message-State: AOJu0YyTJe1d7HFBksS6VvGbb5JLqZfxODKQ0cngEhAT1RMhqgkZQFCo
	IZaLP96PUeXVeAdQY68dhPXI2euoRjBBp43WS3ftZ0tmVFgW6Eakyhs4jjtMGNQTl9t4232AMf1
	bNRk41iAE+nFdnACZFjayLJJG
X-Received: by 2002:a17:902:e811:b0:1cc:569b:1df4 with SMTP id u17-20020a170902e81100b001cc569b1df4mr321031plg.1.1698642908659;
        Sun, 29 Oct 2023 22:15:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzlqUdIn5g7MGLHCMDIJpdHbeIdLsSCJM9vptMH/SAhrXE6OBafwlNSLQzjFajuDnuR2DpWw==
X-Received: by 2002:a17:902:e811:b0:1cc:569b:1df4 with SMTP id u17-20020a170902e81100b001cc569b1df4mr321010plg.1.1698642908347;
        Sun, 29 Oct 2023 22:15:08 -0700 (PDT)
Received: from smtpclient.apple ([203.212.245.41])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001cc55bcd0c1sm313612plg.177.2023.10.29.22.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Oct 2023 22:15:07 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH] hv/hv_kvp_daemon: Some small fixes for handling NM
 keyfiles
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Date: Mon, 30 Oct 2023 10:45:03 +0530
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E44432C5-17B2-47FC-B382-384659B21DCF@redhat.com>
References: <20231016133122.2419537-1-anisinha@redhat.com>
 <20231023053746.GA11148@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)



> On 23-Oct-2023, at 11:07 AM, Shradha Gupta =
<shradhagupta@linux.microsoft.com> wrote:
>=20
> On Mon, Oct 16, 2023 at 07:01:22PM +0530, Ani Sinha wrote:
>> Some small fixes:
>> - lets make sure we are not adding ipv4 addresses in ipv6 section in
>>   keyfile and vice versa.
>> - ADDR_FAMILY_IPV6 is a bit in addr_family. Test that bit instead of
>>   checking the whole value of addr_family.
>> - Some trivial fixes in hv_set_ifconfig.sh.
>>=20
>> These fixes are proposed after doing some internal testing at Red =
Hat.
>>=20
>> CC: Shradha Gupta <shradhagupta@linux.microsoft.com>
>> CC: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Fixes: 42999c904612 ("hv/hv_kvp_daemon:Support for keyfile based =
connection profile")
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> tools/hv/hv_kvp_daemon.c    | 20 ++++++++++++--------
>> tools/hv/hv_set_ifconfig.sh |  4 ++--
>> 2 files changed, 14 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
>> index 264eeb9c46a9..318e2dad27e0 100644
>> --- a/tools/hv/hv_kvp_daemon.c
>> +++ b/tools/hv/hv_kvp_daemon.c
>> @@ -1421,7 +1421,7 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	if (error)
>> 		goto setval_error;
>>=20
>> -	if (new_val->addr_family =3D=3D ADDR_FAMILY_IPV6) {
>> +	if (new_val->addr_family & ADDR_FAMILY_IPV6) {
>> 		error =3D fprintf(nmfile, "\n[ipv6]\n");
>> 		if (error < 0)
>> 			goto setval_error;
>> @@ -1455,14 +1455,18 @@ static int kvp_set_ip_info(char *if_name, =
struct hv_kvp_ipaddr_value *new_val)
>> 	if (error < 0)
>> 		goto setval_error;
>>=20
>> -	error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>> -	if (error < 0)
>> -		goto setval_error;
>> -
>> -	error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>> -	if (error < 0)
>> -		goto setval_error;
>> +	/* we do not want ipv4 addresses in ipv6 section and vice versa =
*/
>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->gate_way)) {
>> +		error =3D fprintf(nmfile, "gateway=3D%s\n", (char =
*)new_val->gate_way);
>> +		if (error < 0)
>> +			goto setval_error;
>> +	}
>>=20
>> +	if (is_ipv6 !=3D is_ipv4((char *)new_val->dns_addr)) {
>> +		error =3D fprintf(nmfile, "dns=3D%s\n", (char =
*)new_val->dns_addr);
>> +		if (error < 0)
>> +			goto setval_error;
>> +	}
>> 	fclose(nmfile);
>> 	fclose(ifcfg_file);
>>=20
>> diff --git a/tools/hv/hv_set_ifconfig.sh =
b/tools/hv/hv_set_ifconfig.sh
>> index ae5a7a8249a2..440a91b35823 100755
>> --- a/tools/hv/hv_set_ifconfig.sh
>> +++ b/tools/hv/hv_set_ifconfig.sh
>> @@ -53,7 +53,7 @@
>> #                       or "manual" if no boot-time protocol should =
be used)
>> #
>> # address1=3Dipaddr1/plen
>> -# address=3Dipaddr2/plen
>> +# address2=3Dipaddr2/plen
>> #
>> # gateway=3Dgateway1;gateway2
>> #
>> @@ -61,7 +61,7 @@
>> #
>> # [ipv6]
>> # address1=3Dipaddr1/plen
>> -# address2=3Dipaddr1/plen
>> +# address2=3Dipaddr2/plen
>> #
>> # gateway=3Dgateway1;gateway2
>> #
>> --=20
>> 2.39.2
> Reviewed-by: Shradha Gupta <Shradhagupta@linux.microsoft.com>

Ping. Can anyone please queue this?
>=20


