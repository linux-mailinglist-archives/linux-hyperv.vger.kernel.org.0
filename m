Return-Path: <linux-hyperv+bounces-9808-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECLqKemSxWlG/QQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9808-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 21:11:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543F33B481
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABFB2300FED4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Mar 2026 20:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459CF3537D3;
	Thu, 26 Mar 2026 20:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgcZD9KR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3C332604;
	Thu, 26 Mar 2026 20:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555667; cv=none; b=PiyPSSMMi5AWOrleRw6X87FBKBdkb3OM/Q8ywh3gWYRzLi/L29TLtK25p2tFnET12MPmA9AUefA9VO8Yvk7cw3I25JWb5W2FEnUhB4gR3lFmptIrODKJbtJioBSuDxmj1SH18UzisrppSucFWYf+qFCBcNen12wTcb4pvDHqEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555667; c=relaxed/simple;
	bh=bp1iEoeqeUWKYCv7HTMg7A+5K8IQRL9BXMemdoAYYT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUvVhCpfYQglziK/gQ4ZzlKURHus1plPKduLtge4lmEIeZCJ8AYPc79oJLtp0fMBmwmAmXKka8ko0CssCzzvsRThsHXuU36AJ4SNR5w7i2TpaIPl2DOI7Z+CyGRpR8bnfUwxR+BVWfuvSLblvHE7wotI0FZ31FoWaEIhDBNo2jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgcZD9KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AF4C19423;
	Thu, 26 Mar 2026 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774555666;
	bh=bp1iEoeqeUWKYCv7HTMg7A+5K8IQRL9BXMemdoAYYT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FgcZD9KRl1ruYV0QQ45A33vgyq9qWjiTVHx3mE961Jym2mBaccT89Sz9ZFKm3X+cm
	 sj67BdmhcWHr/0kV8jUDV6pcamMrsCcc2sngCsKRKNpUb2r7vmrVX7HX9bXNv9xtjj
	 /RAcdBlJ9A+M8VNuwAkapSphCmv31Xld/vDyeU6nQ2cJSdipPZIqHqhCL+4oJ4YbJv
	 qF6MgqpNSW22oMcMV2E8GIUq91k95q5Gafvq+ojg7JgbXKlXL1161KlRnYEOO9VYsV
	 4Nx9ogTtUxzmjgzXYlIxnQmXHpuPg4AEoStmsbc0sgvKv98EBZjSJGLRqwIyKyiIOp
	 I1J1W+/QnJwYA==
Date: Thu, 26 Mar 2026 20:07:40 +0000
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shradhagupta@linux.microsoft.com,
	kotaranov@microsoft.com, dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com, kees@kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Use at least SZ_4K in doorbell ID
 range check
Message-ID: <20260326200740.GY111839@horms.kernel.org>
References: <20260325180423.1923060-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325180423.1923060-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9808-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1543F33B481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 11:04:17AM -0700, Erni Sri Satya Vennela wrote:
> mana_gd_ring_doorbell() accesses offsets up to DOORBELL_OFFSET_EQ
> (0xFF8) + 8 bytes = 4KB within each doorbell page. A db_page_size
> smaller than SZ_4K is fundamentally incompatible with the driver:
> doorbell pages would overlap and the device cannot function correctly.
> 
> Validate db_page_size at the source and fail the
> probe early if the value is below SZ_4K. This ensures the doorbell ID
> range check in mana_gd_register_device() can rely on db_page_size
> being valid.
> 
> Fixes: 89fe91c65992 ("net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v2:
> * Remove "db_page_sz = max_t(u64, SZ_4K, gc->db_page_size)" in
>   mana_gd_register_device and validate db_page_sz at the source
>   mana_gf_init_pf_regs and mana_gd_init_vf_regs.
> * Update commit message.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


