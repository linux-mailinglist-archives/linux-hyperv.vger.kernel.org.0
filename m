Return-Path: <linux-hyperv+bounces-11131-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA0+MNUwD2pSHgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-11131-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:20:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDBD5A920E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48C031132CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 May 2026 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B67D332EBC;
	Thu, 21 May 2026 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMvacMF4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F13446B9;
	Thu, 21 May 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376803; cv=none; b=dIikhpZTYVnuTabJvyyPDN9Re+8ptUMMBWCEIGIhLn7i6Vl3qDuU5UQRjtrWi9iS1MpMfHe7CIBWUuhMmTdK1l6aguAyIDX9852TF/FH/at5eeOZ+jM894e/2d7JBWKSKPd7oswy/IvLvFJeZ3d6MCvWEShIGRG1oVsdD+cuyk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376803; c=relaxed/simple;
	bh=g13g7W/VaZXzTUM0hCt1vLX1HJbnvxyohMVX60cPZY4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ppvY4Kf+9dIozhTWZYVoJgkESPNKc00EP0wIDS9utVq65Bg/55t0GkYw2ucs0Pyc2brO1Ob/Da3p9t8tN/NJ6A0wWdfZDiwKSDYL9lRxHv6RArkiyYZHU7OrVaPHsoPFk5gK2hwF7UqwYoHpZNqKrWz/viScYCWr00TLTRXYNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMvacMF4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7AA1F000E9;
	Thu, 21 May 2026 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779376801;
	bh=9TJ3fv97bS6JHrvc03TR60908Wl3Wrg9s2M8PrERk3k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EMvacMF43cCNc5PTt5yyC/gTDxrL6AOoiyTsmmEb4pLxD7jx/RUD1Xw7VjGadcp1s
	 O17ZV9r1qMFdF03J6rEWnyDDdN6gzzuQIVarAwTRra6jLk1ES7aGylcZQYzWYoN3Mi
	 DDAk5afZNg2k/PgB+x5koMtT4yNPIu8NAZ4CUo6sPjNdFL+YeMlkiIlGw9hEWgUykq
	 CwT0hKmrL7cCwL+/vPLMpNj/cHf2VdJjjob7sL7HiXamLeGYoX9LLKLfCU0tl2t1V1
	 irjSaOzHndjeBKKe8VdLLBA4BLdOJuL6t/oDvBpEcwzHn69IQMAYvxYAbufDivD8YT
	 1qfvtKDU7wmdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C293930E00;
	Thu, 21 May 2026 15:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: validate rx_req_idx to prevent
 out-of-bounds
 array access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937681139.379332.5032231851609131229.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:20:11 +0000
References: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
In-Reply-To: <20260520051553.857120-1-gargaditya@linux.microsoft.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dipayanroy@linux.microsoft.com, horms@kernel.org, ernis@linux.microsoft.com,
 gargaditya@microsoft.com, kees@kernel.org, stephen@networkplumber.org,
 shacharr@microsoft.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11131-lists,linux-hyperv=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3DDBD5A920E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 May 2026 22:15:53 -0700 you wrote:
> In mana_hwc_rx_event_handler(), rx_req_idx is derived from
> sge->address in DMA-coherent memory. In Confidential VMs
> (SEV-SNP/TDX), this memory is shared unencrypted and HW can modify
> WQE contents at any time. No bounds check exists on rx_req_idx,
> which can lead to an out-of-bounds access into reqs[].
> 
> Add bounds check on rx_req_idx in mana_hwc_rx_event_handler() before
> using it to index the reqs[] array.
> 
> [...]

Here is the summary with links:
  - [net] net: mana: validate rx_req_idx to prevent out-of-bounds array access
    https://git.kernel.org/netdev/net/c/b809d0409991

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



