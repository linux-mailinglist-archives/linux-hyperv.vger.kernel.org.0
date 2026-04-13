Return-Path: <linux-hyperv+bounces-10118-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOg9Et163Gn5RgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10118-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:10:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6513E765C
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD8633002112
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 05:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9303B33F5B6;
	Mon, 13 Apr 2026 05:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eayM1VGv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616501D435F;
	Mon, 13 Apr 2026 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776056931; cv=none; b=SvJctBjHQGrlzjCBmIO9Uiad9DEbthvpf40XnFDQIVhVMMzIXEmQdJNKHhBTQca1X5RwspSmGUnP5C/NXRbb0ROy0BkpoPUijfNUr/2gLcdMHKZxatdtn6++XlAT0pqcl8juIJwq/rEw5g+aqWdB2HnmRRJqgOgPhlzGXjSs+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776056931; c=relaxed/simple;
	bh=lSAH4E3Wrx3VZRAyZ5aMCNrPuokPlm2Afab4Li4mbDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RmCJONC8O+nquplvXstqjbe8+G6apP3oej1MAe7CpQEYNwG8Tcu+oaHXcMPjMwUnu4qHRtPZk90Kb+BUlQfzxEF8+JdThtGJMh0xgfswCixfOG/ZlezTQnPXVdSi94/WqyUsMitALjCYuHK8+DyDScIXrB3Fj84SLNZImGxUYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eayM1VGv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id CF2B720B7128; Sun, 12 Apr 2026 22:08:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF2B720B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776056924;
	bh=lYKyXtBPEnGqu4gz96UvNY7M9bXXMspnKyP7NBcRJrQ=;
	h=From:To:Subject:Date:From;
	b=eayM1VGvkRfO0k6fC30nfTBvRr9nrLJq76ML86UAEW9zixynl4yuOw95zOrxyxAZI
	 rr3wET0h8n68JgvaDAUc+ScWXFF1exF3sRejQ7BmP9CrPD3hG749ZSUp2zseuAqfMM
	 PzAPp92CkKGV0/Tl7UMTh7nw7t+fB3dKpzNLuimY=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ernis@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/4] net: mana: Fix probe/remove error path bugs
Date: Sun, 12 Apr 2026 22:08:36 -0700
Message-ID: <20260413050843.605789-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10118-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C6513E765C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix four pre-existing bugs in mana_probe()/mana_remove() error handling
that can cause warnings on uninitialized work structs, masked errors,
and resource leaks when early probe steps fail.

Patches 1-2 move work struct initialization (link_change_work and
gf_stats_work) to before any error path that could trigger
mana_remove(), preventing WARN_ON in __flush_work() or debug object
warnings when sync cancellation runs on uninitialized work structs.

Patch 3 prevents add_adev() from overwriting a port probe error,
which could leave the driver in a broken state with NULL ports while
reporting success.

Patch 4 changes 'goto out' to 'break' in mana_remove()'s port loop
so that mana_destroy_eq() is always reached, preventing EQ leaks when
a NULL port is encountered.
---
Changes in v2:
* Apply the patch in net instead of net-next.
---
Erni Sri Satya Vennela (4):
  net: mana: Init link_change_work before potential error paths in probe
  net: mana: Init gf_stats_work before potential error paths in probe
  net: mana: Don't overwrite port probe error with add_adev result
  net: mana: Fix EQ leak in mana_remove on NULL port

 drivers/net/ethernet/microsoft/mana/mana_en.c | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

-- 
2.34.1


