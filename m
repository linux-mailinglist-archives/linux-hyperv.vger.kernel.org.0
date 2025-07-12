Return-Path: <linux-hyperv+bounces-6200-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D64B02A59
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Jul 2025 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E938F3B0CA3
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Jul 2025 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E21F4C8A;
	Sat, 12 Jul 2025 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDnmtcw1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9A1EFF9F
	for <linux-hyperv@vger.kernel.org>; Sat, 12 Jul 2025 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752314850; cv=none; b=Dg0rG9/GjtSNDD/PUt9JMyoMLJ3oG7CWvcdI1MC5LHNXgupbI07GRwsIjldNWTae8KUan/aO+K2I3zDlcinKQbtPGhP+plltXzvPpXUrWULiBuHIwGOAABKN5M1kH3oVj6d0k/+qESB593XT/etYS3BKrAvGoCTsLehrsHni+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752314850; c=relaxed/simple;
	bh=TSgntFvzr417mI13H6PTNr1hCaOX+YBqsxPHSlM77Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cH3Nozq9TI6VzJ5YSMLKg78B73O9ve1JawSmsGdXkaS8aea+kxqEGTl51Uyh3fa0dTYmiPrnlXrDgGTqlUPjbkArsD5dSFbI8kqSl3cwVl/ojGLsuNQ7y7eaX0kDITsSYZ/2rIMQNMFZC6mDWT4M2i5tCopGSRmlvqqUegAR6iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDnmtcw1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752314846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1JlNlY2tra3Y/oEZeo/U+AdvcEDBVVOybPTu1N4/msQ=;
	b=EDnmtcw1METOqLJk+bCeqm0krIW9+/zqbb8oittNdLHEozVG8HWlj3zI7j03FWCq3yBcsz
	u7Uwz8AoY2HlrHn2piePbtNQ6t8Vm6oM/pd+2Duckj2aT3orTGaH3zu8KbZ0NWs+xcYC2c
	cMetGDNd2KVAxSR9JbhCQyd3nf2j2MU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-3-4kF6wINMOowt8-iPjmsw-1; Sat,
 12 Jul 2025 06:07:25 -0400
X-MC-Unique: 3-4kF6wINMOowt8-iPjmsw-1
X-Mimecast-MFC-AGG-ID: 3-4kF6wINMOowt8-iPjmsw_1752314844
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6A211956086;
	Sat, 12 Jul 2025 10:07:23 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75F1D1956094;
	Sat, 12 Jul 2025 10:07:18 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Long Li <longli@microsoft.com>
Subject: [PATCH net v3] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Sat, 12 Jul 2025 18:07:08 +0800
Message-ID: <20250712100716.3991-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit 8a321cf7becc
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
Suggested-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Li Tian <litian@redhat.com>
---
v3:
  - only fix commit message.
v2: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat.com/
  - instead of replacing flag, add it.
v1: https://lore.kernel.org/netdev/20250710024603.10162-1-litian@redhat.com/
---
 drivers/net/hyperv/netvsc_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c41a025c66f0..8be9bce66a4e 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	if (!ndev)
 		return NOTIFY_DONE;
 
-	/* set slave flag before open to prevent IPv6 addrconf */
+	/* Set slave flag and no addrconf flag before open
+	 * to prevent IPv6 addrconf.
+	 */
 	vf_netdev->flags |= IFF_SLAVE;
+	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
 	return NOTIFY_DONE;
 }
 
-- 
2.50.0


