Return-Path: <linux-hyperv+bounces-9695-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHiSIHNgwWmaSgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9695-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 16:46:59 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F512F6E51
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 16:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B1231774B4
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2026 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2F3AE1A1;
	Mon, 23 Mar 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh/bhj38"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894F8271468;
	Mon, 23 Mar 2026 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279583; cv=none; b=SPNyssdTD2/TU5OI4XopE81wCANdnCGU/c4Ntsj9GzmYmNeavEB39LC5l5mDnjAvTi183zKdHR3SBnik16gP1Lpi/POhtoajtdf7a6cXnaBp4MxoNagYrkDENAe15T6naZche73j6hVjQETJFWjo76sH9pkfRbRkmHs1Vfj0L+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279583; c=relaxed/simple;
	bh=ANcbfjF03b/lmDqKI8A0U8r4MSNANuwX81x/VEjwFLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYZd+ZYss21lPN+c6hAKAauZR+s2gR1bEbD4NPl13kBiGpm55oGyxjuK9Qw4CU/ik3kfGRnpiItoZVziIUJAtCG8R/nXtmj8wNaLKfkfAmD4CCDmL+g248Rradolq/rggw55SAS0aYrYN/iyUkrySBNkUsJVr6UYX/p1XMiq+jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh/bhj38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7A9C4CEF7;
	Mon, 23 Mar 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774279583;
	bh=ANcbfjF03b/lmDqKI8A0U8r4MSNANuwX81x/VEjwFLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hh/bhj38USKevvX95jRTc3M6qr5235NguDX/NIA/JbZ19lDw1C/YLnANCTX3Cp6A0
	 paha+3iU02vir2Dsukdb4/Pgvi0tIlIiCd07H9rh6z2D9SHaj7KiOMi1INYvQEwsGj
	 QVwrjCDl9Ur3A02PvCNJy29wb9w193R4HdbC+pVnCY4hgIJCtrGQ5yt6ErL3zS1i+l
	 Z4oAw3RbmPZpGmObX8X33T3ALEpYrkgVy5ooEmzUH0znszAttsw0a2m2w92t5zKB06
	 EDRR0YEa89fgF8Lx7eSRFc3z+F+Cqi3M2q6evGBmpt/kxcfVR2q8T4qCe9I3wtBwlR
	 Hbim0GlTq8g2g==
Date: Mon, 23 Mar 2026 15:26:17 +0000
From: Simon Horman <horms@kernel.org>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, sgarzare@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] hv_sock: update outdated comment for renamed
 vsock_stream_recvmsg()
Message-ID: <20260323152617.GA112574@horms.kernel.org>
References: <20260321105753.6751-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321105753.6751-1-kexinsun@smail.nju.edu.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9695-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2F512F6E51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 06:57:53PM +0800, Kexin Sun wrote:
> The function vsock_stream_recvmsg() was renamed to
> vsock_connectible_recvmsg() by commit a9e29e5511b9 ("af_vsock:
> update functions for connectible socket").  Update the comment
> accordingly.
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


