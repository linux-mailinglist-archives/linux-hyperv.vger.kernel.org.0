Return-Path: <linux-hyperv+bounces-8991-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKnRFUhSn2k7aAQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8991-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 20:49:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FCF19CECB
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 20:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 574AA3022040
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008F31D399;
	Wed, 25 Feb 2026 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mH5Nc96g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4C258EC1;
	Wed, 25 Feb 2026 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048965; cv=none; b=hlVjIOWt6CSpLVU1bA3vPAHvTcHuiLzulDeuTuJS+MPADp3gUevrbWgZd5v5ty/W/5nyRP5a96spMfOCLuorhHvu9x5cpFrAuu983T4qRSl6VaKqaVgt900Q7GzP39JGta1u2VGVL2RMwCjuNyHw4U3H3ogPZqibt+qOeco65nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048965; c=relaxed/simple;
	bh=XXsaVnR5RoMzHp1jwobt30rnkjQCaIg63M0f2GH/7to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1+zsF60tWIEA9NJhxou1Nx6zlWIUrd8T62C2cWZmksTbwtL6e7ZKsFzItYRV7r54c7vDMnU3z1aoQGTS5zfywDJMR+gbcDx1zFZeRVU+I1NK3EvUUtOUAJGucWWGceTRfDYDiZ+BXOQP9fNVgyHm4KfdBzbXkFa/TyR/Y0FT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mH5Nc96g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C56DC19421;
	Wed, 25 Feb 2026 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772048965;
	bh=XXsaVnR5RoMzHp1jwobt30rnkjQCaIg63M0f2GH/7to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mH5Nc96gkSdNQrXq2JqKlgnivuWROGS1fOkYrNsIcdtZOhVDLeh7L+IdNGRFGZTI+
	 AMGUReARgRcuusg/yOdqATpnaZXDlcf53NNtnKCtQBQZi+Zy13ro0XMvyctxi61xt5
	 IPOi+OQLpdAzoFC+j3tNfaC+CjXti1YaLnuqidiaAJqFWPvb9hCwyy6GgTTPM6tH84
	 KrzPHJX8DmacSgdAiRiar6resaQzj6AF7E/uzimOLsUGrJKa1zkdmBPO0xanXyz1uN
	 8fqe36QjEeK1mAXv9YeIi3t9RFRp9NiRiRUFzEzVl8SmNGsCNH6P6lqiTMy54JsTJJ
	 chVbDsX1x2UCQ==
Date: Wed, 25 Feb 2026 19:49:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] ARM64 support for doorbell and intercept SINTs
Message-ID: <20260225194923.GB413976@liuwe-devbox-debian-v2.local>
References: <20260225124403.2187880-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225124403.2187880-1-anirudh@anirudhrb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8991-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: E8FCF19CECB
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:44:01PM +0000, Anirudh Rayabharam wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
> interrupts (SINTs) from the hypervisor for doorbells and intercepts.
> There is no such vector reserved for arm64.
> 
> On arm64, the hypervisor exposes a synthetic register that can be read
> to find the INTID that should be used for SINTs. This INTID is in the
> PPI range.
> 
[...]
> Anirudh Rayabharam (Microsoft) (2):
>   mshv: refactor synic init and cleanup
>   mshv: add arm64 support for doorbell & intercept SINTs
> 
>  drivers/hv/mshv_root.h      |   5 +-
>  drivers/hv/mshv_root_main.c |  64 ++----------
>  drivers/hv/mshv_synic.c     | 188 +++++++++++++++++++++++++++++++++---
>  include/hyperv/hvgdk_mini.h |   2 +
>  4 files changed, 185 insertions(+), 74 deletions(-)

Applied to hyperv-fixes.

I debated a bit whether this is a new feature or a fix and decided it
fixes an important gap in arm64 support.

Wei

> 
> -- 
> 2.34.1
> 
> 

