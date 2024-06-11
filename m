Return-Path: <linux-hyperv+bounces-2393-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C2F904517
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 21:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA271F24ACF
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jun 2024 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03267F492;
	Tue, 11 Jun 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AO+gqqlC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142614D8BB;
	Tue, 11 Jun 2024 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134915; cv=none; b=ucHyLeTjvniUNrAzX1prDuZ0sVrx62g+7JTz46gLOxBWqaLkZ3fqUVwCo3mUNta8oRkWVxbuGXMEBycRKjCn3jmuUhkiHaAc2uRtkbpo4ziuYa1jjFoj3Imr/3dKuR61bGwK+/hoBdGXlMPLeMhsaBTftLcHe0sgBUv7ypN4Jzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134915; c=relaxed/simple;
	bh=3jSJzP/wKvbuiDtG0srhckDI0jqTpk/NVaK27TegDYY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4RRBsAn2/2cHCHFDyge7lTYTn0H08effQoCP42hiY/UVvw6xA0Wog1M7vOt4aDN1D8WqzcrZ0u0RtelxfuM2+jgLKVHgMdY8yimfvH0UjiTN1hLnrKFKVCZmUbRnl4LFsNRJcTnI+AZyaMl7FX02r8uXWwE7u7317JCiXmBB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AO+gqqlC; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718134914; x=1749670914;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3jSJzP/wKvbuiDtG0srhckDI0jqTpk/NVaK27TegDYY=;
  b=AO+gqqlCb39u+0nU5I4srhI9ge73zIQ6KK5kFQX9wl1aAZ6j5ZXe4p5/
   Ir0NMhVoJjuDm9O909wicw1+g4+9gd0f/C4aNAoLIBDvhtZOjyzwXCocK
   tfJAu8kRMcMixLE+fofhcKTyKiXp+2FjCoioffKBwDSWQIAJKu6soql97
   Vb2n4w5p7VfM9hM6HVS54IF8mxnBU9F7H6mX7zfouZvKuv1OIjzEMWI9w
   aj4t4a62cjdemGYAggYvqNovhqAFWeSW5Rbsy32zCiuKQhfY3K/x/cyXC
   8PvGTFbMRzGjwTyA3ejC9Y/5xQeWTxFvBmdAQJ0rEqPVmOuzR8iA2Cpxq
   Q==;
X-CSE-ConnectionGUID: 4swRpQGIQDCnUX4GSovDaA==
X-CSE-MsgGUID: r0oiH39IQCWTk79TOFwg4A==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14826582"
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="14826582"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 12:41:53 -0700
X-CSE-ConnectionGUID: RmVZgz1VRteabv7gZ38CIw==
X-CSE-MsgGUID: YWjwba72SB6sl89EETJtkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,231,1712646000"; 
   d="scan'208";a="39643390"
Received: from mmasroor-mobl.amr.corp.intel.com (HELO [10.255.231.206]) ([10.255.231.206])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 12:41:52 -0700
Message-ID: <80532f73e52e2c21fdc9aac7bce24aefb76d11b0.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/3] mm: pass meminit_context to __free_pages_core()
From: Tim Chen <tim.c.chen@linux.intel.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-hyperv@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 kasan-dev@googlegroups.com, Andrew Morton <akpm@linux-foundation.org>, Mike
 Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>, "K. Y.
 Srinivasan" <kys@microsoft.com>,  Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>,  Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 11 Jun 2024 12:41:51 -0700
In-Reply-To: <20240607090939.89524-2-david@redhat.com>
References: <20240607090939.89524-1-david@redhat.com>
	 <20240607090939.89524-2-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-06-07 at 11:09 +0200, David Hildenbrand wrote:
> In preparation for further changes, let's teach __free_pages_core()
> about the differences of memory hotplug handling.
>=20
> Move the memory hotplug specific handling from generic_online_page() to
> __free_pages_core(), use adjust_managed_page_count() on the memory
> hotplug path, and spell out why memory freed via memblock
> cannot currently use adjust_managed_page_count().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/internal.h       |  3 ++-
>  mm/kmsan/init.c     |  2 +-
>  mm/memory_hotplug.c |  9 +--------
>  mm/mm_init.c        |  4 ++--
>  mm/page_alloc.c     | 17 +++++++++++++++--
>  5 files changed, 21 insertions(+), 14 deletions(-)
>=20
> diff --git a/mm/internal.h b/mm/internal.h
> index 12e95fdf61e90..3fdee779205ab 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -604,7 +604,8 @@ extern void __putback_isolated_page(struct page *page=
, unsigned int order,
>  				    int mt);
>  extern void memblock_free_pages(struct page *page, unsigned long pfn,
>  					unsigned int order);
> -extern void __free_pages_core(struct page *page, unsigned int order);
> +extern void __free_pages_core(struct page *page, unsigned int order,
> +		enum meminit_context);

Shouldn't the above be=20
		enum meminit_context context);
> =20
>  /*
>   * This will have no effect, other than possibly generating a warning, i=
f the

Thanks.

Tim

