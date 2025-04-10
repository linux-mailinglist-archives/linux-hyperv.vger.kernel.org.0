Return-Path: <linux-hyperv+bounces-4864-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600EA83B7E
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 09:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6407416EE60
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Apr 2025 07:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506E20127A;
	Thu, 10 Apr 2025 07:42:36 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0C1E3DED;
	Thu, 10 Apr 2025 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744270955; cv=none; b=Iv1FoNEMjsCmwlo2ahdtz0MfekrTLU7jrxN7BBdqew7nzgM99jKCIIiZ/9vKYNsFpBBbEzDpIF66qKso4exJjIZOO5deZZv1myyT3Gm/4rNPz1h3ZyGgTkW/4A9Hf3J/fhdye3B9uAWx1ogdCjkBgI9uAtVR9v75bii/5A3Cmto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744270955; c=relaxed/simple;
	bh=85QpR9oFRrRsEnFw64qHfKu5TEkleorKdhp2VUyvkYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IakfVveOTAWScM44giqyf69nrpyrdBN3hbiszSplaVpYnWwJ4kQfQWs8JYVL2LohcqPc6R94wGXJxZCugZ5V93cvdz/SBsq8lbvPj2lRKNyxYXuD/q1qJJbst3Yx68zYn/nv8Afn2DNYFSyHByhGjX8Gco/HQq7zPO4yjU37Blc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EE92D68B05; Thu, 10 Apr 2025 09:42:28 +0200 (CEST)
Date: Thu, 10 Apr 2025 09:42:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@lst.de>,
	"jayalk@intworks.biz" <jayalk@intworks.biz>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	"deller@gmx.de" <deller@gmx.de>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"weh@microsoft.com" <weh@microsoft.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm: Export vmf_insert_mixed_mkwrite()
Message-ID: <20250410074228.GA680@lst.de>
References: <20250408183646.1410-1-mhklinux@outlook.com> <20250408183646.1410-2-mhklinux@outlook.com> <20250409104942.GA5572@lst.de> <BN7PR02MB4148597D0495C631F6E3F8C0D4B42@BN7PR02MB4148.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN7PR02MB4148597D0495C631F6E3F8C0D4B42@BN7PR02MB4148.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 09, 2025 at 02:10:26PM +0000, Michael Kelley wrote:
> Hmmm. What's the reference to "as told last time"? I don't think I've had
> this conversation before.

Hmm, there was a conversation about deferred I/O, and I remember the
drm folks even defending their abuse of vmalloc_to_page on dma coherent
memory against the documentation in the most silly way.  Maybe that was
a different discussion of the same thing.

> 
> For the hyperv_fb driver, the memory in question is allocated with a direct call
> to alloc_pages(), not via dma_alloc_coherent(). There's no DMA in this scenario.
> The memory is shared with the Hyper-V host and designated as the memory
> for the virtual framebuffer device. It is then mapped into user space using the
> mmap() system call against /dev/fb0. User space writes to the memory are
> eventually (and I omit the details) picked up by the Hyper-V host and displayed.

Oh, great.

> Is your point that memory dma_alloc_coherent() memory must be treated as
> a black box, and can't be deconstructed into individual pages? If so, that makes
> sense to me.

Yes.

> But must the same treatment be applied to memory from
> alloc_pages()? This is where I need some education.

No, that's just fine.


