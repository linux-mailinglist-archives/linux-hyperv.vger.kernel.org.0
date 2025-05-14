Return-Path: <linux-hyperv+bounces-5496-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE2FAB60F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 04:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC76A19E728C
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 02:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EAD1E5218;
	Wed, 14 May 2025 02:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="glhNtDAv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212491DFE8;
	Wed, 14 May 2025 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191338; cv=none; b=IzqJIamxBX/XYnXUHJcT0PxCyxuiXBDWizVHQeyN1DTzMHFFmtGlfjSLGkdjOLbeNsUi0Yy9Pks6zLP06i2uF8UPDHWmUjnN+7seFt8ZTW1wHEUkzGIBEx88nBma5UjVe5mUUqJEHJKDo1nu9QrWaJv1QSrpyMMUIdWzm1MJHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191338; c=relaxed/simple;
	bh=8WU7JbOh6C0UWBPkkNHuS/Os4UhSVCxmYCsLSjeovik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTqwWhw5NDSiZ3XB3T70CmXedyJbf8MmIs7ovKziBG0aj0Izj041L0fGLTPXq7QqH4rxVMdtWTCU7XRe53FAazFoih+qVF021vPBLHf2ixyPZZx9FumFwXXJrZcbm9MPSElwFWrrwuNsFiTQPaq0MnqTmdTkgzj4IJA5jtxM6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=glhNtDAv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747191336; x=1778727336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8WU7JbOh6C0UWBPkkNHuS/Os4UhSVCxmYCsLSjeovik=;
  b=glhNtDAvKl7+QPnc+78v+7C++U79gjggUnqH4fcpJfpsQjm/ovED52Ej
   itZKYb50zTm1VioH2SEFYwFzoOOFKrdrT03tdAFO9joAIXMUjSeAh8boH
   Z/iHyINvoyH0Ds8COHtVcNq6RHgN2Nu+p4UIJ5UDyb4Tw3CkNcr1kGimf
   VKxV+jLPR+ogVCL+GEPgkexujyufSv8jZeaCS79O/zUlx/RImi6jSoDSl
   695ddg06M1S27nkQOli+StV68djpZpekI7M2PCIHr8/aSYXAbIl7HNPKk
   nVhacrLAZtd5uVd2TAj6uZk68sMJJrESXLe6FlXQ+ywud5IVDtBuORh7r
   Q==;
X-CSE-ConnectionGUID: VAFUKZQtQZ2XNdjHgbB+Fw==
X-CSE-MsgGUID: cVYPm5xfR5qwDrrtUZPfRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="48999419"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="48999419"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 19:55:31 -0700
X-CSE-ConnectionGUID: Lxk1gkQwQy2unYt0HbrQbQ==
X-CSE-MsgGUID: zukZUz2fQBC0dorp8L1SWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="143075326"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 19:55:31 -0700
Date: Tue, 13 May 2025 20:00:38 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Rob Herring <robh@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
Subject: Re: [PATCH v3 05/13] x86/dt: Parse the `enable-method` property of
 CPU nodes
Message-ID: <20250514030038.GA3300@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-6-ricardo.neri-calderon@linux.intel.com>
 <20250512155415.GB3377771-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512155415.GB3377771-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, May 12, 2025 at 10:54:15AM -0500, Rob Herring wrote:
> On Sat, May 03, 2025 at 12:15:07PM -0700, Ricardo Neri wrote:
> > Add functionality to parse and validate the `enable-method` property for
> > platforms that use alternative methods to wakeup secondary CPUs (e.g., a
> > wakeup mailbox).
> > 
> > Most x86 platforms boot secondary CPUs using INIT assert, de-assert
> > followed by a Start-Up IPI messages. These systems do no need to specify an
> > `enable-method` property in the cpu@N nodes of the DeviceTree.
> > 
> > Although it is possible to specify a different `enable-method` for each
> > secondary CPU, the existing functionality relies on using the
> > APIC wakeup_secondary_cpu{ (), _64()} callback to wake up all CPUs. Ensure
> > that either all CPUs specify the same `enable-method` or none at all.
> > 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  - Introduced this patch.
> > 
> > Changes since v1:
> >  - N/A
> > ---
> >  arch/x86/kernel/devicetree.c | 88 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 86 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> > index dd8748c45529..5835afc74acd 100644
> > --- a/arch/x86/kernel/devicetree.c
> > +++ b/arch/x86/kernel/devicetree.c
> > @@ -127,8 +127,59 @@ static void __init dtb_setup_hpet(void)
> >  
> >  #ifdef CONFIG_X86_LOCAL_APIC
> >  
> > +#ifdef CONFIG_SMP
> > +static const char *dtb_supported_enable_methods[] __initconst = { };
> 
> If you expect this list to grow, I would say the firmware should support 
> "spin-table" enable-method and let's stop the list before it starts. 

Actually, I was thinking on dropping this patch altogether. It does not
seem to be needed: if there is a reserved-memory region for the mailbox,
use it. Otherwise, keep using the INIT-!INIT-SIPI messages. No need to
add extra complexity and maintainance burden with checks for an `enable-
method`.

> Look at the mess that's arm32 enable-methods... Considering you have no 
> interrupts, I imagine what you have is not much different from a 
> spin-table (write a jump address to an address)? Maybe it would already 
> work as long as jump table is reserved (And in that case you don't need 
> the compatible or any binding other than for cpu nodes).

Correct, the spin-table is similar to the ACPI mailbox but there are
differences: the latter lets you send a command to control when, if ever,
secondary CPUs are booted.

> 
> OTOH, as the wakeup-mailbox seems to be defined by ACPI, that seems 
> fine to add,

Yes, and Linux for x86 already supports the ACPI mailbox and that code can
be reused.

> but I would simplify the code here to not invite more 
> entries. Further ones should be rejected IMO.

Unconditionally checking for the presence of mailbox works in this sense
too.

> 
> > +
> > +static bool __init dtb_enable_method_is_valid(const char *enable_method_a,
> > +					      const char *enable_method_b)
> > +{
> > +	int i;
> > +
> > +	if (!enable_method_a && !enable_method_b)
> > +		return true;
> > +
> > +	if (strcmp(enable_method_a, enable_method_b))
> > +		return false;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(dtb_supported_enable_methods); i++) {
> > +		if (!strcmp(enable_method_a, dtb_supported_enable_methods[i]))
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +static int __init dtb_configure_enable_method(const char *enable_method)
> > +{
> > +	/* Nothing to do for a missing enable-method or if the system has one CPU */
> > +	if (!enable_method || IS_ERR(enable_method))
> > +		return 0;
> > +
> > +	return -ENOTSUPP;
> > +}
> > +#else /* !CONFIG_SMP */
> > +static inline bool dtb_enable_method_is_valid(const char *enable_method_a,
> > +					      const char *enable_method_b)
> > +{
> > +	/* No secondary CPUs. We do not care about the enable-method. */
> > +	return true;
> > +}
> > +
> > +static inline int dtb_configure_enable_method(const char *enable_method)
> > +{
> > +	return 0;
> > +}
> > +#endif /* CONFIG_SMP */
> > +
> > +static void __init dtb_register_apic_id(u32 apic_id, struct device_node *dn)
> > +{
> > +	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> > +	set_apicid_to_node(apic_id, of_node_to_nid(dn));
> > +}
> > +
> >  static void __init dtb_cpu_setup(void)
> >  {
> > +	const char *enable_method = ERR_PTR(-EINVAL), *this_em;
> >  	struct device_node *dn;
> >  	u32 apic_id;
> >  
> > @@ -138,9 +189,42 @@ static void __init dtb_cpu_setup(void)
> >  			pr_warn("%pOF: missing local APIC ID\n", dn);
> >  			continue;
> >  		}
> > -		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
> > -		set_apicid_to_node(apic_id, of_node_to_nid(dn));
> > +
> > +		/*
> > +		 * Also check the enable-method of the secondary CPUs, if present.
> > +		 *
> > +		 * Systems that use the INIT-!INIT-StartUp IPI sequence to boot
> > +		 * secondary CPUs do not need to define an enable-method.
> > +		 *
> > +		 * All CPUs must have the same enable-method. The enable-method
> > +		 * must be supported. If absent in one secondary CPU, it must be
> > +		 * absent for all CPUs.
> > +		 *
> > +		 * Compare the first secondary CPU with the rest. We do not care
> > +		 * about the boot CPU, as it is enabled already.
> > +		 */
> > +
> > +		if (apic_id == boot_cpu_physical_apicid) {
> > +			dtb_register_apic_id(apic_id, dn);
> > +			continue;
> > +		}
> > +
> > +		this_em = of_get_property(dn, "enable-method", NULL);
> 
> Use typed accessors. of_property_match_string() would be good here. 
> There's some desire to avoid more of_property_read_string() calls too 
> because that leaks un-refcounted DT data to the caller (really only an 
> issue in overlays).

Thanks for this information! However, I plan to scrap this code and
unconditionally use the mailbox if detected.

I would still like to get your inputs on the next submission with updated
code to use the mailbox if you agree.

BR,
Ricardo

