Return-Path: <linux-hyperv+bounces-6174-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE77AFF6FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 04:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EF97B17F1
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A8827FD64;
	Thu, 10 Jul 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Af9x6OHa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A127F16D
	for <linux-hyperv@vger.kernel.org>; Thu, 10 Jul 2025 02:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752115577; cv=none; b=BKW1/WOFH9I7SnY0pIbLKEqt7xDbvc+XaB0sBvEEfQxO6ROZRhGopmqivPe2VEwqu/VAOD7K37L72IuUzSPyDjgoyJpL+yBG2FA7wL5H74fetVXGiRlGhOFLL7NZ7x4z/kAOD0x7pZuyGgrRSqTAVYGFB60KNIP6d4ae4OI4W04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752115577; c=relaxed/simple;
	bh=Dq5E6qbcnp7OKpb31WemutPpvpSMukiF8kyCjkOa3q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAj6ylrI6/UC7ZYMWU9Jf/bhGRhTli4+AbwkHzdKJlAYRBqhA3/O7UaFhH8RYEy5lneYv2hf78/URSjrjuuA0AahZ9oj5het3VuG6ufaXDviucZXhnzGagM2Zuon9pbhxQolFMVYOtNtxsrke429aRaiejXzqSSFT/jXaZOVdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Af9x6OHa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752115574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iqwXOIteg9qCzt7xtB3xuBCygfMIm2/XPmfbhNkkYd8=;
	b=Af9x6OHacRXW76pLnNnmOMj+VYkrhpa33NZRiRZAslPSmTy1bUz50js/M9Rc/boSLHc+55
	uBrw7N6xifcmiKv+Cg4cbHs5k4IPu2Tn774pnHR58rcBHufbizfKopEDO9rg9BTgqBgzW3
	9qwP+V2JuquR77I1dbRHq/djnG/aHJA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-F9ekLMmrMuuv12pNqApSiw-1; Wed,
 09 Jul 2025 22:46:11 -0400
X-MC-Unique: F9ekLMmrMuuv12pNqApSiw-1
X-Mimecast-MFC-AGG-ID: F9ekLMmrMuuv12pNqApSiw_1752115570
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1DEC1954236;
	Thu, 10 Jul 2025 02:46:09 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.116.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E4ECF18002B5;
	Thu, 10 Jul 2025 02:46:05 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF before open  to prevent IPv6 addrconf
Date: Thu, 10 Jul 2025 10:46:03 +0800
Message-ID: <20250710024603.10162-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The use of the IFF_SLAVE flag was replaced by IFF_NO_ADDRCONF to
prevent ipv6 addrconf.

Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

This new flag change was not made to hv_netvsc resulting in the VF being
assinged an IPv6.

Suggested-by: Cathy Avery <cavery@redhat.com>

Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/net/hyperv/netvsc_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index c41a025c66f0..a31521f00681 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2317,8 +2317,8 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
 	if (!ndev)
 		return NOTIFY_DONE;
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
+	/* Set no addrconf flag before open to prevent IPv6 addrconf */
+	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
 	return NOTIFY_DONE;
 }
 
-- 
2.50.0


