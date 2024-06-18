Return-Path: <linux-hyperv+bounces-2447-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E456590CB82
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919DE1F22EA6
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2024 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F63132492;
	Tue, 18 Jun 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AqsE8Afz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFCF535A3;
	Tue, 18 Jun 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718713229; cv=none; b=dfAniZIDVlYJhykYZMNj3ktd7wtvIRb9Bg8w03JGOS+cBg5/5WDSBhiPyFRUbdTdsueIi074nYZP6GuEf657dPq4fP2DSWErW8TkG0RwclYbVIg6fDshuf6Xd5ya+MsokiyKboH+v2hThjr31nIr1rHnFjo4OlXj9fh31cOmGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718713229; c=relaxed/simple;
	bh=4POtStJCjE5RRoSLSG+N/j3IB3Xj43A0ipVnukEbGJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxwuthxfYCHDQ280Ml/KVPnBDRkJwVIvhjxbp5qZHb8ycY4LXgqrHEctESkdXxEu11ZEwfh0akhEpu3ik3kjC4oBj38IngqdYA8SMbJg2CEzOQLWDTDOg2ufkA3RasZWIChws/vzZ/F9N2cBDSo08PFqXiohvM8oBJ56CEsEUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AqsE8Afz; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718713229; x=1750249229;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4POtStJCjE5RRoSLSG+N/j3IB3Xj43A0ipVnukEbGJg=;
  b=AqsE8AfzsiAg98dDm5LLCK/trgzd/9MsC/v3eH7dRtq3RzU9fjxc5GmE
   GnyDeCGGw07FLWaeqM5nHGpI4ziwIoZrG6KOMhOx0Tf8c5xBhITCC1SY2
   x0mgx4d6N14YKk0GrdDFgKIZg+JmS0ISvXRpraHli4UR38GV1ObqdwFOF
   UYlkDgJWioU6A18U+vz4AHyCN6I7ulcW2tuz1hhqOeHIaAigF4tgIIMg/
   WN7DOe7Zn/oKcUCJrI1aSWNxCI2rmW2lCzyJjQyLAOSLyutEaP4tnau/u
   IlYsdHx2RPCAwOGNk1xPiYWUkbV3nzlHVokw0lqfy7Vo14L7WoEH5Vxmc
   g==;
X-CSE-ConnectionGUID: Ie/mVklxRzmDhZaZbO+o9w==
X-CSE-MsgGUID: HLX8MHSPSoKIRoxfu30ffw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26169871"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26169871"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 05:20:28 -0700
X-CSE-ConnectionGUID: DwcjCin0ROGMSatLBuCePA==
X-CSE-MsgGUID: I5+5RDgfRiK1kXbdoeW9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46659137"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 18 Jun 2024 05:20:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 381D71CB; Tue, 18 Jun 2024 15:20:20 +0300 (EEST)
Date: Tue, 18 Jun 2024 15:20:20 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	"Huang, Kai" <kai.huang@intel.com>, Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, kexec@lists.infradead.org, linux-hyperv@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tao Liu <ltao@redhat.com>
Subject: Re: [PATCHv11 18/19] x86/acpi: Add support for CPU offlining for
 ACPI MADT wakeup method
Message-ID: <noxbrmequ4inpxgnwna6drnzuymcn3k6ik2kvlbzacxvr2udgf@pximrevgcgmu>
References: <icu4yecqfwhmbexupo4zzei4lbe5sgavsfkm27jd6t6gyjynul@c2wap3jhtik7>
 <20240610134020.GCZmcCRFxuObyv1W_d@fat_crate.local>
 <hidvykk3yan5rtlhum6go7j3lwgrcfcgxlwyjug3osfakw2x6f@4ohvo23zaesv>
 <nh7cihzlsjtoddtec6m62biqdn62k3ka5svs6m64qekhpebu5z@dkplwad2urgp>
 <20240611194653.GGZmiprSNzK0JSJL17@fat_crate.local>
 <2kc27uzrsvpevtvos2harqj3bgfkizi5dhhxkigswlylpnogr5@lk6fi2okv53i>
 <20240612092943.GCZmlqh7O662JB-yGu@fat_crate.local>
 <w6ohbffl5wwmralg255ec7nozxksge4z4nnkmwncthxzhuv46d@qq46r2wrjlog>
 <20240613145636.GGZmsIpHn16R04QlaN@fat_crate.local>
 <8efff872-7843-2025-dce2-a5dcdbf31143@amd.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8efff872-7843-2025-dce2-a5dcdbf31143@amd.com>

On Fri, Jun 14, 2024 at 09:06:30AM -0500, Tom Lendacky wrote:
> On 6/13/24 09:56, Borislav Petkov wrote:
> > On Thu, Jun 13, 2024 at 04:41:00PM +0300, Kirill A. Shutemov wrote:
> > > It is easy enough to do. See the patch below.
> > 
> > Thanks, will have a look.
> > 
> > > But I am not sure if I can justify it properly. If someone doesn't really
> > > need 5-level paging, disabling it at compile-time would save ~34K of
> > > kernel code with the configuration.
> > > 
> > > Is it worth saving ~100 lines of code?
> > 
> > Well, it goes both ways: is it worth saving ~34K kernel text and for that make
> > the code a lot less conditional, more readable, contain less ugly ifdeffery,
> 
> Won't getting rid of the config option cause 5-level to be used by default
> on all platforms that support it? The no5lvl command line option would have
> to be used to get 4-level paging at that point.

Yes, there won't be compile-time option to disable 5-level paging.

Is it a problem?

We benchmarked it back when 5-level paging got introduced and were not able
to see a measurable difference between 4- and 5-level paging on the same
machine. There's some memory overhead on more page table, but it shouldn't
be a show stopper.

I would prefer to get 5-level paging enabled if the machine supports it.
"no5lvl" cmdline option can be useful for debug or if your workload is
somehow special.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

