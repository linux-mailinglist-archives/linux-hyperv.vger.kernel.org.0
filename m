Return-Path: <linux-hyperv+bounces-6188-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637FBB01214
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 06:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046B754515A
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5111A5BA4;
	Fri, 11 Jul 2025 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHuEGdh3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE51A08A3
	for <linux-hyperv@vger.kernel.org>; Fri, 11 Jul 2025 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752207444; cv=none; b=LcsOaeDwSzlccD3QefGy6yR76kdCi3x9fr32BUsRJ7amFoLPhyvqC5u35cwmYwFNNoMXFHBm45OQbEcj1C7mcil55+xl2e1qHxH/CE1hJs+1OcxTbUQlFsuWMKlhZi/oR7UK2uh6LRBvS322IdmzL1eH14j77P1IwM9RkxEPTYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752207444; c=relaxed/simple;
	bh=VGjzDZZ1+cEoortXl63nVR2f4+drZLd97eNMlNObsxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/IYjXN2HWfuCE1CqbPzvhzTTvYtUaJHYfSekrB5BRMmW2C1zySDHPjIzUvhxUR8VKvANqmt+clg8ntotF1AYYSdCvKo89qomikYBgI3D6Wfxbc48QQbDrpyb0VJXfstOwhkWWt1u0ojX6yipYbr3WEHio8nfAEdKp+odsj0kis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EHuEGdh3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752207440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrgWwIjSYaWR14oGi13NO50VuL8N7hygSneHcVyTJRg=;
	b=EHuEGdh3VANJo3Qa6y6jEqsZpjiGVPbn3kSgaI8kDxx90rvq5bOjJWUgtQoymLfusXJ3Us
	a8KuTqK/QYIlaJeUkeCb8SA8kS3jnKwAbPHPGPHkbIyMzj5Go7facHkbHV22Zftaloj+sY
	GvDi3ia6l6CotySLaggz4MSShojsmGg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-udV0WTznP6uO1Q1QBSRUxQ-1; Fri,
 11 Jul 2025 00:17:16 -0400
X-MC-Unique: udV0WTznP6uO1Q1QBSRUxQ-1
X-Mimecast-MFC-AGG-ID: udV0WTznP6uO1Q1QBSRUxQ_1752207435
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E92CA1956096;
	Fri, 11 Jul 2025 04:17:14 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2A7E19560A3;
	Fri, 11 Jul 2025 04:17:08 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open to prevent IPv6 addrconf
Date: Fri, 11 Jul 2025 12:17:00 +0800
Message-ID: <20250711041700.13103-1-litian@redhat.com>
In-Reply-To: <20250710024603.10162-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Set an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.

Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

Suggested-by: Cathy Avery <cavery@redhat.com>

Signed-off-by: Li Tian <litian@redhat.com>
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


