Return-Path: <linux-hyperv+bounces-1410-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBBA829EE0
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 18:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9BB2280F
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 17:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78374CDFF;
	Wed, 10 Jan 2024 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dXA46L47"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0C94C3B9;
	Wed, 10 Jan 2024 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704906508; x=1705511308; i=markus.elfring@web.de;
	bh=Bz9Db2FUAkVqUkNWQ/yzViSvqlonoWs5vAEKdEJFosw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dXA46L476Qubr3V28E5jL0y0a23JIp7SQ3wu27euvbg6brlBy2CVjMNBhe2W5z+t
	 R7qQQnwtdNC+UeElZsxnyTFYcT5FDWewIlDd0pYQA5YWmpIBH9XIcKmamu3Z67b1x
	 cSefahiBfQn7OUlP2fxWy+hk1YW1toLIhXYG5Noqij9X0TDWJpg/Rb9I6C3KBDPq9
	 wlJmUrbPhZyPzC1MVneDaTrmQ8Y+3+1Caa5mBS1QUyBvg2apUTHTyi/MlwKNZzBIp
	 1PhaZ7oqxco2MCv/+Mf/gbkf46T7FWoiCrew4c5Mdz+ouP1Xr9elkmP4O6ttkJJnj
	 40LsCVuqwLCBN2xGTQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MuVGC-1r5Fy21P9u-00rgZo; Wed, 10
 Jan 2024 18:08:28 +0100
Message-ID: <1910913d-c3fe-45ab-a871-deda5318e2cf@web.de>
Date: Wed, 10 Jan 2024 18:08:17 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
To: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emKcMjXpJGXLjI1ChMRKyZgY9s+8+hI1Nvf2l2K6ItaH0tdCg0F
 gfgoOrCWA9s5cTuaPJuYnplHU7eHct06NwNCbQMpYaQ1YAU9gw0a2knKGg1zgUl7+x/qZ9F
 7ukQDNDwYcntZX5kg2uj8lEmJRGFm4jNUbzdLQ8UnEsu1V5QC4LLA0BDXK/FZMxjyTdIkpp
 +dTMGPQEPJwOOzQQiJ2dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2x/ntfbrdNw=;+ZwzS1arjIKAorVjx3qIfv7jem7
 rTtEEMGp2Euk71hadmLZbIixqIn4LEMHu0UqAgPbe/q7k+h6KTTkc0UTns7PlpihYme4+6YR8
 +7ntDyLWxgjkDkHBCRmF/Np0xMO0eaH4KKkzafEZNDIyVyALb8oqUYkXRXWG4ri1gzYtUNDCO
 fE5rdEtb3a3/7l7lsLeKussW/8BuZ9EiHSpmbnnZEwQEsLmOCNaAQ5pr75v92xmTWvANk5wvv
 19KpQhtPup3YhkvJ8pS9uC4GhqKcollq+ppyeY9ingTd6OL4l459RmG3AdfP6o81o2pZ0LWv5
 qKHZSyiDVUHrGnqEKajxAS4TlLCSx3LScC1mvGWJmoKp4IGpgQH+Uoul163CpPueqy0lSQJs1
 INTnsbmRi7JfJkda+2TNMbADTxTGweF7nDffbzksFNFomqxJaNb4baR8fJPgDMkI2902Gfdyd
 b9CxOg5+ZnHIC68CbHoA34oEWvPksm9H44BF6IfFdH35/hh0UeZqU24sy2Q4gMxS4wQkEzAmX
 PWCEDY64U5Eatlv/JQJB/ZhuP2VHuGzYu8GXn7AMV4XqEffkZVoDyPsATY7QYUxBTBfqdlnaK
 XpPqZWYLvrnusjLyucaTj8MgRZK6llsY0ayPivMgTYtsZKGweNWZ47OPpJyurqH3B2pBhw2Iv
 JwOxOLy4NKmyUdnGKE5coWB80nt747zct7D+dXNhCGD9fldlgwpTX6yTCOow+MZl/J1Q9BCb0
 tsrPIcTEaUE3tqTUeT/9xtoloi7h/WkWwEyYwm5+Z3B5EeWVddB+wD8in7L82+WL3dNiMHbj8
 JC3FQo2JqFgMyPcFLcpjW5CuNvG7UOxnCdKTpJo3qzU4wyEkIowh4IbWNcrBIsj4lb2SZk7N9
 JJJYu7tVad8R9xvJSllvc95+kAf2ZFr3HCSCSzrjJpPrL99VrQHu9UeYXqDqlJ/NbHwpqLGeE
 KPWyQRbk2ZNBzz3U+ylEnvyCcZU=

> It occurred to me overnight that the existing error handling
> in create_gpadl_header() is unnecessarily complicated.  Here's
> an approach that I think would fix what you have flagged, and
> would reduce complexity instead of increasing it.  Thoughts?

I find this development view interesting.


> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 56f7e06c673e..44b1d5c8dfed 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -336,7 +336,7 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
>  		msgheader =3D  kzalloc(msgsize, GFP_KERNEL);
>  		if (!msgheader)
> -			goto nomem;
> +			return -ENOMEM;
>
>  		INIT_LIST_HEAD(&msgheader->submsglist);
>  		msgheader->msgsize =3D msgsize;
> @@ -386,8 +386,8 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  					list_del(&pos->msglistentry);
>  					kfree(pos);
>  				}
> -
> -				goto nomem;
> +				kfree(msgheader);
> +				return -ENOMEM;
>  			}
>
>  			msgbody->msgsize =3D msgsize;
> @@ -416,8 +416,8 @@ static int create_gpadl_header(enum hv_gpadl_type ty=
pe, void *kbuffer,
>  			  sizeof(struct vmbus_channel_gpadl_header) +
>  			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
>  		msgheader =3D kzalloc(msgsize, GFP_KERNEL);
> -		if (msgheader =3D=3D NULL)
> -			goto nomem;
> +		if (!msgheader)
> +			return -ENOMEM;
>
>  		INIT_LIST_HEAD(&msgheader->submsglist);
>  		msgheader->msgsize =3D msgsize;
> @@ -437,10 +437,6 @@ static int create_gpadl_header(enum hv_gpadl_type t=
ype, void *kbuffer,
>  	}
>
>  	return 0;
> -nomem:
> -	kfree(msgheader);
> -	kfree(msgbody);
> -	return -ENOMEM;
>  }
>
>  /*
>

Should up to two memory areas still be released after a data processing fa=
ilure?

Regards,
Markus

