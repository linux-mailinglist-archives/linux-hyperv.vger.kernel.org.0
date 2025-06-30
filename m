Return-Path: <linux-hyperv+bounces-6050-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC2AEDC43
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42AE18977C3
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C028980A;
	Mon, 30 Jun 2025 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkcTPNzJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F161B4F1F;
	Mon, 30 Jun 2025 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285236; cv=none; b=KMLlsg2FZgzduVPgGipRd6OLcWmu/YDhs1XyC0bzm7ComaeRby7WHCMCgljWbMr0m+6GS6u8nyvap5ZYkpPpumSkkaFOGdBPgxD/+IEgJzPmQqBe7y9WQwvJusx/7jbqMQ6hwuIMApD106KF3cMWEI2qkplOZ8koix18qW0gpYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285236; c=relaxed/simple;
	bh=tFpFBYq9nAUYnE7aI5hh3RcO6oDxXyv1fFzFMy4Q53Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVUuCCq57SxD8ODdIe4huYve2yozfq8Hx8+oeki9Rj6Vz2kWzV2zI1/yWKq8Dxf1Pm3Z6kGRb+ol2dSJrw49DoMYKONoTAo1oOiN7+GFa/PsjM+SQpPmxkIsjKKOhJIf9bfF1q2Qh9P4cY8ROwLCP4JBd9GL5b/PJeOpsegIziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WkcTPNzJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751285235; x=1782821235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFpFBYq9nAUYnE7aI5hh3RcO6oDxXyv1fFzFMy4Q53Y=;
  b=WkcTPNzJbOoq15Mp+s8bkg7AQghCEVBTbZVxmKlLOmzxKxa8kYr8qKwE
   TYDHXGustl54SJonBkf54rkhBid9d+o8/S2QtFYNtzdStGgQnE78Dc02N
   +IPPC378vmh2k1Et69aZusS+lHP/pY5VQUKPgvBo7cQhQ/TCKKnYumq65
   jPPsi20hYBrOXaarNLvWQRYJvyByjJaoBQowZP8rkManD5WBveWDvaCz6
   mTrxu4r0i5Sl2A1HAbpKRvkVhaxV7Xa421bY7ky5cIlD2MOengfqsxDa1
   d1ZFAB2RkR2AM5YYECNupD/bdDk1eo6V1qcBlpATZGU+RxoL1J3HV3cne
   A==;
X-CSE-ConnectionGUID: 2MTfMxl0TseYO5ruVS1QWQ==
X-CSE-MsgGUID: heJ0wbPqQmiH/6wJ1vlLGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="52738882"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="52738882"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 05:07:14 -0700
X-CSE-ConnectionGUID: IsbUOMWqR/Ci/yGddpHU0g==
X-CSE-MsgGUID: LDg4V91mSrug1KUkUNwKVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="190609068"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 30 Jun 2025 05:07:10 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 547623AB; Mon, 30 Jun 2025 15:07:08 +0300 (EEST)
Date: Mon, 30 Jun 2025 15:07:08 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Michael Kelley <mhklinux@outlook.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ricardo Neri <ricardo.neri@intel.com>, Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <sh3fz5qlmy2smu74ezibbptxgmlpedzui3c4q6x22jc5w5ik4q@qms3osoxh74t>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
 <20250630110316.GJ1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630110316.GJ1613376@noisy.programming.kicks-ass.net>

On Mon, Jun 30, 2025 at 01:03:16PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 27, 2025 at 08:35:08PM -0700, Ricardo Neri wrote:
> 
> > -	/*
> > -	 * Wait for the CPU to wake up.
> > -	 *
> > -	 * The CPU being woken up is essentially in a spin loop waiting to be
> > -	 * woken up. It should not take long for it wake up and acknowledge by
> > -	 * zeroing out ->command.
> > -	 *
> > -	 * ACPI specification doesn't provide any guidance on how long kernel
> > -	 * has to wait for a wake up acknowledgment. It also doesn't provide
> > -	 * a way to cancel a wake up request if it takes too long.
> > -	 *
> > -	 * In TDX environment, the VMM has control over how long it takes to
> > -	 * wake up secondary. It can postpone scheduling secondary vCPU
> > -	 * indefinitely. Giving up on wake up request and reporting error opens
> > -	 * possible attack vector for VMM: it can wake up a secondary CPU when
> > -	 * kernel doesn't expect it. Wait until positive result of the wake up
> > -	 * request.
> > -	 */
> > -	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> > -		cpu_relax();
> > -
> > -	return 0;
> > -}
> 
> > +	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> > +		cpu_relax();
> > +
> > +	return 0;
> > +}
> 
> So I realize this is just code movement at this point, but this will
> hard lockup the machine if the AP doesn't come up, right?

Correct.

> IIRC we have some timeout in the regular SIPI bringup if the AP doesn't
> respond.

See the comment.

In TDX guest case, we need to consider malicious VMM that can postpone
scheduling the target vCPU indefinitely. It can give VMM indirect control
of what the target would run upon wakeup. Like, it can wait until the
guest do kexec and the same start RIP would point non-startup code.

I hope we will get SIPI-based CPU bringup in TDX guest eventually. It will
be more reliable.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

