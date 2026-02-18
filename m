Return-Path: <linux-hyperv+bounces-8905-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFBlD+FJlmngdQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8905-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:23:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB8315AE99
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC5730440B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 23:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F26733ADA2;
	Wed, 18 Feb 2026 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QasLF9VN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEE33ADAA;
	Wed, 18 Feb 2026 23:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771456968; cv=none; b=BfFGZUko3VnHRjeZ/IFr8QSTkw3T2S27h0YBWfGmM+6pRFsZ9G+PrV1zVipJuExQ936Q/VoQSLaNGXvEtlnwOLd819YthJRurD0vCZZVxsHRsMbOWbiIhkWpZDXQS87Y96AkaTbmo5CZQXUaURq17U1ypgrzQpsnvzSvqbgc6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771456968; c=relaxed/simple;
	bh=NMsf/JcvSpSUwb8aHp/AjvdiT0Stok3U1ELqzxVPqtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR9LUu+v+doklJXYRkLzUDkwzrmd1+9x4e72pRYWhJQpGaAjx6jfwCWEBLM11QHKFuyipQHR8Bt60I/d3J8fnjFFgPJwcQHjjznOoJ/RCMY5zpztWXe8RKT002KsaQkEGs0mu8ceKg0/7aDcIPeBuedNNQKCFUbI+Mfap+/Pcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QasLF9VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA904C116D0;
	Wed, 18 Feb 2026 23:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771456968;
	bh=NMsf/JcvSpSUwb8aHp/AjvdiT0Stok3U1ELqzxVPqtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QasLF9VNvX6y6/xcFr1WdlK/3qpZKF/EG/2+NmJBvVPAkgdh9IJJVPlI/UkGungD2
	 Kr3/VW58JYv1M8MrjMeqXboWYZCFzhuuenHny4BDhTzVVqFrsdSiveEUg0Y3TPjFtm
	 b1Snenx7q95YSuLTrDdRLq2pbkjA59j65vueRWifivbxyWIC61OtqQBD9EcICUet3R
	 klqj4pNkmSpSg8c1vHXORKLiGPxfclS5hsv/Yxsqz9JAjFg0dB86EJIjX2R1hIv9hb
	 YEmxsJaFTHf2996/BsonlnE/Dr8fmnvm4ao7DVMo3Wj8hKRgMzhPKebhpOzy9kaiR3
	 e3PvDrGuT9wSQ==
Date: Wed, 18 Feb 2026 23:22:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mhklinux@outlook.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Fix error pointer dereference
Message-ID: <20260218232246.GJ2236050@liuwe-devbox-debian-v2.local>
References: <20260218190903.7874-1-ethantidmore06@gmail.com>
 <DGIBQKCDK1KA.1BU93405XZZ9R@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGIBQKCDK1KA.1BU93405XZZ9R@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8905-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,linux.microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,outlook.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9BB8315AE99
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 01:11:18PM -0600, Ethan Tidmore wrote:
> On Wed Feb 18, 2026 at 1:09 PM CST, Ethan Tidmore wrote:
> > The function idle_thread_get() can return an error pointer and is not
> > checked for it. Add check for error pointer.
> >
> > Detected by Smatch:
> > arch/x86/hyperv/hv_vtl.c:126 hv_vtl_bringup_vcpu() error:
> > 'idle' dereferencing possible ERR_PTR()
> >
> > Fixes: 2b4b90e053a29 ("x86/hyperv: Use per cpu initial stack for vtl context")
> > Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> > ---
> 
> Oops, forgot v2 header this is the v2.

Applied. Thanks.

