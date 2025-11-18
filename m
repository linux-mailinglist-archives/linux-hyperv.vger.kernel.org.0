Return-Path: <linux-hyperv+bounces-7675-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 440A3C67506
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 06:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5342360B48
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EA22BEFE6;
	Tue, 18 Nov 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlesX1Gf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D071199FAB;
	Tue, 18 Nov 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763442372; cv=none; b=pSuURTOEqHYg2W/n3AxRP/DicssEXjg8eo8vUMxh2KxfZTiwkqqr4wdqVFW7H6YSLNHaBKEARxlo7d83uf/N7JgFCMPbc7Ug2ZAbI7TkY7un65JXcasv2740Pz66jJJ3pmb0XFhKSR4qc16dvQ9o6Uy5Kss4dDj6/3C8UXnorik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763442372; c=relaxed/simple;
	bh=E2/GPLD9LHCJFZXvMhhFzt8//OzHpaDK2dnAn8M667U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWbu4DmsWULwua5aivjIalFHCwMZMXyt859/66g/IvNR2r0vg/G1EpwgeIPKQOGyMsRJeCgPKjU/khVbmVP7rFj9/WgmUJbJYA2dxXGm5KvGU3B9AAFyMsyZQLst1HW5YEBS1bzzr606A3f6aMKkxsyl2pDTniv2NtTgrbtW1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlesX1Gf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763442371; x=1794978371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2/GPLD9LHCJFZXvMhhFzt8//OzHpaDK2dnAn8M667U=;
  b=FlesX1Gf7RxBaoT6OpUbRP5wAWTZUkGS2QpVwxTptlvYhMFQnKNssXfk
   5lF5U7hLNdoN7GRKlKIAuyu7JqGI+RNQKVjcbLIulkrDbf90CFLuNmh0k
   Vxv7OvJIjM6yBTrBsAO+wEhMdF2yD/jfrDn7u5v0zmuRwLcs+xwh0SPao
   nVFL+TgzEVfeuyzKEt8OX/63uH2iYxTjSH86uj+Oq49jt4Dit/WnEeqWV
   km9orCQvke9eGE2nwXKCmAeIIXwvNfCYqgHFI3SHOU4D9tkfYn28o37qC
   CrnNhJauk6w5caaPQTStpFEKlBYHAROlkkVmxO//AnRKOheHYNxGWD1du
   w==;
X-CSE-ConnectionGUID: OQzzHh0VSB+DKfzQYFNNKw==
X-CSE-MsgGUID: zcR/tvHfSxCJTokGPMtNDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69322782"
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="69322782"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 21:06:09 -0800
X-CSE-ConnectionGUID: TUIvc8e2Qd+ynF26oQC03Q==
X-CSE-MsgGUID: QVjn7dujROOjPsWelWPHUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,313,1754982000"; 
   d="scan'208";a="189916436"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 21:06:08 -0800
Date: Mon, 17 Nov 2025 21:13:12 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	"Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 0/9] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot
 secondary CPUs
Message-ID: <20251118051312.GA20802@ranerica-svr.sc.intel.com>
References: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Nov 17, 2025 at 09:02:46AM -0800, Ricardo Neri wrote:
> Hi,
> 
> Many thanks to Boris, Rafael, Rob, and Dexuan for their valuable feedback!
> The main change in this version is the removal of the patch that moved the
> ACPI mailbox code from the x86 ACPI subsystem to a generic location. Users
> with DeviceTree-based firmware who wish use the ACPI wakeup mailbox need to
> select CONFIG_ACPI=y.

Also, this patchset uncovered, IMHO, missing definitions in arch/x86/asm/
topology.h. I posted a patch for that effect here:

https://lore.kernel.org/all/20251117-rneri-topology-cpuinfo-bug-v1-1-a905bb5f91e2@linux.intel.com/

I can repost this patchset along with the patch above if it makes things
easier.

BR,
Ricardo

