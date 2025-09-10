Return-Path: <linux-hyperv+bounces-6813-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EBDB509EE
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 02:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB31B7AAA26
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A68919D093;
	Wed, 10 Sep 2025 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bndbfUHz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598D78F54
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Sep 2025 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464668; cv=none; b=GObG5WbQRbmzsoM0kMapeDnqSUnkhJE2hcyFWsvACxwVVU+3quDXnhxI6I2lm0aqeV9DcUscZ612NK3e2M7rmFzWrTBA9qrWJydQkY3ATrpQfxWHQXHKTuW3QI2kFU84pA86kz9MvNvVXHFSnLpmJ7dLZGCCdJ9NaPrVMWFsk9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464668; c=relaxed/simple;
	bh=kvsxtl4eteYff9YEkkuUEDpv+2mnjQVnVcZI8Rc1GrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCNGjavH4vbvU9TSR8q6T73OrkaDxKJgVXE1oeUHKTJnQJWoXt2PWC/AhRqpRAD/7nXKONeu9QJjH+/dOYHldXHa6xxj0G7WiTkSoxvZBdBNhulJeX59I3p+lVZl0J98SKMmOfTiQV4vGxh/EGHRq1dYFgSENOrJQMmPMkvDkTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bndbfUHz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757464665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mzYOGafRS64y0cq1Xm2ekzKR94eCodioB25haeoJkRo=;
	b=bndbfUHz0uQ+Vw8sqvXPh3tAtVHxWwmpZAB/IRcg1uoeEZLtWRe2R7MqnVUzHZsgU8AZ+d
	64Q05WFYvM7gM2W3kqqShmcykL01SxOGljsyWyroI3BfeSKwut5JALBwOC3RP7owGb9Wh9
	toynW87duplWYfioP+MxZnC012vsZxU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-SQ1u5hJEMZyb_nWtX2AqRg-1; Tue,
 09 Sep 2025 20:37:42 -0400
X-MC-Unique: SQ1u5hJEMZyb_nWtX2AqRg-1
X-Mimecast-MFC-AGG-ID: SQ1u5hJEMZyb_nWtX2AqRg_1757464661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17F60180057A;
	Wed, 10 Sep 2025 00:37:41 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.72.112.29])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2D7F3002D2A;
	Wed, 10 Sep 2025 00:37:34 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Benjamin Poirier <bpoirier@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net v2] net/mlx5: Not returning mlx5_link_info table when speed is unknown
Date: Wed, 10 Sep 2025 08:37:32 +0800
Message-ID: <20250910003732.5973-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Because mlx5e_link_info and mlx5e_ext_link_info have holes
e.g. Azure mlx5 reports PTYS 19. Do not return it unless speed
is retrieved successfully.

Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")
Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Li Tian <litian@redhat.com>
---
v2:
 - Fix indentation and spacing only.
v1: https://lore.kernel.org/netdev/20250908085313.18768-1-litian@redhat.com
---
 drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 2d7adf7444ba..aa9f2b0a77d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1170,7 +1170,11 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
 	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
 					  force_legacy);
 	i = find_first_bit(&temp, max_size);
-	if (i < max_size)
+
+	/* mlx5e_link_info has holes. Check speed
+	 * is not zero as indication of one.
+	 */
+	if (i < max_size && table[i].speed)
 		return &table[i];
 
 	return NULL;
-- 
2.50.0


