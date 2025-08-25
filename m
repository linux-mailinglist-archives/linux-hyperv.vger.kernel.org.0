Return-Path: <linux-hyperv+bounces-6582-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195B7B33AB5
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F08C7A7D85
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Aug 2025 09:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA99298994;
	Mon, 25 Aug 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VgKchFXC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6A29D283;
	Mon, 25 Aug 2025 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113798; cv=none; b=eXkcjbBIGc/Fg2vToNa8elGJl+sa8TNX5pq6pJ/CljSHMPcYSnywcNb9sNh5RIArsJh3cEym6KXIzB92zSzr+zWneUE3EJfWexi9UaQUbukjAbdx4dhljoVOWGH/qumKSpCPUG/L5Vn6OLy3h4EFAmDp32awBL8sseU14tiKK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113798; c=relaxed/simple;
	bh=ggkzVJ1Jf9cMGZ70QjnFud9Tdiq3OD6CANIfuVvIaw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2+GYzreQMTjL0lb9MDap/7TywOKk/yexoC/suSEJj1XFuMBjj9XUQBQeW8YTSLCZHQKLj08BZuZ5swLg8XhAn6K898/1qsTHWWoBw3dJFfBy52bdTFQgxw4vqQOt8Xe3Z8CAjoK6/NDh4+vlFCUv7tgno6F7zgDWlstbFkhX38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VgKchFXC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BoqmBaEZY9EobthDHh1G78kKAWwwvkNPWi4LK3I8yEA=; b=VgKchFXCYxUBmAifF50C4Lfqo2
	iNkbDmojUzASmpf/ZRsBlAt4Fv7XAIfZbVP2UFyI88OXqj50bpKv12U1FU+sP6I6JOEi9BqDfFsOI
	MQ35lzZjZT1/ECG+EBYcMX/6ftyb3Uf6A0owPxaVZzUIsTUb9FSlsKRSEgR2RSlgEeLqhb/GIUxeJ
	fZBAm/C/RIq0ufbv6KQp/heKYls0twTQY5OxZ54TEfIHi8FLQnQr2MZxTAa9waRD1XOwSZKt1FJG9
	Mcw/RIS9vk18AVHgJhJapM46T9dzWxwoNZOiVQ3HBRN9JaBRqV4sS+XE+Iwnh2ILvK8Ms49pdxLbt
	ln6H0wCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqTQ1-00000007ULk-0IeV;
	Mon, 25 Aug 2025 09:23:13 +0000
Date: Mon, 25 Aug 2025 02:23:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/hyperv: Export hv_hypercall_pg unconditionally
Message-ID: <aKwrgVCtv_FkiuVn@infradead.org>
References: <20250825055208.238729-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825055208.238729-1-namjain@linux.microsoft.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 25, 2025 at 11:22:08AM +0530, Naman Jain wrote:
> With commit 0e20f1f4c2cb ("x86/hyperv: Clean up hv_do_hypercall()"),
> config checks were added to conditionally restrict export
> of hv_hypercall_pg symbol at the same time when a usage of that symbol
> was added in mshv_vtl_main.c driver. This results in missing symbol
> warning when mshv_vtl_main is compiled. Change the logic to
> export it unconditionally.

Note that exporting variables like this always is a bad idea only
used as a last resort.  It would be much better to just build a proper
API for using it instead.


