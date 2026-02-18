Return-Path: <linux-hyperv+bounces-8881-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLGbAgJhlWn9PwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8881-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:49:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 715DC153820
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 07:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22E5F3011048
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 06:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45722F5479;
	Wed, 18 Feb 2026 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq59BhK4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDFF1DF73C;
	Wed, 18 Feb 2026 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771397374; cv=none; b=Dyho35VI65r5xACgav0OAFU+wFkEjX7L0Uy4Vgn0K7vNkstajcxQxnOectRO5pRJDYcXCTd51150SZVPtfVRZV13fyj/4g15BN3AY8dwKvmSWmTMrxP9wqIRYoiO6RQBrmajxw71wsok6Db89hX2lwO52R8ATWR9MNJTVJZAvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771397374; c=relaxed/simple;
	bh=/4jlE1l6YFrLLYVw2+7I3fQnD6R3JRlCkxH/0t7YrUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz8ocEeyzFn+ocn7qtISWzEyGayA0L/IRW/nB8U9M0ZkqNaYu1LSN+tsKsDXhK4mB3xP8fN12xJc8EwXv3TDVNn0Lu/kfbueCABVfvOyoGe9LGWowwS84OvSfSANFY3Y1RXH//jLoDvuyLzYnNuM0wlZQP3WUf7pOfSm34JF5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq59BhK4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC707C19421;
	Wed, 18 Feb 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771397374;
	bh=/4jlE1l6YFrLLYVw2+7I3fQnD6R3JRlCkxH/0t7YrUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uq59BhK4mDAaORYApP+wgpLgsZfmqsC59MdRn1jLhgi0N7HmCyKUxqLisQKyTGShM
	 FJYDaWpzyxDv0h8dmmfLoFZjxF+Ws7r7hy3tIoV3dDamQTtJ9Cev8/5wL94078hu+J
	 Ns5pPLaXNrsYXWqEJEW0gZPT6LG1lJ1BqJquu/wcREcZ7PHu5hSNOTvcOYlVZCc9VL
	 Hj2m+sDIu/pZSjCFP7ULTnhurpl3BjjfVth1X/TkzmpsLwIthmd6PrkH5tIhI217+C
	 l3tcuaQxfSH6Fx1w0aMMMdaBvZW0VnZ0iREPclHRRNjDHj5Lm6KocobjtKO7SdR+Bi
	 RfWyedqABUpBQ==
Date: Wed, 18 Feb 2026 06:49:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v2] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
Message-ID: <20260218064932.GE2236050@liuwe-devbox-debian-v2.local>
References: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217231158.1184736-1-mrathor@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8881-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 715DC153820
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 03:11:58PM -0800, Mukesh R wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> MSVC compiler, used to compile the Microsoft Hyper-V hypervisor currently,
> has an assert intrinsic that uses interrupt vector 0x29 to create an
> exception. This will cause hypervisor to then crash and collect core. As
> such, if this interrupt number is assigned to a device by Linux and the
> device generates it, hypervisor will crash. There are two other such
> vectors hard coded in the hypervisor, 0x2C and 0x2D for debug purposes.
> Fortunately, the three vectors are part of the kernel driver space and
> that makes it feasible to reserve them early so they are not assigned
> later.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

Queued. I also did a few cosmetic changes to this patch.

Wei

