Return-Path: <linux-hyperv+bounces-4417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 974D9A5D38B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 01:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9813B17C22D
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Mar 2025 00:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11664A05;
	Wed, 12 Mar 2025 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7/LFnaV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16F4C9D
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Mar 2025 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741738089; cv=none; b=QFHlFyzJJFBdu+MPbSSdyVSYU1mlwrAdVKhz7jundrxupaKr1HHjhhsU1fRPzH3IsvVhTFfReS2q76vLziTy0lcueStwpPDZC9/35xRk0uqSp1pRO1eQKf2yLDA1lKLUYTi4ACtBO9KRMLAGgraa+0bqLy9wWYkWMTtw7+Vs+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741738089; c=relaxed/simple;
	bh=d/9U3Hs56MfO9ZDfHXmWmno1K8O1u1XuJHmhdH2F0w4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDLwFfOyjxg6h0nEjo9+hhptrGwrVkmQPjUn06Cx61PpAxIbqs1JGfzNbKZA6mzpZlnQ9NJAKP5sQHg5s4/skjNGuxUmFjoy8M662RU8oFb3gKiflrAIjWWeF1a7fgvNJzJgaRvMLCGFmgeE/fb9uELlAnnz2wa7uhLd1t47Bbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7/LFnaV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741738087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2Hs8hV+/gJc3OfaS9x8cWsCD/xR9fjklu355DFl/Jo=;
	b=h7/LFnaVkUYIZb6F2nEvZdEmWqyBt7dDEoFTk6ZMcX6Yr9FDZx5P6Ae5JoY0MvpIMc4slf
	JAiMNoXzTIJupuEUWPld4ASXPr5kuPjJCoZYDNSwMok8CcUvuHlf8NstIYCrh3GKq5l/c3
	858BXLn+8xhqsQOkMCp996R9oXOPdz0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-hcKnUj3kOH-9CB9AP-czdw-1; Tue,
 11 Mar 2025 20:08:04 -0400
X-MC-Unique: hcKnUj3kOH-9CB9AP-czdw-1
X-Mimecast-MFC-AGG-ID: hcKnUj3kOH-9CB9AP-czdw_1741738080
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 629D51800259;
	Wed, 12 Mar 2025 00:08:00 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 989161956094;
	Wed, 12 Mar 2025 00:07:53 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com,
	alexander.atanasov@virtuozzo.com
Subject: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Date: Tue, 11 Mar 2025 18:06:59 -0600
Message-ID: <20250312000700.184573-5-npache@redhat.com>
In-Reply-To: <20250312000700.184573-1-npache@redhat.com>
References: <20250312000700.184573-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Update the NR_BALLOON_PAGES counter when pages are added to or
removed from the VMware balloon.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 drivers/misc/vmw_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index c817d8c21641..2c70b08c6fb3 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
 
 			vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
 						 ctl->page_size);
+			mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+				vmballoon_page_in_frames(ctl->page_size));
 		}
 
 		if (page) {
@@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
 	list_for_each_entry_safe(page, tmp, page_list, lru) {
 		list_del(&page->lru);
 		__free_pages(page, vmballoon_page_order(page_size));
+		mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
+			-vmballoon_page_in_frames(page_size));
 	}
 
 	if (n_pages)
@@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
 
 		/* Update the balloon size */
 		atomic64_add(ctl.n_pages * page_in_frames, &b->size);
-
 		vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
 					    ctl.page_size);
 
-- 
2.48.1


