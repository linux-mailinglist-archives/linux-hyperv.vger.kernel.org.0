Return-Path: <linux-hyperv+bounces-7268-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FCBEC5EE
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 04:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F206E3DFA
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 02:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A362727EE;
	Sat, 18 Oct 2025 02:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fj9VnqMk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8126E710;
	Sat, 18 Oct 2025 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760755709; cv=none; b=DcU/V69K+vCD4G4T4NL7mlHkpJUABayzE1a1HY4v0s1w3OZvgSaegMNiIfsXnsifgLHGiwaQ7UN+VSlXYUXkmLNF58JOlzeUWHkpTC3IHIFkM+DwVXOSwAZlnAYrCoNnZACAvIjNrYH7EaDxnS7/y2oXyzqt7OWC38iHTZLgBd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760755709; c=relaxed/simple;
	bh=WVWtfKK+vDqGNd+hHo1rvqT82s5arm/ftAiBJiPTr+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkSa+BU5RC3n7GaiCgvVTacLakGNPwyWIZCcs+GUr30rEHha38gNxiQwHKlIvUBGMrsIqRjqZFU3Cbb01YklPsJQGmQTvUH5C9+/PfAXVHeEsdSR1/rpvNmQ7oTkNhkVVQ4WdTUVIEKys+s59Jt70vRbRwcDYe8xe9lPen6n0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fj9VnqMk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760755708; x=1792291708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=WVWtfKK+vDqGNd+hHo1rvqT82s5arm/ftAiBJiPTr+o=;
  b=Fj9VnqMkjBgHMLMvlgVbssXDG6ZVHEoBGpuMe2cq8UwGwEeW4577lF/K
   7dMx+oP5TFt70FBe2LsgeMBxP21UhlYsa+krM/DXLFzCCV/18Eax0vFjo
   bCIVDKnjVEGZs6bthJzmV6tTSc9u0rKA+3bL5SQ7nho3U8H9ns2BT1qot
   K2P/wJJxHj57QpjNMmd8lq9jgEdEqqmOqqXgbcoqBD5CnomCijv4f20yV
   NUi8bHVEr+n9BXL1GpoQn+M6UaXJV2AtC6x+FeelDQoQKGHLT7a/LH8p8
   9FiTRz7tyBvBm4sHaQ8Ffqk1mxDZboREeIvQXOQ9qbZSJfHG4rhGtdGYX
   g==;
X-CSE-ConnectionGUID: x8veFEuHRcOFEVIXcEKGFA==
X-CSE-MsgGUID: yYrF6j1IRICAHz3krMEJjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62876618"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62876618"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 19:48:25 -0700
X-CSE-ConnectionGUID: HgsJk2K+SoekCEz+hIw0lA==
X-CSE-MsgGUID: XIcqlnUtQnKoumUUL92cNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="182512093"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 14:02:44 -0700
Date: Fri, 17 Oct 2025 14:10:15 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v6 01/10] x86/acpi: Add helper functions to setup and
 access the wakeup mailbox
Message-ID: <20251017211015.GA7078@ranerica-svr.sc.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-1-40435fb9305e@linux.intel.com>
 <CAJZ5v0iB4iZFs8C6EZayLVPbLz50MJ9GEniSHfbP31-yHRg1Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iB4iZFs8C6EZayLVPbLz50MJ9GEniSHfbP31-yHRg1Bw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Oct 17, 2025 at 11:46:59AM +0200, Rafael J. Wysocki wrote:
> On Fri, Oct 17, 2025 at 4:48 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > In preparation to move the functionality to wake secondary CPUs up from the
> > ACPI code, add two helper functions.
> >
> > The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
> > the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
> >
> > There is a slight change in behavior: now the APIC callback is updated
> > before configuring CPU hotplug offline behavior. This is fine as the APIC
> > callback continues to be updated unconditionally, regardless of the
> > restriction on CPU offlining.
> >
> > The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
> > mailbox. Use this helper function only in the portions of the code for
> > which the variable acpi_mp_wake_mailbox will be out of scope once it is
> > relocated out of the ACPI directory.
> >
> > The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
> > CONFIG_SMP=y.
> >
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> This should have been
> 
> Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>
> 
> The "(Intel)" part is missing and I omitted it when I sent the tag.
> Sorry for the confusion.

Thanks for the clarification Rafael. Does this clarification apply also
patches 2 and 3?

Also, if no further changes are needed in the series, can it be corrected
when the patches are merged?

