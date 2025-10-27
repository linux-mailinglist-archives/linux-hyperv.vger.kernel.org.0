Return-Path: <linux-hyperv+bounces-7349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F4C116F8
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 21:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650F8566343
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E8C312824;
	Mon, 27 Oct 2025 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9EVhyCS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D552652AF;
	Mon, 27 Oct 2025 20:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761598257; cv=none; b=H6YkXTXsvyZtEWD916rctj1Iy0Cwuc5X5XLEyfF3OkUEzPRd1+O9tleiPcW5iP3KLgH3vwVNUbFVFRYJKK+r4aR+/I4J4yjI7OPBBglV6hSb54WTNR212PluUi4qRNb8Rh0v0PFGpGUrM/JZFjq9M6H5yP85TvNFC/uYByQ7Lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761598257; c=relaxed/simple;
	bh=z+FDoogTKU9c2WL40dpjz8cNG7A5GjItH6nzMZSkZxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rL3kVjc1wP5yRrbGtJVCEinkdiW2Db/OjkRnYEKPUs26Cvf/0yHm7wiXbDQghp/v/ZAVRuzzuctggeImsOMG4M2mg6XPHiPIf2hmpiGwsp/LyG4ryA+3ebplNTghUMbfgxVSRgpskULnt8OvV3BDVmE9XhZOOrc9i3jbV2qtZrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9EVhyCS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761598256; x=1793134256;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+FDoogTKU9c2WL40dpjz8cNG7A5GjItH6nzMZSkZxw=;
  b=R9EVhyCSu7tRsHzkr6GD9jwefFKyRI3uHjYNF3+8Xn1fm80c/kL2IPIu
   ZHbR8WkxuGyc1uFQ/WogJ0HKdbTYp0KJpkbhQeIxzt0/2kC2fdCOJ8/I3
   HsPO0V2oZCxO43+oStrP1SCBjtLq/+Nzs+JwTozNL5rks6TE5AozX9EMv
   lE7WjZk89MfERHeTkqd2mxOlkBkH3CRbdmcoJwPEs/WojWspomas7fN0F
   1jyfQFqTQufasN9WhHJZo76M+XSUoGAe3yhDeDCohAjHWFNwhGesWgavy
   6kxVrURzlLOIy/dugefUzBq4tl2b3+q9aNscLn6PFVcZqjBbFCpFkz/WX
   A==;
X-CSE-ConnectionGUID: VZvgDS6ZRIWnYtVz3lwNoA==
X-CSE-MsgGUID: wdqFpfIkQJSzq4QqAnGBIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75133326"
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="75133326"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:50:55 -0700
X-CSE-ConnectionGUID: P97fmo4ATamgPOVbmizedg==
X-CSE-MsgGUID: LKd5bah5QcWJEkcg/3BWVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,259,1754982000"; 
   d="scan'208";a="190351070"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 13:50:55 -0700
Date: Mon, 27 Oct 2025 13:58:16 -0700
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
Message-ID: <20251027205816.GB14161@ranerica-svr.sc.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Oct 27, 2025 at 03:18:35PM +0100, Borislav Petkov wrote:
> On Thu, Oct 16, 2025 at 07:57:24PM -0700, Ricardo Neri wrote:
> >  arch/x86/kernel/acpi/madt_wakeup.c | 76 ----------------------------------
> >  arch/x86/kernel/smpwakeup.c        | 83 ++++++++++++++++++++++++++++++++++++++
> 
> How does ACPI-related code belong in the arch/x86/kernel/ hierarchy?
> 
> Not to mention that arch/x86/kernel/ is a dumping ground for everything *and*
> the kitchen sink so we should not put more crap in there...

Right. All the functions in the file start with the acpi_ prefix. It could
be kept under arch/x86/kernel/acpi/. The Kconfig symbol X86_MAILBOX_WAKEUP
would have to live in arch/x86/Kconfig as there is no Kconfig file under
arch/x86/kernel/acpi. ACPI_MADT_WAKEUP is arch/x86/Kconfig.

Does that sound acceptable?

Thank you for your feedback, Boris,

Best,
Ricardo

