Return-Path: <linux-hyperv+bounces-9912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGT5FqmPzmkbogYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9912-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:47:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8BD38B6CE
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F5E130C8DFC
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EE62E266C;
	Thu,  2 Apr 2026 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="xLrHu0Ox"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919F2FC01B;
	Thu,  2 Apr 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144717; cv=pass; b=NuE/ZZw/TnYsk8HV/UQOCn/7WGvYn1JpB/rFVgB8268T6UqVkMltw0fJ3aYU9lOSeTzMd02xNeNwvyl3wZ0P1SYjQkqPhlv59R4GtMBM6PGk71MNbtzhtpcVnm418CTWfbGUtHvg41/DRW0paJHNDAHIsioFepUF+qntkuyECRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144717; c=relaxed/simple;
	bh=/FkCBp2auy5mAbpfVpk+aEazetpheVAQOJSKyOZpoF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nxflgm5ZT7HPWYb7kR/sfhoK363jo2rIKIzOQVwdNQGhtdSYntgXzmZqGpOm4H/qaj2TTenRmJSSWeLkafstHpKrI9uJJ6zE1Th3UA3gxDvFbQZfXmqT445WZRqALbvbelr+m+GCofevNd6fygd3Eu0iGbFe9qsO5bXGvESuKG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=xLrHu0Ox; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1775144705; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Aluv6uiow7AApgvAzuZWMRootT9LgEGVKUsQn7uB+UNSbLLH4RnvhmX3Qyl8iAFlWs8swUkg9F1ee2V9Xw6hiAq4ejZ0n089ooPo258Ha0sFPfkw0pH+dOECJaH1vKId/11L7vzeEKWpLNi3WCqjK9i3as99H/R1j9D4S7ci31Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775144705; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5ua02cmkRbGq39OVjUW1ufiZjvjlzlcBpR/kDl4H+fY=; 
	b=UBU8rvR2jHRxom+qX3F6ih3DMzYMb7vndnt9jpXYXMcT/ApiNikGObPQbWZ7VmRME/QcvGTAE8cPFPpdxxDFuzmGr03ERJaBcJrDxaODFv08EFdpj37XPxwCghb82jnzzv3kmCI4sbH1uojoEZPouwMM9j8Ijvnkzf7JIJuJwOY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775144705;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=5ua02cmkRbGq39OVjUW1ufiZjvjlzlcBpR/kDl4H+fY=;
	b=xLrHu0OxYTAvZiuuKf01lyqwaOcTVHDE5Z4la5mVOfYYy93tk2lgrHPx1bFCt2l+
	DMdDIPDRdcJH4BJnYJQtQxcUGY0UIF7u2ROxf4HVDx1ZixL5xPZdzIJ7qfTlAK2JHZN
	6176mgyI0JZkChzNas1jsu5S39H+LIu1RHJJXjfQ=
Received: by mx.zohomail.com with SMTPS id 1775144703947908.4536148690371;
	Thu, 2 Apr 2026 08:45:03 -0700 (PDT)
Date: Thu, 2 Apr 2026 15:44:58 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix infinite fault loop on permission-denied GPA
 intercepts
Message-ID: <20260402-rare-heretic-tench-adfc68@anirudhrb>
References: <177439665824.171668.3582744847973205980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177439665824.171668.3582744847973205980.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9912-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudhrb.com:dkim,anirudhrb.com:email]
X-Rspamd-Queue-Id: CA8BD38B6CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 11:57:40PM +0000, Stanislav Kinsburskii wrote:
> Prevent infinite fault loops when guests access memory regions without
> proper permissions. Currently, mshv_handle_gpa_intercept() attempts to
> remap pages for all faults on movable memory regions, regardless of
> whether the access type is permitted. When a guest writes to a read-only
> region, the remap succeeds but the region remains read-only, causing
> immediate re-fault and spinning the vCPU indefinitely.
> 
> Validate intercept access type against region permissions before
> attempting remaps. Reject writes to non-writable regions and executes to
> non-executable regions early, returning false to let the VMM handle the
> intercept appropriately.
> 
> This also closes a potential DoS vector where malicious guests could
> intentionally trigger these fault loops to consume host resources.
> 
> Fixes: b9a66cd5ccbb ("mshv: Add support for movable memory regions")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   15 ++++++++++++---
>  include/hyperv/hvgdk_mini.h |    6 ++++++
>  include/hyperv/hvhdk.h      |    4 ++--
>  3 files changed, 20 insertions(+), 5 deletions(-)

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


