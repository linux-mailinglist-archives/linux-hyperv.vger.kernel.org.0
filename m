Return-Path: <linux-hyperv+bounces-6960-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E5B87C1E
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 04:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4314E1370
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Sep 2025 02:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD0258CD8;
	Fri, 19 Sep 2025 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTa9HBGn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2035942;
	Fri, 19 Sep 2025 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250420; cv=none; b=mJJOg8GL4uUNVNh/h6QrQGeSQ82Ku7CgCQz6KclZmR4Wq1f1T9KKFSu3f/VYb+Nn7Jurn43c0LFHTFkucCO5UIPBqFLMfnbraK5hQOB6D1BmMKEUxggq9jktKIQoXFs65DxriovUOkw7qaO8oLtOVibhFaQknxINS7A0S1/0dIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250420; c=relaxed/simple;
	bh=j82TMQoQw7EKWFSP4Sw60PGiritoIjvbYGE4+qDeWww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUTqAeUg4gNVxARfxWnx3DhlycSC+DyVptKiZP5LGH8v7T4ib7jf0pPZsu2b8JCpap1FUo6rFR/LFDGlCUqtUzqbS/Pn5aOf74Lghc48bOCBiqi8dawx6ODFNoC+jlI5aVDGJn7HIJw6v8RJ6AkmU+LG80eHlHNv04uB6gTMbrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTa9HBGn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758250419; x=1789786419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j82TMQoQw7EKWFSP4Sw60PGiritoIjvbYGE4+qDeWww=;
  b=CTa9HBGnkBc5Hfe4CY55jJD+jERKLEfXtzvGipr2/STUwmiflAcELmGX
   qyZLUnODjCW0KuA4O85LNCIVdOifDRwbkqBBjZ/EEGpHor7VSHcb5iLx4
   h0lLNnvs2WY77d+YPIYhMAfqymkU1tsLQhjc5i9zTQNGxWd3lFIznW7oC
   /pzb6CL1L0MqbcGQw5/726o8Ag3sq1xLzzgF0ZxEXq3bBhp4y+YZtB3HV
   +Sk9VwS4mkSZTDyZ0aJgYIsHVoxKoz+qa0TA3PBeoUoN/799sjIC/ERSS
   MAY0E7KfUcLAT9rckwO2VDBDiGDnv1rj+p+Y+5jcPcIRCX1cFsRindkvZ
   A==;
X-CSE-ConnectionGUID: GZz2Ek1nSn+kUmscPoe6Gg==
X-CSE-MsgGUID: UZGboaPnTEiZ6tNUAQIC5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64414305"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64414305"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:53:38 -0700
X-CSE-ConnectionGUID: XyYy/EE/TimXwY7VKuwmQw==
X-CSE-MsgGUID: 4nZwnVAAS7aBonngmyHF9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175328006"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:53:38 -0700
Date: Thu, 18 Sep 2025 19:59:28 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 00/10] x86/hyperv/hv_vtl: Use a wakeup mailbox to boot
 secondary CPUs
Message-ID: <20250919025928.GA9212@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
 <20250820231135.GA24797@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820231135.GA24797@ranerica-svr.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Aug 20, 2025 at 04:11:35PM -0700, Ricardo Neri wrote:
> On Fri, Jun 27, 2025 at 08:35:06PM -0700, Ricardo Neri wrote:
> > Hi,
> > 
> > Here is a new version of this series. Thanks to Rafael for his feedback!
> > I incorporated his feedback in this updated version. Please see the
> > changelog for details.
> > 
> > If the DeviceTree bindings look good, then the patches should be ready for
> > review by the x86, ACPI, and Hyper-V maintainers.
> > 
> > I did not change the cover letter but I included it here for completeness.
> > 
> > Thanks in advance for your feedback!
> 
> Hello,
> 
> I would like to know what else is needed to move this patchset forward.
> Rafael and Rob have reviewed the DeviceTree bindings. Rafael has reviewed
> the relocation of the code that makes use of the mailbox.
> 
> Would it be possible for the Hyper-V maintainers to take a look (Michael
> Kelley has reviewed the patches already)? Perhaps this could increase the
> confidence of the x86 maintainers.

Many thanks Dexuan for reviewing this series. Now that the relevant
subsystem maintainers have reviewed their portions of the series, perhaps
the x86 maintainers could take a look?

Thanks in advance!

BR,
Ricardo

