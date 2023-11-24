Return-Path: <linux-hyperv+bounces-1043-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86D7F70CF
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 11:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054C1281709
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E471803D;
	Fri, 24 Nov 2023 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGQv4CNM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44010F0;
	Fri, 24 Nov 2023 02:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700820395; x=1732356395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohoDw7JZUTv1RjPou6a4xNAn3GHL7KxVPsE5YzKJdKk=;
  b=BGQv4CNMGbgTkzoYhne64szpj0gFZ4rf9vxH0sYOFl0YPUwjFfRlWi39
   0DdYL77ZHNX5S9yHHALJn+WN6vIx8YHX+DWK167DvqKl3icE3aPCWVz65
   laLujl9Fjk8oBNmn4jVGD9SRZ6P1Lb+cbOwXe4PSzrf8qpUzK/veEH1uI
   LNLoQ39NehRXspUQIX61QvoJtwZp5yGRCi/+m/xz2tU9/Ea6Wbg8smYNE
   7jyckZgdO+3jZOyM42KeGtmgj3FkNoNuiqZd2xljU1D8XaIU49BUfiCU/
   aSoT45kMybsoQwaIXt6AC7Nmi8+IYUFcLAauGBN+im8nv+y+1up02GnxY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377430632"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="377430632"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 02:06:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014863922"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="1014863922"
Received: from dlemiech-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.78])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 02:06:29 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 6460210A38A; Fri, 24 Nov 2023 13:06:27 +0300 (+03)
Date: Fri, 24 Nov 2023 13:06:27 +0300
From: kirill.shutemov@linux.intel.com
To: mhklinux@outlook.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
	akpm@linux-foundation.org, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, thomas.lendacky@amd.com, ardb@kernel.org,
	jroedel@suse.de, seanjc@google.com, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/8] x86/coco: Mark CoCo VM pages not present when
 changing encrypted state
Message-ID: <20231124100627.avltdnuhminwuzax@box>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>

On Tue, Nov 21, 2023 at 01:20:08PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a CoCo VM when a page transitions from encrypted to decrypted, or vice
> versa, attributes in the PTE must be updated *and* the hypervisor must
> be notified of the change.

Strictly speaking it is not true for TDX. Conversion to shared can be
implicit: set shared bit and touch the page will do the conversion. MapGPA
is optional.

> Because there are two separate steps, there's
> a window where the settings are inconsistent.  Normally the code that
> initiates the transition (via set_memory_decrypted() or
> set_memory_encrypted()) ensures that the memory is not being accessed
> during a transition, so the window of inconsistency is not a problem.
> However, the load_unaligned_zeropad() function can read arbitrary memory
> pages at arbitrary times, which could read a transitioning page during
> the window.  In such a case, CoCo VM specific exceptions are taken
> (depending on the CoCo architecture in use).  Current code in those
> exception handlers recovers and does "fixup" on the result returned by
> load_unaligned_zeropad().  Unfortunately, this exception handling can't
> work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode)
> if the exceptions are routed to the paravisor.  The paravisor can't
> do load_unaligned_zeropad() fixup, so the exceptions would need to
> be forwarded from the paravisor to the Linux guest, but there are
> no architectural specs for how to do that.

Hm. Can't we inject #PF (or #GP) into L2 if #VE/#VC handler in L1 sees
cross-page access to shared memory while no fixup entry for the page in
L1. It would give L2 chance to handle the situation in a transparent way.

Maybe I miss something, I donno.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

