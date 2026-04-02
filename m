Return-Path: <linux-hyperv+bounces-9910-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IUIAvWIzmlMoQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9910-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:19:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BE38B294
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC02F30378F1
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C434D4D2;
	Thu,  2 Apr 2026 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="n7w2NfER"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ED032860F;
	Thu,  2 Apr 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143100; cv=none; b=iCl2+n+v8gqGA5IAVeHsse8FUQsQuR1H6uTrzf8op6FUjEvEJSqCCtyPXI4DevIeAbK6tKrGEcFWnEK2ssnDyRfX8pWwjAU9xx+CG2Qu1AP7hzfDiIjut6PDqBay/LE7UZBmSr1KRovHkcbOX6efOQvm1HI8Rv9wE2BFMncNEjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143100; c=relaxed/simple;
	bh=tqSq9PMnm2p7kPxFnohq9Xb6y+5vBKL6rwAAof8VG0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usIvx7uWyoApdaFlUkyyaangVKX3i0xLQftIwIN3XTvr0accdia4tZxSqej4kjKg2uv8GGLGrvSrmHMbixVq2E2Xw2JdltFg4RqOk65c0t0Lrv7fpd4wMRB2ZM8Y83472WiqFucjtNeTsHTH7ptn81+43ewX4UInsPcgYbFgYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=n7w2NfER; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775143095;
	bh=tqSq9PMnm2p7kPxFnohq9Xb6y+5vBKL6rwAAof8VG0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n7w2NfERKAGyjEBFr8IqEXV8fXn4m/EiDUjX52VAU1/BhszXQmV/6kRm9QEX0REoB
	 9FWdymhLO7vlcJrvZ/OVlIsCOdb2bjVSOuYkORGIvqQYsypWoCLKw+B8BDaktQ5zCJ
	 aaprfcVemP0i2jmA77V8bTO3wKFHCPAvqi9hzhlI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Apr 2026 17:18:13 +0200
Subject: [PATCH 2/4] drivers: hv: use ATTRIBUTE_GROUPS helper
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-sysfs-const-hv-v1-2-a467d6f7726e@weissschuh.net>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775143095; l=700;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tqSq9PMnm2p7kPxFnohq9Xb6y+5vBKL6rwAAof8VG0g=;
 b=PKKgskB8fIFQgaKc4OFaZKoDi+ind8DtCxNupOjWsDGUCymHgznwEGlKTC9f5DmwVWt1N5fsY
 gTHPS4l3HOJACE3JrZiL9N3ClZ7JEf/9UXYScmMGQTIG5x2NCHlo+1H
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9910-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid]
X-Rspamd-Queue-Id: A29BE38B294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The current logic is equivalent to the helper.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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


