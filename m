Return-Path: <linux-hyperv+bounces-10210-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNNsKnQg5mkMsAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10210-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:47:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1142AEB1
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 14:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 757F0300BBA2
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Apr 2026 12:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3F439FCA2;
	Mon, 20 Apr 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FSczLDXw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B837F8A3;
	Mon, 20 Apr 2026 12:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689265; cv=none; b=EeBHDxwE8jOrv8PcBBen+RcgNdhbz5KtO5KvPES/oP5A3Ub2f9UyPXLrBgNPm93A5I/WqZ+y/K4GhTN779Vl4He5k11+HNLRVI855wnHKNvUCrkxZLVLzB4EgrMhqHNnEKf+FepdRPY+wIu7Q15CEN0rNBzriimNqALHSSfxUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689265; c=relaxed/simple;
	bh=bvZfBidEQ5/CscPzRaY/LIy+hxk99bYXUJ9+3FRln4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUU0+6BHSEfFI+ep06sOEy7UKMVQFPoan8PiIp1DgCcM1SFg958LB6hnEYpVSYEAu2jCW+79wr6xlJotKnij+v43NMDWQBwCZ9feGzfLZlh3rCNPr85IvjJzc89WQADvDtWz4X73nmxFc9YguVrexclBc1kwZcbC83NmnvDJ8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FSczLDXw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 0ADA520B712D; Mon, 20 Apr 2026 05:47:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0ADA520B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689264;
	bh=2b+SdzBl2fLw0sHK6RRua/VTF4F59mZJmPHAHlWpzrI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FSczLDXwZKDNkhf5RcN1NiC0mlJWATnL1Syqtnocn14ReFGU7ml6UNLtXQeh1M/b9
	 mlbFfbkcRuBYpoWcr8+EvDYHf8rjXKYGC/HslpAnXiz2L9ZK2CNvqc1gvowATk3Ohw
	 vtT0XvKO+9RTA7zlqX7LhNRmi88Vm+VdA/M2sVbk=
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
Subject: [PATCH net v4 1/5] net: mana: Init link_change_work before potential error paths in probe
Date: Mon, 20 Apr 2026 05:47:35 -0700
Message-ID: <20260420124741.1056179-2-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10210-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FC1142AEB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move INIT_WORK(link_change_work) to right after the mana_context
allocation, before any error path that could reach mana_remove().

Previously, if mana_create_eq() or mana_query_device_cfg() failed,
mana_probe() would jump to the error path which calls mana_remove().
mana_remove() unconditionally calls disable_work_sync(link_change_work),
but the work struct had not been initialized yet. This can trigger
CONFIG_DEBUG_OBJECTS_WORK enabled.

Fixes: 54133f9b4b53 ("net: mana: Support HW link state events")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3,v4:
* No change.
Changes in v2:
* Apply the patch in net instead of net-next.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 6302432b9bf6..e3e4b6de6668 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3631,6 +3631,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 		ac->gdma_dev = gd;
 		gd->driver_data = ac;
+
+		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	}
 
 	err = mana_create_eq(ac);
@@ -3648,8 +3650,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	if (!resuming) {
 		ac->num_ports = num_ports;
-
-		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	} else {
 		if (ac->num_ports != num_ports) {
 			dev_err(dev, "The number of vPorts changed: %d->%d\n",
-- 
2.34.1


