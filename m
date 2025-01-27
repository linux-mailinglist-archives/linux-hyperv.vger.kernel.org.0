Return-Path: <linux-hyperv+bounces-3775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C954A20008
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 22:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4221886E86
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Jan 2025 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33B81D86F6;
	Mon, 27 Jan 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R4CbrTEs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAF190664;
	Mon, 27 Jan 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738014184; cv=none; b=NWwRH6MMKxeXu5P6WzaNe+o/XeEJXmKLpNYeXzrnjT5Mkx98QcwmnxyskOGE5zZSOo0UIkZfdLhaOGlBSUnVvrzPHj2iovthOlI6/ZrCBJmshrBdEhDF/SdghJy8xH9KdmPasQo4e8QUs0gag6TQeUjqXfPHbB3q/35Vzt8LkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738014184; c=relaxed/simple;
	bh=amWnXKJDfu9x7z8AEwJSfk3fbiQeT7cAvuR5bp9HWTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eajmI1vKzMPoWGhKkhXJ42lY2rpawB4wqXb3l7ruwIgOpRkfizUuuWS/ejawNwkXAL7U3NDOsGQsBJKe/V/7GEFR10VJ8iRgM3oXhjNAHG8Xme5IrqNJ8IwWbhubVGM3cBNWNRXVX3K9CR0zD6LhudoLpl0mKOGllws4ZE/Sb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R4CbrTEs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from hm-sls2 (bras-base-toroon4332w-grc-51-184-146-177-43.dsl.bell.ca [184.146.177.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id 38EF0203716A;
	Mon, 27 Jan 2025 13:43:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38EF0203716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738014182;
	bh=sDyFIa9eqolzc81S1g1JJRzaiBj3izmmQxt0+YYah2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4CbrTEs3YCAokeulW4Lh9X9v/nwjnxkI5U6CpFnK7+9EwBUlBMF+05Mi232qZu+w
	 OVXcUu1xeANxKBlDfo9cE3oF0uAGeEzIovjeyGrS1nZKL9SE6dxdEI5D2wkGu2oBuy
	 hC/rwIbjHCI376IJDfLPQ6cZjUQjym6fweosUrro=
Date: Mon, 27 Jan 2025 16:42:56 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/hv: select PCI_HYPERV if PCI is enabled
Message-ID: <Z5f94J7rzSC-TyIB@hm-sls2>
References: <20250127180947.123174-1-hamzamahfooz@linux.microsoft.com>
 <SN6PR02MB4157BAAEB938E7E4E849DC7CD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157BAAEB938E7E4E849DC7CD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Jan 27, 2025 at 09:02:22PM +0000, Michael Kelley wrote:
> From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com> Sent: Monday, January 27, 2025 10:10 AM
> > 
> > We should select PCI_HYPERV here, otherwise it's possible for devices to
> > not show up as expected, at least not in an orderly manner.
> 
> The commit message needs more precision:  What does "not show up"
> mean, and what does "not in an orderly manner" mean?  And "it's possible"
> is vague -- can you be more specific about the conditions?  Also, avoid
> the use of personal pronouns like "we".
> 
> But the commit message notwithstanding, I don't think this is change
> that should be made. CONFIG_PCI_HYPERV refers to the VMBus device
> driver for handling vPCI (a.k.a PCI pass-thru) devices. It's perfectly
> possible and normal for a VM on Hyper-V to not have any such devices,
> in which case the driver isn't needed and should not be forced to be
> included. (See Documentation/virt/hyperv/vpci.rst for more on vPCI
> devices.)

Ya, we ran into an issue where CONFIG_NVME_CORE=y and
CONFIG_PCI_HYPERV=m caused the passed-through SSDs not to show up (i.e.
they aren't visible to userspace). I guess it's cause PCI_HYPERV has
to load in before the nvme stuff for that workload. So, I thought it was
reasonable to select PCI_HYPERV here to prevent someone else from
shooting themselves in the foot. Though, I guess it really it on the
distro guys to get that right.

> 
> There are other VMBus device drivers:  storvsc, netvsc, the Hyper-V
> frame buffer driver, the "util" drivers for shutdown, KVP, etc., and more.
> These each have their own CONFIG_* entry, and current practice
> doesn't select them when CONFIG_HYPERV is set. I don't see a reason
> that the vPCI driver should be handled differently.
> 
> Also, different distro vendors take different approaches as to whether
> these drivers are built as modules, or as built-in to their kernel images.
> I'm not sure what the Kconfig tool does when a SELECT statement identifies
> a tri-state setting. Since CONFIG_HYPERV is tri-state, does the target of
> the SELECT get the same tri-state value as CONFIG_HYPERV? Again,
> that may not be what distro vendors want. They may choose to have
> some of the VMBus drivers built-in and others built as modules. Distro
> vendors (and anyone doing a custom kernel build) should be allowed
> to make their choices just like for any other drivers.
> 
> If you've come across a situation these considerations don't apply
> or are problematic, provide more details. That's what a good commit
> message should do -- be convincing as to *why* the change should
> be made! :-)
> 
> Michael
> 
> > 
> > Cc: stable@vger.kernel.org
> > Cc: Wei Liu <wei.liu@kernel.org>
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 862c47b191af..6ee75b3f0fa6 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -9,6 +9,7 @@ config HYPERV
> >  	select PARAVIRT
> >  	select X86_HV_CALLBACK_VECTOR if X86
> >  	select OF_EARLY_FLATTREE if OF
> > +	select PCI_HYPERV if PCI
> >  	help
> >  	  Select this option to run Linux as a Hyper-V client operating
> >  	  system.
> > --
> > 2.47.1
> > 
> 

