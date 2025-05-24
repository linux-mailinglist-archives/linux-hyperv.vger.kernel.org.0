Return-Path: <linux-hyperv+bounces-5656-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD13FAC2CA7
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 May 2025 02:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35BC4A23665
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 May 2025 00:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A261D798E;
	Sat, 24 May 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2FTt7XS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA4443ABC;
	Sat, 24 May 2025 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748046378; cv=none; b=rJCerW43oxhttl+Gn+q3Q6Ib400q7OyD+CyK/iXwF9q/QEXjge6M+UxjjIuJUvw6PkqhxjnLaTwa5YqkJ0gI88rG/N3Kg6GXIE3PemHnOoLJ6Nyv2iPOW+u9iaatlPEVBLC3/du4ihcemOhO+H83QCyAvhcBvNpaewpl6gxygdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748046378; c=relaxed/simple;
	bh=c4xRZ4ajkNNxv72dim1ZxZUGfsQ36EBupCSDdWIY/PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTDDpDEIgOzowJIL9405e0BpfbXzAiHwXYizwr/JBoemUa626tU0epFXU9zPsJq7pcbpbPPvQBsRitY3kw1/9VL4i5J1Dt8ZzeNm4smTpaGTGQS4J+qXevReqyWYf3VkquYQ56CHQtZCuSmACwmNTe34AFAp0wVcxTMh0YcvMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2FTt7XS; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748046377; x=1779582377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4xRZ4ajkNNxv72dim1ZxZUGfsQ36EBupCSDdWIY/PA=;
  b=K2FTt7XSgcEyD5LoXrF5mMQdFRsahGJUUm5SlBMmhNUrxPIpX+o2N6xA
   dUehrIOpAe4rglrO3CCQuatpeKAqSwSD1HjoUSSrLEZX7r6eVaMHqxHaz
   +TrIMizLP9HjEgtffhvhWYC3G4e3vRExNtCNpsDDNxWTN6Ocq2XBq+lsN
   1rmHB4v/kwvdF+hLPVOQWE+UmvQdedIKN0dHuzdKkLTiuCq/a9/tbiYNM
   eeoIG2OIbWfIRbnxgupi58VoDfHrjAv6Z/811DdQxe7UtkR27tDIFYvKh
   H5M9OiVkOsx8FjfWg1GQ8G3jzBqYlXtoAG5rcSFcB3THkW0ORrCM4QkMg
   A==;
X-CSE-ConnectionGUID: FZgUxdPUT0eEPPTwy4cncw==
X-CSE-MsgGUID: cuvJ1L4uS4qeAVJXzgqTHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="50000204"
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="50000204"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 17:26:16 -0700
X-CSE-ConnectionGUID: lKjs1kwWQbCb34sNPEDhcg==
X-CSE-MsgGUID: 54MpCOBDRCW4FlK24TMHFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="146343293"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 17:26:16 -0700
Date: Fri, 23 May 2025 17:31:20 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 13/13] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Message-ID: <20250524003120.GA15882@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-14-ricardo.neri-calderon@linux.intel.com>
 <SN6PR02MB4157F93812247213DFA922ECD49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157F93812247213DFA922ECD49FA@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, May 20, 2025 at 01:35:02AM +0000, Michael Kelley wrote:
> From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com> Sent: Saturday, May 3, 2025 12:15 PM
> > 
> > The hypervisor is an untrusted entity for TDX guests. It cannot be used
> > to boot secondary CPUs. The function hv_vtl_wakeup_secondary_cpu() cannot
> > be used.
> > 
> > Instead, the virtual firmware boots the secondary CPUs and places them in
> > a state to transfer control to the kernel using the wakeup mailbox.
> > 
> > The kernel updates the APIC callback wakeup_secondary_cpu_64() to use
> > the mailbox if detected early during boot (enumerated via either an ACPI
> > table or a DeviceTree node).
> > 
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  - Unconditionally use the wakeup mailbox in a TDX confidential VM.
> >    (Michael).
> >  - Edited the commit message for clarity.
> > 
> > Changes since v1:
> >  - None
> > ---
> >  arch/x86/hyperv/hv_vtl.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> > index cd48bedd21f0..30a5a0c156c1 100644
> > --- a/arch/x86/hyperv/hv_vtl.c
> > +++ b/arch/x86/hyperv/hv_vtl.c
> > @@ -299,7 +299,15 @@ int __init hv_vtl_early_init(void)
> >  		panic("XSAVE has to be disabled as it is not supported by this module.\n"
> >  			  "Please add 'noxsave' to the kernel command line.\n");
> > 
> > -	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
> > +	/*
> > +	 * TDX confidential VMs do not trust the hypervisor and cannot use it to
> > +	 * boot secondary CPUs. Instead, they will be booted using the wakeup
> > +	 * mailbox if detected during boot. See setup_arch().
> > +	 *
> > +	 * There is no paravisor present if we are here.
> > +	 */
> > +	if (!hv_isolation_type_tdx())
> > +		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
> > 
> >  	return 0;
> >  }
> > --
> > 2.43.0
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thank you very much for your review!

