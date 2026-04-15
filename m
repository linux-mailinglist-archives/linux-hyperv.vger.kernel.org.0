Return-Path: <linux-hyperv+bounces-10173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCj5K85H32mFRQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10173-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:09:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C521401BB5
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 158133037670
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E133CB2C1;
	Wed, 15 Apr 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iFmuZDsD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D253A16AC;
	Wed, 15 Apr 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240586; cv=none; b=fZfr0CtZtJ5esiP1Hr8p97Vkmxy6rv1za145yKSFfc5ukQZuTKG+Tns52qspYeC2gJ4iXl24Jlpgw5WnZjNnp1ZmnMANkNacEkUlW1axFo1WmQI424SiGqOZCiFoCA7FeBoXZpil3ryYyrY1mwaSakdcfn4ZeJ054DNJ9hCC9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240586; c=relaxed/simple;
	bh=uBRnMlDfj/tOCjGMx//bbuTGvrnnRua7gmuOOKSFfaw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UBv6Cb79uhVZlkCMppqwgz8kdc05a1g8inXhg8PH2fkQWpRiiGOjgnE8jNTCx7zG0mIW1B4X0jNLpaUDKlNdmvEHaZB519g42DAO6oFefwzdoybJy1ksC+zRGfDLQ7sc95/4U1LtsVgr1iFP8RQ0ZpYc76ksN3J2BqVO2h1IMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iFmuZDsD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 7CFFD20B7128; Wed, 15 Apr 2026 01:09:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CFFD20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776240585;
	bh=11vQyduJihdW+uI2RpTJB50IxU++9GE3Yj97Lvk6iHk=;
	h=From:To:Subject:Date:From;
	b=iFmuZDsDmYbvRxLaLosQK2/jvGvby2olOH9YtB4OjfOqy+It8wNycQjOYvwELtC/j
	 LjSfpQDOUI4Oe7Akj4nIrIsz8kE+gG9eNBwwrfkzCWo3aBwhdgIruWQmQjB2m0dmxH
	 HCl9Fh5sTEk1v6YEdNjwJ5Ct+yZ2JhHllxQPcdfo=
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
Subject: [PATCH net v3 0/5] net: mana: Fix probe/remove error path bugs
Date: Wed, 15 Apr 2026 01:09:36 -0700
Message-ID: <20260415080944.732901-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10173-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 2C521401BB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix five bugs in mana_probe()/mana_remove() error handling that can
cause warnings on uninitialized work structs, NULL pointer dereferences,
masked errors, and resource leaks when early probe steps fail.

Patches 1-2 move work struct initialization (link_change_work and
gf_stats_work) to before any error path that could trigger
mana_remove(), preventing WARN_ON in __flush_work() or debug object
warnings when sync cancellation runs on uninitialized work structs.

Patch 3 guards mana_remove() against double invocation. If PM resume
fails, mana_probe() calls mana_remove() which sets gdma_context and
driver_data to NULL. A failed resume does not unbind the driver, so
when the device is eventually unbound, mana_remove() is called again
and dereferences NULL, causing a kernel panic. An early return on
NULL gdma_context or driver_data makes the second call harmless.

Patch 4 prevents add_adev() from overwriting a port probe error,
which could leave the driver in a broken state with NULL ports while
reporting success.

Patch 5 changes 'goto out' to 'break' in mana_remove()'s port loop
so that mana_destroy_eq() is always reached, preventing EQ leaks when
a NULL port is encountered.
---
Changes in v3:
* Add patch 3: net: mana: Guard mana_remove against double invocation.
* Fix inaccurate comments.
* Correct Fixes tag from ca9c54d2d6a5 to 1e2d0824a9c3.
Changes in v2:
* Apply the patchset in net instead of net-next.
---
Erni Sri Satya Vennela (5):
  net: mana: Init link_change_work before potential error paths in probe
  net: mana: Init gf_stats_work before potential error paths in probe
  net: mana: Guard mana_remove against double invocation
  net: mana: Don't overwrite port probe error with add_adev result
  net: mana: Fix EQ leak in mana_remove on NULL port

 drivers/net/ethernet/microsoft/mana/mana_en.c | 35 +++++++++++--------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.34.1


