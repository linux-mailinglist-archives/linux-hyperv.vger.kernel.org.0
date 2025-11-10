Return-Path: <linux-hyperv+bounces-7486-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0ACC4864E
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 18:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 89AF434A405
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CCE2DBF7C;
	Mon, 10 Nov 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GLIQVvF6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF8727A476;
	Mon, 10 Nov 2025 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796551; cv=none; b=Z5CqbKIYArOE75/vssRWVFCKKwSQTcU/PKlmrfl8uFZWgDHsZJof7fRj+mRa/KeZp1sxram1u8tssoMpmowdsQ59SZS4+w9C/G0slzbq25/9OrsCsApYXjnS/y7vlETxIBYx9YDuVnFTxggzFjsqFpVbqo1z6Bzkizi8wbZL7cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796551; c=relaxed/simple;
	bh=bF0yjEbcevQBWk5oPzqOzKNeEyHOpGbHckyEKO6yX98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+jSf6pLPjnqWC9N9Af+26xoOxkylF+KwBi4YoMNJWB9TJlLYycyagGqs/VGqE7+XwkTfsO1GcifS8dzi7lIAlohMtRFPdXWzdsdU09jsvqjPqAJ2q4uitIzuv2/gw12swWiycAndMyjqWC02YQqgdTSd7wWgtmuqMr67OpDseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GLIQVvF6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762796549; x=1794332549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bF0yjEbcevQBWk5oPzqOzKNeEyHOpGbHckyEKO6yX98=;
  b=GLIQVvF6NuIL36rD4twOazyaWuFRdOAqvAFe/AzQGrGKcx56PLljcNGE
   OqnthdfUdEEIaB7vew6gRc/xwLHzW1QoWx9wMmISqaXk5GYfxNqgfFKHj
   4PfboGKET7hAAbEhBUVcxTvGA94PiQzcgIRKUgVUE8X/62ncZ+EaN0iop
   xbmWNtNJvDsRm28EfqfTWZSZEmHeKx6v6XRjCp763uWft+d+PmrmUvmDM
   5XJbPSWWQZ6IRs0wGDW3j5qltM1egmkp3U4BNZI/Ve+2Lj7ZTQKCz1wdg
   /4yUZaHO0/62WZ1XAgI7vMUkivtBKL3EqtVqdSjLIXELXu1rJoCjpHxwp
   g==;
X-CSE-ConnectionGUID: 2anrqC4tRYCuKRM3vIu/MQ==
X-CSE-MsgGUID: RMTy7dh0R3Gmv+U4h/r7zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64733729"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64733729"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:42:29 -0800
X-CSE-ConnectionGUID: Oz9c1E4GQc6+Fd99ooQCBQ==
X-CSE-MsgGUID: qsdIoRCzSAaLBsSm5qA5jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="219386344"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:42:28 -0800
Date: Mon, 10 Nov 2025 09:49:38 -0800
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
Message-ID: <20251110174938.GA26690@ranerica-svr.sc.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
 <20251016-rneri-wakeup-mailbox-v6-2-40435fb9305e@linux.intel.com>
 <20251027141835.GYaP9_O1C3cms6msfv@fat_crate.local>
 <20251027205816.GB14161@ranerica-svr.sc.intel.com>
 <20251029111358.GDaQH29lURT0p_WWsb@fat_crate.local>
 <20251030054350.GA17477@ranerica-svr.sc.intel.com>
 <20251103134037.GOaQiw1Y6Iu_ENu6ww@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103134037.GOaQiw1Y6Iu_ENu6ww@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Nov 03, 2025 at 02:40:37PM +0100, Borislav Petkov wrote:
> On Wed, Oct 29, 2025 at 10:43:50PM -0700, Ricardo Neri wrote:
> > I did not want to enable the whole of ACPI code as I need a tiny portion of it.
> > Then yes, saving memory and having a smaller binary were considerations.
> > 
> > The only dependency that ACPI_MADT_WAKEUP has on ACPI is the code to read and
> > parse the ACPI table that enumerates the mailbox. (There are a couple of
> > declarations for CPU offlining that need tweaking if I want ACPI_MADT_WAKEUP to
> > not depend on ACPI at all).
> > 
> > The DeviceTree firmware only needs the code to wake CPUs up. That is the code
> > I am carving out.
> > 
> > Having said that, vmlinux and bzImage increase by 4% if I enable ACPI.
> 
> So, is it a concern or not? I cannot understand from the above whether you
> care about 4% or not.

I apologize for my late reply. Also, I am sorry I was not clear. I needed to
consult with a few stakeholders whether they could live with the increase in
size resulting from having CONFIG_ACPI=y. They can.

If it is OK with Rafael, I plan to post a new version that drops this patch and
adds the necessary function stubs for the !CONFIG_ACPI case.

Thanks and BR,
Ricardo

