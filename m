Return-Path: <linux-hyperv+bounces-1813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EBA88604E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 19:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0618287222
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7221332A6;
	Thu, 21 Mar 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qkMJ/tdE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A1B13342F;
	Thu, 21 Mar 2024 18:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044433; cv=none; b=uV9Kw71CVzPh8RaaTelLj0RMxa7ie4WSTSye2/1uYNsZcw7aEjMhRK1rPTWb9yJRHG287vTnvbUGfggbhEf6B9fv9KRaGqlT6Sac7KGQL6tG1Jv8dT45Hn262D8VpQTqSWD1vI9+OXHS/ExsaHFJmjeGJx+wvukZ9NCc3rd7AKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044433; c=relaxed/simple;
	bh=05ZEYDmt2+qqCLfDyEKQhHqR7TKdqX5zogWxaN4oz3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YljOykEH5jIqlUg2yza4/aGaOBcKpKevceKk9u0rBcVfg6+4k9s6GM6zh7QCWIUL4NXDsrTbJatVeA3amybi6QKt0UZ05TJtPskaP0cbd51eKTA4ifdKx/8knMkuJ5TNjCpK//R9b/JjpGOWd7MpoEr6qS5UKWgXP7CFdWnlPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qkMJ/tdE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0ACEA20B74C0; Thu, 21 Mar 2024 11:07:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0ACEA20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711044426;
	bh=3TunyeQrBBOJTdW13HcN0B0MpmXt0vTpUXifX+gGy4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkMJ/tdEq8BHkpDVPjwShASHaPP8LviJ26jsmrkSScJXHVFrcNPbw3eUPe+s/D2pF
	 0XQ/NoJSs+t/bFtRbSK0MRz69VnlypivU2mMggm692qMqusppHUTg4bQ/KoGLy0dvz
	 zG7rH5low6mZOVO7M3CNBN9+kNXA1VllhHfycMBc=
Date: Thu, 21 Mar 2024 11:07:06 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Long Li <longli@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: Re: [PATCH v2 5/7] tools: hv: Add new fcopy application based on uio
 driver
Message-ID: <20240321180705.GA12387@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
 <1710930584-31180-6-git-send-email-ssengar@linux.microsoft.com>
 <SJ1PR21MB3457E5B4D852A914CD691E53CE322@SJ1PR21MB3457.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR21MB3457E5B4D852A914CD691E53CE322@SJ1PR21MB3457.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 21, 2024 at 04:42:44PM +0000, Long Li wrote:
> > Subject: [PATCH v2 5/7] tools: hv: Add new fcopy application based on uio driver
> > 
> > New fcopy application using uio_hv_generic driver. This application copies file
> > from Hyper-V host to guest VM.
> > 
> > A big part of this code is copied from tools/hv/hv_fcopy_daemon.c which this new
> > application is replacing.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> > [V2]
> > - Improve commit message.
> > - Change (4 * 4096) to 0x4000 for ring buffer size
> > - Removed some unnecessary type casting.
> > - Mentioned in file copy right header that this code is copied.
> > - Changed the print from "Registration failed" to "Signal to host failed".
> > - Fixed mask for rx buffer interrupt to 0 before waiting for interrupt.
> > 
> >  tools/hv/Build                 |   3 +-
> >  tools/hv/Makefile              |  10 +-
> >  tools/hv/hv_fcopy_uio_daemon.c | 490
> > +++++++++++++++++++++++++++++++++
> >  3 files changed, 497 insertions(+), 6 deletions(-)  create mode 100644
> > tools/hv/hv_fcopy_uio_daemon.c
> > 
> > diff --git a/tools/hv/Build b/tools/hv/Build index 6cf51fa4b306..7d1f1698069b
> > 100644
> > --- a/tools/hv/Build
> > +++ b/tools/hv/Build
> > @@ -1,3 +1,4 @@
> >  hv_kvp_daemon-y += hv_kvp_daemon.o
> >  hv_vss_daemon-y += hv_vss_daemon.o
> > -hv_fcopy_daemon-y += hv_fcopy_daemon.o
> > +hv_fcopy_uio_daemon-y += hv_fcopy_uio_daemon.o hv_fcopy_uio_daemon-y
> > +=
> > +vmbus_bufring.o
> > diff --git a/tools/hv/Makefile b/tools/hv/Makefile index
> > fe770e679ae8..944180cf916e 100644
> > --- a/tools/hv/Makefile
> > +++ b/tools/hv/Makefile
> 
> I'm not sure if vmbus_bufring will compile on ARM.
> If it's not supported, can use some flags in Makefile to not build this.

You are right, this is not supported on ARM64. I can query uname in Makefile
and compile this only for arch != aarch64.
I will add this info in commit message as well.

- Saurabh


