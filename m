Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8707A49F75A
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jan 2022 11:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiA1Ke3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jan 2022 05:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231685AbiA1Ke0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jan 2022 05:34:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643366065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Quc4skgWQnhYb+89AvQYjxil+ByV/pBG/nU7QFXNosI=;
        b=OmMl5+uKVGJe6Q4mJIUEzw2+Fbal5hzB1t/awcfjDE0l7KffIsVzZTONK6HQzBUuLdqKX1
        SURJf6cCslomkuc10zr99u0x2Eex528oXZOyjl21Xe2DRh0zO4uAC8/n55jdaFPzZj80Ap
        EmCPYyeHYKGMR/OXij+dXPAU31gNYLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-gM9IMD9IOuKE_VIN-ADfgw-1; Fri, 28 Jan 2022 05:34:22 -0500
X-MC-Unique: gM9IMD9IOuKE_VIN-ADfgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 180CD1083F61;
        Fri, 28 Jan 2022 10:34:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C790A7B6D5;
        Fri, 28 Jan 2022 10:34:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 2/2] Drivers: hv: Compare cpumasks and not their weights in init_vp_index()
Date:   Fri, 28 Jan 2022 11:34:12 +0100
Message-Id: <20220128103412.3033736-3-vkuznets@redhat.com>
In-Reply-To: <20220128103412.3033736-1-vkuznets@redhat.com>
References: <20220128103412.3033736-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The condition is supposed to check whether 'allocated_mask' got fully
exhausted, i.e. there's no free CPU on the NUMA node left so we have
to use one of the already used CPUs. As only bits which correspond
to CPUs from 'cpumask_of_node(numa_node)' get set in 'allocated_mask',
checking for the equal weights is technically correct but not obvious.
Let's compare cpumasks directly.

No functional change intended.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hv/channel_mgmt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 52cf6ae525e9..26d269ba947c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -762,8 +762,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 		}
 		allocated_mask = &hv_context.hv_numa_map[numa_node];
 
-		if (cpumask_weight(allocated_mask) ==
-		    cpumask_weight(cpumask_of_node(numa_node))) {
+		if (cpumask_equal(allocated_mask, cpumask_of_node(numa_node))) {
 			/*
 			 * We have cycled through all the CPUs in the node;
 			 * reset the allocated map.
-- 
2.34.1

