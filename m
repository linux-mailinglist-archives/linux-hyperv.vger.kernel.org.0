Return-Path: <linux-hyperv+bounces-1139-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3832C7FDAD9
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 16:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91B7BB2118D
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Nov 2023 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C837154;
	Wed, 29 Nov 2023 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2BP+IkY"
X-Original-To: linux-hyperv@vger.kernel.org
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 07:11:25 PST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1CA3;
	Wed, 29 Nov 2023 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701270686; x=1732806686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+WmXrJbd+4V27ux01qGWHb6jKBIycuX+25UjSdydb/I=;
  b=H2BP+IkYuW3BxhwKR0bIzT/geZs7X8pGilk4etDN7bJGROnTX0ZbJtzX
   MVxfMZvh1RqaYri3twMfU1KHotqyT0pAKXtYYByofonYDJecsTNwYJ1p3
   y45V5bKj/zV2GIVvUlm9YZbJLfFNCsfBXshKnYHGq3PaZbrJ238YSYaT4
   H8TtPw23Obh46DGz+K+hVLYg65S4GLpACXcSRvLIU2Fb77dz819gi9tQB
   UYaW+68ILcm/00CzVphkl9EfYyrYeSrIUJj4h9TZGgjNdVsYWOCcX+098
   ID5XhADax4t4apkxMypjfLlc4uLOaT2fvpgvCrwxSAIXagJyjwKf2j7iP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="162829"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="162829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:10:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016292536"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="1016292536"
Received: from padamowi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.60.113])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 07:10:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id E10D010A424; Wed, 29 Nov 2023 18:10:12 +0300 (+03)
Date: Wed, 29 Nov 2023 18:10:12 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"jroedel@suse.de" <jroedel@suse.de>,
	"seanjc@google.com" <seanjc@google.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 0/8] x86/coco: Mark CoCo VM pages not present when
 changing encrypted state
Message-ID: <20231129151012.4un33hvk4nrsicou@box>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
 <20231124100627.avltdnuhminwuzax@box>
 <SN6PR02MB415717E09C249A31F2A4E229D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415717E09C249A31F2A4E229D4BCA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Nov 28, 2023 at 07:12:33PM +0000, Michael Kelley wrote:
> From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sent: Friday, November 24, 2023 2:06 AM
> > 
> > On Tue, Nov 21, 2023 at 01:20:08PM -0800, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > In a CoCo VM when a page transitions from encrypted to decrypted, or vice
> > > versa, attributes in the PTE must be updated *and* the hypervisor must
> > > be notified of the change.
> > 
> > Strictly speaking it is not true for TDX. Conversion to shared can be
> > implicit: set shared bit and touch the page will do the conversion. MapGPA
> > is optional.
> 
> Interesting.  Given that, is there a reason to use the explicit
> hypervisor callbacks in for private->shared transitions in 
> __set_mem_enc_pgtable()?   It probably doesn't have direct relevance
> to this patch series, but I'm just trying to understand the tradeoffs of
> the implicit vs. explicit approach.  And am I correct that
> shared->private transitions must use the explicit approach?

It must be explicit in sense, that the memory has to be accepted before
use. MapGPA() is still optional.

I don't like this implicit tricks. I spent a lot of time debugging an
issue that was obscured by this semantics.

But I think it is going to say :/

> > > Because there are two separate steps, there's
> > > a window where the settings are inconsistent.  Normally the code that
> > > initiates the transition (via set_memory_decrypted() or
> > > set_memory_encrypted()) ensures that the memory is not being accessed
> > > during a transition, so the window of inconsistency is not a problem.
> > > However, the load_unaligned_zeropad() function can read arbitrary memory
> > > pages at arbitrary times, which could read a transitioning page during
> > > the window.  In such a case, CoCo VM specific exceptions are taken
> > > (depending on the CoCo architecture in use).  Current code in those
> > > exception handlers recovers and does "fixup" on the result returned by
> > > load_unaligned_zeropad().  Unfortunately, this exception handling can't
> > > work in paravisor scenarios (TDX Paritioning and SEV-SNP in vTOM mode)
> > > if the exceptions are routed to the paravisor.  The paravisor can't
> > > do load_unaligned_zeropad() fixup, so the exceptions would need to
> > > be forwarded from the paravisor to the Linux guest, but there are
> > > no architectural specs for how to do that.
> > 
> > Hm. Can't we inject #PF (or #GP) into L2 if #VE/#VC handler in L1 sees
> > cross-page access to shared memory while no fixup entry for the page in
> > L1. It would give L2 chance to handle the situation in a transparent way.
> > 
> > Maybe I miss something, I donno.
> 
> I'm recounting what the Hyper-V paravisor folks say without knowing all the
> details. :-(   But it seems like any kind of forwarding scheme needs to be a
> well-defined contract that would work for both TDX and SEV-SNP.   The
> paravisor in L1 might or might not be Linux-based, so the contract must be OS
> independent.  And the L2 guest might or might not be Linux, so there's
> potential for some other kind of error to be confused with a Linux
> load_unaligned_zeropad() reference.

Okay, fair enough. I have hard time reasoning if it is okay for L2 which
is not Linux.


-- 
  Kiryl Shutsemau / Kirill A. Shutemov

