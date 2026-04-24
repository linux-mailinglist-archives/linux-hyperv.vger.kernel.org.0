Return-Path: <linux-hyperv+bounces-10363-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOe9C3GF62lBNwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10363-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 17:00:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D237460728
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 17:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CC1830382AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3713E0C57;
	Fri, 24 Apr 2026 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="gk6Lx6B5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C83E0C63;
	Fri, 24 Apr 2026 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042738; cv=pass; b=LhPsHvvUzo1rJKky/bUHf+aqfz+Jpk6mPTzdRBzr1oXNHkhTeQkVLhThM4uUwVTLL640RH2VxFMaGJcTv4D5czEYJ/7rGvdnPetnpCMOdIm3xo3vRQCNOZnmqO5Esb1njCdGG3Zb84Eew8NVwOew1yINANRZf4p1604wNMtaZIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042738; c=relaxed/simple;
	bh=FRr38I7cMflzCgQM25o0tQ3TLRcq4FZP6JuHF3oUnhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omxwy1Zs3aImbaA97DYS0w+0ub5T0FKbfEz0H7Z6UXPT0PfLfJ09uWKuYGUlhKdCSWxaA3/LVP+0Nw471I72vq7WKymiiJZL/3bVfpj7R1Bm4wMEHQyIzRNwlDVEVW3ShvS2aKKEM6/1Y7HwnQP/5x+th8guf1GtyBIvVx8N+Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=gk6Lx6B5; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777042702; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aycJMPuvWM130Y7GH4WCHuXEzOdY81F2d13LoCw6FQe39BJhkluSlFXnoz3KWswseKdnxwjSAhXshf/fONAlD2OUf5Hi+oJPsmqQVEHOGu3Kt2XC0lG/Eyi78fry6Z5F3Si8wQXYLtMZ0BvifMLt4150bxC/ZD1Vo04gxaQS80E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777042702; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jc9dVVt1flEcC54ECMR2u7OzYKiCI+2ZnuPCR00/9xY=; 
	b=VTubVyo7op48zoKbIfHn8xQwEmhPoOapyoRkdkMlIK6+2bgjtAO7gNYbK8FwjLqqYudu3zzdbjWzGnCO6RiPnIxuLTSjn3jjtFIKNu0Gun+I5m2UfXMrSKP5zwuA8Pr2Ff2LfYxo43k86dPG88jO52gQI8r4aB2xDAVi8kBw++o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777042702;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=Jc9dVVt1flEcC54ECMR2u7OzYKiCI+2ZnuPCR00/9xY=;
	b=gk6Lx6B5W04qq8YuuuvAEYtygTRaUHN/kjqs6YqGdQcuj6c1sZUvcj9xor1uKg24
	NRZPE60lQc4z8+PrXWofcjPYFiUeilxJI0LSQvyuGySTDcTsymHNCWgEubH+LmrfGli
	BeU3rzeRC/4mtdoBjV5xROL45u6aT3hR9MpltOis=
Received: by mx.zohomail.com with SMTPS id 1777042699264442.63793575006525;
	Fri, 24 Apr 2026 07:58:19 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:58:08 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 01/13] iommu/hyperv: rename hyperv-iommu.c to
 hyperv-irq.c
Message-ID: <20260424-furry-significant-slug-3fc0ba@anirudhrb>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
 <20260422023239.1171963-2-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023239.1171963-2-mrathor@linux.microsoft.com>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 7D237460728
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10363-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:dkim,anirudhrb.com:email]

On Tue, Apr 21, 2026 at 07:32:27PM -0700, Mukesh R wrote:
> This file actually implements irq remapping, so rename to more appropriate
> hyperv-irq.c. A new file to implement hyperv iommu will be introduced
> later.  Also, it should not be tied to HYPERV_IOMMU, but to CONFIG_HYPERV
> and IRQ_REMAP. The file already has #ifdef CONFIG_IRQ_REMAP.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  MAINTAINERS                                    | 2 +-
>  drivers/iommu/Makefile                         | 2 +-
>  drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} | 2 +-
>  drivers/iommu/irq_remapping.c                  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename drivers/iommu/{hyperv-iommu.c => hyperv-irq.c} (99%)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


