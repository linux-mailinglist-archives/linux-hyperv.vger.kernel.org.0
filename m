Return-Path: <linux-hyperv+bounces-1020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285BD7F3E1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 07:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D497F282A3A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 06:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D615ACF;
	Wed, 22 Nov 2023 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fe2I/IaA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09790BB;
	Tue, 21 Nov 2023 22:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xtM5w+3ktsUlDXMQVtnpLNAqSOnoIivIrkJOJCkE54I=; b=Fe2I/IaAvdwWG+Odxk+6Jev5z3
	mK9sa7hFGwb3eVUq2oD7TbGb7hgoYqNv1lUIQA7B9oEqYEdA7jZ3gET9qde5ALtzb3OuNKtvKWEni
	o2qwzas/AcBnFxN3yaeTlYMG1T7VFZ9CnZPWJdRQxiWxsMbr5KKC1jffOB91ZtG1CEHWFcV/1IYgy
	4bx/fnMba/ANB9OlFhprno8GEhWK/gchg0kss9uWMEk4L5iMiT/3nWara2+kiWD/wDuQTE7xclyVN
	+dq0YYJeGwaDiM6gM3nRzb56eKlxYha4MQob2PkWBTKillzASwWTQQRdBl+sAWzopkMNCaJfilvz4
	jufGGghg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5gga-000q0S-01;
	Wed, 22 Nov 2023 06:26:08 +0000
Date: Tue, 21 Nov 2023 22:26:07 -0800
From: Christoph Hellwig <hch@infradead.org>
To: mhklinux@outlook.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	kirill.shutemov@linux.intel.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	urezki@gmail.com, hch@infradead.org, lstoakes@gmail.com,
	thomas.lendacky@amd.com, ardb@kernel.org, jroedel@suse.de,
	seanjc@google.com, rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/8] x86/mm: Remove "static" from vmap_pages_range()
Message-ID: <ZV2e/6qTJDkjYbfY@infradead.org>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
 <20231121212016.1154303-4-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121212016.1154303-4-mhklinux@outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 21, 2023 at 01:20:11PM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The mm subsystem currently provides no mechanism to map memory pages
> to a specified virtual address range.  A virtual address range can be
> allocated using get_vm_area(), but the only function available for
> mapping memory pages to a caller-specified address in that range is
> ioremap_page_range(), which is inappropriate for system memory.
> 
> Fix this by allowing vmap_pages_range() to be used by callers outside
> of vmalloc.c.

I really do not want to expose vmap_pages_range.  Please try to come up
with a good way to encapsulate your map at a certain address primitive
and implement it in vmalloc.c.


