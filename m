Return-Path: <linux-hyperv+bounces-5621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5EAC1308
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 20:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96BB67A9A3A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 May 2025 18:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FA019C556;
	Thu, 22 May 2025 18:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oH1DSp/F"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9703833F3;
	Thu, 22 May 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747937405; cv=none; b=icMyqO9Xl94iu9Buyks8JCEmy62cf3QWihgRgnHpGY63gyri/6T7PwR25o90jr/HcbKpBtxYeMupLsFrhjvAsTapa16RrinrrUgu1m8f8XHXHMdTfA3NixSSr8UwrRUwLs5kAK0kKc+peHCaUMzOcWlQBW1ecK3+zvuZdP8tHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747937405; c=relaxed/simple;
	bh=MD5KJq3xPJPOvEt1jbGXI8dTkIRIaaOxZdxZhx34yjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHFCmez2Nkakal+x1sEknc2gUd8t4csky1dLgYqDWmn7qAiDJEpjp77xRSmvB7XXEVmKkegKIfXDPc+yG0+wNmj7Fq4UODml47J2xI/WHShdDLWYG8IeItP0Sx2mcCXlT+fc0cV40FYeqlNxCdvNyGUEZt2ZEyVkxebh8S28yYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oH1DSp/F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii. (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id D3833211CFAC;
	Thu, 22 May 2025 11:10:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3833211CFAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747937403;
	bh=idVisYYe/w991BM/hJuvBP6Q3CZkk9VCPKdJIOFknD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oH1DSp/FutoWNwGNHtqpGL//4xt1b5If34PQM9zqCl59E4csloLyqfvSV/e0YcFdJ
	 NVt6ZvWx/4ZJzdm3tu8aDFEhtuO0Qd3buWV8evnmZMpKUl7QlRQtVZotmKdRSQ35W8
	 becguvbl3u+YqMvlrzfHfjOwPRbRflH1PvIZNfhg=
Date: Thu, 22 May 2025 11:10:00 -0700
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
Message-ID: <aC9oeJPFynyYg9pU@skinsburskii.>
References: <20250519045642.50609-1-namjain@linux.microsoft.com>
 <20250519045642.50609-3-namjain@linux.microsoft.com>
 <aCzQMuwQZ1Lkk7eH@skinsburskii.>
 <80853cdb-fd34-4a5e-99a0-1a71b8ce8226@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80853cdb-fd34-4a5e-99a0-1a71b8ce8226@linux.microsoft.com>

On Wed, May 21, 2025 at 11:33:29AM +0530, Naman Jain wrote:
> 
> 
> On 5/21/2025 12:25 AM, Stanislav Kinsburskii wrote:
> > On Mon, May 19, 2025 at 10:26:42AM +0530, Naman Jain wrote:
> > > Provide an interface for Virtual Machine Monitor like OpenVMM and its
> > > use as OpenHCL paravisor to control VTL0 (Virtual trust Level).
> > > Expose devices and support IOCTLs for features like VTL creation,
> > > VTL0 memory management, context switch, making hypercalls,
> > > mapping VTL0 address space to VTL2 userspace, getting new VMBus
> > > messages and channel events in VTL2 etc.
> > > 
> > > Co-developed-by: Roman Kisel <romank@linux.microsoft.com>
> > > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > > Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > > Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> > > Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > > Message-ID: <20250512140432.2387503-3-namjain@linux.microsoft.com>
> > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > ---
> > >   drivers/hv/Kconfig          |   20 +
> > >   drivers/hv/Makefile         |    7 +-
> > >   drivers/hv/mshv_vtl.h       |   52 +
> > >   drivers/hv/mshv_vtl_main.c  | 1783 +++++++++++++++++++++++++++++++++++
> > >   include/hyperv/hvgdk_mini.h |   81 ++
> > >   include/hyperv/hvhdk.h      |    1 +
> > >   include/uapi/linux/mshv.h   |   82 ++
> > >   7 files changed, 2025 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/hv/mshv_vtl.h
> > >   create mode 100644 drivers/hv/mshv_vtl_main.c
> > > 
> > > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > > index eefa0b559b73..21cee5564d70 100644
> > > --- a/drivers/hv/Kconfig
> > > +++ b/drivers/hv/Kconfig
> > > @@ -72,4 +72,24 @@ config MSHV_ROOT
> > >   	  If unsure, say N.
> > > +config MSHV_VTL
> > > +	tristate "Microsoft Hyper-V VTL driver"
> > > +	depends on HYPERV && X86_64
> > > +	depends on TRANSPARENT_HUGEPAGE
> > 
> > Why does it depend on TRANSPARENT_HUGEPAGE?
> > 
> 

Let me rephrase: can this driver work without transparent huge pages?
If yes, then it shouldn't depend on the option and rather select it.
If not, then it should be either fixed to be able to or have an
expalanation why this dependecy was introduced.

> > > +
> > > +/* vtl device */
> > > +#define MSHV_CREATE_VTL			_IOR(MSHV_IOCTL, 0x1D, char)
> > > +#define MSHV_VTL_ADD_VTL0_MEMORY	_IOW(MSHV_IOCTL, 0x21, struct mshv_vtl_ram_disposition)
> > > +#define MSHV_VTL_SET_POLL_FILE		_IOW(MSHV_IOCTL, 0x25, struct mshv_vtl_set_poll_file)
> > > +#define MSHV_VTL_RETURN_TO_LOWER_VTL	_IO(MSHV_IOCTL, 0x27)
> > > +#define MSHV_GET_VP_REGISTERS		_IOWR(MSHV_IOCTL, 0x05, struct mshv_vp_registers)
> > > +#define MSHV_SET_VP_REGISTERS		_IOW(MSHV_IOCTL, 0x06, struct mshv_vp_registers)
> > > +
> > > +/* VMBus device IOCTLs */
> > > +#define MSHV_SINT_SIGNAL_EVENT    _IOW(MSHV_IOCTL, 0x22, struct mshv_vtl_signal_event)
> > > +#define MSHV_SINT_POST_MESSAGE    _IOW(MSHV_IOCTL, 0x23, struct mshv_vtl_sint_post_msg)
> > > +#define MSHV_SINT_SET_EVENTFD     _IOW(MSHV_IOCTL, 0x24, struct mshv_vtl_set_eventfd)
> > > +#define MSHV_SINT_PAUSE_MESSAGE_STREAM     _IOW(MSHV_IOCTL, 0x25, struct mshv_sint_mask)
> > > +
> > > +/* hv_hvcall device */
> > > +#define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
> > > +#define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
> > 
> > How many of these ioctls are actually used by the mshv root driver?
> > Should those which are VTl-specific be named as such (like MSHV_VTL_SET_POLL_FILE)?
> > Another option would be to keep all the names generic.
> > 
> > Thanks,
> > Stanislav
> 
> None of the IOCTLs in mshv_vtl section, introduced in this patch is used
> by mshv_root driver. Since IOCTLs of mshv_root does not have MSHV_ROOT
> prefix, I am OK with removing MSHV_VTL_* prefix from these IOCTL names.
> You can let me know if you want me to prefix them with MSHV_VTL.
> 
> Thanks again for reviewing.
> 
> Regards,
> Naman
> 

As these ioctls share the same "namespace" (MSHV_IOCTL), removal os the
VTL suffix looks a better optio to me.

Thanks,
Stanislav.

