Return-Path: <linux-hyperv+bounces-1388-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD3C826F4F
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 14:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA731C22287
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jan 2024 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1AD4438E;
	Mon,  8 Jan 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSpRTgSG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16641208;
	Mon,  8 Jan 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704719442; x=1736255442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wb4zIKFOfFxBuDXZB8HXoCbo185XhuliuaB2tqVha7U=;
  b=TSpRTgSGn9WKTavlBp9WLGrSeziPftaZe6RDcGzFxxBcTlBvJXnt5ZTM
   hLH7B/xuq1OJf5sL0S3DxCUVIuqdF0AF4STB+6qAeGNW7y26YMdaL3P6M
   H0KG8N2ImPB1eju9vFbfmjyOkYO7pQRe8J1y8WFqrzxamL6lQAODRs+GT
   5mYmRxIZgSwgUg/IxatmW8JmIdeyc1a5oUQGtz8omv+utfE1ZkQ8tfJJu
   AFCrpLNQCZy9ykK30X+tWaJKvTcRvw+KnyST4dq6HurFMdl2yoFtY6sTW
   tHhZtwzCv+xC6jxizhf+CCxa5HJ7UVaq8dsPxNYK62+/2oZ5xjyKCtIa8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="462166788"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="462166788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:10:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="954626861"
X-IronPort-AV: E=Sophos;i="6.04,341,1695711600"; 
   d="scan'208";a="954626861"
Received: from ddraghic-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.212.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 05:10:36 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 3DF8310498C; Mon,  8 Jan 2024 16:10:34 +0300 (+03)
Date: Mon, 8 Jan 2024 16:10:34 +0300
From: kirill.shutemov@linux.intel.com
To: mhklinux@outlook.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
	thomas.lendacky@amd.com, ardb@kernel.org, jroedel@suse.de,
	seanjc@google.com, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] x86/mm: Regularize set_memory_p() parameters and
 make non-static
Message-ID: <20240108131034.rm3kxtptguiai57a@box.shutemov.name>
References: <20240105183025.225972-1-mhklinux@outlook.com>
 <20240105183025.225972-3-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105183025.225972-3-mhklinux@outlook.com>

On Fri, Jan 05, 2024 at 10:30:24AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> set_memory_p() is currently static.  It has parameters that don't
> match set_memory_p() under arch/powerpc and that aren't congruent
> with the other set_memory_* functions. There's no good reason for
> the difference.
> 
> Fix this by making the parameters consistent, and update the one
> existing call site.  Make the function non-static and add it to
> include/asm/set_memory.h so that it is completely parallel to
> set_memory_np() and is usable in other modules.
> 
> No functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

