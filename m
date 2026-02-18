Return-Path: <linux-hyperv+bounces-8906-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qkY7HvlKlmkmdgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8906-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:27:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D838F15AED1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Feb 2026 00:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88EF03014761
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42E33ADA2;
	Wed, 18 Feb 2026 23:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+BE/qnx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D9133AD89;
	Wed, 18 Feb 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771457269; cv=none; b=c9MSPlrdSju5BthTNLxsFjGHZCXfc58/qQisSKybCWf4qCq5cghlRLeUJ/rBgwWi0paEQwyCWsa9gyOHl/kBjXQ345wqUjAtwGx9qZ82GIgsXCEviGdTK81AnM/lZFroxnPpGCVKELYIjUhC03HtgfaHS0/VmK0ZyR4t+ss9FRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771457269; c=relaxed/simple;
	bh=doeOuSBApm+Mg1WjaDnCLqHu6Mu7xY6QiFNZ484sfpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ4ANg3xPsiUXERuAFL9WgDFyKCcLb3CHkt0gLufBlFJqnDYzRUXWCDtNlbew67YfiR5zr24bL+5c7nl/0r1k3mqXjaLTELUwlOJ3T+ozNTsjneybxNE3o9q0be34jXde9t3hyCCn9NfprqV6R/cz4h7c3u5pWIrCDbM6/49B1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+BE/qnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E75C116D0;
	Wed, 18 Feb 2026 23:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771457268;
	bh=doeOuSBApm+Mg1WjaDnCLqHu6Mu7xY6QiFNZ484sfpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+BE/qnxDXpCPsoqJ3n16bpNtXVoEQNgyxIIozv5KvCShnIIfsm4DQQbLXFi5keYW
	 vg/xv1caByD32w9rHoCpvziiJLeibdxThUh5kT5/BlJpXxbOnnwRMgz30PXrsDPXzS
	 yBxSpum+FvEsCCmsAhQm0Z+gKtUzuYqGuBVp+uhLpn7+n5uVJi/TAYh4ft034DCCC0
	 pEPcMaEd+BMmzPweoCf9z/kf9tqL6m4du9TJieVPEu3O1qIbNenvBPPpateXkLxiAT
	 8lPkJ7vJOI3qFMN83R6EIrba+7ZtHtjLnq82rryyHfyGg2UjS6nfowKH0JygDa409S
	 xcgIefQl7QkTA==
Date: Wed, 18 Feb 2026 23:27:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: Re: [PATCH RESEND] mshv: Use try_cmpxchg() instead of cmpxchg()
Message-ID: <20260218232747.GK2236050@liuwe-devbox-debian-v2.local>
References: <20260218102604.178561-1-ubizjak@gmail.com>
 <20260218110041.179949-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218110041.179949-1-ubizjak@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8906-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D838F15AED1
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 12:00:18PM +0100, Uros Bizjak wrote:
> Use !try_cmpxchg() instead of cmpxchg (*ptr, old, new) != old.
> x86 CMPXCHG instruction returns success in ZF flag, so this
> change saves a compare after CMPXCHG.
> 
> The generated assembly code improves from e.g.:
> 
>      415:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
>      41a:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
>      41f:	f0 49 0f b1 91 a8 02 	lock cmpxchg %rdx,0x2a8(%r9)
>      426:	00 00
>      428:	48 3b 44 24 30       	cmp    0x30(%rsp),%rax
>      42d:	0f 84 09 ff ff ff    	je     33c <...>
> 
> to:
> 
>      415:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
>      41a:	48 8b 54 24 38       	mov    0x38(%rsp),%rdx
>      41f:	f0 49 0f b1 91 a8 02 	lock cmpxchg %rdx,0x2a8(%r9)
>      426:	00 00
>      428:	0f 84 0e ff ff ff    	je     33c <...>
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>

Applied. Thanks.

