Return-Path: <linux-hyperv+bounces-8035-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D72CC3D84
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 16:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78D503009F2D
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 15:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E93596E1;
	Tue, 16 Dec 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i262Xwwu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AA83590D6;
	Tue, 16 Dec 2025 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898088; cv=none; b=djxjhiiCYv+Qgd714owlG9FRp3AkCU/sLAtaLTnRAI5gXZXlaoLGn52lzqT6Q6TfJGeLgtp7UY/AzsdgJrNdKFYXj1t7bjBmhsUCukeM0Zv+l0dEGeYiXRtUXZtJ7HKEsGUUR9nJZ3NDJKkUm8KI7JtC9McBnQ9xCC/+OUnG+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898088; c=relaxed/simple;
	bh=vbH4lfU4OaMRR6m/SXJoCDqFgTX/oggcskfyWPQN/W8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=O9gDSlvRy+dpEBmbO01jhqidR2qev+Y3sfqFRn42kGGr7Gy6zq+RVdjNMagPw1Wg0AEgYZggcSf+o3BFnMFJhdumQqgSdHlzPED8BcoGa5VNxvXJfdtnf/sH7yRkTXhYkQP2C/lqGSRyLdTrW4V1nQrIIhzd5Ff88njBlWXWF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i262Xwwu; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dW0pV5WWBz9tNR;
	Tue, 16 Dec 2025 16:14:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1765898082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZAv/aSP68imDCSQcg3eQLhImeRHS9IyQKJ4c4ZFsa4=;
	b=i262Xwwudk/tNN8hFzXF/Ngga2gw2r+8Fz3CfYS5Yb+G1oXJMJqJFdutpKZ7eEuKoijVis
	IMDe4nMT5bS8NYqvkle8+kwnzlfBR0YrhdGKyXKmS/cCkdZ8TOTNPp7wjROzqVGovQJRzo
	TU17c9qLmgrXaPjj8KXim+XU8Mznj8TTiMkvIwJwbhGYvdJZplyodAUfmHKc0tnMRBq3bD
	G/0BlhtVmjMlBMJaPbnNgMv5KkYyLQA59D1r4mPLVspj0IDDWZG830Gfl77adUrI75xlS7
	HXvR65f1fFZ646JqprZr0dPaWllaBge7dDBkRnxpbII56ypZnKQMjuYkdxpI3g==
Date: Tue, 16 Dec 2025 07:14:40 -0800 (PST)
From: vdso@mailbox.org
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, longli@microsoft.com,
	decui@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <912772765.178375.1765898080667@app.mailbox.org>
In-Reply-To: <20251216142030.4095527-4-anirudh@anirudhrb.com>
References: <20251216142030.4095527-1-anirudh@anirudhrb.com>
 <20251216142030.4095527-4-anirudh@anirudhrb.com>
Subject: Re: [PATCH 3/3] mshv: release mutex on region invalidation failure
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: dc6751303d40ab2286f
X-MBO-RS-META: g5psqzmyxaqm5w68qr1uoakbe4pmkcif


> On 12/16/2025 6:20 AM  Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> 
>  
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> In the region invalidation failure path in
> mshv_region_interval_invalidate(), the region mutex is not released. Fix
> it by releasing the mutex in the failure path.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

Reviewed-by: Roman Kisel <vdso@mailbox.org>

> ---
>  drivers/hv/mshv_regions.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 8abf80129f9b..30bacba6aec3 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -511,7 +511,7 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
>  	ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
>  				      page_offset, page_count);
>  	if (ret)
> -		goto out_fail;
> +		goto out_unlock;
>  
>  	mshv_region_invalidate_pages(region, page_offset, page_count);
>  
> @@ -519,6 +519,8 @@ static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
>  
>  	return true;
>  
> +out_unlock:
> +	mutex_unlock(&region->mutex);
>  out_fail:
>  	WARN_ONCE(ret,
>  		  "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
> -- 
> 2.34.1

