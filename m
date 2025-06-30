Return-Path: <linux-hyperv+bounces-6059-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F032AAEEA92
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Jul 2025 00:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09803B4E09
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E1D24678B;
	Mon, 30 Jun 2025 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3QCKssD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C7E245012;
	Mon, 30 Jun 2025 22:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323466; cv=none; b=VX8jI2t8HLcAnuFyC4eOGhHeopMgzcgoE1sjRGlJYQlebneyFTsbHEcAVmuHHXRlTJav5f7ReNjwbPaWUP7Hg7dgnstYQxV1xmkgLav7nImDQYs7v03H6walfM/UNqocOvxIyb8wk04JDYuBDl7Lfr/ZTfY7msgm9GKSytarNKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323466; c=relaxed/simple;
	bh=+Uhu5MGMXjBHuO9+G/IohnJoF3U7v/RblPnZRmrlXeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQKJshzoyfMNQDqha6+by5pCY+JHjqm7Wv+M5L3O2YTHVaMoz2LZuE9qpr31/qHGbPlvy4egnmxuABM5T2xT/RU0Q3HQMQUM6baaGUE1/XTyGqlF3xZ3E9kRfLEYTLfgn+0PRAYwRmFNMTt61ijiPGNcDNl3G7h3ll7fdERGB14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3QCKssD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751323465; x=1782859465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+Uhu5MGMXjBHuO9+G/IohnJoF3U7v/RblPnZRmrlXeI=;
  b=L3QCKssDzn/21207/vUx7LifstkpRbxRHKp2SL9S5mlpErab6EQZe7y+
   Saca531IqHJBXlVvBeQrVD1DHhf1p5/khjGa83MOPo3qW0qRnA+6ZRAn3
   pILY+KHJFpUF1hyu8sJZBsHISThOLKIyDab69hhjn+5voVl1GtAWh6wAX
   6jRul2+ZMuIDjUUUqqpXdua6HRJUBPmgq3kdc55iM9tjAxXzZT4Gv+unD
   gVDwFWvcLYZ04hn/gXgjQ6K9KCLNYRIt7K922rsNWZrhL5jAEE+oHqRhg
   ScO8cKJXJvx1Q2757TmnaUjsJxC5p1+NycPvkyW3G0NybOsKTsQdaDxjk
   w==;
X-CSE-ConnectionGUID: HiRxDDssSBu1+glkyM5VYg==
X-CSE-MsgGUID: Cv2mHfhpQHeAUjpMyz7TjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53500761"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53500761"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 15:44:24 -0700
X-CSE-ConnectionGUID: qWUIf+drSYmj2BvlrVV2Ag==
X-CSE-MsgGUID: jRAA2r7YQ/29RRl0B0VkiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="184525973"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 15:44:23 -0700
Date: Mon, 30 Jun 2025 15:50:22 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v5 02/10] x86/acpi: Move acpi_wakeup_cpu() and helpers to
 smpwakeup.c
Message-ID: <20250630225022.GB3072@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250627-rneri-wakeup-mailbox-v5-2-df547b1d196e@linux.intel.com>
 <CAJZ5v0iw9zi8cZK=2j-fWR4tzYgaSMPYoNHf=F+-51cbkxGYSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iw9zi8cZK=2j-fWR4tzYgaSMPYoNHf=F+-51cbkxGYSg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Jun 30, 2025 at 08:58:56PM +0200, Rafael J. Wysocki wrote:
> On Sat, Jun 28, 2025 at 5:35 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > The bootstrap processor uses acpi_wakeup_cpu() to indicate to firmware that
> > it wants to boot a secondary CPU using a mailbox as described in the
> > Multiprocessor Wakeup Structure of the ACPI specification.
> >
> > The platform firmware may implement the mailbox as described in the ACPI
> > specification but enumerate it using a DeviceTree graph. An example of
> > this is OpenHCL paravisor.
> >
> > Move the code used to setup and use the mailbox for CPU wakeup out of the
> > ACPI directory into a new smpwakeup.c file that both ACPI and DeviceTree
> > can use.
> 
> IMV "that can be used by both ACPI and DeviceTree" would sound better.

I have taken your rewording suggestion.

> 
> > No functional changes are intended.
> >
> > Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> With the above addressed
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thank you!

