Return-Path: <linux-hyperv+bounces-10361-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAkAHwSA62lLNgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10361-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 16:36:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2196460498
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 16:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E5E30075FD
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BF3DC4D6;
	Fri, 24 Apr 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="oE75Jntu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8FE3BE632;
	Fri, 24 Apr 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041331; cv=pass; b=LculbE7is0ve6t8jQtXhLM/rZO6WDu/Va/ZFjLIhYGQEBuwmiwW7+1HwDihb1u2RPcBGC4JVLxH2tansxkxal1/CE8R3n4ZCWRyZCb5wKhjWCXuZTD+4SXJmTYcSRvpmlwmk1YEVK6xbvAJe/a0LW/zJ3KHsu4e60rkonp7BV4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041331; c=relaxed/simple;
	bh=HoXuzA3iPUwjrKoduj2ysGsZJvVgpgI714q1YBWglkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2EMkjrtZMy9sJZHJ5rzrcDkOLimboBc+EYgS5jrmjOW/ah2tTDzjeR30FczSVxmYP4bMz5n32H3vr+MSjp6bfXw5OXoz7AE9hx5yxhOieCUZNvubNDsuupeoKGJN4k0HayVbey+Kbu854NhOioXu2cmAAUUFbOWGp9eXbZOx7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=oE75Jntu; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777041318; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q5GN8nwgAywt+nt/rpNvhqwGNQdOd4R0pKvNY/xByMs6k/m3kmH82Y3n6hephcj6jMAvaHX1jOUcQxmojD3sCNIJkX1rkwxMRNkiZeNhPIHhJ+0m+F05MXXZf3mmPykQiito8TtAcdchpIlTKe/nQfiX7lb8ZIFHj6PrX0SSVuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777041318; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WSBXsU7J067v34LoCBp0D999tnNI8HsbueW7xl7ulsk=; 
	b=AWLZiG9gwwZ62pDlwtL/CwRQoKJo/U9dQ9+EOcuztunbW/w+kPDELXmuJ74sLXE/f0MruNWIv4b7+lkxPIyRj+Rgvl88RZfyAO1B3nqEGZgPT0rtBlQXJI4G+LctDc+80zOhlKTSL+dPMlfoBd5jjGqLe5saNmkAXwiw/OPLm14=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777041318;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WSBXsU7J067v34LoCBp0D999tnNI8HsbueW7xl7ulsk=;
	b=oE75Jntu4QW15eQlXvvUmB6gl7BFlzOpH8WxvViECL4NZfIBc0ShfTRQr781C8cj
	UA3LZ+GH4qD2hBCUvS/+hniKnY5FMytp6Ag+RN3/cbeixXKBrlBdcvbAqlAuOhaHnwx
	8WkzoT4x4OC2v3DuZO4/tEgB4vty7qTb3HzzGiFs=
Received: by mx.zohomail.com with SMTPS id 1777041315267880.469744397844;
	Fri, 24 Apr 2026 07:35:15 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:35:09 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix interrupt state corruption in hv_do_map_pfns
 error path
Message-ID: <20260424-merry-elfish-fossa-885586@anirudhrb>
References: <177681692062.637858.4160821495321404639.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177681692062.637858.4160821495321404639.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: F2196460498
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10361-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:dkim]

On Wed, Apr 22, 2026 at 12:15:28AM +0000, Stanislav Kinsburskii wrote:
> Restore interrupt state before breaking out of the loop on error.
> 
> The irq_flags are saved before entering the loop, but the early exit
> path on error fails to restore them. This leaves interrupts in an
> inconsistent state and can lead to lockdep warnings or other
> interrupt-related issues.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 7ed623668c8ec..6381f949d9d91 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -237,8 +237,10 @@ static int hv_do_map_pfns(u64 partition_id, u64 gfn, u64 pfns_count,

Umm... I don't see this function in the hyperv-next tree at all.

Anirudh.

>  			} else {
>  				pfnlist[i] = mmio_spa + done + i;
>  			}
> -		if (ret)
> +		if (ret) {
> +			local_irq_restore(irq_flags);
>  			break;
> +		}
>  
>  		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
>  					     input_page, NULL);
> 
> 

