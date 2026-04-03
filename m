Return-Path: <linux-hyperv+bounces-9957-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAXvOgN8z2mvwgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9957-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 10:36:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCB0392238
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 10:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C46D30469BC
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 08:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2CC373BFC;
	Fri,  3 Apr 2026 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hWJ2wKqE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C52DC76A;
	Fri,  3 Apr 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204958; cv=none; b=SqUpUP8SPzel/+R+XJEqcGb1kuNA5vxbaJIZfJ/5sqRIzTllPwmv35nCGn/f81acXfb6VIb21PKsSZrK05+r3nofspzv5M+qJnSF6DniYm6ZZ5nEO1/qIZ1AEVMFb6+k/m/UK1/zYc+g+sz6PPR9gpLU2w5Sm45mBtE3OqMpfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204958; c=relaxed/simple;
	bh=wZ/b1Wn9T98S235PB+hnupCILUCOYfQkZl7yWCKUdMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6y/3mqTZ6kWVSVsXMUNbuRkorJoHlgeo3kRa9Aio5yObpPFq99es8qNsfVvls+vUQ95e4fjN0Y++IthYDgUzLHCYwLdIU8zkpuvvhmBbuVQ6+ZCsBl0XxxGOCc2whvAFc1+1TI3Fj479dxOjdd94KCzB5jdJcnguqYL68MbY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hWJ2wKqE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775204954;
	bh=wZ/b1Wn9T98S235PB+hnupCILUCOYfQkZl7yWCKUdMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hWJ2wKqErZRLSm72gIhPUo5naRbpxw8ympo/015WJ+QY3c8sA5TdsKrUEJVhsKtZV
	 nTpInsR4XYEPnVCzIb1Z0hRZgAuWlI54kKVB1qfNdbx6OwIw344eng/Mv44gfGGFE/
	 MGM1g6fknEXZ9cpnuKKXRWKMsVYB+TrZsH+AvKYc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 Apr 2026 10:29:14 +0200
Subject: [PATCH v2 2/4] drivers: hv: use ATTRIBUTE_GROUPS helper
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-sysfs-const-hv-v2-2-8932ab8d41db@weissschuh.net>
References: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
In-Reply-To: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775204954; l=802;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wZ/b1Wn9T98S235PB+hnupCILUCOYfQkZl7yWCKUdMM=;
 b=5LSGdeyCwF8pA/+DWPT47+UWWq4v8l7CK0MnhQG8VOSuk9mn4PoQdcr1hOOVyYFOCBHIoy2Gx
 ZLEL2f+R0vWCAseTna8zxHMcz6JTwLtqt20Uq8cjKXImZRoG2nd4Vr+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,weissschuh.net];
	TAGGED_FROM(0.00)[bounces-9957-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7FCB0392238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current logic is equivalent to the helper.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5f9b7cc9080c..d41b39ab628d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -645,10 +645,7 @@ static struct attribute *vmbus_bus_attrs[] = {
 	&bus_attr_hibernation.attr,
 	NULL,
 };
-static const struct attribute_group vmbus_bus_group = {
-	.attrs = vmbus_bus_attrs,
-};
-__ATTRIBUTE_GROUPS(vmbus_bus);
+ATTRIBUTE_GROUPS(vmbus_bus);
 
 /*
  * vmbus_uevent - add uevent for our device

-- 
2.53.0


