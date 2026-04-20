Return-Path: <linux-hyperv+bounces-10211-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPZ+ORMi5mnCsQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10211-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:54:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDB42B050
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31879308C423
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0313A0B20;
	Mon, 20 Apr 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cRInjWEJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C739BFEF;
	Mon, 20 Apr 2026 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689265; cv=none; b=UkRYvnoDZOKhroCub2VwRn/vGqK4wM7WQERStoa99Ytv3mzFlY+dWRR+m+1E4RpQab091Z3HXweyLNXWb7sXxrh3CV4w8wfQEaRFch7uecpdp6yahfixMd+h5s7Qf2dnDCO2dcpCKwaGs9rgZvdyOlnztaaOW/ULLhWUTAMUPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689265; c=relaxed/simple;
	bh=BbHisHAiZPuS3BJCinTzaZM6Zj98oF1WDvTozelDMnY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbRu8n9Bt+CvXZZ/bfYTgH790RF+m+bY9RbuMKLxpDjNE5IzVwlkJKVNTGnoZfS1CnK90HRGvjpCCQsQdJAh4rnY8AmI/eC7RuVkd41emtwTmlRL0OB7H18wc+BtAE5dU8h1IuOq5Z/fAllsAagDNeHHBG/imUfeQuGhPShJdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cRInjWEJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D8BCD20B7129; Mon, 20 Apr 2026 05:47:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D8BCD20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689264;
	bh=TO5DGqsb3Bk8K5yEpkaKIxhBRQ4TjEnpb6HMU0jAUb0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cRInjWEJ11OIN8DMsVqyRgfsnwzgIkzdz2tF/2p4LxLeE4GLs6FXCfR8SQO50YNUq
	 rEdJWcQeOuQxI7QpzmCthOBkHbVehcVHxs2KOipxJeb0ce9TTdhrL9J0p5TzkfWjnf
	 IywwOkPq324CZZDHRRLf3dwFl0cfFAeYJ1HJDHpU=
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
Subject: [PATCH net v4 2/5] net: mana: Init gf_stats_work before potential error paths in probe
Date: Mon, 20 Apr 2026 05:47:36 -0700
Message-ID: <20260420124741.1056179-3-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10211-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61EDB42B050
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move INIT_DELAYED_WORK(gf_stats_work) to before mana_create_eq(),
while keeping schedule_delayed_work() at its original location.

Previously, if any function between mana_create_eq() and the
INIT_DELAYED_WORK call failed, mana_probe() would call mana_remove()
which unconditionally calls cancel_delayed_work_sync(gf_stats_work)
in __flush_work() or debug object warnings with
CONFIG_DEBUG_OBJECTS_WORK enabled.

Fixes: be4f1d67ec56 ("net: mana: Add standard counter rx_missed_errors")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3,v4:
* No change.
Changes in v2:
* Apply the patch in net instead of net-next.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index e3e4b6de6668..468ed60a8a00 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3635,6 +3635,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	}
 
+	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
+
 	err = mana_create_eq(ac);
 	if (err) {
 		dev_err(dev, "Failed to create EQs: %d\n", err);
@@ -3709,7 +3711,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	err = add_adev(gd, "eth");
 
-	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
 
 out:
-- 
2.34.1


