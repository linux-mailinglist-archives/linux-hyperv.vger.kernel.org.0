Return-Path: <linux-hyperv+bounces-4519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69905A61E67
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 22:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D9F174138
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEFE205ACE;
	Fri, 14 Mar 2025 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBzdXIRQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A971204582
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Mar 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988324; cv=none; b=Sy8mvkNLF/iDb4AS3kQP16VqG9wCBJPKFdJi0Tt/KsSHkruC93T/SURxBx4+peLjI0uvMUF7kKeNp37iat+V9EWhjfZELaQCgTzhK3PWh7Qelcdvs9uRm4BQC7ze8U6TUJtxiJCwH+FrPofGeFE22HM/O3+BddGsCJ/l1lauIT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988324; c=relaxed/simple;
	bh=7JAKR1B2EJs5OMc3kDKDyMYaNnMBEQeVe+0pTH470+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/Ug0Xo14f55RpNdClXIFTLzVMEIOCvF19kgXhD2tmDlqf9vd0fxttJ/3w4gydKBbewTxfQownv3bnMlxukC5g1nN8SjOiEq5czfmtkEskhISEIrLA+HplqA1Bufdb0N6Xl2CtvqQGWdoGi9yJq51+3VtZdqO6c7BuIRbQmcQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBzdXIRQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGPxM9RdXtkX+Els8nvXOJm60GkYwZd/fztNUeVaxvI=;
	b=cBzdXIRQtbdcHqo+9ADP3RB8MxDuJYfDH5HBSodysz86gvelytsrvOy4lPEeXrB93kYL/9
	BsbXhe44dFlpmF32toZlsNorO9lrdm5+zAzggFoOz+n6qGyVsAZ2FxfnB/Cvrrbikq+h5k
	Rx+1BLVObHiAIFywjfVIc3kmSnrTKoY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-4j3QuXoCNQOrm0DeJ5-F4Q-1; Fri,
 14 Mar 2025 17:38:37 -0400
X-MC-Unique: 4j3QuXoCNQOrm0DeJ5-F4Q-1
X-Mimecast-MFC-AGG-ID: 4j3QuXoCNQOrm0DeJ5-F4Q_1741988314
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B7E419560BB;
	Fri, 14 Mar 2025 21:38:34 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A74201944E42;
	Fri, 14 Mar 2025 21:38:28 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	mhocko@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	mst@redhat.com,
	david@redhat.com,
	yosry.ahmed@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	kanchana.p.sridhar@intel.com,
	llong@redhat.com,
	shakeel.butt@linux.dev
Subject: [PATCH v2 4/4] xen: balloon: update the NR_BALLOON_PAGES state
Date: Fri, 14 Mar 2025 15:37:57 -0600
Message-ID: <20250314213757.244258-5-npache@redhat.com>
In-Reply-To: <20250314213757.244258-1-npache@redhat.com>
References: <20250314213757.244258-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Update the NR_BALLOON_PAGES counter when pages are added to or
removed from the Xen balloon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/xen/balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 163f7f1d70f1..65d4e7fa1eb8 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -157,6 +157,8 @@ static void balloon_append(struct page *page)
 		list_add(&page->lru, &ballooned_pages);
 		balloon_stats.balloon_low++;
 	}
+	inc_node_page_state(page, NR_BALLOON_PAGES);
+
 	wake_up(&balloon_wq);
 }
 
@@ -179,6 +181,8 @@ static struct page *balloon_retrieve(bool require_lowmem)
 		balloon_stats.balloon_low--;
 
 	__ClearPageOffline(page);
+	dec_node_page_state(page, NR_BALLOON_PAGES);
+
 	return page;
 }
 
-- 
2.48.1


