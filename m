Return-Path: <linux-hyperv+bounces-4842-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A974A823FD
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BB37B05D8
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7DD25523F;
	Wed,  9 Apr 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wuv6sRTX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148201DF25D;
	Wed,  9 Apr 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199352; cv=none; b=IImdF7ATSlejN9WCtaB3/wftfJ9D/u39yGnDt9a0l30KX1027moQRkv3vBf87scs6kW6Bv7Nh1wlCD5YxA5K3Fbf5uAAbVAGUSfVUMWQee0cnE5s8yoAtHMoghcLFSJ6JTLOrsccp+OEhMquozxGSBqTF6X5mLaXUzMDa/Y6VTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199352; c=relaxed/simple;
	bh=b89AxCC0or7u4BnPQBzKZbFr3LbSbaCir0htR+5n8Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/N6dQ6YE3vXYPE4dvmrda4Rjsya+lOk05TKLr/mtn1T/PF3dFlkot0fmNxdQC0ig+pviToJNb3qfnu5eQmhifG/DH1Cz9bVV0sc2DYNjYrdUiFj6g4fiZK0NGEeYIA1GPbHdWeWLx17ljRW6OIxL2CAYIJWRwEh8hoaLjxeffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wuv6sRTX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744199351; x=1775735351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b89AxCC0or7u4BnPQBzKZbFr3LbSbaCir0htR+5n8Bg=;
  b=Wuv6sRTXKRP3Lz8RWlnprEyG6E3BF3nS9x2OMHXDde0DOmDDifGxRR+7
   qmMMjL7+/wciig1XLzSK0DqkKcnXwxTnTxZU41W+Ua1B/R91kXHqyUxf7
   cc9l9Ls9F11qTjEqDD3ClQa7zKbltMxsMeegXnumz0saT9wDfWNgNL+LL
   depsR2yd8TdmIpABggz8Ew/lHiS7LVKiYqW3ozIJaHeV2I0+xP1YyJss5
   FAwj0RDSy07LvwJWkoQvqhd2867z922kzE2VXvzP0G5Tqlu7Nq3npeU0M
   /nuQVcBB46Rox1O1L7MXqSx5rXwPSXdw8vQBR1cYQcu+xx1fhazWOUP64
   Q==;
X-CSE-ConnectionGUID: eG3KtPMiTHi6HkTVDji0WA==
X-CSE-MsgGUID: BjNtLWf9RUGGvs3t2VDIPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63067311"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="63067311"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 04:49:10 -0700
X-CSE-ConnectionGUID: u2zyH/jVQKaveoc+s3fo7g==
X-CSE-MsgGUID: cOSZSGWeTsa7lCiW7CGzpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="165780107"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 09 Apr 2025 04:49:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3BF64541; Wed, 09 Apr 2025 14:49:02 +0300 (EEST)
Date: Wed, 9 Apr 2025 14:49:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
	Jonathan.Cameron@huawei.com, allenbh@gmail.com, d-gole@ti.com,
	dave.jiang@intel.com, haiyangz@microsoft.com, jdmason@kudzu.us,
	kristo@kernel.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
	logang@deltatee.com, manivannan.sadhasivam@linaro.org,
	martin.petersen@oracle.com, maz@kernel.org, mhklinux@outlook.com,
	nm@ti.com, ntb@lists.linux.dev, peterz@infradead.org,
	ssantosh@kernel.org, wei.huang2@amd.com, wei.liu@kernel.org
Subject: Re: commit 7b025f3f85ed causes NULL pointer dereference
Message-ID: <Z_ZeraOgM0d-WMus@black.fi.intel.com>
References: <20250408120446.3128-1-spasswolf@web.de>
 <87iknevgfb.ffs@tglx>
 <87friivfht.ffs@tglx>
 <f303b266172050f2ec0dc5168b23e0cea9138b01.camel@web.de>
 <87a58qv0tn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a58qv0tn.ffs@tglx>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 08, 2025 at 10:46:12PM +0200, Thomas Gleixner wrote:
> On Tue, Apr 08 2025 at 18:20, Bert Karwatzki wrote:
> > Am Dienstag, dem 08.04.2025 um 17:29 +0200 schrieb Thomas Gleixner:
> >> > Can you please decode the lines please via:
> >> >
> >> >     scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
> >> >     scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280

Also hit this, bisected to this change and in my case it's Clang 19.

> > I had to recompile with CONFIG_DEBUG_INFO=Y, and reran the test, the calltrace
> > is identical.
> >
> > $ scripts/faddr2line vmlinux msi_domain_first_desc+0x4/0x30
> > msi_domain_first_desc+0x4/0x30:
> > msi_domain_first_desc at kernel/irq/msi.c:400
> >
> > So it seems msi_domain_first_desc() is called with dev = NULL.
> 
> Yup
> 
> > $ scripts/faddr2line vmlinux msix_setup_interrupts+0x23b/0x280
> > msix_setup_interrupts+0x23b/0x280:
> > msix_update_entries at drivers/pci/msi/msi.c:647 (discriminator 1)
> 
> Aaarg. The patch below should fix that.

Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



