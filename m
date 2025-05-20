Return-Path: <linux-hyperv+bounces-5566-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411ECABCDE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 05:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FD7B0210
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 May 2025 03:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF59B2566F4;
	Tue, 20 May 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GmAQUsI9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000DF253F3B;
	Tue, 20 May 2025 03:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711924; cv=none; b=XYXdeIVXj3N9eR8EWZPF3Y+otPO0BbUqPzXxJEtZwd5GpAtYV4c43nRuk1n6XvBgTVsnnatu7p/YqXlbPld+Jb/NoaLfkpyiGTocSo9rdNyR4SqnbEfKSXUmRfYmAXtr5WB513tO0CPmSwamR2GCJ/EdizgEs7y9J1gkNMJKY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711924; c=relaxed/simple;
	bh=7uAagP8R5nYG++boL0qLzn70Ikc+MfotszTo32MHa8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejkDXm837c8RWEHihR5g0rNt0EbvsRDo0QO0vu9G5UuDsPw+AMAFcTfdwL0Lp1/HNyxro7nmTS3tQRIvKgw1J0GgCJX+rQLWtKXrCe2REzUy/jczLhqrIqWQ5NG76A2U+sGhg4OamEbQmMPOKUqtQRPBs9e8efKDd+ajKzP1AxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GmAQUsI9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 4F0FB2067884; Mon, 19 May 2025 20:32:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F0FB2067884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747711922;
	bh=fA8qx9+0rF8iQR8ecGm4xRCN9Y4os0RUn9COBgB/VJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmAQUsI9gHwD/vb3P4NK37JSBdE97JwJnzoW6/+7fuPnCHoYl1MxoFlgxNbY4CVRU
	 lbhUxTUC0MruxBogOwUdB2V6pGLc6hojLaWlSNfjTi1TeEK6y24obk+6dr0uVJCC8M
	 eOz582tOJCS4bxVwCWT1yKIVNov2zRbSWNXMkajw=
Date: Mon, 19 May 2025 20:32:02 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Singh Sengar <ssengar@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, "deller@gmx.de" <deller@gmx.de>,
	"javierm@redhat.com" <javierm@redhat.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 1/1] Drivers: hv: Always select CONFIG_SYSFB
 for Hyper-V guests
Message-ID: <20250520033202.GA30215@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250516235820.15356-1-mhklinux@outlook.com>
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <SN6PR02MB41575C18EA832E640484A02CD492A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250517161407.GA30678@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB41574848C3351DD1673A2855D492A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250519165454.GA11708@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157FD9AB9114C8DD6FF4B82D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157FD9AB9114C8DD6FF4B82D49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, May 20, 2025 at 02:07:48AM +0000, Michael Kelley wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, May 19, 2025 9:55 AM
> > 
> > On Sat, May 17, 2025 at 06:47:22PM +0000, Michael Kelley wrote:
> > > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Saturday, May 17, 2025 9:14 AM
> > > >
> > > > On Sat, May 17, 2025 at 01:34:20PM +0000, Michael Kelley wrote:
> > > > > From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Friday, May 16, 2025 9:38 PM
> > > > > >
> > > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > >
> > > > > > > The Hyper-V host provides guest VMs with a range of MMIO addresses that
> > > > > > > guest VMBus drivers can use. The VMBus driver in Linux manages that MMIO
> > > > > > > space, and allocates portions to drivers upon request. As part of managing
> > > > > > > that MMIO space in a Generation 2 VM, the VMBus driver must reserve the
> > > > > > > portion of the MMIO space that Hyper-V has designated for the synthetic
> > > > > > > frame buffer, and not allocate this space to VMBus drivers other than graphics
> > > > > > > framebuffer drivers. The synthetic frame buffer MMIO area is described by
> > > > > > > the screen_info data structure that is passed to the Linux kernel at boot time,
> > > > > > > so the VMBus driver must access screen_info for Generation 2 VMs. (In
> > > > > > > Generation 1 VMs, the framebuffer MMIO space is communicated to the
> > > > > > > guest via a PCI pseudo-device, and access to screen_info is not needed.)
> > > > > > >
> > > > > > > In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info") the
> > > > > > > VMBus driver's access to screen_info is restricted to when CONFIG_SYSFB is
> > > > > > > enabled. CONFIG_SYSFB is typically enabled in kernels built for Hyper-V by
> > > > > > > virtue of having at least one of CONFIG_FB_EFI, CONFIG_FB_VESA, or
> > > > > > > CONFIG_SYSFB_SIMPLEFB enabled, so the restriction doesn't usually affect
> > > > > > > anything. But it's valid to have none of these enabled, in which case
> > > > > > > CONFIG_SYSFB is not enabled, and the VMBus driver is unable to properly
> > > > > > > reserve the framebuffer MMIO space for graphics framebuffer drivers. The
> > > > > > > framebuffer MMIO space may be assigned to some other VMBus driver, with
> > > > > > > undefined results. As an example, if a VM is using a PCI pass-thru NVMe
> > > > > > > controller to host the OS disk, the PCI NVMe controller is probed before any
> > > > > > > graphic devices, and the NVMe controller is assigned a portion of the
> > > > > > > framebuffer MMIO space.
> > > > > > > Hyper-V reports an error to Linux during the probe, and the OS disk fails to
> > > > > > > get setup. Then Linux fails to boot in the VM.
> > > > > > >
> > > > > > > Fix this by having CONFIG_HYPERV always select SYSFB. Then the VMBus
> > > > > > > driver in a Gen 2 VM can always reserve the MMIO space for the graphics
> > > > > > > framebuffer driver, and prevent the undefined behavior.
> > > > > >
> > > > > > One question: Shouldn't the SYSFB be selected by actual graphics framebuffer driver
> > > > > > which is expected to use it. With this patch this option will be enabled irrespective
> > > > > > if there is any user for it or not, wondering if we can better optimize it for such systems.
> > > > > >
> > > > >
> > > > > That approach doesn't work. For a cloud-based server, it might make
> > > > > sense to build a kernel image without either of the Hyper-V graphics
> > > > > framebuffer drivers (DRM_HYPERV or HYPERV_FB) since in that case the
> > > > > Linux console is the serial console. But the problem could still occur
> > > > > where a PCI pass-thru NVMe controller tries to use the MMIO space
> > > > > that Hyper-V intends for the framebuffer. That problem is directly tied
> > > > > to CONFIG_SYSFB because it's the VMBus driver that must treat the
> > > > > framebuffer MMIO space as special. The absence or presence of a
> > > > > framebuffer driver isn't the key factor, though we've been (incorrectly)
> > > > > relying on the presence of a framebuffer driver to set CONFIG_SYSFB.
> > > > >
> > > >
> > > > Thank you for the clarification. I was concerned because SYSFB is not currently
> > > > enabled in the OpenHCL kernel, and our goal is to keep the OpenHCL configuration
> > > > as minimal as possible. I haven't yet looked into the details to determine
> > > > whether this might have any impact on the kernel binary size or runtime memory
> > > > usage. I trust this won't affect negatively.
> > > >
> > > > OpenHCL Config Ref:
> > > > https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/6.12/Microsoft/hcl-x64.config
> > > >
> > >
> > > Good point.
> > >
> > > The OpenHCL code tree has commit a07b50d80ab6 that restricts the
> > > screen_info to being available only when CONFIG_SYSFB is enabled.
> > > But since OpenHCL in VTL2 gets its firmware info via OF instead of ACPI,
> > > I'm unsure what the Hyper-V host tells it about available MMIO space,
> > > and whether that space includes MMIO space for a framebuffer. If it
> > > doesn't, then OpenHCL won't have the problem I describe above, and
> > > it won't need CONFIG_SYSFB. This patch could be modified to do
> > >
> > > select SYSFB if !HYPERV_VTL_MODE
> > 
> > I am worried that this is not very scalable, there could be more such
> > Hyper-V systems in future.
> 
> I could see scalability being a problem if there were 20 more such
> Hyper-V systems in the future. But if there are just 2 or 3 more, that
> seems like it would be manageable.
> 
> Regardless, I'm OK with doing this with or without the
> "if !HYPERV_VTL_MODE". I don't think we should just drop this
> entirely. When playing around with various framebuffers drivers
> a few weeks back, I personally encountered the problem of having
> built a kernel that wouldn't boot in an Azure VM with an NVMe OS
> disk. I couldn't figure out why probing the NVMe controller failed.
> It took me an hour to sort out what was happening, and I was
> familiar with the Hyper-V PCI driver. I'd like to prevent such a
> problem from happening to someone else.

I agree we want to fix this.

> 
> > 
> > >
> > > Can you find out what MMIO space Hyper-V provides to VTL2 via OF?
> > > It would make sense if no framebuffer is provided. And maybe
> > > screen_info itself is not set up when VTL2 is loaded, which would
> > > also make adding CONFIG_SYSFB pointless for VTL2.
> > 
> > I can only see below address range passed for MMIO to VMBus driver:
> > ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
> 
> I'm guessing the above text is what shows up in DT?  I'm not sure
> how to interpret it. In normal guests, Hyper-V offers a "low MMIO"
> range that is below the 4 GiB line, and a "high MMIO" range that
> is just before the 64 GiB line. In a normal guest in Azure, I see the
> MLX driver using 0xfc0000000, which would be just below the 64 GiB
> line, and in the "high MMIO" range. The "0x0f 0xf0000000" in DT might
> be physical address 0xff0000000, which is consistent with the
> "high MMIO" range.  I'm not sure how to interpret the second
> occurrence of "0xf 0xf0000000".  I'm guessing the 0x10000000
> (256 Mib) is the length of the available range, which would also
> make sense.
> 
> The framebuffer address is always in the "low MMIO" range. So
> if my interpretation is anywhere close to correct, DT isn't
> specifying any MMIO space for a framebuffer, and there's
> no need for CONFIG_SYSFB in a kernel running in VTL2.
> 
> What's your preference for how to proceed? Adding CONFIG_SYSFB
> probably *will* increase the kernel code size, but I don't know
> by how much. I can do a measurement.

My primary preference is to ensure that OpenHCL remains unaffected.
And since there are no better alternatives I can think of, I am fine
proceeding with !HYPERV_VTL_MODE

with that,
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh

