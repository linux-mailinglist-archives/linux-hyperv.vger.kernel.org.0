Return-Path: <linux-hyperv+bounces-2496-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DAA917459
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jun 2024 00:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDC286E31
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2024 22:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3A317F37B;
	Tue, 25 Jun 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LalejVUM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE2149C6E;
	Tue, 25 Jun 2024 22:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719355426; cv=none; b=i5b10hyxLrEF6hMk+kgpvvOvpEXFFyQkfNj0egfc1gp9CJPPbkStVgHusouUWnt7H6J0QQfFEKSQtAISZw3us7j90/U6wY8Hg191eYiJrFqilkCOYvKm8uKMzPDJepb0CNk0+mh02Stv3bVRTLGCNGGCAMgKXyOzO62nwWigFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719355426; c=relaxed/simple;
	bh=TXSHlymv2cQdW6Cq8S2aO79qhvv/iUOqt59Pv0/5CXU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FOfd5Wa79brQnhRfIDmA98LqQWqUH4g4Pf6dXQXZoDXyr6SvXSINKiAGhzsFVqT9W7BntakVPMtzODcX5Y0DGVNih3tsyJKtW/a92WdKVh5sBvycNHJKOrTWz9cklQba8P2V5TTV/df9MR7xENCxfMwZAGhjA6mp/tWemNqKNgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LalejVUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3666BC32781;
	Tue, 25 Jun 2024 22:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719355426;
	bh=TXSHlymv2cQdW6Cq8S2aO79qhvv/iUOqt59Pv0/5CXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LalejVUMAXCZLbTrD760WCKxVsMt+y/H6z57ZUZWJ8bcVEpj19D2HYs0wTGwNfn50
	 lWMnhSd6uPZeT602t95YLigRh7bMgkNVpbcXDY0b13d+wNFpIToVB/OIU9+bzKAotf
	 ohw/Pr2e6FkpvNZtWPIghnTGjZ2Dym6GlV1UmDWg=
Date: Tue, 25 Jun 2024 15:43:44 -0700
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
Subject: Re: [PATCH v1 0/3] mm/memory_hotplug: use PageOffline() instead of
 PageReserved() for !ZONE_DEVICE
Message-Id: <20240625154344.9f3db1ddfe2cb9cdd5583783@linux-foundation.org>
In-Reply-To: <20240607090939.89524-1-david@redhat.com>
References: <20240607090939.89524-1-david@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

afaict we're in decent state to move this series into mm-stable.  I've
tagged the following issues:

https://lkml.kernel.org/r/80532f73e52e2c21fdc9aac7bce24aefb76d11b0.camel@linux.intel.com
https://lkml.kernel.org/r/30b5d493-b7c2-4e63-86c1-dcc73d21dc15@redhat.com

Have these been addressed and are we ready to send this series into the world?

Thanks.

