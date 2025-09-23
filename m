Return-Path: <linux-hyperv+bounces-6972-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDDAB94F11
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Sep 2025 10:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E162E3A55B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Sep 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38F23101C2;
	Tue, 23 Sep 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="ZK+rYXV9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EB26D4DA;
	Tue, 23 Sep 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615221; cv=pass; b=P7vZsjiabTndCdD8U9g1Y7m3yAli0RmaENjJtCC1g1nm24Ilc4lRhtiFSeU6hQYGNmr77TFnyJyw9OA75pZmCYtbYOmSiiPC5BhPnqnkH4seAQ4rnWnhamBHLzh88KfmMRHpVipZuQN/drZZrxNEFC4b10gVltE0W1+r4j7Gims=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615221; c=relaxed/simple;
	bh=v1z8I7LHTd1S54Kk6OtZb6YZesD83PEak2QvUknS/5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrnGEoCYhhtRvikn9jVu1yQSvV//u7GcOKhzDZRMs5qnerS/raKFtoRw2vkKEuW8CM7W+ICEhWzUdMNN90nuR6h1dmKSHNT2gmBhfcqPPqrV9eztZVWnbUeb077U76VI5Yx0nClsE0qbJOiqDstQ/TwNU7Ub5bp8I/6x+2+VY5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=ZK+rYXV9; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1758615209; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EL3aqBndY/x6L3pCRV1JTt+N+nm6SAoT8mHdK5bYNmGcX0fbu8FeqEpwGBx57WYN0Plczd+jN/Ep5WI6oYuXWWQteVtsoSH2aJO3hogLCdQVTtUdneLx3WoUEMFF1/wvSB8d0CVaAMcuIUV0FHLRDnb8LWf9gCjbGpTvdIVHR8M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758615209; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C9DTAoEOjasD6g9mOY3kW7X/PBdvh2Nm82DUSoq0Gvw=; 
	b=HkA3R6FfoeeLgtL4dj/iChjaiVNEYGn+xSsAyWoJVQPwL4Yza5h30msSnKeLxe0kD0/is+b+GKiDzPbvksoTT283HJ3FajjYLK3/73BGnNaI+Rk5/29cZz8/XT5fij25IKxB0JWpNirvGi6Z/XdrovxUz0incU9/HtdIl/NJbGc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758615209;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=C9DTAoEOjasD6g9mOY3kW7X/PBdvh2Nm82DUSoq0Gvw=;
	b=ZK+rYXV9a+WgPL/BonwKZ5F1y3tS3SS7JF7wNrY1Y2YvkVa7k1V61JKVJM6Viv1y
	6/TUjc1ElK3ELtcdZ4mWoaOXRb5nVGqmuQA6zo0pW2/Pz9iftW7xlFujFVnHB704f/O
	fk+zK9K5Xk+AOQs8dfLgQiv1u+GjQByhhDo241rg=
Received: by mx.zohomail.com with SMTPS id 1758615207097808.8085793888619;
	Tue, 23 Sep 2025 01:13:27 -0700 (PDT)
Date: Tue, 23 Sep 2025 08:13:21 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, paekkaladevi@linux.microsoft.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, Jinank Jain <jinankjain@linux.microsoft.com>
Subject: Re: [PATCH v3 4/5] mshv: Allocate vp state page for
 HVCALL_MAP_VP_STATE_PAGE on L1VH
Message-ID: <aNJWoV0H-7U85GMX@anirudh-surface.localdomain>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-5-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758066262-15477-5-git-send-email-nunodasneves@linux.microsoft.com>
X-ZohoMailClient: External

On Tue, Sep 16, 2025 at 04:44:21PM -0700, Nuno Das Neves wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com>
> 
> Introduce mshv_use_overlay_gpfn() to check if a page needs to be
> allocated and passed to the hypervisor to map VP state pages. This is
> only needed on L1VH, and only on some (newer) versions of the
> hypervisor, hence the need to check vmm_capabilities.
> 
> Introduce functions hv_map/unmap_vp_state_page() to handle the
> allocation and freeing.
> 
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root.h         | 11 ++---
>  drivers/hv/mshv_root_hv_call.c | 61 ++++++++++++++++++++++++---
>  drivers/hv/mshv_root_main.c    | 76 +++++++++++++++++-----------------
>  3 files changed, 98 insertions(+), 50 deletions(-)

Reviewed-by: Anirudh Rayabharam <anirudh@anirudhrb.com>


