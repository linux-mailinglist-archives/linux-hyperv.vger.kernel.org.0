Return-Path: <linux-hyperv+bounces-2390-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0882290445C
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54D51F23BF5
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C92B80604;
	Tue, 11 Jun 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eEh1Bqsw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825D57CAE;
	Tue, 11 Jun 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718133584; cv=none; b=AJH5uZ5eOpLMJSLM9nw3IvGtmCKv4fU2fTNUE5N0es54qiATMZ05vnwXDBuqhrf5/Qaiw8mi5WgKfFS9llzN7W88UC6aEIMUjH5ywO//7iOIqos0mh4cdzesdmNV0M4UUTq6LcWhjCBHqrhoUDVsl4nqGe3CrI91FCovGv3TRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718133584; c=relaxed/simple;
	bh=AUJ44aafNBmr/yleRRZzaXjkALQuPOf50mYZh00Z5XE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iWjYZx9Ur+l7WUoOOV6LcXy232K8fmzqXC+FVlzUXZAQDzjmyfqqoKfrwgUCxYmd59jhs924Y4Q0qi0RD7ZoJ08RlZqKi0pLtdX0Gq9t9kfiSuQEHvMcvsq7Zh+bytTQ4V+1w11U9emOT/p9dNGNNMwQUGzEXJ06uHdkFadZXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eEh1Bqsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA6EC2BD10;
	Tue, 11 Jun 2024 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718133584;
	bh=AUJ44aafNBmr/yleRRZzaXjkALQuPOf50mYZh00Z5XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eEh1BqswoHduG9oop33Az9TKXljfW3F9d2mhubpTL00w+7sI2Bxwr+YQyOGwZl7sK
	 MhJWEusJFvap0UM4BgBZ5H75YgdngB52ZuTWLHaFqC+jP2aZPOLpyM8OKdLaQDRdBi
	 79cuL9urUZBnnBw995W3elJj3j5pLY0GIPM3fFx0=
Date: Tue, 11 Jun 2024 12:19:42 -0700
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
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
Message-Id: <20240611121942.050a2215143af0ecb576122f@linux-foundation.org>
In-Reply-To: <2ed64218-7f3b-4302-a5dc-27f060654fe2@redhat.com>
References: <20240607090939.89524-1-david@redhat.com>
	<20240607090939.89524-2-david@redhat.com>
	<2ed64218-7f3b-4302-a5dc-27f060654fe2@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 12:06:56 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 07.06.24 11:09, David Hildenbrand wrote:
> > In preparation for further changes, let's teach __free_pages_core()
> > about the differences of memory hotplug handling.
> > 
> > Move the memory hotplug specific handling from generic_online_page() to
> > __free_pages_core(), use adjust_managed_page_count() on the memory
> > hotplug path, and spell out why memory freed via memblock
> > cannot currently use adjust_managed_page_count().
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> 
> @Andrew, can you squash the following?

Sure.

I queued it against "mm: pass meminit_context to __free_pages_core()",
not against

> Subject: [PATCH] fixup: mm/highmem: make nr_free_highpages() return "unsigned
>   long"


