Return-Path: <linux-hyperv+bounces-7380-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E02F1C1E6F9
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 06:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CEB3A3976
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Oct 2025 05:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0F528641E;
	Thu, 30 Oct 2025 05:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAFpFgNl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F778F2B;
	Thu, 30 Oct 2025 05:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761802600; cv=none; b=LLteaGLpnIMq8dR9NHMs52j3Lf7oWx+e4nC1iH7hQSR5tP6lAj4kyt4M7GX2YRVzH7Su2PPTCapb6wLKYdc4MLX4RlhJ7jWfUSz+jSzFfs+YxsFTSCDWY0aI6rnucWeozCbQteyWuYp3tqad8LMzLdgcO5cvJHCjaNplJSVx4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761802600; c=relaxed/simple;
	bh=I0DvfS4U97yWtVOK4JDyCuktO+OnCUalK1razNfYHYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWV6W8IcyLam/KvB1fjTZn+ExLE1vfl1wu7ulGC1PnlgP3h0wQY5uEheZFIQlmrknoO2DV2juLjG6bc9VYYEsiWpJjLovL1xshezC0uMjWGLUU3yQHbvSqDPnKRr2TMok/E61DYhVdaiW9QTkXWH3aYtdUDTIb+xT4CC32AZ8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAFpFgNl; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761802599; x=1793338599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I0DvfS4U97yWtVOK4JDyCuktO+OnCUalK1razNfYHYY=;
  b=ZAFpFgNlRyrNqvSS2nGqp0PIjnZdUw7KsOKgKSgwrQvkfSkb8T5r6+Xt
   1ekHqtkSlNc1Qk0LGDpSf87XgXhP4WJidxvEoqCwy4tzSAxdyL1lC/JZO
   Nv2zoGKUVtrY0nPUniv+rMeql1k8nnP9/v6S3L4K0TkExiVhwRk2cBAvh
   MF2DKaT2meWigO4Gjv71Z3kB7BRFg1IDQBdirSTPcYHxef3pPNu0VHyGY
   D5R3/6J0omQj/UELgh1bfRyMc5HIX7Z9iw3xDBqy6uBow7fg1zpdessjf
   iQuC/Ol8S5sEns0AfkudTVZdfSw0/mT5c69dEIJIR7DzYNaN0z08PKyOg
   Q==;
X-CSE-ConnectionGUID: 00A4lAj/TMuM6ki3qc9UWg==
X-CSE-MsgGUID: LU/dPjw+TLe+kVwLsHCPRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="86561957"
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="86561957"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:36:39 -0700
X-CSE-ConnectionGUID: LvGHA+liS02goj4ga5s29g==
X-CSE-MsgGUID: fXa5BMzSQTy9VXuquhwAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="190224388"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 22:36:34 -0700
Date: Wed, 29 Oct 2025 22:43:50 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v6 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <20251030054350.GA17477@ranerica-svr.sc.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
 <20251027205816.GB14161@ranerica-svr.sc.intel.com>
 <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Oct 29, 2025 at 12:13:58PM +0100, Borislav Petkov wrote:
> On Mon, Oct 27, 2025 at 01:58:16PM -0700, Ricardo Neri wrote:
> > Right. All the functions in the file start with the acpi_ prefix. It could
> > be kept under arch/x86/kernel/acpi/. The Kconfig symbol X86_MAILBOX_WAKEUP
> > would have to live in arch/x86/Kconfig as there is no Kconfig file under
> > arch/x86/kernel/acpi. ACPI_MADT_WAKEUP is arch/x86/Kconfig.
> > 
> > Does that sound acceptable?
> 
> Right, this looks kinda weird. You have devicetree thing using ACPI code,
> you're trying to carve it out but then it is ACPI code anyway. So why even do
> that?
> 
> You can simply leave ACPI enabled on that configuration. I don't see yet what
> the point for the split is - saving memory, or...?

I did not want to enable the whole of ACPI code as I need a tiny portion of it.
Then yes, saving memory and having a smaller binary were considerations.

The only dependency that ACPI_MADT_WAKEUP has on ACPI is the code to read and
parse the ACPI table that enumerates the mailbox. (There are a couple of
declarations for CPU offlining that need tweaking if I want ACPI_MADT_WAKEUP to
not depend on ACPI at all).

The DeviceTree firmware only needs the code to wake CPUs up. That is the code
I am carving out.

Having said that, vmlinux and bzImage increase by 4% if I enable ACPI.

Thanks and BR,
Ricardo

