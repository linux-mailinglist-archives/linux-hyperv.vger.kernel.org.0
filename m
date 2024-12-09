Return-Path: <linux-hyperv+bounces-3441-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A849E9DB5
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 18:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B46165D54
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 17:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9681F2C25;
	Mon,  9 Dec 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcUoNWsI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094D1E9B25
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Dec 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767093; cv=none; b=Cg2dcrGJvaIU0KieK2Ormeva4zavQAd75Wk3j69UznO2Qb+9b7elpcVrJDzJIOpOBUmJVF+9PHvUdafdUaGCQrW0a0t5dOSqi1l5P0wGNTtRNiki9AzUnjc085dkdEpIkUMorEb5Om/kIYOjjPZpjqQ8ikCMl9tMGKm0toZ7ByE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767093; c=relaxed/simple;
	bh=qP2Hlu3N0NgQnWyH9Lx3+uHpafocFuwd0F24K19I0HQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=on3hB0h0fcQ1AEMaGmRXgJ1lDLnUI7MGza6fkAcaapDiygs3MOPqGqBNTa5+Xt/PqBh7Q6dZGuJRvy2rhe5AuG7s0gTOMgkVzSU4sKUJ9vgXNbgjfpNlE1N728oCCWlVzqYQV4Qsr7h+xE2zETUMtUl8Ih+8CXO+XJPR8EaLbiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcUoNWsI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733767089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RszX/9FzqgwZYqnsZaT6Kv2E583oRNDgfo2kcZMftbw=;
	b=ZcUoNWsI8S5l6ASsHPkwFQeQ5eHT3GgbRKmMSW3Kb5+TV0eKxJh+mlollJ9UC87WRLZy6e
	YmUYtnMtUuzwP3buGfjnfhQTj4AXLLf2gF+Gp+Y/dLl9duF4XLhOn9j0y3Ws1DKQ3qqrfy
	P+2saU38G0uQPyvrSVgbfOmJWesU0/E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-O7c4uoO3Omy0eq5aDjnZsg-1; Mon,
 09 Dec 2024 12:58:06 -0500
X-MC-Unique: O7c4uoO3Omy0eq5aDjnZsg-1
X-Mimecast-MFC-AGG-ID: O7c4uoO3Omy0eq5aDjnZsg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8A8D1955F29;
	Mon,  9 Dec 2024 17:58:03 +0000 (UTC)
Received: from starship.lan (unknown [10.22.82.46])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3816E195605A;
	Mon,  9 Dec 2024 17:58:00 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Long Li <longli@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 2/2] net: mana: Fix irq_contexts memory leak in mana_gd_setup_irqs
Date: Mon,  9 Dec 2024 12:57:51 -0500
Message-Id: <20241209175751.287738-3-mlevitsk@redhat.com>
In-Reply-To: <20241209175751.287738-1-mlevitsk@redhat.com>
References: <20241209175751.287738-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

gc->irq_contexts is not freeded if one of the later operations
fail.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aba188f9f10f..6297c0869cd6 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1318,7 +1318,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 				   GFP_KERNEL);
 	if (!gc->irq_contexts) {
 		err = -ENOMEM;
-		goto free_irq_vector;
+		goto free_irq_array;
 	}
 
 	for (i = 0; i < nvec; i++) {
@@ -1388,8 +1388,9 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
 	}
 
 	kfree(gc->irq_contexts);
-	kfree(irqs);
 	gc->irq_contexts = NULL;
+free_irq_array:
+	kfree(irqs);
 free_irq_vector:
 	cpus_read_unlock();
 	pci_free_irq_vectors(pdev);
-- 
2.26.3


