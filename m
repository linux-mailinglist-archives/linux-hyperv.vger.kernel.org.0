Return-Path: <linux-hyperv+bounces-9730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCYUGc+CwmlneQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9730-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 13:25:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9303082EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 13:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C94930CF83A
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640EB3F23C6;
	Tue, 24 Mar 2026 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsKrMguy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400363F1652;
	Tue, 24 Mar 2026 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354817; cv=none; b=fPgLRFzCQ/otOhojCLoipD0t90NolZeNiP+IOEtSoWp5GCZ2tG7FXSLYYDjDrNZYlu6ZvOi4MankCuy+Zq0COOr7bHH7ez/M3zcIe8u4TzyKzlFjfBpLVoEScqOoCI6flgNVrNc9DOBw3y8YWw7omKsYKviAchHUNtjas7ZxDm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354817; c=relaxed/simple;
	bh=TJM16cgMCE3F73ThP2YTFbewAd4hnvkgTJBlhnNOB8A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T4C7vo5Xf+CnPMMCDAFxeJLVzfVdabSXr4tpfdSc8JpMYQIHfHO9usrFJTOY/frUQgLiY4Ig+FP0fOjFjhjQQdR1rFSXHYDfMjjMhyly/rM5J+GLo+lzGxTj4s8c6J8vg/DVmd6dIGn7TGileNaR18xCApPt9Mgjr5lhiR45Iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsKrMguy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B2FC2BCB1;
	Tue, 24 Mar 2026 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774354816;
	bh=TJM16cgMCE3F73ThP2YTFbewAd4hnvkgTJBlhnNOB8A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dsKrMguy3XxGtaQwCFHvx3nuHVmExCWYZd4atb2+0M+x74fp4eK/A78ZgGYwvWvGE
	 rzvXvVAbw3VxPWbAgibnQ0pA83aWPSAjFzKBSuVfGn+kNVMIbBclYx9MX5seN3oogJ
	 JEFH+r+o2XQeQlFJgTeMoMwY6/RODrVjBnfY0C/QEiatjSQtIYBr8hnwE6gh6M2ifS
	 5XsTgIGiIVyY7aCMCBA2pMowR8l2A39APYIRnX9F8IhYbQy9hCoTk+pGaZVaxA0egu
	 GQvYpuJyxRhPthqItYOqDRITNzY6rIUfBc88fL7hqMGkRaNZ2dQvrUJoR1LfHnzAGz
	 JPCGLINPqVquQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D103808200;
	Tue, 24 Mar 2026 12:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] hv_sock: update outdated comment for renamed
 vsock_stream_recvmsg()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177435480479.653782.5696189465886513982.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 12:20:04 +0000
References: <20260321105753.6751-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105753.6751-1-kexinsun@smail.nju.edu.cn>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr,
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9730-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC9303082EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 21 Mar 2026 18:57:53 +0800 you wrote:
> The function vsock_stream_recvmsg() was renamed to
> vsock_connectible_recvmsg() by commit a9e29e5511b9 ("af_vsock:
> update functions for connectible socket").  Update the comment
> accordingly.
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> 
> [...]

Here is the summary with links:
  - hv_sock: update outdated comment for renamed vsock_stream_recvmsg()
    https://git.kernel.org/netdev/net-next/c/88c07dff9f6d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



