Return-Path: <linux-hyperv+bounces-2051-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8C8B5B3B
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE48A1F21C85
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Apr 2024 14:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B5F78B4E;
	Mon, 29 Apr 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cg29qHmp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F158877F11;
	Mon, 29 Apr 2024 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400974; cv=none; b=BMz3UZ7mEavGje20tJ9bUtpoDOQoNWdxDVx4f5MO2gl4v24RtaS/gvvRP3G/Lcq6pYqp8yw+SjTGGMekxcRu4aaiqnYigl4+glZ477AvBRSrGuzpf6TAOJuhR7PwmaV3+tZgRRAGJLnNAixBH9juoi+kehAxgTVA7VvqXIwUoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400974; c=relaxed/simple;
	bh=lnmpDQnRv6ZNQZTqtUONOeLziTno1c2pGB56FVkEOEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8G9GTfBknAoNwsoCq5phZfTGyJgaQxSe4MoCiZkSxYtrsw+6N7Bl3yedr5NWk8nj7KFigVql6faJGDe2EmXpEMXeRpB994DJY9Vl4wXHZGA3zFgZfL3HxNIWhQOaVK9cEol+GG+vrh1wPa7bgUmISDkObKV79+vHPnxdinGNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cg29qHmp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714400972; x=1745936972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lnmpDQnRv6ZNQZTqtUONOeLziTno1c2pGB56FVkEOEE=;
  b=cg29qHmpJxUhLcE/S2f8s+I+RTy3BN5/Up/6WFJV0ULB4xApKQhz2XuF
   iaP5teZYd5rnucwst2w+ok86df4Xqb9jzC8RKQW5/Rp5tjEC6j2rd5IsH
   3tod0+y/wWO11j9gM/6LrvNNu3n2gZex9O2BUDJONyzXjlGSKV20NdyFC
   S4vrMC0xvjwpMaSrOHRy0nveSLGuUcqSj3QB5ssMT3yQ0pN6uKmS8e0v6
   +ooZ9KoyYDmTXs3TG5qf9bTMxuVNu+rJKtUaXExwGp+2Jemv9O/ugw+T0
   D8aGrbsj9rlSjFUWrRcAH+06Rw7rpC15jLNzFdt68LLjCY9+saJEK1nJY
   g==;
X-CSE-ConnectionGUID: /qHsT91hQg2JAlhCd756Ng==
X-CSE-MsgGUID: bPQFmcSXTFus8RNEGf6Raw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10227692"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10227692"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 07:29:31 -0700
X-CSE-ConnectionGUID: jCUPWXxUTdG7tdcGTA0h9w==
X-CSE-MsgGUID: vwoW0j5TRESQOwxzFM6Tuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="57006944"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 29 Apr 2024 07:29:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 82C161A0; Mon, 29 Apr 2024 17:29:23 +0300 (EEST)
Date: Mon, 29 Apr 2024 17:29:23 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, 
	Sean Christopherson <seanjc@google.com>, "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@intel.com>, Tao Liu <ltao@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCHv10 06/18] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Message-ID: <xoksw5s5tl6wso4xirh4u422xmera4pyulptfmn3zeqtp5lmt2@d3y6ucap37da>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-7-kirill.shutemov@linux.intel.com>
 <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240428172557.GLZi6GpTaSBj-DphCL@fat_crate.local>

On Sun, Apr 28, 2024 at 07:25:57PM +0200, Borislav Petkov wrote:
> On Tue, Apr 09, 2024 at 02:29:58PM +0300, Kirill A. Shutemov wrote:
> > TDX is going to have more than one reason to fail
> > enc_status_change_prepare().
> > 
> > Change the callback to return errno instead of assuming -EIO;
> > enc_status_change_finish() changed too to keep the interface symmetric.
> 
> "Change enc_status_change_finish() too... "
> 
> "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour."

Hm. I considered the sentence to be in imperative mood already. I guess I
don't fully understand what imperative mood is. Will fix.

> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > Tested-by: Tao Liu <ltao@redhat.com>
> > ---
> >  arch/x86/coco/tdx/tdx.c         | 20 +++++++++++---------
> >  arch/x86/hyperv/ivm.c           | 22 ++++++++++------------
> >  arch/x86/include/asm/x86_init.h |  4 ++--
> >  arch/x86/kernel/x86_init.c      |  4 ++--
> >  arch/x86/mm/mem_encrypt_amd.c   |  8 ++++----
> >  arch/x86/mm/pat/set_memory.c    |  8 +++++---
> >  6 files changed, 34 insertions(+), 32 deletions(-)
> 
> Another thing you should long know by now: get_maintainer.pl. You do
> know that when you send a patch which touches multiple different
> "places", you run it through get_maintainer.pl to get some hints as to
> who to CC, right?

You are right, I didn't run get_maintainer.pl this time. I never got it
integrated properly into my workflow. How do you use it? Is it part of
'git send-email' hooks or do you do it manually somehow.

I don't feel I can trust the script to do The Right Thing™ all the time
to put into my hooks. I expect it to blow up on tree-wide patches for
instance.

As result I only run it occasionally, when I remember to which is
suboptimal.

Any tips?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

