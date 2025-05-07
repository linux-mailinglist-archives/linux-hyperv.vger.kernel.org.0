Return-Path: <linux-hyperv+bounces-5395-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158CAAD3FD
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 05:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A63587B05F3
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 May 2025 03:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB071C4A17;
	Wed,  7 May 2025 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1r44WmD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65EF1B422A;
	Wed,  7 May 2025 03:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587918; cv=none; b=OvY0hq77uDKAni0S28rxRDWX+cBDwWhHIyCjhHz4Ht5h1f6t0JBOxFJhM6mzS0HFTe+aQSIP0NiRW7aVQjq6sz880cioZ/u4ZcrnF/U4VdW+/MjETJLoQOWPiYbYxxdhnQcJiAsWfv6WvUhdlGCsn0Wqhhnxv1R2HKGL17IXbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587918; c=relaxed/simple;
	bh=0wP1bQljxUQUGrOunL2PMPLMe5TpD0MJuFYd/zpWynM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc985+Bw40Ib0MTm0OGlfzZMbba52zc/zlimZ7WfBCx2C4ZMCioixUeydmJW1bYRbD1KaJJzI5E7FtbSrW0kH63CooQgZ1HM9JhpHUebHsk4Q94J2BhDN1M1HphjFh5BZ31wXvJBpYVbbdKpRJNnteR0rUvh2ChQfDpv0TrGHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1r44WmD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746587916; x=1778123916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0wP1bQljxUQUGrOunL2PMPLMe5TpD0MJuFYd/zpWynM=;
  b=X1r44WmD+ej8EPP+BYa9DffEOEMuZaPsEVmXYuG2LF/0uN6noN8CBZQq
   wZRffzNtPmodXrxvx1TbT5NtN1dvjvWsKejXY9mgVVa6Gp5zszOPxa1Up
   109CikbZZQ9674KYrPOndXNE1Zcc+Cm4nKugZbLOEvPspxO3QIStrTFlT
   9OPzA/IVCXGvDWtk6My/4Ik+lijqPTZkhKK3JTLRvYuHJ11Y5wllCXXl2
   uexaFpAXaDprCYdaf/pJm/MNQejmJ9JqzZrTu1421Lq7BVQkZWJpkcq0E
   3pTsf+cRW7LLxUiAxLXf2oilcV5OQoY3HG4mQixZVSB2DqUoUi1EeLvr1
   w==;
X-CSE-ConnectionGUID: VzYl/c90TdaiF0k99fTJoA==
X-CSE-MsgGUID: 7wt+Rv6nQLWxeL4YqcAC4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="51945575"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="51945575"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 20:18:35 -0700
X-CSE-ConnectionGUID: RUHY0FDlT/CApbLIDCobyQ==
X-CSE-MsgGUID: FcGpM7MtTzCK67BqXHo+Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; 
   d="scan'208";a="135821930"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 20:18:34 -0700
Date: Tue, 6 May 2025 20:23:39 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox
 for Intel processors
Message-ID: <20250507032339.GA27243@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
 <20250504-original-leopard-of-vigor-5702ef@kuoka>
 <20250506051610.GC25533@ranerica-svr.sc.intel.com>
 <20250506-pompous-meaty-crane-97efce@kuoka>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506-pompous-meaty-crane-97efce@kuoka>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, May 06, 2025 at 09:10:22AM +0200, Krzysztof Kozlowski wrote:
> On Mon, May 05, 2025 at 10:16:10PM GMT, Ricardo Neri wrote:
> > > If this is a device, then compatibles specific to devices. You do not
> > > get different rules than all other bindings... or this does not have to
> > > be binding at all. Why standard reserved-memory does not work for here?
> > > 
> > > Why do you need compatible in the first place?
> > 
> > Are you suggesting something like this?
> > 
> > reserved-memory {
> > 	# address-cells = <2>;
> > 	# size-cells = <1>;
> > 
> > 	wakeup_mailbox: wakeupmb@fff000 {
> > 		reg = < 0x0 0xfff000 0x1000>
> > 	}
> > 
> > and then reference to the reserved memory using the wakeup_mailbox
> > phandle?
> 
> Yes just like every other, typical reserved memory block.

Thanks! I will take this approach and drop this patch.

BR,
Ricardo 

