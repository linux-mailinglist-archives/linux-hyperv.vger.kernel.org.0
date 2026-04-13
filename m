Return-Path: <linux-hyperv+bounces-10120-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCDRGhR73Gn5RgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10120-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:11:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E73E768B
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 07:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988453032F6A
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Apr 2026 05:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A49538642E;
	Mon, 13 Apr 2026 05:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f9uNMtf8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A7381AE3;
	Mon, 13 Apr 2026 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776056933; cv=none; b=seIl5bFRU5RVMOL/hRjsXmghdBnOfHynUPY+vqjH/KsYBh/CtAyDA1ZFWgSY5n2a5s3ejFtbZUtvdrESgPD6KmWfqH0xTN441iqkaMB+2Ba0tfpIceedlpSEyJOL1a78GGOnFFIVakxpj2IyDMYsNWnyvUr9IQ1Ua15KCtfEb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776056933; c=relaxed/simple;
	bh=2/Sgiuf0i4Z6yaO92crvH0qtHa25YLDB6KSbbFFkCnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAMPnoVTKSJLAq1u/7dSaMmNvA4csh6UQEMfupOR1ZYHC0KhuiobjnYLB+8sYTUUe2AqtJ4+hGVyD3kTRchNSVqq860sewKv3gEzUwCiWTmN48k7I3hfXHlP/cs3Ir7p/1D8j9E2WLL6li7YWYnxpUcUbzcjjcoYK0SjHbZEy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f9uNMtf8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1931B20B7129; Sun, 12 Apr 2026 22:08:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1931B20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776056926;
	bh=sb3m66RzCJPfglqdY/359rz5n0K9rwFOKlus0zCVaOk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f9uNMtf8U3KeTSHwVdn4+WPHCIn/cqN0IBGAqyOJqxMVbju10236Y1f3BpwlGVNas
	 FQK/aLD2wRpE9/aYe/6MCsxWawlp/34y3QqIVWqlLPSKwTE7kGC3RgU+YCvgr2z+AG
	 3cA5VHLtK1EXCQ8+MP1T6FCVttAMp0YHe1jtA3/E=
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
Subject: [PATCH net v2 2/4] net: mana: Init gf_stats_work before potential error paths in probe
Date: Sun, 12 Apr 2026 22:08:38 -0700
Message-ID: <20260413050843.605789-3-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260413050843.605789-1-ernis@linux.microsoft.com>
References: <20260413050843.605789-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10120-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 094E73E768B
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
Changes in v2:
* Apply the patch in net instead of net-next.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 57f146ea6f66..f6ad46736418 100644
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


