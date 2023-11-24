Return-Path: <linux-hyperv+bounces-1049-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650197F754A
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CC21C20D4E
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Nov 2023 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515E28DDB;
	Fri, 24 Nov 2023 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTge55eB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58E173B;
	Fri, 24 Nov 2023 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832847; x=1732368847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BqOo8o3FAxQ3sv9OF/Du7NB3vD4Ym6X99rsyMxspLOM=;
  b=KTge55eBh93oK3Q0xtIOLcD0Un9M7udXR1ayJ26jEE/EHZzmEw7zG4wF
   Q/9nvVX1jC3i36KBf5ItSg6EtXPKPWEqQsC2ZiKh0+z6BUSDZyxevz1gN
   NPsGFdcKMcsZI+TAfcSOnUHUTvn7aGsnDXbX/zo8WqBJ3HgX0BaEplYVc
   Vok53/RAOQhz4HnngzcolIitnDYRSak1mc8IektnZtw860eGY9nEsUeNt
   r72Cxpz+I31Z5n4sAP70mU5hyaizpNkuD60iAPkFKaNE9SHxZbZWaYUNZ
   fntzwTIalpjc+y9HrkvK48YgPHLE8iHCHLNnHqLKQou/m8A11ltYanHgj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389576992"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389576992"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:34:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15634065"
Received: from dlemiech-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.59.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:34:02 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id A48F510A38A; Fri, 24 Nov 2023 16:33:58 +0300 (+03)
Date: Fri, 24 Nov 2023 16:33:58 +0300
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
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231124133358.sdhomfs25seki3lg@box.shutemov.name>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231123135846.pakk44rqbbi7njmb@box.shutemov.name>
 <9f550947-9d13-479c-90c4-2e3f7674afee@linux.microsoft.com>
 <20231124104337.gjfyasjmo5pp666l@box.shutemov.name>
 <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58c82110-45b2-4e23-9a82-90e1f3fa43c2@linux.microsoft.com>

On Fri, Nov 24, 2023 at 12:04:56PM +0100, Jeremi Piotrowski wrote:
> On 24/11/2023 11:43, Kirill A. Shutemov wrote:
> > On Fri, Nov 24, 2023 at 11:31:44AM +0100, Jeremi Piotrowski wrote:
> >> On 23/11/2023 14:58, Kirill A. Shutemov wrote:
> >>> On Wed, Nov 22, 2023 at 06:01:04PM +0100, Jeremi Piotrowski wrote:
> >>>> Check for additional CPUID bits to identify TDX guests running with Trust
> >>>> Domain (TD) partitioning enabled. TD partitioning is like nested virtualization
> >>>> inside the Trust Domain so there is a L1 TD VM(M) and there can be L2 TD VM(s).
> >>>>
> >>>> In this arrangement we are not guaranteed that the TDX_CPUID_LEAF_ID is visible
> >>>> to Linux running as an L2 TD VM. This is because a majority of TDX facilities
> >>>> are controlled by the L1 VMM and the L2 TDX guest needs to use TD partitioning
> >>>> aware mechanisms for what's left. So currently such guests do not have
> >>>> X86_FEATURE_TDX_GUEST set.
> >>>>
> >>>> We want the kernel to have X86_FEATURE_TDX_GUEST set for all TDX guests so we
> >>>> need to check these additional CPUID bits, but we skip further initialization
> >>>> in the function as we aren't guaranteed access to TDX module calls.
> >>>
> >>> I don't follow. The idea of partitioning is that L2 OS can be
> >>> unenlightened and have no idea if it runs indide of TD. But this patch
> >>> tries to enumerate TDX anyway.
> >>>
> >>> Why?
> >>>
> >>
> >> That's not the only idea of partitioning. Partitioning provides different privilege
> >> levels within the TD, and unenlightened L2 OS can be made to work but are inefficient.
> >> In our case Linux always runs enlightened (both with and without TD partitioning), and
> >> uses TDX functionality where applicable (TDX vmcalls, PTE encryption bit).
> > 
> > What value L1 adds in this case? If L2 has to be enlightened just run the
> > enlightened OS directly as L1 and ditch half-measures. I think you can
> > gain some performance this way.
> > 
> 
> It's primarily about the privilege separation, performance is a reason
> one doesn't want to run unenlightened. The L1 makes the following possible:
> - TPM emulation within the trust domain but isolated from the OS
> - infrastructure interfaces for things like VM live migration
> - support for Virtual Trust Levels[1], Virtual Secure Mode[2]
> 
> These provide a lot of value to users, it's not at all about half-measures.

Hm. Okay.

Can we take a step back? What is bigger picture here? What enlightenment
do you expect from the guest when everything is in-place?

So far I see that you try to get kernel think that it runs as TDX guest,
but not really. This is not very convincing model.

Why does L2 need to know if it runs under TDX or SEV? Can't it just think
it runs as Hyper-V guest and all difference between TDX and SEV abstracted
by L1?

So far, I failed to see coherent design. Maybe I just don't know where to
look.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

