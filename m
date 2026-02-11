Return-Path: <linux-hyperv+bounces-8784-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO8XGafNjGmbtQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8784-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 19:42:47 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B44126E76
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 19:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 993D1301496D
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6A7339719;
	Wed, 11 Feb 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xj4VXsOw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E0EACD;
	Wed, 11 Feb 2026 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770835363; cv=none; b=O66w6EgkZffPcIwSnDPaPeL38/zczTygH+4GVveyg487rIP72xyYE2VaYrg65K2z8oJzhWLx/1l2cXlr1hFQu4z3x1EBtvud8nLT3N+5whEHSzXk4Myz5Q/gsEqzyyn9jdKigI0RJkivFx0gxmMazKVwgdT2uPUZ74NxYMbK5TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770835363; c=relaxed/simple;
	bh=w9YH2qHvBpOAFF3GK8fG/1xJUZsoARiE0rs4HEbaiEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBkua+rcWzGZz1x6UL9qv8nA1SYn4wKQj9cPQm31LMRlz54VgHrAmQzSLSrVK7fMH9+NdQg/OoZpCQtnM5KSDsX7+EIrCAKqaGDvbiBdWb5NCORzylX6g6qDtgmzrlN2aRXQd5WDf3bopzxcrOv8A/BZnfYsSgSvAu/Gf3d4WNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xj4VXsOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA88C4CEF7;
	Wed, 11 Feb 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770835362;
	bh=w9YH2qHvBpOAFF3GK8fG/1xJUZsoARiE0rs4HEbaiEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xj4VXsOwgspoyvTnJIbrMSoe+pTtL7BS/K95gE9sD2gc7JLEG+eNKvz9Z70EJvJUq
	 ipJf15uzEWyiC87tEF877vT+AldZvQfzzVZoxKkvpJWq6KKAU603bUdlax1el8sdFW
	 nGynULUO3EN/552gLYuG4cg7aBu0yZBjOQq3dc9A5YbWugXxJPcTRFHLt01ToTS2+F
	 t/Z++87u4mTJ7X08KA7hN/ZqJT8LsVhxhoNKiu7iT5EOo8bLdw26mWmCSVJbVNJmiu
	 Tp4/xhK4jXPy3Z5qMdANyYdi4dlDuWmhvC3plfj8uV/N9lnsxFPTyyRNuw5D0+dcHq
	 Zr5fwDvSX3n0Q==
Date: Wed, 11 Feb 2026 10:42:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: ernis@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dipayanroy@linux.microsoft.com,
 shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
 gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: mana: Add MAC address to vPort logs
 and clarify error messages
Message-ID: <20260211104241.1ab298c2@kernel.org>
In-Reply-To: <20260211054335.8511-1-ernis@linux.microsoft.com>
References: <20260211054335.8511-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8784-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2B44126E76
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 21:43:24 -0800 Erni Sri Satya Vennela wrote:
> Add MAC address to vPort configuration success message and update error
> message to be more specific about HWC message errors in
> mana_send_request and mana_hwc_send_request.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.0,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Feb 23rd.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


