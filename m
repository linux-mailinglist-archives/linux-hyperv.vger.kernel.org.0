Return-Path: <linux-hyperv+bounces-4837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C1AA822AF
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CF63BC7EA
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Apr 2025 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673925D8EC;
	Wed,  9 Apr 2025 10:49:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22362459E8;
	Wed,  9 Apr 2025 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744195789; cv=none; b=qXPsQMrpBdGut4pWfgMdzuUL/nK2noRIEqCal3vdN76QiphIN6fCn+VOTHRKGt5qfxom0Fr8mFLVdlenZtSEb4C0W4jmi6dZUARi2bsLS9FbfRsqo7eX63EXHP2/0RCmADHLz/wbcCZ+55oBT3ZzUnAOlHZXA89r7/53sxWGnNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744195789; c=relaxed/simple;
	bh=VcXPIsYKRo3MhwBOVsH4CASSunr7jIyXwKdenYydJ3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hufAkVbs26NwpYy22TzqSN+mFzpvEjvRZV3lDXkomX1pqGkFLjYIs/A1jRqKosbRP6QS+ipqg2exXhm0zMyC3SUojXZ4aWyl609H4DE2CNFK51Ju+ohz5Z9QsZP/WSCjVpIiw+gxs8oXb1wxzmcSSJXdUNfM9WfdRXldUicWDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 91A7968AA6; Wed,  9 Apr 2025 12:49:42 +0200 (CEST)
Date: Wed, 9 Apr 2025 12:49:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: mhklinux@outlook.com
Cc: jayalk@intworks.biz, simona@ffwll.ch, deller@gmx.de,
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, akpm@linux-foundation.org, weh@microsoft.com,
	tzimmermann@suse.de, hch@lst.de, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm: Export vmf_insert_mixed_mkwrite()
Message-ID: <20250409104942.GA5572@lst.de>
References: <20250408183646.1410-1-mhklinux@outlook.com> <20250408183646.1410-2-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408183646.1410-2-mhklinux@outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 08, 2025 at 11:36:44AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Export vmf_insert_mixed_mkwrite() for use by fbdev deferred I/O code,

But they are using this on dma coherent memory, where you can't legally
get at the page.  As told last time you need to fix that first before
hacking around that code.

> which can be built as a module. For consistency with the related function
> vmf_insert_mixed(), export without the GPL qualifier.

No.  All advanced new Linux functionality must be _GPL.  Don't try to
sneak around that.


