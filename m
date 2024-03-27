Return-Path: <linux-hyperv+bounces-1837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076F288D519
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 04:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A5A1C23A67
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 Mar 2024 03:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AD1225D6;
	Wed, 27 Mar 2024 03:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KH+PR2NJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024F23763;
	Wed, 27 Mar 2024 03:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711510839; cv=none; b=SYoyMloI0rnB1J9Lum4wAKiKCHm9S42ntqiPenID/RlYEnA9+JOQopZxHeCwtEkvHrB1QzgHHZiRTBoms4Ng9p0TSxqKAv10aqvt8sNS2CyvbD5sA0UZjan75857WepcYy3Jr85iw7h87jM5CZPu+QiOmOC3YaUc8PTdqETyE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711510839; c=relaxed/simple;
	bh=Qy9jNwoADlloXLB/O/YDSRWz34f2X4WLlvwpB0CLSKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psiGWiuv74xW2BcisIbYtPkwLI+L8H4DbjlO8pjl+N4SIFNMbXF72mez0VOmkPkRtYsqpHZb7lSIjslPu53VrBBFMkBYFYoSjpZsiXirq2rsBDyiz7ujpCXbWcKtMOaF/rk5qmlaW9fz8e3atlfO/bIVsu/esQ6GmnYOGg94et8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KH+PR2NJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 820E7208444F; Tue, 26 Mar 2024 20:40:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 820E7208444F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711510837;
	bh=4WwOkF9QcocRskGPQZaISh5gvanICY1Ewo+yRt6ITI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KH+PR2NJT9MAI9WHMxn7DG+mfgYB4OiJWsDUCRNM/0e1hq7N/Q9iYajobG1DJH04m
	 x7zHhawGfqygZbnDkrYZB8OAnz63zhnSRkeodlvJ/Nf/CWNlcTUMUlBBqseJanUmJw
	 hyOo4nLVdBVKIkPnXe9B+FgpZZqYFFFlCLUsw7NM=
Date: Tue, 26 Mar 2024 20:40:37 -0700
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
Message-ID: <20240327034037.GA22340@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710930584-31180-1-git-send-email-ssengar@linux.microsoft.com>
 <1710930584-31180-6-git-send-email-ssengar@linux.microsoft.com>
 <SJ1PR21MB3457E5B4D852A914CD691E53CE322@SJ1PR21MB3457.namprd21.prod.outlook.com>
 <20240321180705.GA12387@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321180705.GA12387@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Mar 21, 2024 at 11:07:06AM -0700, Saurabh Singh Sengar wrote:
> On Thu, Mar 21, 2024 at 04:42:44PM +0000, Long Li wrote:
> > > Subject: [PATCH v2 5/7] tools: hv: Add new fcopy application based on uio driver
> > > 
> > > New fcopy application using uio_hv_generic driver. This application copies file
> > > from Hyper-V host to guest VM.
> > > 
> > > A big part of this code is copied from tools/hv/hv_fcopy_daemon.c which this new
> > > application is replacing.
> > > 
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > ---
> > > [V2]
> > > - Improve commit message.
> > > - Change (4 * 4096) to 0x4000 for ring buffer size
> > > - Removed some unnecessary type casting.
> > > - Mentioned in file copy right header that this code is copied.
> > > - Changed the print from "Registration failed" to "Signal to host failed".
> > > - Fixed mask for rx buffer interrupt to 0 before waiting for interrupt.
> > > 
> > >  tools/hv/Build                 |   3 +-
> > >  tools/hv/Makefile              |  10 +-
> > >  tools/hv/hv_fcopy_uio_daemon.c | 490
> > > +++++++++++++++++++++++++++++++++
> > >  3 files changed, 497 insertions(+), 6 deletions(-)  create mode 100644
> > > tools/hv/hv_fcopy_uio_daemon.c
> > > 
> > > diff --git a/tools/hv/Build b/tools/hv/Build index 6cf51fa4b306..7d1f1698069b
> > > 100644
> > > --- a/tools/hv/Build
> > > +++ b/tools/hv/Build
> > > @@ -1,3 +1,4 @@
> > >  hv_kvp_daemon-y += hv_kvp_daemon.o
> > >  hv_vss_daemon-y += hv_vss_daemon.o
> > > -hv_fcopy_daemon-y += hv_fcopy_daemon.o
> > > +hv_fcopy_uio_daemon-y += hv_fcopy_uio_daemon.o hv_fcopy_uio_daemon-y
> > > +=
> > > +vmbus_bufring.o
> > > diff --git a/tools/hv/Makefile b/tools/hv/Makefile index
> > > fe770e679ae8..944180cf916e 100644
> > > --- a/tools/hv/Makefile
> > > +++ b/tools/hv/Makefile
> > 
> > I'm not sure if vmbus_bufring will compile on ARM.
> > If it's not supported, can use some flags in Makefile to not build this.
> 
> You are right, this is not supported on ARM64. I can query uname in Makefile
> and compile this only for arch != aarch64.
> I will add this info in commit message as well.
> 
> - Saurabh

Greg/Long,

I will be sending the V3 fixing above comment. Hope there are no
further comments.

- Saurabh

