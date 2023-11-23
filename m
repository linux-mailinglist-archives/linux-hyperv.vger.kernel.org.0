Return-Path: <linux-hyperv+bounces-1041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAB97F612B
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 15:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2DF1C20F8C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 14:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8594522071;
	Thu, 23 Nov 2023 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bFDa7rYY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD28DD;
	Thu, 23 Nov 2023 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700748806; x=1732284806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i6dlBQVLbMkbONcy1iFh3NN9IB9skLHq2GtmTkDvwpI=;
  b=bFDa7rYYQhVaP7n0o2u9TqxFUZ0FsNkNCfXJb8/wcNHdNSur0lykkiIG
   XTU7mQ8ojwuwuvxy8boWs2FvDrPy8yLz8VQsCXVQIm+wTUGR911Hf+abT
   SDCTNJvy5DQq8ewy+hoOsqCKHCqaopWzNX3anqi4pAU0uzvskM3xFlIZe
   D9SKFwpBVvuvzIo8qqXMvDfLHVOQel4yKObI7kNr3QWr3ecJYiUmynfFf
   0Z52+gDMEmAjRczN9qAxwK5fbXCEFqcpqiMR6/UlRdw1/H2aDWNtUmcXH
   oH1mFMTrUc4OZXzUtjgynliH7S954yvoh2KxvwhIBZ6V3fDchXDBPo0fR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13826094"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="13826094"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="837815344"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="837815344"
Received: from ckochhof-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.117])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:13:20 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 2250410A38A; Thu, 23 Nov 2023 17:13:18 +0300 (+03)
Date: Thu, 23 Nov 2023 17:13:18 +0300
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
Subject: Re: [PATCH v1 2/3] x86/coco: Disable TDX module calls when TD
 partitioning is active
Message-ID: <20231123141318.rmskhl3scc2a6muw@box.shutemov.name>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231122170106.270266-2-jpiotrowski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170106.270266-2-jpiotrowski@linux.microsoft.com>

On Wed, Nov 22, 2023 at 06:01:05PM +0100, Jeremi Piotrowski wrote:
> Introduce CC_ATTR_TDX_MODULE_CALLS to allow code to check whether TDX module
> calls are available. When TD partitioning is enabled, a L1 TD VMM handles most
> TDX facilities and the kernel running as an L2 TD VM does not have access to
> TDX module calls. The kernel still has access to TDVMCALL(0) which is forwarded
> to the VMM for processing, which is the L1 TD VM in this case.

Sounds like a problem introduced by patch 1/3 :/

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

