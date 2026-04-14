Return-Path: <linux-hyperv+bounces-10158-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIYSBGhg3mk1DgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10158-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:42:32 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7056A3FC0D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 17:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F9333034B0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2026 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E053EBF29;
	Tue, 14 Apr 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKS7uiiz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E883D902A;
	Tue, 14 Apr 2026 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181267; cv=none; b=KRjj0Iun4/u/mt3Syot24/bEy3uXJDOKW1QOBdd4E8bMVUilnCl3XQiAy70P/Jt1CJs6uOaEE4F9/Rx+C/BS4Etbf8+gerKfQgVOQV10M3MM6kwHROvdNEVuyLFjqdB1/0q0jKNvjEsB5YsZCDVC7buBo8Ti/ya4Fu56Cj4DDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181267; c=relaxed/simple;
	bh=YrmTD9eum045wyxGIEZt1HMiOH5MJ9kWS/wJfIDaWNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ix18uR1K+bjq1NMXQeLG8vqYJlY68feCPMLUMPEDUjqXvqM+OVRGlgm0HDxI8pKbjuFCIQGd5f7VSS+CA1LiZLioWowMkxQeDSA1YKTC7O9Xdn4Kvs8gBZD4FRmUXAdI77YaQ4O3p8+PzYM0RF4p1qtkajQHwCaik1g19VMm25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKS7uiiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7D8C19425;
	Tue, 14 Apr 2026 15:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181267;
	bh=YrmTD9eum045wyxGIEZt1HMiOH5MJ9kWS/wJfIDaWNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKS7uiiz1giGWkML/vR5PNrWYhEtX/07uokO0jOQcvzbe5WP2laoXgpEUvpCrv1kd
	 YEvd7IdD0+k7CkWz9V+HBLyP4n51hq6Jelf5WSWHka6ySsBFFCIq5Kvy6x8393OKnU
	 2OR2bPHA4Y3INR8RdlMvT86Ss0zde+LCMVKWZAM8qoVD5JDGKS5hdjBjk+7MlQ3Xe1
	 c9UocBs1Zdcsjc/Jpv2HFtVrzbf0YmzGFWMgY0L/Qqg1BreOFMwBsctKw+hi8xRZiT
	 GnX3UdbKd0i1FXOGqXph1b6xoefed+C993+QRdEQGTaUivyh7I63lFk/aNQzewllo/
	 qibTSXn+nWJDw==
From: Simon Horman <horms@kernel.org>
To: ernis@linux.microsoft.com
Cc: Simon Horman <horms@kernel.org>,
	pabeni@redhat.com,
	edumazet@google.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	decui@microsoft.com,
	shacharr@microsoft.com,
	linux-hyperv@vger.kernel.org,
	kotaranov@microsoft.com,
	kys@microsoft.com,
	shirazsaleem@microsoft.com,
	longli@microsoft.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	wei.liu@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	haiyangz@microsoft.com,
	kees@kernel.org,
	stephen@networkplumber.org,
	leon@kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH net v2 4/4] net: mana: Fix EQ leak in mana_remove on NULL port
Date: Tue, 14 Apr 2026 16:40:58 +0100
Message-ID: <20260414154058.771241-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413050843.605789-5-ernis@linux.microsoft.com>
References: <20260413050843.605789-5-ernis@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-10158-lists,linux-hyperv=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 7056A3FC0D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: mana: Fix EQ leak in mana_remove on NULL port

In mana_remove(), when a NULL port is encountered in the port iteration
loop, 'goto out' skips the mana_destroy_eq(ac) call, leaking the event
queues allocated earlier by mana_create_eq(). This can happen when
mana_probe_port() fails for port 0, leaving ac->ports[0] as NULL. On
driver unload or error cleanup, mana_remove() hits the NULL entry and
jumps past mana_destroy_eq(). Change 'goto out' to 'break' so the
for-loop exits normally and mana_destroy_eq() is always reached.

> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

Does this Fixes tag point to the correct commit? Looking at the commit
history, the original driver commit ca9c54d2d6a5 did not have
mana_destroy_eq() in mana_remove() at all, so the 'goto out' pattern could
not have caused an EQ leak at that point.

The bug appears to have been introduced by commit 1e2d0824a9c3 ("net: mana:
Add support for EQ sharing"), which added mana_destroy_eq(ac) to
mana_remove() and placed it after the 'out:' label, making it skippable by
the 'goto out' on NULL port.

Should the Fixes tag be:
  Fixes: 1e2d0824a9c3 ("net: mana: Add support for EQ sharing")

