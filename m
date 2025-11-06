Return-Path: <linux-hyperv+bounces-7420-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1CC3A369
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4161A47E7F
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F830DECD;
	Thu,  6 Nov 2025 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOa9ZqL8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990D272E41
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Nov 2025 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424041; cv=none; b=TWTQuIYx8UXNj6FmBoByMo/Qu8okebaKa1vE19pZeGOPx4T7jUbHFeAmVfElu5jvF1Cv8ke05teLLunoxtI6ZxSja3IZF4pKMKeQVuPnnK3tYvVlA4de2UvMySIxAJpqoo1nrjN4qVgErmC5/LUvfq632gHcrxZJZi3aIxydb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424041; c=relaxed/simple;
	bh=3g6OwqvUvgOuE0sVQ1tvj2/4v52gpeHEPrmCnel5VNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VRQhV8p/g3rn1daFR5v8/UV5WAQoRHqn+kYmyThwsuoxBdGUoI2r4xNwxLk+bO5bCFVBGJIDcQDvlHx/GNnd+vfo4wg7pS2V2OIAqAif9Y8mihPO+ivDfzMAw76tOVf4IRmfveFs1pMPw15wxSs7uzpMnXTyUV/3NZOLk6y97pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOa9ZqL8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso817706b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Nov 2025 02:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762424038; x=1763028838; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XVferEyN4+RzXvE7eehEmFRfQazqGQ49nTw3vZt6WP4=;
        b=fOa9ZqL89qNKkCAz8jQYoADmdLmc1LtqIlsCaUEVxK9YS6x3ZBOhldjv8rDDuf4yvf
         GhQbPWIX2m8kSLQ7HAZseTB5Tsg8lrSzVTXqPO6aKqiboFeCiC/C58qBa79f2wiRhApB
         Vtn93e1Kp3oVPkrv9lMvvJ764fw6z8Qw+jLMlOTPSSnRkVdLgp702zIwJszfsM8okrrQ
         lb/B90zsPEt2Pavga6L2LHM4EV5/3yu2v9PQl7rKjsEyVbRwFpA1CIa9IMvSZ+E6nbRq
         1ZV8WZ8uXOBdPxRAxkfAI+rxq4KzGAElTBNzHGFzZuX/yRQsZAVr9/XNQy+seOD2PJNM
         qqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424038; x=1763028838;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XVferEyN4+RzXvE7eehEmFRfQazqGQ49nTw3vZt6WP4=;
        b=g/t2sZs4sNcWBwFIVe97P8mSPZpuDJxosc9MYnhMXwJQ4vLhHVTW6EIFGkTZFLW+In
         fHyOTtsSs5/kkxLH0lY7ew8SPVBYk7PVsIFbTihEXjQpCAHNOjpuHAFD1SEU+Bf/2trM
         wYhBAz+jU1BurR0hUy8zXUBN7kGvsfVQQbNA1UYEaasPv136TN3RYnaN1Tg8ZjP4HdX0
         +Vj5RcNld4U93znXjcXqOZttwQJEScNXLssHRYeU632EnHS667DrVY56hKFj7/HGxy0M
         16NgVEDNDh3BVId4K4hv3JnGCroUCXJ6mXEJf59sDo3HRrzNiwSqPlK5YeI4nrOMD/In
         +p0A==
X-Forwarded-Encrypted: i=1; AJvYcCVvQTM6AAAN4STAjr0QDelyHK0QmysTvY6ugIlS38ZAHCMhYDLi1kPCdVAAdGNZDg3z3JmuPhNZ27CE5Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwOCGKFFU189OQmDY4rznr1QZlzSdREtQPSJJcaxu/HsrND8A
	YXZllv9nIyRTUa1vNMHJEmYJcsEXymHHFG5Xjm+dMRv+P2SxJd4YIU74
X-Gm-Gg: ASbGncs+GCO8diwO1ZQiv2TvI0WrXuGh7+OYc0Xf3VIDdHqdNdEoOBztLEJ8YPsFUpz
	0Gy/8I2vw6fS8BhBIN3NjUavS7Y8/VyaYemcQdIlhHGYclSC0w7KwhCo93OcVaYrkh4mBkCkHXx
	FVNz5smUkPq+A4wvj/F89K9MsXv472CaNR30PJi2FbxjakA61u1eSUPyVXcw8jd8fcXotoFP1kg
	rMz/013PFJ8iNvEhgz1Gzy+Bv8/vlt20Sth84lSwGSKvukCgi1cS7mdUqrFlPOW1AzRWt1SFh6K
	8l+R424zCFtAFlxf9EyXTLg9ZpkeNhrMn0np4uyL1VeyO19ixrCBI35NZZKh0fJj8EKh56UJ6pS
	0jxZHLpgWigkaWR0ZnmM+akQH3K/mdufwXTHwLuXZQz86z0x+IgwwSWSo4xQjBJYP8h77dighqY
	yGYtg1lnlvxXk0P4H9WFMBka990nntpAo74u6NlrytrS2IwD5H
X-Google-Smtp-Source: AGHT+IHFm4f4DIfuJZeWFWHECmS607MVUrzEbqxwY7bBNABCSqwm+nfFI94x/cfAN4hYxfUSU4FFIA==
X-Received: by 2002:a05:6a00:2e0d:b0:792:574d:b12 with SMTP id d2e1a72fcca58-7ae1d7350a5mr8116654b3a.10.1762424038444;
        Thu, 06 Nov 2025 02:13:58 -0800 (PST)
Received: from ?IPv6:2401:4900:88f4:f6c4:5041:b658:601d:5d75? ([2401:4900:88f4:f6c4:5041:b658:601d:5d75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af825fbc63sm2270481b3a.49.2025.11.06.02.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 02:13:58 -0800 (PST)
Message-ID: <26b0845236aeeedae68b20765376e6acf3bb0e97.camel@gmail.com>
Subject: Re: [PATCH] net: ethernet: fix uninitialized pointers with free attr
From: ally heev <allyheev@gmail.com>
To: kernel test robot <lkp@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller"	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan"	 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu	 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Dan Carpenter <error27@gmail.com>
Date: Thu, 06 Nov 2025 15:43:49 +0530
In-Reply-To: <202511061627.TYBaNPrX-lkp@intel.com>
References: 
	<20251105-aheev-uninitialized-free-attr-net-ethernet-v1-1-f6ea84bbd750@gmail.com>
	 <202511061627.TYBaNPrX-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 17:06 +0800, kernel test robot wrote:
> Hi Ally,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on c9cfc122f03711a5124b4aafab3211cf4d35a2ac]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/Ally-Heev/net-ethe=
rnet-fix-uninitialized-pointers-with-free-attr/20251105-192022
> base:   c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> patch link:    https://lore.kernel.org/r/20251105-aheev-uninitialized-fre=
e-attr-net-ethernet-v1-1-f6ea84bbd750%40gmail.com
> patch subject: [PATCH] net: ethernet: fix uninitialized pointers with fre=
e attr
> config: x86_64-randconfig-015-20251106 (https://download.01.org/0day-ci/a=
rchive/20251106/202511061627.TYBaNPrX-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251106/202511061627.TYBaNPrX-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202511061627.TYBaNPrX-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from include/uapi/linux/posix_types.h:5,
>                     from include/uapi/linux/types.h:14,
>                     from include/linux/types.h:6,
>                     from include/linux/objtool_types.h:7,
>                     from include/linux/objtool.h:5,
>                     from arch/x86/include/asm/bug.h:7,
>                     from include/linux/bug.h:5,
>                     from include/linux/vfsdebug.h:5,
>                     from include/linux/fs.h:5,
>                     from include/linux/debugfs.h:15,
>                     from drivers/net/ethernet/microsoft/mana/gdma_main.c:=
4:
>    drivers/net/ethernet/microsoft/mana/gdma_main.c: In function 'irq_setu=
p':
> > > include/linux/stddef.h:8:14: error: invalid initializer
>        8 | #define NULL ((void *)0)
>          |              ^
>    drivers/net/ethernet/microsoft/mana/gdma_main.c:1508:55: note: in expa=
nsion of macro 'NULL'
>     1508 |         cpumask_var_t cpus __free(free_cpumask_var) =3D NULL;
>          |                                                       ^~~~
>=20
>=20
> vim +8 include/linux/stddef.h
>=20
> ^1da177e4c3f41 Linus Torvalds   2005-04-16  6 =20
> ^1da177e4c3f41 Linus Torvalds   2005-04-16  7  #undef NULL
> ^1da177e4c3f41 Linus Torvalds   2005-04-16 @8  #define NULL ((void *)0)
> 6e218287432472 Richard Knutsson 2006-09-30  9 =20

Sorry. I think I messed up config somehow during build. Hence, couldn't
catch the error in local. Fixed in v2

