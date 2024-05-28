Return-Path: <linux-hyperv+bounces-2223-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD7C8D1703
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEC11C22C61
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C086F525;
	Tue, 28 May 2024 09:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxsOeS6W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7917E8F3;
	Tue, 28 May 2024 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887773; cv=none; b=HLSx9EZ07i1T0uCBI2yt0U6kw11v0kO5fOu+xmN6fx/jnnn1InahuTypsph2RGWs0LwBLQZfRLPvV7Oqwn6L8tLw1w7u76LJG0sT80xpqaU3KAKdNmCzjVFjCMzosvQoUpbeonFcMuytsqsr+zv+Hina+ji1GM2t2KMgZxaQryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887773; c=relaxed/simple;
	bh=ODCeOz68Tw5iqfAQ+za+X6Ik/MLNV933HgaQ30waK/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGhwkSraWu2iI7JvBy6r9WE//kq3jyHGpsebgkRXFqkL4rGASUfGgHoGaSJJKU3LZlNWd/aBaRRDEfYqJ79QVMVe0DmUOzDvTS6j8lrcd1zOTp8NiZLX4fCjYv1RQ6daHVvEW5z3yS/C+cDccwOICZeI9tJX18Sp9YsFohxpbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxsOeS6W; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716887772; x=1748423772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODCeOz68Tw5iqfAQ+za+X6Ik/MLNV933HgaQ30waK/4=;
  b=bxsOeS6WEGzt0QHsQEdQA7gDddEgsBm84682Flt11bLuZFnOwBFk1q6I
   mRjev80Gz0meEImcoXmOqyTOzF731XWt/gHsHBUInAv2fD1aJJyu69RZ3
   yljYED4NHf4xRJZ+1AhIQpgR6FdN0j6SyRxriNZSZ/LrjS1Y+jWjP5FFQ
   SRgKC+fgsx8Raun8Ur5aPt77E8VAct9qXFM09YDS2xlR+r9ayH5CK//Er
   oTkXjpFv4qlTRF+htgYIq/rvniHpT+fpTjue3ujMBEREREeqdkt9/hlGX
   cn5LAjf11BRfgMWirFrmopMZ+H5dH5aUC166+zkKFgFMkPsKzBbJwaNLr
   w==;
X-CSE-ConnectionGUID: 6lMTsNc2Q6+sA0lHHqcmaA==
X-CSE-MsgGUID: ZVltBjMyTfCDh7jI82aupQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="23884590"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="23884590"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:16:11 -0700
X-CSE-ConnectionGUID: Om5udNsHS6m98j9lL/vqJg==
X-CSE-MsgGUID: PeGsG56JQ/ehJ5bU6MIA6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="35093312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 28 May 2024 02:16:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 19534184; Tue, 28 May 2024 12:16:05 +0300 (EEST)
Date: Tue, 28 May 2024 12:16:05 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, 
	"luto@kernel.org" <luto@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, 
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>, 
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
	"tytso@mit.edu" <tytso@mit.edu>, "ardb@kernel.org" <ardb@kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: Re: [RFC PATCH] clocksource: hyper-v: Enable the tsc_page for a TDX
 VM in TD mode
Message-ID: <pwwqslpypa4zbyypq25qkvyayu5qpmz7wkjmax7zs6s4f7mr5t@7pf4gq2w6o7u>
References: <20240523022441.20879-1-decui@microsoft.com>
 <299a83e8-cb13-4599-9737-adb3bb922169@intel.com>
 <SA1PR21MB1317CD997CCD64654B438754BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1317CD997CCD64654B438754BFF52@SA1PR21MB1317.namprd21.prod.outlook.com>

On Fri, May 24, 2024 at 08:45:42AM +0000, Dexuan Cui wrote:
> > From: Dave Hansen <dave.hansen@intel.com>
> > Sent: Thursday, May 23, 2024 7:26 AM
> > [...]
> > On 5/22/24 19:24, Dexuan Cui wrote:
> > ...
> > > +static bool noinstr intel_cc_platform_td_l2(enum cc_attr attr)
> > > +{
> > > +	switch (attr) {
> > > +	case CC_ATTR_GUEST_MEM_ENCRYPT:
> > > +	case CC_ATTR_MEM_ENCRYPT:
> > > +		return true;
> > > +	default:
> > > +		return false;
> > > +	}
> > > +}
> > > +
> > >  static bool noinstr intel_cc_platform_has(enum cc_attr attr)
> > >  {
> > > +	if (tdx_partitioned_td_l2)
> > > +		return intel_cc_platform_td_l2(attr);
> > > +
> > >  	switch (attr) {
> > >  	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> > >  	case CC_ATTR_HOTPLUG_DISABLED:
> > 
> > On its face, this _looks_ rather troubling.  It just hijacks all of the
> > attributes.  It totally bifurcates the code.  Anything that gets added
> > to intel_cc_platform_has() now needs to be considered for addition to
> > intel_cc_platform_td_l2().
> 
> Maybe the bifurcation is necessary?

I would like to keep the same code paths for all TDX guests level, if
possible.

> TD mode is different from
> Partitioned TD mode (L2), after all. Another reason for the bifurcation
> is:  currently online/offline'ing is disallowed for a TD VM, but actually
> Hyper-V is able to support CPU online/offline'ing for a TD VM in
> Partitioned TD mode (L2) -- how can we allow online/offline'ing for such
> a VM?

This is going to be fixed by kexec patchset. It was wrong to block offline
based on TDX enumeration. It has to be stopped for MADT wake up method, if
reset vector is not supported.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

