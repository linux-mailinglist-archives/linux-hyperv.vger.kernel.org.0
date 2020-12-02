Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD742CC1D6
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Dec 2020 17:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgLBQOY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Dec 2020 11:14:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728503AbgLBQOX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Dec 2020 11:14:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606925577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mnMzbDEpi77RtO/Ws+e06k7eBfAFFroo39MhnBjLVjQ=;
        b=PbyxQDHZCA+dazSpK32DWzmgr6w7zboDtQ54vzIkvk2fK6wzHEIvVvDbJ4A7NuwsLxC9Tg
        TU0Bv7KwVOPgsxK01FYLlF0FG+MkfbDqofC5M02TesjvzbGicdjCZT3mUyZ6PtD1dQ+mAd
        pw0uTYCN0UC3kkLHWrq4P0YVuHsczZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-e9LXZ4EmN-280v1-3L1PrQ-1; Wed, 02 Dec 2020 11:12:54 -0500
X-MC-Unique: e9LXZ4EmN-280v1-3L1PrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10EE6185E4A6;
        Wed,  2 Dec 2020 16:12:52 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.192.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EDE75C1D0;
        Wed,  2 Dec 2020 16:12:46 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 0/2] hv_balloon: hide ballooned out memory in stats
Date:   Wed,  2 Dec 2020 17:12:43 +0100
Message-Id: <20201202161245.2406143-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

It was noticed that 'free' information on a Hyper-V guest reports ballooned
out memory in 'total' and this contradicts what other ballooning drivers 
(e.g. virtio-balloon/virtio-mem/xen balloon) do.

Vitaly Kuznetsov (2):
  hv_balloon: simplify math in alloc_balloon_pages()
  hv_balloon: do adjust_managed_page_count() when
    ballooning/un-ballooning

 drivers/hv/hv_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.26.2

