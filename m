Return-Path: <linux-hyperv+bounces-10202-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFgGNLhA4mmB3wAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10202-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 16:16:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C341BF37
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 16:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFF373046EA0
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Apr 2026 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6178A3A7F47;
	Fri, 17 Apr 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWuJdSIy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF16371876;
	Fri, 17 Apr 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435030; cv=none; b=PUzcHgki49kCNaPnhvefgotzMekch3lT1yW/G0eed1wM4upNugFkyD6cklMFciFxaPhQ2ZomBG+TMiVvFElOKsx4clim6QEljx8oiC0krXUfkgdawbLcEh40qYO8qas5tE0JRwPuIIhCA2a315/5Br9w6c8PdYqg9CcI2S5X+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435030; c=relaxed/simple;
	bh=8SQMGs8IWZBtfCQwHQf5nFYIse/C/NhBhMykySPb1Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzWhDkJhN+WcWCcSkYkKLNH2M5/qPGNpsWHOnGW8VCKubtSKAOh34Ge2FNYLiIVnAsyMkgeT6XVo9SjziooiOaadPnmKYGBYJ2XMnkrZ+RU7BkvfA3tPbEMzOUfahvBvyU5tEj5DH2Uu5IHAftqRDrDK/WvyRimlhFhw0wHiXZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWuJdSIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DDC2C2BCB0;
	Fri, 17 Apr 2026 14:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776435029;
	bh=8SQMGs8IWZBtfCQwHQf5nFYIse/C/NhBhMykySPb1Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oWuJdSIyOIMeesi/u0QxMeqg949poLCxbCiPwfj4Ja1juqgi0XzciaCep1oF/KVc1
	 /gpoeScvEpAX52iIZnMvnnKE3aG1S6WOaSufG2+cjrLPtSBDL2PZmqW7/LmMTZShyb
	 KNHOBDgRZEQ6NY06NOWYoHk9rr1lUOUUwpSx3k79QxEdqEVPSxSAzrj6CL/qUwBSSb
	 1Ey1sLAyPKg/QZqw8gsEEX90HXQEVAKi8G7w9EYWo35gaUhreo6Dph8xLreeqO22JQ
	 Vp5BN14i5y8bJy0ZmH6EaZ42SIPiOYEXL+ApbcHJdbsWHMM/X/3m/27POm/0Lzhq6X
	 R9AlBweeL6+/Q==
From: Simon Horman <horms@kernel.org>
To: ernis@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	haiyangz@microsoft.com,
	davem@davemloft.net,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	kuba@kernel.org,
	kotaranov@microsoft.com,
	stephen@networkplumber.org,
	andrew+netdev@lunn.ch,
	kys@microsoft.com,
	wei.liu@kernel.org,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	edumazet@google.com,
	decui@microsoft.com,
	leon@kernel.org,
	gargaditya@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	netdev@vger.kernel.org,
	shacharr@microsoft.com
Subject: Re: [PATCH net v3 4/5] net: mana: Don't overwrite port probe error with add_adev result
Date: Fri, 17 Apr 2026 15:10:14 +0100
Message-ID: <20260417141014.218936-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415080944.732901-5-ernis@linux.microsoft.com>
References: <20260415080944.732901-5-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-10202-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 621C341BF37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Don't overwrite port probe error with add_adev result

In mana_probe(), if mana_probe_port() fails for any port, the error
is stored in 'err' and the loop breaks. However, the subsequent
unconditional 'err = add_adev(gd, "eth")' overwrites this error.
If add_adev() succeeds, mana_probe() returns success despite ports
being left in a partially initialized state (ac->ports[i] == NULL).
Only call add_adev() when there is no prior error, so the probe
correctly fails and triggers mana_remove() cleanup.

> In mana_probe(), if mana_probe_port() fails for any port, the error
> is stored in 'err' and the loop breaks. However, the subsequent
> unconditional 'err = add_adev(gd, "eth")' overwrites this error.
> If add_adev() succeeds, mana_probe() returns success despite ports
> being left in a partially initialized state (ac->ports[i] == NULL).
>
> Only call add_adev() when there is no prior error, so the probe
> correctly fails and triggers mana_remove() cleanup.
>
> Fixes: ced82fce77e9 ("net: mana: Probe rdma device in mana driver")

The existing Fixes: tag points to commit ced82fce77e9 ("net: mana: Probe
rdma device in mana driver"), but was the bug actually introduced there?

Looking at the commit history, commit a69839d4327d ("net: mana: Add support
for auxiliary device") added the unconditional 'err = add_adev(gd);' call
that overwrites the error from mana_probe_port(). Commit ced82fce77e9 only
modified the add_adev signature from add_adev(gd) to add_adev(gd, "eth")
but did not introduce the buggy pattern.

Should the Fixes: tag be:
    Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")

