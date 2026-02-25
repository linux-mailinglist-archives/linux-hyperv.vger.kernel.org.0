Return-Path: <linux-hyperv+bounces-8976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDV3HqqGnmnRVwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8976-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 06:20:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F4D191F9A
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 06:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1971303A8C5
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 05:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59C1D95A3;
	Wed, 25 Feb 2026 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="eRrodiiP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF432D249B;
	Wed, 25 Feb 2026 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771996826; cv=pass; b=rrwhWyJR97jZ4Xma3f2ZUmTtJkJ+hzHAH9+yB0NQIirolLfP8tLv5qp4ulW9KNxswSJgA3nAzbiWnv01vDjxQZj3vTCTExq7VF0+8vhi00hHchK/Kw2dLkqOYqXx5+0CjirL8IXLXiCuA8T6DYF+Y2et/3PF5+5SZuE1zLbs5hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771996826; c=relaxed/simple;
	bh=NY+b7G0wWPdKty6t8Rfk6StNdEgRQSilCBLDbNiNslA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwyM3yjFGLhemH6WoHQyP5F/MYVK0OGb6r99xJbQhZ0YOm/FIaauEnfWzV042CNz+v0pSqAx6mDIe45pB0IDd49fDvQiIYrikI9Y46kwD4n9fSRb+rK9hP6UndpAj3og7KbAJYalhm0ynDlBPzwUNCHmeycl5Ga25yIUBzTZCkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=eRrodiiP; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1771996817; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y43AVEj7TN09+DIFPao02Dlk8C+h1gANpLo/RIv7+cPDMHs03Qk9f9qc51h7RcC7VdFbmvijl3U6SWGF9WcX2aC59+Z8t2COX2hWdK8zMFtPiYGud4O3fW+yW+LteC7pPzN/WjVW1ZQleAZPLScx7LVWN8c3uOsdwFJcoFEXl9o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771996817; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oFw66RFaz/pdJjZ4Feq8VPD50BeRGi3P8V16cCb3PW8=; 
	b=mkFFDKB9jpc8+UhzmGNxkygRqyUzO+QnoVDZHlXaik42lF1JEOlZVy79FSO0E+r+SIp1REfXjJZj18zYwqgr3Zi4o4Jq8tahOCT8DuHJvrCngnRMpmlerHILsd8jqGxTHwoV+SY8fW5Lm4PHeJv9Af0GExsrNb0cRm8hlMlvo2I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771996817;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=oFw66RFaz/pdJjZ4Feq8VPD50BeRGi3P8V16cCb3PW8=;
	b=eRrodiiPUVojtXFEi96USVHOHvpYGcjpUZmSWcDrspi6uO5RZpqYCK8FJmUKV8vP
	e3loyiSH82lQtG1RNHfhiNRhEGYpqQLSuNIyC2+yg7XzvEX+OE2Kd7nY38VHuQVcEpG
	OFlZS6HQQV8KJw+Ii8hCDnqA5/q9aoFpwMGrnTcc=
Received: by mx.zohomail.com with SMTPS id 1771996814739592.2486828810191;
	Tue, 24 Feb 2026 21:20:14 -0800 (PST)
Date: Wed, 25 Feb 2026 05:20:08 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Replace fixed memory deposit with status driven
 helper
Message-ID: <aZ6GiMAoacfHX-9H@anirudh-surface.localdomain>
References: <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177153896491.48883.14285093878498416061.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8976-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: E3F4D191F9A
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:09:32PM +0000, Stanislav Kinsburskii wrote:
> Replace hardcoded HV_MAP_GPA_DEPOSIT_PAGES usage with
> hv_deposit_memory() which derives the deposit size from
> the hypercall status, and remove the now-unused constant.
> 
> The previous code always deposited a fixed 256 pages on
> insufficient memory, ignoring the actual demand reported
> by the hypervisor. hv_deposit_memory() handles different
> deposit statuses, aligning map-GPA retries with the rest
> of the codebase.
> 
> This approach may require more allocation and deposit
> hypercall iterations, but avoids over-depositing large
> fixed chunks when fewer pages would suffice. Until any
> performance impact is measured, the more frugal and
> consistent behavior is preferred.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_hv_call.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index 7f91096f95a8..317191462b63 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -16,7 +16,6 @@
>  
>  /* Determined empirically */
>  #define HV_INIT_PARTITION_DEPOSIT_PAGES 208
> -#define HV_MAP_GPA_DEPOSIT_PAGES	256
>  #define HV_UMAP_GPA_PAGES		512
>  
>  #define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
> @@ -239,8 +238,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
>  		completed = hv_repcomp(status);
>  
>  		if (hv_result_needs_memory(status)) {
> -			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
> -						    HV_MAP_GPA_DEPOSIT_PAGES);
> +			ret = hv_deposit_memory(partition_id, status);
>  			if (ret)
>  				break;
>  
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


