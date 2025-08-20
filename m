Return-Path: <linux-hyperv+bounces-6568-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 666B8B2E86D
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Aug 2025 01:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12CFA4E23A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Aug 2025 23:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4E52BE64E;
	Wed, 20 Aug 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C4dCd2Um"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363C36CE0E;
	Wed, 20 Aug 2025 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731121; cv=none; b=XuhoBn2GF1938/rTP+q7Qh9vFeS6Cz74T352gX7IfXnGNlxWvGzkrtxYWNM+eJv2xLwYBm/mmnyRj9qJxsT1B7+F4D4xB6MAy+qMbq3TI7SgS6H+ns7a5GlAujkv1QCBE08oxp642Rz1UlXBgFRtusEIz/gioJHxAjV13nkUzQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731121; c=relaxed/simple;
	bh=nr1/ZpykDzY/GfAUTO5xatJNE5SpOD44gVut+/do0Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ20umf9qI5kGr0u9doN/ic0W1hNg7+JVWz/0BszMzHh/USkUTcaPVekw9861m7K9i42gESMJDkYRGcb4tPAjI7Ujygo3xS8is1QpAVjLP6LXisBpr5GSstmDdp744OZmC2M6EbqONv2LFGF/trAasZSLgj5SSY5gJ0gGLFH0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C4dCd2Um; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755731120; x=1787267120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nr1/ZpykDzY/GfAUTO5xatJNE5SpOD44gVut+/do0Kk=;
  b=C4dCd2UmGtXN46RBBUSBVDEY8Z5B2iM72k6mkDEMCRSDUg97eqhUcanL
   mviEzwdLiW9w01FJkT//Pewebf6ziyIkmzcGMNYdht0penIZvhe2WpFGU
   3UPaY/I95+lz5mrbXjIYYkFAOtc9sqZVYsPHVWyMFkxgfr4oKVQbgou8p
   h4mPnoEmmiLvHKd6ESCIOmKDzL/ItV61U/vqRRottMZG27CRmHsWR7Msn
   YXqFntiVkyYUo+XCW6uHE8t0lD76hEh8LpOybV8mYuQUz2CT7px8dEnML
   ID0ciV40alN9Hl0TKR28yDjkEDmXBCBaM72TyQ74pky+Mbz/tw7zvMbA+
   Q==;
X-CSE-ConnectionGUID: xsPSMkO4RdGgeJ90vBOHng==
X-CSE-MsgGUID: qayqUP8GT3mcse3M6xmQKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58080239"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58080239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 16:05:19 -0700
X-CSE-ConnectionGUID: 5wTcD2vyQQmnoR1aFrmA/A==
X-CSE-MsgGUID: D3ukZWbfTly7d+vDz1QS3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199234003"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 16:05:18 -0700
Date: Wed, 20 Aug 2025 16:11:35 -0700
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
Message-ID: <20250820231135.GA24797@ranerica-svr.sc.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Jun 27, 2025 at 08:35:06PM -0700, Ricardo Neri wrote:
> Hi,
> 
> Here is a new version of this series. Thanks to Rafael for his feedback!
> I incorporated his feedback in this updated version. Please see the
> changelog for details.
> 
> If the DeviceTree bindings look good, then the patches should be ready for
> review by the x86, ACPI, and Hyper-V maintainers.
> 
> I did not change the cover letter but I included it here for completeness.
> 
> Thanks in advance for your feedback!

Hello,

I would like to know what else is needed to move this patchset forward.
Rafael and Rob have reviewed the DeviceTree bindings. Rafael has reviewed
the relocation of the code that makes use of the mailbox.

Would it be possible for the Hyper-V maintainers to take a look (Michael
Kelley has reviewed the patches already)? Perhaps this could increase the
confidence of the x86 maintainers.

Thanks!

Ricardo

