Return-Path: <linux-hyperv+bounces-6959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D27B87BC2
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 04:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5091894158
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 02:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6502459FD;
	Fri, 19 Sep 2025 02:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a5kAr5h2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150C2264AD;
	Fri, 19 Sep 2025 02:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758249711; cv=none; b=sLYcuS/r46xPWKrk/+WlsMjqqWq/eLFYTikPe7t7lw5eCVZWDUhE8ktJbtFrdz1h6nWs/+Dnwda7qKa0fqZaLjbQZJGUOQEA92Z/dd18YeLudURq2U1uf7C4g7upSsRXkD9vwm4xXJ2gyTqFYFS/KGjdRcZL2kbTwqXUZ63EGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758249711; c=relaxed/simple;
	bh=6xG4xuP98J5/wZamd8W2Oyr/1PetV/Dyo3VkqLNWTck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE2SYtTM4hRaRy1ZbJL+BUR+pK8weTFEimXBDnlv246g/cUPTuQb6o0HL+f2yOUjchT1OTBX2dU1wmH73QFdUgtGbe9woMgf1JiBOlU5pSyRGOhupJ0piZU20LHyChnBikHwTjeOd451Nf9Ry7Qi4AxBz+cXxBdP0DMfDMEdgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a5kAr5h2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758249709; x=1789785709;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6xG4xuP98J5/wZamd8W2Oyr/1PetV/Dyo3VkqLNWTck=;
  b=a5kAr5h2prwjQhRyul2UoEpkJd6pQw34YuxxkXvfeoP9LrIWywNxnp0X
   TaE9JPU0/hJLGwfSbOYrM6n2e7lT4GCY1lo9jHlzz0DcyDhmp/YEstt4c
   QPjhmS4GFEyi024izv/eqPqDketcmbzMx2K+2mwCPJJKrYOPwIJTvupwF
   KCoMEJsyZrpu7WnA4mPKf5o/JMgATTjvnoVTFRzGdYPG46pPKlstZMKm2
   jI3E8TdN86qPW2aN9Qw4AsVB+b9+HvCXABQgWIyS97BavnzuTWN+pQNmG
   4xWR0Tn2x+7ljZzH/cZIKec5249PUBt6/MEK5ZrIpS53Lx9ea6+DyzzOY
   g==;
X-CSE-ConnectionGUID: tsJU4hp3QTiGd9JBgGdJEQ==
X-CSE-MsgGUID: QBlc6D6FS9eabB7PAKfKVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="86032992"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="86032992"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:41:49 -0700
X-CSE-ConnectionGUID: 8mVBPbn0TLSdkRUSgIEVpw==
X-CSE-MsgGUID: YAkvs1+vQUi+Atke9qd2VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="199418711"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:41:48 -0700
Date: Thu, 18 Sep 2025 19:47:39 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [EXTERNAL] [PATCH v5 10/10] x86/hyperv/vtl: Use the wakeup
 mailbox to boot secondary CPUs
Message-ID: <20250919024739.GB9139@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-10-df547b1d196e@linux.intel.com>
 <DS3PR21MB5878BD23A845865D898E3C4DBF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS3PR21MB5878BD23A845865D898E3C4DBF08A@DS3PR21MB5878.namprd21.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Sep 12, 2025 at 08:47:52PM +0000, Dexuan Cui wrote:
> > From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > Sent: Friday, June 27, 2025 8:35 PM
> > [...]
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
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> 
> LGTM
> 
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Thank you for your review!

