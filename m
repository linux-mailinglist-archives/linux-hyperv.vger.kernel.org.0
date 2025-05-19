Return-Path: <linux-hyperv+bounces-5556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB95ABC4FC
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 18:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F087A24D2
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 May 2025 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB7A286406;
	Mon, 19 May 2025 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="P7L81j2k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DACB28313B;
	Mon, 19 May 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673697; cv=none; b=T9a83Y8sEhY3MuHKwgWo1yjScx9Tuz/zRtzf6Gy6T1V4q+4ViPkoa3sc37bd8EXDineXK7vLKyhBzo0JpDdz/LyMNGECsXPvSIUQvkDVae6N5GXLQyt9xx9s9zRrL8bmZKu9tv3fzIfIPEuTcm5tEZ8JFcdUg1OBbwSUsqF1WJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673697; c=relaxed/simple;
	bh=bW+o8oCViCCYXcAqVtY/0UB3qmmBvGj7Uz+FyS2bPSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmoODVSTbSWHTSj1COX/EIpuLoni7dFbaNa0SJKs0m6otLd0XsgSiJIRQ/WlNSZlVRX+PzkrY84jM2cmGsO4CymoyyrmLAHq20LGgZCON/BE3jX96uEo3o0VdNprx3TNGM7938Kr4hHYcdae95JsbFUJbpI7eQ7SevfSWK9fKKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=P7L81j2k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 039812067864; Mon, 19 May 2025 09:54:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 039812067864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747673695;
	bh=wg6hvFqkqMq7BInGeV8wn3GSM9YWzn8YzNDbZ6ZxWFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7L81j2kqiuVsDt0TAWtSv/U5ulAeQg6gOh08uzjdHgtJAOiPqYoDh2Aw2/qhJ3Dn
	 4sgBCfookyA6OQNNJ/6NSR2l4ujeDjSZgAhgm8MSiVEfDzxk/TJLjFCRnpEumkTZX8
	 Twb8s27sufQ4Go3mdGcrcax0JfCNhiMKQHBvaW8Q=
Date: Mon, 19 May 2025 09:54:54 -0700
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
Message-ID: <20250519165454.GA11708@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250516235820.15356-1-mhklinux@outlook.com>
 <KUZP153MB144472E667B0C1A421B49285BE92A@KUZP153MB1444.APCP153.PROD.OUTLOOK.COM>
 <SN6PR02MB41575C18EA832E640484A02CD492A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20250517161407.GA30678@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB41574848C3351DD1673A2855D492A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574848C3351DD1673A2855D492A@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, May 17, 2025 at 06:47:22PM +0000, Michael Kelley wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Saturday, May 17, 2025 9:14 AM
> > 
> > On Sat, May 17, 2025 at 01:34:20PM +0000, Michael Kelley wrote:
> > > From: Saurabh Singh Sengar <ssengar@microsoft.com> Sent: Friday, May 16, 2025 9:38 PM
> > > >
> > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > >
> > > > > The Hyper-V host provides guest VMs with a range of MMIO addresses that
> > > > > guest VMBus drivers can use. The VMBus driver in Linux manages that MMIO
> > > > > space, and allocates portions to drivers upon request. As part of managing
> > > > > that MMIO space in a Generation 2 VM, the VMBus driver must reserve the
> > > > > portion of the MMIO space that Hyper-V has designated for the synthetic
> > > > > frame buffer, and not allocate this space to VMBus drivers other than graphics
> > > > > framebuffer drivers. The synthetic frame buffer MMIO area is described by
> > > > > the screen_info data structure that is passed to the Linux kernel at boot time,
> > > > > so the VMBus driver must access screen_info for Generation 2 VMs. (In
> > > > > Generation 1 VMs, the framebuffer MMIO space is communicated to the
> > > > > guest via a PCI pseudo-device, and access to screen_info is not needed.)
> > > > >
> > > > > In commit a07b50d80ab6 ("hyperv: avoid dependency on screen_info") the
> > > > > VMBus driver's access to screen_info is restricted to when CONFIG_SYSFB is
> > > > > enabled. CONFIG_SYSFB is typically enabled in kernels built for Hyper-V by
> > > > > virtue of having at least one of CONFIG_FB_EFI, CONFIG_FB_VESA, or
> > > > > CONFIG_SYSFB_SIMPLEFB enabled, so the restriction doesn't usually affect
> > > > > anything. But it's valid to have none of these enabled, in which case
> > > > > CONFIG_SYSFB is not enabled, and the VMBus driver is unable to properly
> > > > > reserve the framebuffer MMIO space for graphics framebuffer drivers. The
> > > > > framebuffer MMIO space may be assigned to some other VMBus driver, with
> > > > > undefined results. As an example, if a VM is using a PCI pass-thru NVMe
> > > > > controller to host the OS disk, the PCI NVMe controller is probed before any
> > > > > graphic devices, and the NVMe controller is assigned a portion of the
> > > > > framebuffer MMIO space.
> > > > > Hyper-V reports an error to Linux during the probe, and the OS disk fails to
> > > > > get setup. Then Linux fails to boot in the VM.
> > > > >
> > > > > Fix this by having CONFIG_HYPERV always select SYSFB. Then the VMBus
> > > > > driver in a Gen 2 VM can always reserve the MMIO space for the graphics
> > > > > framebuffer driver, and prevent the undefined behavior.
> > > >
> > > > One question: Shouldn't the SYSFB be selected by actual graphics framebuffer driver
> > > > which is expected to use it. With this patch this option will be enabled irrespective
> > > > if there is any user for it or not, wondering if we can better optimize it for such systems.
> > > >
> > >
> > > That approach doesn't work. For a cloud-based server, it might make
> > > sense to build a kernel image without either of the Hyper-V graphics
> > > framebuffer drivers (DRM_HYPERV or HYPERV_FB) since in that case the
> > > Linux console is the serial console. But the problem could still occur
> > > where a PCI pass-thru NVMe controller tries to use the MMIO space
> > > that Hyper-V intends for the framebuffer. That problem is directly tied
> > > to CONFIG_SYSFB because it's the VMBus driver that must treat the
> > > framebuffer MMIO space as special. The absence or presence of a
> > > framebuffer driver isn't the key factor, though we've been (incorrectly)
> > > relying on the presence of a framebuffer driver to set CONFIG_SYSFB.
> > >
> > 
> > Thank you for the clarification. I was concerned because SYSFB is not currently
> > enabled in the OpenHCL kernel, and our goal is to keep the OpenHCL configuration
> > as minimal as possible. I haven't yet looked into the details to determine
> > whether this might have any impact on the kernel binary size or runtime memory
> > usage. I trust this won't affect negatively.
> > 
> > OpenHCL Config Ref:
> > https://github.com/microsoft/OHCL-Linux-Kernel/blob/product/hcl-main/6.12/Microsoft/hcl-x64.config
> > 
> 
> Good point.
> 
> The OpenHCL code tree has commit a07b50d80ab6 that restricts the
> screen_info to being available only when CONFIG_SYSFB is enabled.
> But since OpenHCL in VTL2 gets its firmware info via OF instead of ACPI,
> I'm unsure what the Hyper-V host tells it about available MMIO space,
> and whether that space includes MMIO space for a framebuffer. If it
> doesn't, then OpenHCL won't have the problem I describe above, and
> it won't need CONFIG_SYSFB. This patch could be modified to do
> 
> select SYSFB if !HYPERV_VTL_MODE

I am worried that this is not very scalable, there could be more such
Hyper-V systems in future.

> 
> Can you find out what MMIO space Hyper-V provides to VTL2 via OF?
> It would make sense if no framebuffer is provided. And maybe
> screen_info itself is not set up when VTL2 is loaded, which would
> also make adding CONFIG_SYSFB pointless for VTL2.

I can only see below address range passed for MMIO to VMBus driver:
ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;

I don't think we have any use of scrren_info or framebuffer in OpenHCL.

- Saurabh

