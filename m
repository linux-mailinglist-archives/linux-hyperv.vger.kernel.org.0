Return-Path: <linux-hyperv+bounces-3377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 952DE9DBCAC
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Nov 2024 20:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34369B217F7
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Nov 2024 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC751C2450;
	Thu, 28 Nov 2024 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cucPuAA5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156281C2309
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Nov 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732822995; cv=none; b=PyAk4XiE+zIzKrR8YD+hB/JzwBwKgkonE119mmfgHQYSolrPRs9bu4W9ntXUYvFp3OyFqNfZ++5q4ZcXDnLJdntTmo/z9WMiULooXgDR5qxHCc+tysBEqEKr0s3KQS325HHQhcyyWQn6cro+7gJlj/fP5Q4xmB3qjaLbZYNs7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732822995; c=relaxed/simple;
	bh=VaTHl5CWYXaEUg5GJy076IuF06Ppro6TIwGO5pxBuO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eHoE+7voaXXVDT6wulaSZsrv7EWEmmF4EteI219tFeQ/S2C4NTICtAlr/INOmcV2B9oEAxQcdZtSwfrpA6DTwDhGLPE6u6dzKJPzke3cUlVzhh4orsC2wumFo302P2+YaJzBirmva8uYMst6BgEenh5L/X+2TNmZpQgqSQxV/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cucPuAA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732822991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PGHdr5xe6OO2VfVdzoKzmBYzOtEMeKKpC50tlN0vOu0=;
	b=cucPuAA5J3ZT0DhSPTcsMERWnp5tvMVYQ6AkWl+S1MtTdbOwMBHK2MOO7Ru7l/tZDqsVbP
	aEd/XMJGC3ABWfz/bIOPDKXl06uBgz3Mz5HCTBLDWnf5AvRZGhfDntT7weSemV/mnaNvoT
	5NsiKJISZOQD5nd3KASEYs350lrBXmQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-pQL-K4C2OSu2dQbquJMVrw-1; Thu,
 28 Nov 2024 14:43:10 -0500
X-MC-Unique: pQL-K4C2OSu2dQbquJMVrw-1
X-Mimecast-MFC-AGG-ID: pQL-K4C2OSu2dQbquJMVrw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF1651954197;
	Thu, 28 Nov 2024 19:43:04 +0000 (UTC)
Received: from starship.lan (unknown [10.22.88.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7ECDB195605A;
	Thu, 28 Nov 2024 19:43:01 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mana: Fix memory leak in mana_gd_setup_irqs
Date: Thu, 28 Nov 2024 14:43:00 -0500
Message-Id: <20241128194300.87605-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Commit 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
added memory allocation in mana_gd_setup_irqs of 'irqs' but the code
doesn't free this temporary array in the success path.

This was caught by kmemleak.

Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index e97af7ac2bb2..aba188f9f10f 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1375,6 +1375,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	gc->max_num_msix = nvec;
 	gc->num_msix_usable = nvec;
 	cpus_read_unlock();
+	kfree(irqs);
 	return 0;
 
 free_irq:
-- 
2.26.3


