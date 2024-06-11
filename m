Return-Path: <linux-hyperv+bounces-2392-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1E9044EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 21:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D2D1C209AC
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 19:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B719762C9;
	Tue, 11 Jun 2024 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JB948CVY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F183A27B;
	Tue, 11 Jun 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134573; cv=none; b=Sw4wm3LAfPv+IXqW3L3a8zGQijJtafZoE9MVMMzBFgQOKq9gl8IZbG5p2A1A36IJk4clD1r6ctx5GrEWJwz3Sh/XWKkMEvAGZSb5jz4TNzjRb12cuDG9U+jb51z6do7RVVcZZJRIqg2Kl2w8WibkfgtobZpgFDbh09r7dTAyUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134573; c=relaxed/simple;
	bh=GdA6KT5UlfpnGhC3psTeDTcc9QB/a0N+IRhJ64cOBEU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WTusb77Dtgm/OxnEMrzlxsPHP6k4KWmdZ4sC3DeO84Isl+MHS7lVuntUvGvOQAZV5RuePVip/hRzoBQl+estIhfmUxhl09DZoI4MUyrWaA5bXq5BgYbH9e0qbAPmevPHMmpY+MCIQSEp3iQwy/GG8JR2iYhCRQWNbQM8uPCM7v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JB948CVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5183C2BD10;
	Tue, 11 Jun 2024 19:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718134572;
	bh=GdA6KT5UlfpnGhC3psTeDTcc9QB/a0N+IRhJ64cOBEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JB948CVYmQmTc/5A4rHdUtUx98VRAUbQLgcPx7ZLb7Ixz24iZxaAzJDVfs+JRO5YW
	 CCPvVl85B+g0dyiNojTR+kxGEPc9ZgbqQD2ZBp34OLwozipdz5vU+CNeaE3NaT5REm
	 svy2ZcgGUGTCQSvDFEiwKvklcemFxCLjWAbltRSA=
Date: Tue, 11 Jun 2024 12:36:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 xen-devel@lists.xenproject.org, kasan-dev@googlegroups.com, Mike Rapoport
 <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: initialize memmap of
 !ZONE_DEVICE with PageOffline() instead of PageReserved()
Message-Id: <20240611123611.36d0633c65ec8171152fe803@linux-foundation.org>
In-Reply-To: <824c319a-530e-4153-80f5-20e2c463fa81@redhat.com>
References: <20240607090939.89524-1-david@redhat.com>
	<20240607090939.89524-3-david@redhat.com>
	<824c319a-530e-4153-80f5-20e2c463fa81@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 11:42:56 +0200 David Hildenbrand <david@redhat.com> wrote:

> > We'll leave the ZONE_DEVICE case alone for now.
> > 
> 
> @Andrew, can we add here:
> 
> "Note that self-hosted vmemmap pages will no longer be marked as 
> reserved. This matches ordinary vmemmap pages allocated from the buddy 
> during memory hotplug. Now, really only vmemmap pages allocated from 
> memblock during early boot will be marked reserved. Existing 
> PageReserved() checks seem to be handling all relevant cases correctly 
> even after this change."

Done, thanks.

