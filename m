Return-Path: <linux-hyperv+bounces-5367-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BFAABAB0
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF6F4A4DD0
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AAB28980A;
	Tue,  6 May 2025 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dj/WdAve"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567823A9A0;
	Tue,  6 May 2025 05:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508556; cv=none; b=lXsoMUTW6j2RUDlv2vwpG1i9UWjAof/E0PrqNwDgl1hsHdr3aged6bFSF979rkRre2PklD4sgbpIBZYZBQHpDopxLQPcuzR4c5S7T5TzbnL5d4Oh7ia2Nt0Cc94jQfbqjWTS7n2VZHPlt8+VUexY+BmCJ2nzWrUge9cWa5qhz+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508556; c=relaxed/simple;
	bh=hSOe7W1i/TDp0yuPqat8xcNLroQ1jLgwAx6EZl69f20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNSNqhEJ4nUSp5L3T2YZ5TFVW0+MV7zq5hrEhwpDh/yWvGk1ffZkq9lDiTDNKnVmmdpX4DvNLmwpChv08CosgvlpGxtaCsotQseSZUyCvCjfobG7N5gyH6GntWzkVSbqmAfS3LsLiEL50P/Y1/ofKKsRj4ro9JusEcBF+HfLeow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dj/WdAve; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746508555; x=1778044555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hSOe7W1i/TDp0yuPqat8xcNLroQ1jLgwAx6EZl69f20=;
  b=Dj/WdAveBqJ/Y6DVAcXFeONt50N22DPvP6+825PBqFij3kitEAaefy2T
   KjN1W9cg6hrNE6Pv29BUmA3offZbeylZscWu1xu1LDXWZTZ7YWYjHuG+N
   YX6VzBxHnZ9yKtHjeMORBbbZKh0N7smT5tDUtYjZRZxHKzNaerET4MNGs
   WQiZplxwpjnG3ygNBLaxWPx9fn7BDT6ALi9QcIJiPZKtbJe0To+QB9hCP
   bd6dit1c7RW8cYAJUBsn1QCRJvDQQA4lM1w3xpuHKgkW/Oas4mH02V2XY
   NWlZJdBGllHCjft8UaWSffkRnQet2HR/2u1grhydXGgIEeJDBuIZ9+ML/
   w==;
X-CSE-ConnectionGUID: dU0++nSHSyavN5+1cpjGAw==
X-CSE-MsgGUID: g105mdPGQjKXs8yTu1XpQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="58814889"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="58814889"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:15:51 -0700
X-CSE-ConnectionGUID: iwjHzIWVSOmJcGroFQKUrQ==
X-CSE-MsgGUID: soqB6P+WTWCWmEIRMbS2xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="135201369"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:15:50 -0700
Date: Mon, 5 May 2025 22:20:53 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH v3 01/13] x86/acpi: Add a helper function to setup the
 wakeup mailbox
Message-ID: <20250506052053.GD25533@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-2-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0grwGDrwFSbtXzia6ijd4DTOpU3b6RWR4JPfJmXqz78xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0grwGDrwFSbtXzia6ijd4DTOpU3b6RWR4JPfJmXqz78xQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, May 05, 2025 at 11:50:08AM +0200, Rafael J. Wysocki wrote:
> On Sat, May 3, 2025 at 9:10 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > In preparation to move the functionality to wake secondary CPUs up out of
> > the ACPI code, add a helper function that stores the physical address of
> > the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.
> >
> > There is a slight change in behavior: now the APIC callback is updated
> > before configuring CPU hotplug offline behavior. This is fine as the APIC
> > callback continues to be updated unconditionally, regardless of the
> > restriction on CPU offlining.
> >
> > The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
> > CONFIG_SMP=y.
> >
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  - Introduced this patch.
> >
> > Changes since v1:
> >  - N/A
> > ---
> >  arch/x86/include/asm/smp.h         |  4 ++++
> >  arch/x86/kernel/acpi/madt_wakeup.c | 10 +++++++---
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> > index 0c1c68039d6f..3622951d2ee0 100644
> > --- a/arch/x86/include/asm/smp.h
> > +++ b/arch/x86/include/asm/smp.h
> > @@ -146,6 +146,10 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
> >         return per_cpu(cpu_l2c_shared_map, cpu);
> >  }
> >
> > +#ifdef CONFIG_X86_64
> > +void setup_mp_wakeup_mailbox(u64 addr);
> > +#endif

Thank you for your feedback, Rafael!

> 
> The #ifdef is only necessary if you are going to provide an
> alternative for builds in which the symbol is unset.

I see. All callers will be built only with CONFIG_X86_64. I will remove
this #ifdef.

> 
> > +
> >  #else /* !CONFIG_SMP */
> >  #define wbinvd_on_cpu(cpu)     wbinvd()
> >  static inline int wbinvd_on_all_cpus(void)
> > diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> > index f36f28405dcc..04de3db307de 100644
> > --- a/arch/x86/kernel/acpi/madt_wakeup.c
> > +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> > @@ -227,7 +227,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> >
> >         acpi_table_print_madt_entry(&header->common);
> >
> > -       acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
> > +       setup_mp_wakeup_mailbox(mp_wake->mailbox_address);
> 
> I'd prefer acpi_setup_mp_wakeup_mailbox().

Sure. This looks like a more appropriate name.

Thanks and BR,
Ricardo

