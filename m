Return-Path: <linux-hyperv+bounces-2761-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2694D90D
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Aug 2024 01:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB811F227F5
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2024 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A01662FD;
	Fri,  9 Aug 2024 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SekrIZ4D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5C26AE4;
	Fri,  9 Aug 2024 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723245474; cv=none; b=SEixxdDe5zEGxBr2l/6Su5DpItmHQvsLAK/jkeTv4FfETs+OnKCg2MVqHWaezbI+21Pm+L2nmK/TdloX/IFGdB+AmsKhpyyRXqVq84MjjUZ/eh9sFSWDJNOLiv+eKNDRlcGM+m6VkSCCFmuzqbk4Ai5iPyaNP6jmJzKmTT+8vKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723245474; c=relaxed/simple;
	bh=p1UP7kXiF05qDpfx0vUke1Tz4fzvzlzprD6gFSFkk1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5cVlNi+ELGcVgdDjAc/S6U5+Bb3LQ2XHbeLnI73MoWmQdQNkBPT03MyhmUcWxcQQDOsWl/L/eTM1CS2y/ZVN8Hb7XK/k4pNRD+M4YF1N4009C7pYxXjL0WhgWPMCWeAl3i/gWOfmEPxKYDbqYG2p1PDdqv/ROcMDTDUts6Z9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SekrIZ4D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723245472; x=1754781472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p1UP7kXiF05qDpfx0vUke1Tz4fzvzlzprD6gFSFkk1Y=;
  b=SekrIZ4DdxLxsxa6DBZpDDeWPxJX1Xe8V/k524aiLmBUhG34LQgpUwXV
   5v4p77o6/Yi+2WyLpAgaS93gZuIOmYz3L/5mCCW8RPeZErAxq1s+FE9EO
   /5o3JX2Rm1XcuEkwRsE8fe0VRKr6eQvguSCKHhTeCn06LhiORPWwECAKf
   70mwAtDYorhD7kMX4L8+XJeqlo8sSSDQ39h2jD4b7/8Y/jPaYJ4mtp0cm
   dlPA68x/KbAHorTUbS9Sa9oCAF8gl7ajvYB7A+bqVgoYDBe9qKspc7/5a
   MhWnGShuLpnPauUDx4FyAq2B8yg2wEyOeVzOMROsVZDkJW0zXMrX+lrtz
   A==;
X-CSE-ConnectionGUID: 1uQ6OhbGQnWX3xVFkDKQrA==
X-CSE-MsgGUID: 1NP1wrpLTDi+u/OznvN3sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21095565"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="21095565"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 16:17:50 -0700
X-CSE-ConnectionGUID: 1aalignmTu6jxIAJvMbfMA==
X-CSE-MsgGUID: vRgog+eEQGmPu3xqM1EpQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62359538"
Received: from unknown (HELO localhost) ([10.79.232.122])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 16:17:50 -0700
Date: Fri, 9 Aug 2024 16:17:49 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
	lenb@kernel.org, kirill.shutemov@linux.intel.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 5/7] x86/hyperv: Mark ACPI wakeup mailbox page as private
Message-ID: <20240809231749.GA25056@yjiang5-mobl.amr.corp.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-6-yunhong.jiang@linux.intel.com>
 <87cymk2rrj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cymk2rrj.ffs@tglx>

On Wed, Aug 07, 2024 at 06:59:28PM +0200, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 15:12, Yunhong Jiang wrote:
> > The ACPI wakeup mailbox is accessed by the OS and the firmware, both are
> > in the guest's context, instead of the hypervisor/VMM context. Mark the
> > address private explicitly.
> 
> This lacks information why the realmode area must be reserved and
> initialized, which is what the change is doing implicitely.
> 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> >  
> > +/*
> > + * The ACPI wakeup mailbox are accessed by the OS and the BIOS, both are in the
> > + * guest's context, instead of the hypervisor/VMM context.
> > + */
> > +static bool hv_is_private_mmio_tdx(u64 addr)
> > +{
> > +	if (wakeup_mailbox_addr && (addr >= wakeup_mailbox_addr &&
> > +	    addr < (wakeup_mailbox_addr + PAGE_SIZE)))
> > +		return true;
> > +	return false;
> > +}
> 
> static inline bool within_page(u64 addr, u64 start)
> {
> 	return addr >= start && addr < (start + PAGE_SIZE);
> }
> 
> static bool hv_is_private_mmio_tdx(u64 addr)
> {
>         return wakeup_mailbox_addr && within_page(addr, wakeup_mailbox_addr)
> }
> 
> Hmm?
> 
> > +
> >  void __init hv_vtl_init_platform(void)
> >  {
> >  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> >  
> > -	x86_platform.realmode_reserve = x86_init_noop;
> > -	x86_platform.realmode_init = x86_init_noop;
> > +	if (wakeup_mailbox_addr) {
> 
> Wants a comment vs. realmode here.

Sorry for the confusion. This patch is not related to real mode. This change is
similar to 88e378d400fa0544d51cf62037e7774d8a4b4379. Current code maps MMIO
devices as shared (decrypted) by default in a confidential computing VM. But the
wakeup mailbox must be accessed as private (encrypted) because all the access to
it are encrypted.

It's my fault to leave the realmode_reserve/realmode_init change here and cause
this confusion. Originally this patch and the real mode patch were included in
one patch. When I splitted them, I wrongly left this change here. Will put it to
the realmode patch on my next submission.

Will address all your other comments on my next submission.

Thank you
--jyh

> 
> > +		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
> > +	} else {
> > +		x86_platform.realmode_reserve = x86_init_noop;
> > +		x86_platform.realmode_init = x86_init_noop;
> > +	}
> >  	x86_init.irqs.pre_vector_init = x86_init_noop;
> >  	x86_init.timers.timer_init = x86_init_noop;
> 
> Thanks,
> 
>         tglx

