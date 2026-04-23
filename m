Return-Path: <linux-hyperv+bounces-10352-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABBuCelg6mmrygIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10352-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:11:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 910FD455F20
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 20:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 611193051DB9
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FB3AC0CB;
	Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWn8teTQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ABA3AB29C;
	Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967852; cv=none; b=uHBs/eqHLIvxa8WONbBGshpLPi085n7squnfFu/0B+fDNAe3LVhPUFmNtqNxOZ2AFMIBZcP7YUu51yMDVrS9fprQZycUYbtO9UPtRa/IU6C9/yewYJY1hrnlx1RQcRPyAOkP5GvEKf6GGSgznbkKWiXbLtZQ1M5s4Y5yKp2neEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967852; c=relaxed/simple;
	bh=XhUlM6BGLQdoKRgV5m1mUgb5JD0UF9cyT+NL3ECG4Oc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tzvsjmsvpLo9cVbL/571KAXvLdSdvtWAP2e6BatvKRgAf5n1uyO/U93+2hokSdjQs+X+M/YijwFZnR1kIWfPWA14H0Oroxvc2s+Hlhgp+sMVCwTcXo/dmOAxhu7LA8nLwwqEOc3DdTfmhgTpcBd7IT0UcISzZ3s8579uDSjFqTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWn8teTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281C7C2BCAF;
	Thu, 23 Apr 2026 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967852;
	bh=XhUlM6BGLQdoKRgV5m1mUgb5JD0UF9cyT+NL3ECG4Oc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iWn8teTQ+jTCjBnpOqLhiQDAmQypPO5FjJCA4VfZg4BsNWahCnpppOoqze+vT9I0W
	 fxijmp0y1oXCHM2dgY7P4nlIbsYDe9/sXA7/GCsn9OjerNkH/Pa7PApJEudXSBR3Z+
	 BDLAzdWnDbjLh7I/JkQXRXGer5NNN6F5EAQwj0LAfy6KJpk+uStz0A8Hb7MuHIdust
	 wX0xn3JfMFDtceEjWbnmoqDnnl4RvmaChgCaBS9eEEUuu1KXO/XCp42ghCyHVuXVJl
	 H1/8oeTSBRkUWxN8H1GLEGl4ljnotAYQh7u3/W9qX1TSUgl5E0BkfodZevVar0UNnz
	 i1W/YnhMGlfvA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D1E38111D6;
	Thu, 23 Apr 2026 18:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] hv_sock: Return -EIO for malformed/short packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177696781354.700507.8576235951589562643.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 18:10:13 +0000
References: <20260423064811.1371749-1-decui@microsoft.com>
In-Reply-To: <20260423064811.1371749-1-decui@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 longli@microsoft.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 niuxuewei.nxw@antgroup.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10352-lists,linux-hyperv=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 910FD455F20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 23:48:11 -0700 you wrote:
> Commit f63152958994 fixes a regression, however it fails to report an
> error for malformed/short packets -- normally we should never see such
> packets, but let's report an error for them just in case.
> 
> Fixes: f63152958994 ("hv_sock: Report EOF instead of -EIO for FIN")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] hv_sock: Return -EIO for malformed/short packets
    https://git.kernel.org/netdev/net/c/3d1f20727a63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



