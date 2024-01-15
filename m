Return-Path: <linux-hyperv+bounces-1434-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43D582D68E
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jan 2024 11:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EF9284855
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jan 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE18E57A;
	Mon, 15 Jan 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBi7HhCv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0BF9C2;
	Mon, 15 Jan 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705312820; x=1736848820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=utTJkdiQ3vnztSPGEHcOmRJIWy6d/oKeObynN8qfOUs=;
  b=kBi7HhCvaH2leHxkZOeIvjOfVwHdwNNYUngjOw7zARJXm/5kxKNJeKjF
   PJitXnGRVV7DZrVMyVjxufPs8hpZa9DMi71Xd8yo47V2e6oLu8EoYX7/G
   5WnHP2mSrax/oP+9NCMJOQJuQ0a7y2ZeWR1zrMm6LFhMkB5wV5Lp4EKin
   9mLhO890duRfe4fu6mt516h2Xo0TGJDXFy5jkldqeFo2KYwGenmvV/Y+N
   OhDOzpshOgOzCTwXIJ2r1/wkyJqEt6zLfTvpzP6DUBMarXJlEZgrU74I3
   k2JwYilFMb0qgrXpjys8Xj9S/wmuE8isxxyYLltrPwvRAbwQONKKeKI+K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="18182459"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="18182459"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:00:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874059378"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="874059378"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.55.160])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:00:13 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 44E2E10A58F; Mon, 15 Jan 2024 13:00:11 +0300 (+03)
Date: Mon, 15 Jan 2024 13:00:11 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"Lutomirski, Andy" <luto@kernel.org>,
	"hch@infradead.org" <hch@infradead.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"seanjc@google.com" <seanjc@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Cui, Dexuan" <decui@microsoft.com>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"Rodel, Jorg" <jroedel@suse.de>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
Message-ID: <20240115100011.yvecjjezrkcptnle@box.shutemov.name>
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-2-mhklinux@outlook.com>
 <9dcdd088494b3fa285781cccfd35cd47a70d69c3.camel@intel.com>
 <SN6PR02MB4157B123128F6C2F6C3600D9D46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3ddc237d9fbbe0aa8838babf0df790076017e9f7.camel@intel.com>
 <SN6PR02MB415720444A3D848D444BB58AD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415720444A3D848D444BB58AD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Fri, Jan 12, 2024 at 07:24:35PM +0000, Michael Kelley wrote:
> From: Edgecombe, Rick P <rick.p.edgecombe@intel.com> Sent: Friday, January 12, 2024 9:17 AM
> > 
> > On Fri, 2024-01-12 at 15:07 +0000, Michael Kelley wrote:
> > > The comment is Kirill Shutemov's suggestion based on comments in
> > > an earlier version of the patch series.  See [1].   The intent is to
> > > prevent
> > > some later revision to slow_virt_to_phys() from adding a check for
> > > the
> > > present bit and breaking the CoCo VM hypervisor callback.  Yes, the
> > > comment could get stale, but I'm not sure how else to call out the
> > > implicit dependency.  The idea of creating a private version of
> > > slow_virt_to_phys() for use only in the CoCo VM hypervisor callback
> > > is also discussed in the thread, but that seems worse overall.
> > 
> > Well, it's not a huge deal, but I would have just put a comment at the
> > caller like:
> > 
> > /*
> >  * Use slow_virt_to_phys() instead of vmalloc_to_page(), because it
> >  * returns the PFN even for NP PTEs.
> >  */
> 
> Yes, that comment is added in this patch.
> 
> > 
> > If someone is changing slow_virt_to_phys() they should check the
> > callers to make sure they won't break anything. They can see the
> > comment then and have an easy time.
> > 
> > An optional comment at slow_virt_to_phys() could explain how the
> > function works in regards to the present bit, but not include details
> > about CoCoO VM page transition's usage of the present bit. The proposed
> > comment text looks like something more appropriate for a commit log.
> 
> Kirill -- you originally asked for a comment in slow_virt_to_phys(). [1]
> Are you OK with Rick's proposal?

Yes, sounds sensible.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

