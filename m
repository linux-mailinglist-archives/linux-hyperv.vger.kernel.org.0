Return-Path: <linux-hyperv+bounces-1040-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E527E7F6125
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 15:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E74B2139A
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E202D608;
	Thu, 23 Nov 2023 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIMNKYce"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C6D47;
	Thu, 23 Nov 2023 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700748682; x=1732284682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+S1rlzshvZ8ftnOlxHsPUzLeZYI4iqYxRU8oFrLAWM=;
  b=VIMNKYcezkSS2StDkb+38iNhfWuVPHBmKtd2W+OfhhNbKJ901fEyuh+A
   1iUXvrW4N/zvTp/o13Uiu9GMIATtsVOXBNwEcNhk9iImSEm1fuCP8Xsxt
   aZT5YZFZXm8Y1kbSxDVLvtfqChU74iRuKqqn0xNwWJo08wLfsRoPsCnbh
   gvkZ8b4f6gvYvS+oMyz+JxuWqb6K6GTNKam+FRbRFr7lGI0rdnRt2OIHO
   euFG0kI+r/RwEQco4XKAuNCbgEoLV/B/QM4AIxW14szEUh0PzRs6TspIu
   cVEzT3nVSNPA9IUcm0e3iy4FjGpPfn8YiVqfSpOJ+aHpzpEH85s5vmFGg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423404280"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="423404280"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760670680"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="760670680"
Received: from ckochhof-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.117])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:11:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 8D51C10A38A; Thu, 23 Nov 2023 17:11:13 +0300 (+03)
Date: Thu, 23 Nov 2023 17:11:13 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Michael Kelley <mhkelley58@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	stefan.bader@canonical.com, tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com, cascardo@canonical.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 3/3] x86/tdx: Provide stub tdx_accept_memory() for
 non-TDX configs
Message-ID: <20231123141113.l3kwputphhj3hxub@box.shutemov.name>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>

On Wed, Nov 22, 2023 at 06:01:06PM +0100, Jeremi Piotrowski wrote:
> When CONFIG_INTEL_TDX_GUEST is not defined but CONFIG_UNACCEPTED_MEMORY=y is,
> the kernel fails to link with an undefined reference to tdx_accept_memory from
> arch_accept_memory. Provide a stub for tdx_accept_memory to fix the build for
> that configuration.
> 
> CONFIG_UNACCEPTED_MEMORY is also selected by CONFIG_AMD_MEM_ENCRYPT, and there
> are stubs for snp_accept_memory for when it is not defined. Previously this did
> not result in an error when CONFIG_INTEL_TDX_GUEST was not defined because the
> branch that references tdx_accept_memory() was being discarded due to
> DISABLE_TDX_GUEST being set.

And who unsets it now?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

