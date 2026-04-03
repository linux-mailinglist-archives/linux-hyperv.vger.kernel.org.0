Return-Path: <linux-hyperv+bounces-9959-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOOULHd6z2mvwgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9959-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 10:29:43 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1B392163
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 10:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7626E300B19A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 08:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0872E37BE6A;
	Fri,  3 Apr 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dz4fIsf5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DC376490;
	Fri,  3 Apr 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204959; cv=none; b=AQP0J1kzqB22qHJz8lG5nvKPn4vO+nFMLPyu7cS0uNBMbsSaj1x0+HIYIWg7d97oY1gLZVtUMzlqiFzZyd9hQELnIlvTllbFXUTCJ1INOelXnQffpqynDZ+NnwFhgEsGr+AUANj/i6XMhTEippWA6KnTU/jUt6Mlnmw2AoftiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204959; c=relaxed/simple;
	bh=FlF/f5L19lcRqO1NGuv79B5PwCyCBGlkX7t4AjqtJqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWSUFYu/fW1gy5gZYPxSqvb7EdDPea4G4HbaESbuLDm5+W+j8z1HHZ4SeTLKIUTvMEq1q505zeTLfgi7P4rF1V0lVuMlJXdtz0HxEIuZHfd9ELf8V+C89uLCfzdvDPqY59C+aMFqnE1fnLURKjeARwCatF2gAb2bN5NHQRBeZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dz4fIsf5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775204954;
	bh=FlF/f5L19lcRqO1NGuv79B5PwCyCBGlkX7t4AjqtJqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dz4fIsf5joVts5/QmPWFnv3uu+S/vBAukPHBecM2CU7q7BNAIOf12fUC9qaOBDeJv
	 eoobCPYcgxJtvYd8DEaos89ElGlU/POEq9gVvbzY+A9Adilv7EzT3bFBSuFAI2hDfk
	 Qhc+aaPegZqfBM4t5HfMF9Jdm81QVJ5MKJgLlGto=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 Apr 2026 10:29:15 +0200
Subject: [PATCH v2 3/4] drivers: hv: mark bus attributes as const
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-sysfs-const-hv-v2-3-8932ab8d41db@weissschuh.net>
References: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
In-Reply-To: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775204954; l=881;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FlF/f5L19lcRqO1NGuv79B5PwCyCBGlkX7t4AjqtJqc=;
 b=vUMNXT4NkLCxbO0dLT2ySiAi03MBAX60oPOgDzxAhRGfGkWcsaP7b/m9l1Icz0774+eMVJmsy
 owWDKI6eQ22CgJ6DnE3mAg2D7XvMn/Pa7VsaW79lsyRZx6D9m7A4K5N
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,weissschuh.net];
	TAGGED_FROM(0.00)[bounces-9959-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 99B1B392163
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This attribute is never modified, mark it as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
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


