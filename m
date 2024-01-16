Return-Path: <linux-hyperv+bounces-1445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5182F2D0
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 18:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B00287EDA
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6008C1CA92;
	Tue, 16 Jan 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3fpkxT3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14661CA8C;
	Tue, 16 Jan 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424556; cv=none; b=f5GROFrrXWcNXEVspikodXsbH3zaxBWd8fVK24a9Rak8ZrAOgFnxbxaNg11hGphBk5U+8yuN6pKkQ1M/IBKv0ma6drtTgg/pdyYxP8JIMXPK5MB14XE/AsjxIUBrve9LLyZtEuwTBW4kYYa3/ttLubhCmyDLRazRB5bPMK1uQP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424556; c=relaxed/simple;
	bh=W5qlSOrOPnf06NpnZ5IqQM7YnmklSyj2ZEoUbqEujIw=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Subject:From:To:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version; b=N2Yh5OWftWZ/4FPjZti0DhRV8PYCQx/+SW1ZMfzy6iAlsCmZdNFbkWDbAdIsBoJaTa/x/YO4IrX8S9GvFzAebpS2+eG7TwrwhcHxHSP3IVdg2JJ3XTfFx3G6F/gu/dpxer7zXRHKwxTiEUx6h2Iwxtr5d1/9FPAHWlzUpB27MEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3fpkxT3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705424555; x=1736960555;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=W5qlSOrOPnf06NpnZ5IqQM7YnmklSyj2ZEoUbqEujIw=;
  b=H3fpkxT3zodoUsC5/NAD30F6gV0gQAPJhFTvDoj/K+4UehL5HfF97hRc
   076fnEeqsR1MurRflZgAzAdVVGK1H4kifoniADKgpWPKEdP9KP8N8YBVW
   xruLIZj7glu8buF9c1CURm+12RK3zc7KVdcE27zGRIJi4oWfpJmzZyi7W
   U+SNar92FTDC2kZIS+BzTMOhmP194S+YXuIlCjU+E8KY9h5JJttwDyjVW
   5rKbK0W+ZdySdAXzVuHQfkVskZOTGxhR+uBCx1vWeqKBpFHV3rLFEGGZk
   qAzBbeFYi+PGgZz6i4PMmG1xCF7kgRPtzRWfJ6nEajUgT2ru8ztoLkPko
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6632877"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="6632877"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 09:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="818220972"
X-IronPort-AV: E=Sophos;i="6.05,199,1701158400"; 
   d="scan'208";a="818220972"
Received: from ticela-or-353.amr.corp.intel.com ([10.209.70.241])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 09:02:30 -0800
Message-ID: <ad55e4845edfd052538b5e80ae7ff2a67820424c.camel@linux.intel.com>
Subject: Re: [PATCH v4 1/3] x86/hyperv: Use slow_virt_to_phys() in page
 transition hypervisor callback
From: "rick.p.edgecombe@linux.intel.com" <rick.p.edgecombe@linux.intel.com>
To: mhklinux@outlook.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de,  dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
 kirill.shutemov@linux.intel.com, haiyangz@microsoft.com,
 wei.liu@kernel.org,  decui@microsoft.com, luto@kernel.org,
 peterz@infradead.org,  akpm@linux-foundation.org, urezki@gmail.com,
 hch@infradead.org, lstoakes@gmail.com,  thomas.lendacky@amd.com,
 ardb@kernel.org, jroedel@suse.de, seanjc@google.com, 
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-kernel@vger.kernel.org, 
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Date: Tue, 16 Jan 2024 09:02:29 -0800
In-Reply-To: <20240116022008.1023398-2-mhklinux@outlook.com>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
	 <20240116022008.1023398-2-mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-15 at 18:20 -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
>=20
> In preparation for temporarily marking pages not present during a
> transition between encrypted and decrypted, use slow_virt_to_phys()
> in the hypervisor callback. As long as the PFN is correct,
> slow_virt_to_phys() works even if the leaf PTE is not present.
> The existing functions that depend on vmalloc_to_page() all
> require that the leaf PTE be marked present, so they don't work.
>=20
> Update the comments for slow_virt_to_phys() to note this broader
> usage
> and the requirement to work even if the PTE is not marked present.
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

