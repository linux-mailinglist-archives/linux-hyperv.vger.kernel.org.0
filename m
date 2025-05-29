Return-Path: <linux-hyperv+bounces-5701-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C1AC80CC
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551D21C00B30
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 May 2025 16:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73822DF97;
	Thu, 29 May 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c478Cpkx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F88322D7B3;
	Thu, 29 May 2025 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535680; cv=none; b=PK5RcThy4cyoYmfyc4sihU9ZGZHQp0HDwtnWYxAjo6Qe8Cxxzo2phOICH/TqciECGaA3Oj8iekZwPCRss2EUzgBIUPFajg4M4voeXvayeEn8IKcZXvgefw7AmM8YTlSOsuwpzD0DTrhMoeTu3QGEGcmm98D61/GFsAxjfoKZrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535680; c=relaxed/simple;
	bh=Be3P6pHlfgYQ66GFjv2+QPhwAR0GQVt5u8J1oxny0Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PK6dLFUFz8fdHGA2d7u7alsrl2wACAmbxRlOFwdnlum72ov2jXOc22X+rbsDxb0Tb4mSK8kXcadQNdKAMONL/OokWUaEc/8JV2k3nIb28mv7npST34TgVJZEnp73CwpE5nyaA6p/gbqBv0bFsSmAdWqrrY9dRqfMp4lF0FfkoUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c478Cpkx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id AA53C2078633;
	Thu, 29 May 2025 09:21:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA53C2078633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748535679;
	bh=6TzLCYuve+sXzJFxusy5XeqylgGah8gPMYzZ/JWVXA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c478Cpkx3Q2iqRCsuEdg+ydYlY+2jBg2qSahJFzIA7lF1QBN6g/fMKjprf98pxm47
	 B93FZtEul2Q1TRJwcnGjKUAau9Sdo51CT1ARUFdE1U0A0MHegT71UC2R+cXvkDsJ94
	 4LuyuRAWUA4hy5fw5dO3YoHehiG89KvterLiRfw4=
Date: Thu, 29 May 2025 09:21:17 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Drivers: hv: Introduce mshv_vtl driver
Message-ID: <aDiJfYetw4S-RBML@skinsburskii.localdomain>
References: <20250519045642.50609-1-namjain@linux.microsoft.com>
 <20250519045642.50609-3-namjain@linux.microsoft.com>
 <aCzQMuwQZ1Lkk7eH@skinsburskii.>
 <80853cdb-fd34-4a5e-99a0-1a71b8ce8226@linux.microsoft.com>
 <aC9oeJPFynyYg9pU@skinsburskii.>
 <e7763e8c-5f3a-4a37-a696-1b8492d92662@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7763e8c-5f3a-4a37-a696-1b8492d92662@linux.microsoft.com>

On Fri, May 23, 2025 at 02:55:32PM +0530, Naman Jain wrote:
> 
> 
> On 5/22/2025 11:40 PM, Stanislav Kinsburskii wrote:
> > On Wed, May 21, 2025 at 11:33:29AM +0530, Naman Jain wrote:
> > > 
> > > 
> > > On 5/21/2025 12:25 AM, Stanislav Kinsburskii wrote:
> > > > On Mon, May 19, 2025 at 10:26:42AM +0530, Naman Jain wrote:
> > > > > Provide an interface for Virtual Machine Monitor like OpenVMM and its
> > > > > use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> > > > > Expose devices and support IOCTLs for features like VTL creation,
> > > > > VTL0 memory management, context switch, making hypercalls,
> > > > > mapping VTL0 address space to VTL2 userspace, getting new VMBus
> > > > > messages and channel events in VTL2 etc.
> > > > > 
> > > > > Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> > > > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > > > Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > > > Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> > > > > Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > > > > Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
> > > > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > > > ---
> > > > >    drivers/hv/Kconfig          |   20 +
> > > > >    drivers/hv/Makefile         |    7 +-
> > > > >    drivers/hv/mshv_vtl.h       |   52 +
> > > > >    drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
> > > > >    include/hyperv/hvgdk_mini.h |   81 ++
> > > > >    include/hyperv/hvhdk.h      |    1 +
> > > > >    include/uapi/linux/mshv.h   |   82 ++
> > > > >    7 files changed, 2025 insertions(+), 1 deletion(-)
> > > > >    create mode 100644 drivers/hv/mshv_vtl.h
> > > > >    create mode 100644 drivers/hv/mshv_vtl_main.c
> > > > > 
> > > > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > > > index eefa0b559b73..21cee5564d70 100644
> > > > > --- a/drivers/hv/Kconfig
> > > > > +++ b/drivers/hv/Kconfig
> > > > > @@ -72,4 +72,24 @@ config MSHV_ROOT
> > > > >    	  If unsure, say N.
> > > > > +config MSHV_VTL
> > > > > +	tristate "Microsoft Hyper-V VTL driver"
> > > > > +	depends on HYPERV && X86_64
> > > > > +	depends on TRANSPARENT_HUGEPAGE
> > > > 
> > > > Why does it depend on TRANSPARENT_HUGEPAGE?
> > > > 
> > > 
> > 
> > Let me rephrase: can this driver work without transparent huge pages?
> > If yes, then it shouldn't depend on the option and rather select it.
> > If not, then it should be either fixed to be able to or have an
> > expalanation why this dependecy was introduced.
> 
> No, it won't work. Reason being - we are adding support to map VTL0 address
> space to a user-mode process in VTL2. VTL2 for OpenHCL makes use of Huge
> pages to improve performance on VMs having large memory requirements. Thus,
> we need TRANSPARENT_HUGEPAGE.
> 
> I will add this as a comment in Kconfig.
> 

Then I'd suggest selecting huge pages instead of depending on them: it's
kinda weird that one need to select huge pages first to be able to
even find out, that there is some virtualization driver, depending on it.

Thanks,
Stanislav

