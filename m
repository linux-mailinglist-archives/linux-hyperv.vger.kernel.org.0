Return-Path: <linux-hyperv+bounces-9906-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLfBKJKJzmlMoQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9906-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:21:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3BC38B2FD
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA4CB301F4A5
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938633121D;
	Thu,  2 Apr 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MxmWh30W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD265315D49;
	Thu,  2 Apr 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143098; cv=none; b=mXzpmoVdRolGAXP6QaN800h3jL3NWzo2qo8+eJIj9x+qsBdKiucPIVwNbJWALdjuhvQbKCMDkyumvYLqjdSlIM78iUaDKdbfwx706WiMrsv8ZX8Bf+czn8/Z7dncKRtFZLZDYBJ8hFw3ZanYy2fNZl1Ca3Hx1knGgI9rAFjEhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143098; c=relaxed/simple;
	bh=krFqt0H/TD1jR7FnVLhssGI1mPzdQgEscZoIPgw+wgo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KERo1XQU7ICdyWGbpZStWc2dKQ6ajY0IFRtrUxW8XUhAf7HwDTNyaP/voQvNWlqWmhzLVZb8z1sgvGcCZUcenuiVoNHf5XDYKbSZYt2VQJL2raFhKQv/bjdBwE8qkd/MvKHp4Ymjt5h0+o7vfjQZ77cURlnTH70SqXvkveVSXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MxmWh30W; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775143095;
	bh=krFqt0H/TD1jR7FnVLhssGI1mPzdQgEscZoIPgw+wgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MxmWh30Wr5r9EgEl3qAT6YUz5fSf5oBDX0m8Cbwm0PNlf8IxsWb7Fj7uxJuuQu9K2
	 4wv1aJrPFqwwZ5Zw/MgoIPTR6+fSW7qF0fpNBsb7HL/tQqdd3IB9YIjMJZOHzN6UXK
	 Sf7WCotJa2NkP0eiszwwtugAPx8A1mOV/lC/aTS4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 02 Apr 2026 17:18:14 +0200
Subject: [PATCH 3/4] drivers: hv: mark bus attributes as const
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-sysfs-const-hv-v1-3-a467d6f7726e@weissschuh.net>
References: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
In-Reply-To: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775143095; l=779;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=krFqt0H/TD1jR7FnVLhssGI1mPzdQgEscZoIPgw+wgo=;
 b=rrxPO+UjvzIVp2m5pRjxTdtQu77xrEnz0Q+xaH2Yw7c/ggwsMcGXmbNY32AVEaEglNIFP6vji
 2GrL/YQ/qF2DnEYA9V1pE5OMb+zcTExpxY2GdXvm73wEWKRL6BGap3H
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9906-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid]
X-Rspamd-Queue-Id: 1A3BC38B2FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This attribute is never modified, mark it as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d41b39ab628d..ecce6b72a2a2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -639,9 +639,9 @@ static ssize_t hibernation_show(const struct bus_type *bus, char *buf)
 	return sprintf(buf, "%d\n", !!hv_is_hibernation_supported());
 }
 
-static BUS_ATTR_RO(hibernation);
+static const BUS_ATTR_RO(hibernation);
 
-static struct attribute *vmbus_bus_attrs[] = {
+static const struct attribute *const vmbus_bus_attrs[] = {
 	&bus_attr_hibernation.attr,
 	NULL,
 };

-- 
2.53.0


