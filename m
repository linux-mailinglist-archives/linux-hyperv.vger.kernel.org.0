Return-Path: <linux-hyperv+bounces-9909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JLVJqaJzmlMoQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9909-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:22:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 518AC38B320
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E72F23036486
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662933ADA8;
	Thu,  2 Apr 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eQ/xLJcY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609C0327C08;
	Thu,  2 Apr 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143099; cv=none; b=bpz6CobOKsbCgj8PArFNMxbXZ4O/VooEjFbN0o7ITzi8n1Xaxy62OZKgT+EXRbPHnIr8zhWxkHVUAk9ggIc63qeqiLHy9/2EsRn62KncQ5FP+TvRVLL7tQaaqCkeopkszPoH0cCAMsuRSglZ8d2yXkUNes678en/MVz3xVCYb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143099; c=relaxed/simple;
	bh=8ImfWPmr7gw4XNtq5keCwB+AkftKlSmuDqX9bFHAJgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mI16XA9/HZJ8d/l1XuShSPlndzdgO7rkakh3jz9iE9UX+8AFYuHJ3gVVj7CI4pEV9760YdkQzzoGVO2vau//6/4nyN9nS2jhNFgESSnqXGOkx/lK7fiD/rdIc3pG4D2uEnuesBA8IZ7FJio1l9hcejBtU++AdPIOhVWoZIejAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eQ/xLJcY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775143095;
	bh=8ImfWPmr7gw4XNtq5keCwB+AkftKlSmuDqX9bFHAJgY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eQ/xLJcYtF4Aj6WyatAyscivM5LD3wU54TLJhxBO2ZA3PRpY6koIRWlbw0xvnFgT3
	 IELxp0mV6rR+gaHgV7Cc7OlZ5yqJkRX+Z3y9UkobBaLAdcGANpQMyJj+6Y3Vt7sN2C
	 TpzMhn4iX3InywaU4dPbOImBCwOmRnzJIPzU7eJ8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Apr 2026 17:18:12 +0200
Subject: [PATCH 1/4] drivers: hv: mark chan_attr_ring_buffer as const
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-sysfs-const-hv-v1-1-a467d6f7726e@weissschuh.net>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775143095; l=971;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8ImfWPmr7gw4XNtq5keCwB+AkftKlSmuDqX9bFHAJgY=;
 b=PLmQ0EHMNkKvfwemdkWzS5cKBskqbpn7Z3BJjw4qACfshfxjQJneiF7pk81wHv1VOG55FlfQD
 0VT8BkOta4XAQu3yfcmGRJN3+wjw9jXWjLoIVFoPiNVdt1b3Z6jjQv4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9909-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 518AC38B320
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The structure is never modified, mark it as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..5f9b7cc9080c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1959,7 +1959,7 @@ static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
 	return channel->mmap_ring_buffer(channel, vma);
 }
 
-static struct bin_attribute chan_attr_ring_buffer = {
+static const struct bin_attribute chan_attr_ring_buffer = {
 	.attr = {
 		.name = "ring",
 		.mode = 0600,
@@ -1985,7 +1985,7 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
-static const struct bin_attribute *vmbus_chan_bin_attrs[] = {
+static const struct bin_attribute *const vmbus_chan_bin_attrs[] = {
 	&chan_attr_ring_buffer,
 	NULL
 };

-- 
2.53.0


