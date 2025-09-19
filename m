Return-Path: <linux-hyperv+bounces-6958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1B2B87BBC
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B807A1DA9
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A5923C8C7;
	Fri, 19 Sep 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AS3X14lJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10299221294;
	Fri, 19 Sep 2025 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249629; cv=none; b=W4ETyWPcU5jiM+OweGWthzVjFYgqhyAB/2En7dfO5OQOlYjtbapjAIaXmzkTQMzw5pMBJOBLPebh5QypgG3gmDDTbmU1vmSbBVsEYrSWqKj17Ys7pu3DIjtUlCIUrUM1uw6nxV0uA6uaJ7muFR3CCIe7WhjNwDJILAAXET3qoEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249629; c=relaxed/simple;
	bh=Rz0vS7PBQPgIsMKkeSO+GXnSlq0aqgZpxnHZjHim7EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNeKsTBkdn2AB+iDIAGGT1vwbDmk9GiU8RBpGrHdvcwFmIMbhU5pqHa9wm5Uz9/vqfL2TL6SVGpS4VyjMx7Gs1PCK70CZGDssOO8Sw23Cas8yv747u140dv1WZgxumLADBbOi2I+y4NopGfAhb0KbOpqgDD5ZxnpnwnmucCJvAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AS3X14lJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758249628; x=1789785628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rz0vS7PBQPgIsMKkeSO+GXnSlq0aqgZpxnHZjHim7EY=;
  b=AS3X14lJmg+pZmYPcN5r3bq2uCh7BEgT4yFQ/0XCIFbLAlExdYW9yjIt
   ssPCWqY1urGE8O2HWKDMZddRjV9tVBUUuqzL1uBXZx217frEC8Sk3mmiP
   hxmH6gaBMLItXX0NDq+u8Zm5ocmEm0hpyJZAn6BxAWPcBoRA1ryPbZL5n
   yaroDdTIJxFONwGnpKH2sqmejA+fE4TYaJH9yb9a5jvy4pTrKEd9ElVRd
   9L4aFilMsOJJPB5CeuEyC1eWimpwPn2mN5w5fbYdQ94QWHuw3EbCSyHgF
   fEQoTdAl4XBsGwbkhTDProZlAR1dFN/uFOTfL4XSDnwULqheML2hX/AW5
   Q==;
X-CSE-ConnectionGUID: 4cHiMrmvSdayMBNw9xtatg==
X-CSE-MsgGUID: Sa0KTlAlR4WozYEB/hglQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="71704510"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="71704510"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:40:24 -0700
X-CSE-ConnectionGUID: f94HVOvHT8mi339fwrKh4A==
X-CSE-MsgGUID: ULdPVqC+RWaubeNrPdJRPw==
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:40:23 -0700
Date: Thu, 18 Sep 2025 19:46:14 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [EXTERNAL] [PATCH v5 05/10] x86/hyperv/vtl: Set real_mode_header
 in hv_vtl_init_platform()
Message-ID: <20250919024614.GA9139@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-5-df547b1d196e@linux.intel.com>
 <DS3PR21MB58781CFA8BEFF22D9BA407B1BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS3PR21MB58781CFA8BEFF22D9BA407B1BF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Sep 12, 2025 at 08:43:47PM +0000, Dexuan Cui wrote:
> > From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > Sent: Friday, June 27, 2025 8:35 PM
> >[...]
> > From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > 
> > Hyper-V VTL clears x86_platform.realmode_{init(), reserve()} in
> > hv_vtl_platform_init() whereas it sets real_mode_header later in
> 
> s/hv_vtl_platform_init/hv_vtl_init_platform/

Thanks for catching this. I will correct it.

> 
> otherwise LGTM
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Thank you!

