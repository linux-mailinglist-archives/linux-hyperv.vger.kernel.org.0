Return-Path: <linux-hyperv+bounces-2996-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B267972950
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 08:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DE1C222E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Sep 2024 06:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34E7170A2E;
	Tue, 10 Sep 2024 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liThnj3C"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B91CD1F;
	Tue, 10 Sep 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948806; cv=none; b=A3lW/2KqaST98xNXn5xKeClUoJFPC3W2l2l/0vD73NtzOOBAzhfsESgVwJUOMga+w4RRuboW8mam5R3az4r+2rjC3kBcf62yOh3aNqTq8Ct6T+yOo1xv28WXuKfhtl+ZLqE0ieNYKeXOWpEJH+fVLJUtDh3phXWHt6Q3O1bvCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948806; c=relaxed/simple;
	bh=nP3dbTmnW9Jo6LEMnVuvysQouJEbu7BMzkCTla3SEwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQD2yXz5qr9XACK9TXRJtha0C8l3ZprpE4vu98Vob13/BByF4peQvWpKqSlbcKwYrsmbPjtudlIX2JpsLdVMrTok0G16mbWnr+HPNvEVX9S7PFdbWyF/2Vwqc9P1qFwJY0NxIznevko8ers4lFd0FsEGekv6BHc4Ojj7de1ZuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liThnj3C; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725948805; x=1757484805;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nP3dbTmnW9Jo6LEMnVuvysQouJEbu7BMzkCTla3SEwI=;
  b=liThnj3CKO1fkwsn4mjU+0buMsB5WUKqjYJB+yt8PeS4IvOX8kX9+KGT
   mHqaQI+Z0WRjsdPmcD1GvrGoVlUEDEq2s1Zl4p3iHXXuPa49D3WwkCzCq
   KFn4sKqKCzlFaPaH3PW2FFNM4JIWBgvDvBd9adiDynieNUw4u7mgEwMbF
   ETpYDWXLLy0/6O32Cy6lBnWWVWPXLLMRDxiBvK6UgyR0w/CWCbci2QI67
   avjXwEEcaarntcci4zvaZhPJf3upVf+zY0IvhSjMR9Fhev5zY9BKp49wC
   G8S+kRh9sLUYzNPZqXTpKZ6fSvhuar/NBUxUNGLWp+99ca7Tr9qlxvLe9
   Q==;
X-CSE-ConnectionGUID: G1y3zHakTGqWWEJOFdCyWw==
X-CSE-MsgGUID: ohNcfbgISaK7IXoWVniJYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24177058"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="24177058"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:13:24 -0700
X-CSE-ConnectionGUID: 6QGfVu/6SPqrHGcD0SFmag==
X-CSE-MsgGUID: oLfrut1BSaKLrNGDsdP8bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="104378886"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.124.87.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 23:13:22 -0700
Date: Mon, 9 Sep 2024 23:13:21 -0700
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
Message-ID: <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
 <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
 <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
 <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>

On Tue, Aug 27, 2024 at 01:45:49PM -0700, Yunhong Jiang wrote:
> On Sun, Aug 25, 2024 at 09:10:01AM +0200, Krzysztof Kozlowski wrote:
> > On Fri, Aug 23, 2024 at 04:23:20PM -0700, Yunhong Jiang wrote:
> > > Add the binding to use mailbox wakeup mechanism to bringup APs.
> > > 
> > > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > ---
> > >  .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
> > >  1 file changed, 64 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > > new file mode 100644
> > > index 000000000000..cb84e2756bca
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
> > > @@ -0,0 +1,64 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2024 Intel Corporation
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/x86/wakeup.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: x86 mailbox wakeup
> > > +maintainers:
> > > +  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > > +
> > > +description: |
> > > +  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
> > > +  processor (BSP) to wake up application processors (APs) through a wakeup
> > > +  mailbox.
> > > +
> > > +  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
> > > +  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
> > > +  memory.
> > > +
> > > +  The wakeup mailbox structure is defined as follows.
> > > +
> > > +    uint16_t command;
> > > +    uint16_t reserved;
> > > +    uint32_t apic_id;
> > > +    uint64_t wakeup_vector;
> > > +    uint8_t  reservedForOs[2032];
> > > +
> > > +  The memory after reservedForOs field is reserved and OS should not touch it.
> > > +
> > > +  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
> > > +  routine's address into the wakeup_vector field, fill the apic_id field with
> > > +  the target AP's APIC_ID, and write 1 to the command field. After receiving the
> > > +  wakeup command, the target AP will jump to the wakeup routine.
> > > +
> > > +  For each AP, the mailbox can be used only once for the wakeup command. After
> > > +  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
> > > +  this AP.
> > > +
> > > +  The wakeup mailbox structure and the wakeup process is the same as
> > > +  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
> > > +  section 5.2.12.19 [1].
> > > +
> > > +  References:
> > > +
> > > +  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
> > > +
> > > +select: false
> > 
> > This schema is still a no-op because of this false.
> > 
> > What is the point of defining one property if it is not placed anywhere?
> > Every device node can have it? Seems wrong...
> > 
> > You need to come with proper schema. Lack of an example is another thing
> > - this cannot be even validated by the tools. 
> > 
> > Best regards,
> > Krzysztof

Hi, Krzysztof, I'm working to address your comments and have some questions.
Hope to get help/guide from your side.

For the select, the writing-schema.rst describes it as "A json-schema used to
match nodes for applying the schema" but I'm a bit confused. In my case, should
it be "cpus" node? Is there any code/tools that uses this property, so that I
can have a better understanding?

For your "validated by the tools", can you please share the tools you used to
validate the schema? I used "make dt_binding_check" per the
submitting-patches.rst but I think your comments is about another tool.

Sorry for the bothering. I read the DT spec and the
Documentation/devicetree/bindings documents and still not sure.

Than you
--jyh

> 
> Thank you for the feedback. Will update the schema file on next round
> submission.
> 
> Thanks
> --jyh
> 
> > 
> 

