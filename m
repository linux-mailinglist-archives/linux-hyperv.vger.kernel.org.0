Return-Path: <linux-hyperv+bounces-2762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DB94D91F
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Aug 2024 01:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D5A1F22192
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2024 23:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784C116D4DA;
	Fri,  9 Aug 2024 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEwZei4z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01026AE4;
	Fri,  9 Aug 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723246171; cv=none; b=MdUcSLBbh7IdZfKW7+p30O/zIhfoeu9K2WZltWNnO/bV7g79qTsayU85gwHdpv7U2nhDfGe4N5UvJb6in+GjywVkxldqBNGPb134qgtr7rbdfgXQ3IHWu6ZlasttlUSo6Bi7L+/HF6W1y62V0Nkdy9XV1ur1INGN4zN1I7BM9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723246171; c=relaxed/simple;
	bh=t0PCcCq04qC6ZwgyjpVfF+3cDG+djSZndkmy/cwOAJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHCfAgyIBQDUBpX6TJCdyVOyyF9aOTFO2cMBCJdCvU6A9XeQmga99Ry173KHKU3nEkHWPAsdIzci1TVze1Qm5wYFrDKceSxkxeQppcwqciUvnGeHzQvLToZrRTsC9hk5YeBIlPJ7mlXQizzgDzB5NPjwv6B5gibbpDb7lfZ3HGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEwZei4z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723246170; x=1754782170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t0PCcCq04qC6ZwgyjpVfF+3cDG+djSZndkmy/cwOAJc=;
  b=EEwZei4zB+9bj0Lr2C5s6Kv7S2sUhzI79hgfWOVFMRbhn5DS5Dj2i7y3
   KUWlU1RRMqCpthXCH6UKv0O0hA5aJdg3+g6Xz9dCWFT/f1Tgj7YHX7Diw
   G9MmGl0h+ia8JuK4J1Qv2X8z4t6ffOhBVlhrQ3sW/OqYrzOgkE8xGuqqg
   OBncXnY44pPRzPpQ07zdqef+NuDxkNF3RMSUCC2xCIvanytV8RbUDBQsK
   uXOfcY7i3gynOiRRyREeUnyR/VtuXWpJIk0OYA4AxHNaNLUUPlnl9oNic
   JCAiPyD35yjS02L8wCvcA32oIugRaLZBCWYB75/45e1KHcsyFg/3xRool
   A==;
X-CSE-ConnectionGUID: H5O+j3lISDuJPZGrTucxUw==
X-CSE-MsgGUID: 15RPW8bMTsCQc6G8TYK2oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="32829886"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="32829886"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 16:29:30 -0700
X-CSE-ConnectionGUID: qeTveLK/TU+9bL0BsyK2ng==
X-CSE-MsgGUID: zLQtiumFQ4ezGkmOfk85sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62551834"
Received: from unknown (HELO localhost) ([10.79.232.122])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 16:29:29 -0700
Date: Fri, 9 Aug 2024 16:29:28 -0700
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
Subject: Re: [PATCH 2/7] dt-bindings: x86: Add ACPI wakeup mailbox
Message-ID: <20240809232928.GB25056@yjiang5-mobl.amr.corp.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-3-yunhong.jiang@linux.intel.com>
 <ce4903f2-2a9d-45c4-bd4d-ac5165211a83@kernel.org>
 <20240807165658.GA17382@yjiang5-mobl.amr.corp.intel.com>
 <624e1985-7dd2-4abe-a918-78cb43556967@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624e1985-7dd2-4abe-a918-78cb43556967@kernel.org>

On Thu, Aug 08, 2024 at 09:41:16AM +0200, Krzysztof Kozlowski wrote:
> On 07/08/2024 18:56, Yunhong Jiang wrote:
> > On Wed, Aug 07, 2024 at 07:57:43AM +0200, Krzysztof Kozlowski wrote:
> >> On 07/08/2024 00:12, Yunhong Jiang wrote:
> >>> Add the binding to use the ACPI wakeup mailbox mechanism to bringup APs.
> >>
> >> We do not have bindings for ACPI. I think in the past it was mentioned
> >> pretty clear - we do not care what ACPI has in the wild.
> > 
> > Thank you for review.
> > Can you please give a bit more information on "do not have bindings for ACPI"?
> > We don't put the ACPI table into the device tree, but reuse some existing ACPI
> > mailbox mechanism. Is this acceptable for you?
> 
> I understood that rationale behind this patch is "ACPI" thus that reply.
> This one sentence in commit msg is not helping. Entire binding
> description speaks about ACPI, so yeah - I don't care what ACPI does.
> Provide proper explanation/description of firmware or hardware, then
> sure. But the patch saying ACPI is doing something, so bindings will be
> doing the same is for me NAK. Whatever ACPI is doing is never a reason
> alone to do the same in Devicetree.

Thank you for the explanation. I will make the description as ACPI independent.

> 
> Best regards,
> Krzysztof
> 
> 

