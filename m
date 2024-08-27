Return-Path: <linux-hyperv+bounces-2886-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544D9618AF
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 22:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601A5B22C79
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Aug 2024 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3551D363D;
	Tue, 27 Aug 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnXLVpa8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3445679945;
	Tue, 27 Aug 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791554; cv=none; b=FM/g/j6uEkXuuHO8agp7Z3aHJJiVtbUOcLxrcSARFTqyssz731yfZrDcLiF2Y9KDOnFBXk/iYJmakwtIV5tnvJEV2r5iminhb0baEAEDCmxwSsMNleenxLhGSaAbkoS19Ru8MT7vkfdv6Vwe/QZHAQm/QTDhhvJ2OOS1wOud7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791554; c=relaxed/simple;
	bh=1cA7NWIoKf453mPwbKoIelgbAeoo+9Zyhe+bdYmd4ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKKP0d/es6Z7mgtQtQr3z5PyOaGiTo9PVGNZSbVcLf8VhKUwjVpX0xNabe9mmez/IyOOAaWrYV3ucu6Ev+bk8eBQcKcevLnMugeqtfZ0jiBdqNATOubYYBIguYSp8ZvOTaKxyFaK8R4jBFqR48jH5kUikrfqX05OxxV5azTHApA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnXLVpa8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724791552; x=1756327552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1cA7NWIoKf453mPwbKoIelgbAeoo+9Zyhe+bdYmd4ew=;
  b=LnXLVpa8fbUzWQsJxhDXhWEeknFds5+otnPhFE5YEKFrRGASh4B7Rbgf
   gMvwrx3X11ptl+4rMkK5Q48EsWolfUvXbeVN+TJpS6tyjI5Q9XD9KaPZC
   0iKdWNnTLBA3UtOpWUpDozdLaIeA1jOm4L1Y7sGSxfct1xqQ+Yq9xdYzo
   NMK42JHCuIoJfhr8sLuGm//f744t5eTizyuzTsQMCm8IZVEqex/sMZ4Ru
   vmXtzHqXuQOcZOw0mz2888WDOjGL6VgTCZSIi0kwkJQ4x1cdk0AGoK9eq
   QfWqV9m+o3NfRUszKdNjSVdF31oeCj6KmE18/r69HrGqb+1JpplbJl+aI
   A==;
X-CSE-ConnectionGUID: aB037YuuTfun4p+Pumbl3Q==
X-CSE-MsgGUID: WGAf8Dy1TPqVfVy/eHDa+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="13246653"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="13246653"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:45:51 -0700
X-CSE-ConnectionGUID: g2alJnmwR9KimVAeHOfSng==
X-CSE-MsgGUID: wHEWNCmyRjaVEj+daww94A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="93782943"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.124.129.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:45:50 -0700
Date: Tue, 27 Aug 2024 13:45:49 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
	kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
Message-ID: <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
 <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>

On Sun, Aug 25, 2024 at 09:10:01AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Aug 23, 2024 at 04:23:20PM -0700, Yunhong Jiang wrote:
> > Add the binding to use mailbox wakeup mechanism to bringup APs.
> > 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > ---
> >  .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > new file mode 100644
> > index 000000000000..cb84e2756bca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2024 Intel Corporation
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: x86 mailbox wakeup
> > +maintainers:
> > +  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > +
> > +description: |
> > +  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
> > +  processor (BSP) to wake up application processors (APs) through a wakeup
> > +  mailbox.
> > +
> > +  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
> > +  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
> > +  memory.
> > +
> > +  The wakeup mailbox structure is defined as follows.
> > +
> > +    uint16_t command;
> > +    uint16_t reserved;
> > +    uint32_t apic_id;
> > +    uint64_t wakeup_vector;
> > +    uint8_t  reservedForOs[2032];
> > +
> > +  The memory after reservedForOs field is reserved and OS should not touch it.
> > +
> > +  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
> > +  routine's address into the wakeup_vector field, fill the apic_id field with
> > +  the target AP's APIC_ID, and write 1 to the command field. After receiving the
> > +  wakeup command, the target AP will jump to the wakeup routine.
> > +
> > +  For each AP, the mailbox can be used only once for the wakeup command. After
> > +  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
> > +  this AP.
> > +
> > +  The wakeup mailbox structure and the wakeup process is the same as
> > +  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
> > +  section 5.2.12.19 [1].
> > +
> > +  References:
> > +
> > +  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
> > +
> > +select: false
> 
> This schema is still a no-op because of this false.
> 
> What is the point of defining one property if it is not placed anywhere?
> Every device node can have it? Seems wrong...
> 
> You need to come with proper schema. Lack of an example is another thing
> - this cannot be even validated by the tools. 
> 
> Best regards,
> Krzysztof

Thank you for the feedback. Will update the schema file on next round
submission.

Thanks
--jyh

> 

