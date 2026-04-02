Return-Path: <linux-hyperv+bounces-9907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDysHZSJzmlMoQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9907-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:21:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EE38B304
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 17:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AFBE3020EB2
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 15:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FFB332EC8;
	Thu,  2 Apr 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="n+dl22LG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B062620DE;
	Thu,  2 Apr 2026 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143099; cv=none; b=WRwlilPmWr+RtWJg0CnIKI4/Nk1+GFPD2ihLgrD1503ZBNQXok5iiGXPufrvOTi0/JWKE/lck1Ko81X7WT6LUNCu7BZCCQKyMeAwi9Zwiqy+erh6Jy8/wgJJZ1czzWlgfk8uMwPIMsQ2pnxavpyX2aT2vQcVIKVig69hK8zU4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143099; c=relaxed/simple;
	bh=DVYpLqWWZCzR7awppWJPTPL2ZbyIonfbbFVFU/UNqG8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b292UVeDxikCWitBUMxjDDhPPqHwToW+b7oxDP9pPp/BDWVIaTH/EjXHHgqVQrJu87zx3d3+htIEjiEZm8FcSnu+qWZGu8PBGBA+QhJqXGrH/AqFU96W2HtbODDnO7ecYTRlhsBxRPLgYncyq7XOMPTUfhcgQbxho5Hk/iq/5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=n+dl22LG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775143095;
	bh=DVYpLqWWZCzR7awppWJPTPL2ZbyIonfbbFVFU/UNqG8=;
	h=From:Subject:Date:To:Cc:From;
	b=n+dl22LGQfJZSyZnrcmPwZ+CxiMiLDJeEIDMcazrV5BHw9xFblYANxr3QQRCSOVj2
	 29TAjq37HdJFkJbe14hBcoKVb7Bz9p/2qvknD/UWaAoJ+As7JR3W1/j6qHkfiBWONQ
	 LdY3Q9lXY2Hf+Ktuxyj9/JLLcPHNWqiR7EAaRFus=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] drivers: hv: mark some sysfs attribute as const
Date: Thu, 02 Apr 2026 17:18:11 +0200
Message-Id: <20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMMQ6DMAxA0asgz1hKQA2Iq1QMqTHEDKGKAbVC3
 L2hjG/4/wDlJKzQFQck3kVliRm2LICCjxOjDNlQmcqZuraoXx0VaYm6YtiR/GAejW3JtR5y9E4
 8yuc/fPa3dXvNTOt1gfP8AVEuYVpyAAAA
X-Change-ID: 20260331-sysfs-const-hv-cad05718c68a
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775143095; l=773;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DVYpLqWWZCzR7awppWJPTPL2ZbyIonfbbFVFU/UNqG8=;
 b=W/Q27mnED9mCK68YC/Xt3qRuhQjzE8LMHJstxzqllGpWq7Dj5MfKwupxb+eci6B23pDvlFVuo
 O0OjhSYnO0FClTz96Nx1tqQM0e0yZkiDGxcNyROZmPywsiKiyn4ty9C
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
	TAGGED_FROM(0.00)[bounces-9907-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid]
X-Rspamd-Queue-Id: 2D1EE38B304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The sysfs attribute structures are never modified.
Mark them as const where possible.

This excludes the device attributes for now, as these will have their
own migration.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (4):
      drivers: hv: mark chan_attr_ring_buffer as const
      drivers: hv: use ATTRIBUTE_GROUPS helper
      drivers: hv: mark bus attributes as const
      drivers: hv: mark channel attributes as const

 drivers/hv/vmbus_drv.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260331-sysfs-const-hv-cad05718c68a

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


