Return-Path: <linux-hyperv+bounces-4652-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A6A6AF2C
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 21:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7A217D716
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Mar 2025 20:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650B2288E3;
	Thu, 20 Mar 2025 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFR5E6BQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323552A1A4;
	Thu, 20 Mar 2025 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742502549; cv=none; b=gEYg6oWr1/kdH9MG0iB8geQSBfKaADl+cELMOmvj4O4MTgTE3j+LTARcm25gStxEAN2JmgrHCKzioYOW9+9R0g8s74h5jR9s1GJ7Rm51fNXpxpG5D7QNTd3XpnQmyimz2gf0w1CjkqGXmjxvCIK0ch6ohT4XLmBjcCUgmWVoZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742502549; c=relaxed/simple;
	bh=/A7i/1Uro6h6eIUjAdKuaXPvRrA3wGaUjO4OFnhofeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtWS7TflIo/6uY/ru6x5u8cUoPfj3KZXtvUsESNUSzIswrNO0uSE0hJ/r52Pshcnb3WXPrO5Gs+UjJR4PUH/cXGXdxqT7z9+qjLYIVkJLiklh83DZOViW6hjeCdtqh5aKx/eLXjsgIz8Af2iPTj9Prf7O7GBfT76PJMdVyCxiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFR5E6BQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742502547; x=1774038547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/A7i/1Uro6h6eIUjAdKuaXPvRrA3wGaUjO4OFnhofeM=;
  b=gFR5E6BQkeWuoPW9RqJAX0QSTbjHWq7anj9p94nVASl0lA1+/SbQLYQr
   bNETSC6nxylpk4c8dMiq+78mDZV5j5YbOPUNSqbhPU06BwlsYuchpEfzP
   2KnyFkt0bWLOyYOSErdLnGJ136uT8FWVBnLBwqDqSaMMmZo7Vj2doGJNd
   dRKLb5fHHYS8BjKJnGSnHh1Ujvt2F6/KMK+Ekb7iTDN423xl3WBelemSh
   t9a6ncU5EzoqR+ydJJ2VyjntF7IkhS/cCEqEZ8wET2yf6CYeYyk4VForK
   gTXALtEiDbJft6ggk2A7Gb5RNznxx7Wk1w1WbTZ9OGLzNLPmEqsb6zmBF
   A==;
X-CSE-ConnectionGUID: v/SpxdCBS4mPPxJ1l+UoYw==
X-CSE-MsgGUID: XyxZxKqmSMy33vGqH3ok5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43641584"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43641584"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 13:29:06 -0700
X-CSE-ConnectionGUID: zWGEOKDhRA6107exREHPMQ==
X-CSE-MsgGUID: mqxpcH5pQA2dGiRObZSJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="122921213"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 13:29:06 -0700
Date: Thu, 20 Mar 2025 13:34:51 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yunhong Jiang <yunhong.jiang@linux.intel.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
	lenb@kernel.org, kirill.shutemov@linux.intel.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
	ricardo.neri@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup
 mailbox
Message-ID: <20250320203451.GA8338@ranerica-svr.sc.intel.com>
References: <ujfqrllrii6iijlhbwx3bltpjogiosw4xx5pqbcddgpxjobrzh@xqqrfxi5lv3i>
 <20240827204549.GA4545@yjiang5-mobl.amr.corp.intel.com>
 <20240910061227.GA76@yjiang5-mobl.amr.corp.intel.com>
 <1d0ba3fc-1504-4af3-a0bc-fba86abe41e8@kernel.org>
 <20240919191725.GA11928@yjiang5-mobl.amr.corp.intel.com>
 <874d5908-f1db-412f-96a2-83fcebe8dd98@kernel.org>
 <20250303222102.GA16733@ranerica-svr.sc.intel.com>
 <acb5fa11-9dce-44d0-85e3-e67a6a10c48f@kernel.org>
 <20250312055118.GA29492@ranerica-svr.sc.intel.com>
 <17d37eab-2275-49ff-97b9-6b6706756f04@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d37eab-2275-49ff-97b9-6b6706756f04@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Mar 19, 2025 at 08:52:37AM +0100, Krzysztof Kozlowski wrote:
> On 12/03/2025 06:51, Ricardo Neri wrote:
> > On Tue, Mar 11, 2025 at 11:01:28AM +0100, Krzysztof Kozlowski wrote:
> >> On 03/03/2025 23:21, Ricardo Neri wrote:
> >>> On Fri, Sep 20, 2024 at 01:15:41PM +0200, Krzysztof Kozlowski wrote:
> >>>
> >>> [...]
> >>>  
> >>>> enable-method is part of CPUs, so you probably should match the CPUs...
> >>>> I am not sure, I don't have the big picture here.
> >>>>
> >>>> Maybe if companies want to push more of bindings for purely virtual
> >>>> systems, then they should first get involved more, instead of relying on
> >>>> us. Provide reviews for your virtual stuff, provide guidance. There is
> >>>> resistance in accepting bindings for such cases for a reason - I don't
> >>>> even know what exactly is this and judging/reviewing based on my
> >>>> practices will no be accurate.
> >>>
> >>> Hi Krzysztof,
> >>>
> >>> I am taking over this work from Yunhong.
> >>>
> >>> First of all, I apologize for the late reply. I will make sure
> >>> communications are timely in the future.
> >>>
> >>> Our goal is to describe in the device tree a mechanism or artifact to boot
> >>> secondary CPUs.
> >>>
> >>> In our setup, the firmware puts secondary CPUs to monitor a memory location
> >>> (i.e., the wakeup mailbox) while spinning. From the boot CPU, the OS writes
> >>> in the mailbox the wakeup vector and the ID of the secondary CPU it wants
> >>> to boot. When a secondary CPU sees its own ID it will jump to the wakeup
> >>> vector.
> >>>
> >>> This is similar to the spin-table described in the Device Tree
> >>> specification. The key difference is that with the spin-table CPUs spin
> >>> until a non-zero value is written in `cpu-release-addr`. The wakeup mailbox
> >>> uses CPU IDs.
> >>>
> >>> You raised the issue of the lack of a `compatible` property, and the fact
> >>> that we are not describing an actual device.
> >>>
> >>> I took your suggestion of matching by node and I came up with the binding
> >>> below. I see these advantages in this approach:
> >>>
> >>>   * I define a new node with a `compatible` property.
> >>>   * There is precedent: the psci node. In the `cpus` node, each cpu@n has
> >>
> > 
> > Thanks for your feedback!
> > 
> >> psci is a standard. If you are documenting here a standard, clearly
> >> express it and provide reference to the specification.
> > 
> > It is not really a standard, but this mailbox behaves indentically to the
> > wakeup mailbox described in the ACPI spec [1]. I am happy reference the
> > spec in the documentation of the binding... or describe in full the
> > mechanism of mailbox without referring to ACPI. You had indicated you don't
> > care about what ACPI does [2].
> 
> Behaving like ACPI and implementing a spec are two different things. The
> question is whether you need to implement it like that and I believe
> answer is: no.
> 
> > 
> > In a nutshell, the wakeup mailbox is similar to the spin table used in ARM
> > boards: it is reserved memory region that secondary CPUs monitor while
> > spinning.
> > 
> >>
> >>
> >>>     an `enable-method` property that specify `psci`.
> >>>   * The mailbox is a device as it is located in a reserved memory region.
> >>>     This true regardless of the device tree describing bare-metal or
> >>>     virtualized machines.
> >>>
> >>> Thanks in advance for your feedback!
> >>>
> >>> Best,
> >>> Ricardo
> >>>
> >>> (only the relevant sections of the binding are shown for brevity)
> >>>
> >>> properties:
> >>>   $nodename:
> >>>     const: wakeup-mailbox
> >>>
> >>>   compatible:
> >>>     const: x86,wakeup-mailbox
> >>
> >> You need vendor prefix for this particular device. If I pointed out lack
> >> of device and specific compatible, then adding random compatible does
> >> not solve it. I understand it solves for you, but not from the bindings
> >> point of view.
> > 
> > I see. Platform firmware will implement the mailbox. It would not be any
> > specific hardware from Intel. Perhaps `intel,wakeup-mailbox`?
> > 
> >>
> >>>
> >>>   mailbox-addr:
> >>>     $ref: /schemas/types.yaml#/definitions/uint64
> >>
> >> So is this some sort of reserved memory?
> > 
> > Yes, the mailbox is located in reserved memory.
> 
> 
> Then why reserved memory bindings are not working?
> 
> Anyway this was half a year ago. None of the emails are in my inbox.
> None of the context is in my head.
> 
> It's the second or third email this month someone responds to my email
> from 2024.
> 
> Frankly, that's a neat trick. I won't remember anything, but it would be
> impolite to say just "no" without arguments. So now you will resend the
> same code leading to the same discussions we had half a year ago. Or
> ignoring that discussions.
> 
> I don't understand why this should be reviewers problem, so no, that's
> just unfair.
> 

Thank you again for your feedback. I will send a third version of the
patchset. This will give the full context. I will incorporate your feedback
in such version.

Thanks and BR,
Ricardo


