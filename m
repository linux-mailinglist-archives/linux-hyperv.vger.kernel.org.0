Return-Path: <linux-hyperv+bounces-10174-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMCGDudH32nNRQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10174-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:10:15 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5005401BD3
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 10:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3CAA305A4CE
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Apr 2026 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5C13CD8AB;
	Wed, 15 Apr 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U38i76rU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262A3281357;
	Wed, 15 Apr 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240587; cv=none; b=M4LvX3ewEYx9zaARjnJS3LKROw86bBp2N/UfdqCBBqOixrVmhTJkJ7OuHnLfgQWzT09oQ21n67wfC3srmXU+iAluoAgK9YT6Md/TWGNj7/pzDHdqzf4GX4JzD8ERlE0NlwPW7Rg+qRjwI4rLCCYYuCJ+hEAa8DZVSR5hier2rC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240587; c=relaxed/simple;
	bh=ZhA9M77bYSyp++9kW5NFpO+iorbjw8MZjKC6BY6253c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aair+vQvlaRDRobl4tb5mmjIRyA5CS+jmDGXxGhbk+6VwJSHzz6ZkJ1A3/xGVnGqQQVh3hfU/yEs19zVTUEINykRbLMNN5JHEAzD3uT/Nq5NkL+SekPi630/wGxhGw3qnAzSflWp3K4jwILTsw9Cu65zcudeAbBJlxd2EzuI5Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U38i76rU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 240C620B712D; Wed, 15 Apr 2026 01:09:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 240C620B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776240586;
	bh=XhtpcIYIkBp3wS6dQeNciqwB7nL148jNLzyfe7009PM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=U38i76rUA6XArx2Mk/5C7aNO0q17m19nsPdsyrYT/MMcEd4Dhdhz+g1rsQjzG030G
	 vkmENm/cyf04AB3VJ2Rom+OaOgNyNYDayqxTdq53cosjKCDqQjSdexRnPUoAzrXxTD
	 lLHxDejG4Yr/OQX1nxj6CTzwv0f4XA0HPY5A8dKk=
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
Subject: [PATCH net v3 1/5] net: mana: Init link_change_work before potential error paths in probe
Date: Wed, 15 Apr 2026 01:09:37 -0700
Message-ID: <20260415080944.732901-2-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260415080944.732901-1-ernis@linux.microsoft.com>
References: <20260415080944.732901-1-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10174-lists,linux-hyperv=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-0.994];
	RCPT_COUNT_TWELVE(0.00)[23];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: E5005401BD3
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
Changes in v3:
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


