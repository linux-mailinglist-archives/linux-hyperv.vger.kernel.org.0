Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DBF69627B
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Feb 2023 12:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjBNL2v (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Feb 2023 06:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjBNL2u (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Feb 2023 06:28:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0891222A17
        for <linux-hyperv@vger.kernel.org>; Tue, 14 Feb 2023 03:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676374087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TgvLb/I5kjbbxPz95TkbVUH4AnpMDD8c4k9xDghATcg=;
        b=PBKJuAtLYRvcqb3UmCfyA1V9w96C12VMzPnx/VKh39Mq+CKrMzlvroEWcrtM1GbriKG2R7
        bN1Ebrj2Zf4LIBkmHw04noFvWsqsAmb72bSJ55TUwQF3UtyLc5RcD5PHT3SI4ddFF4UVYG
        kWDjJDK0Cho6GVW/x4VsDiJeFLP3Jqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-625hxeStNqafWUydeF3aWg-1; Tue, 14 Feb 2023 06:28:04 -0500
X-MC-Unique: 625hxeStNqafWUydeF3aWg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B5E5971092;
        Tue, 14 Feb 2023 11:28:03 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-208-27.brq.redhat.com [10.40.208.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 53D86140EBF6;
        Tue, 14 Feb 2023 11:27:58 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     decui@microsoft.com, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        vkuznets@redhat.com, xxiong@redhat.com,
        Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH v2] Drivers: vmbus: Check for channel allocation before looking up relids
Date:   Tue, 14 Feb 2023 13:27:41 +0200
Message-Id: <20230214112741.133900-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

relid2channel() assumes vmbus channel array to be allocated when called.
However, in cases such as kdump/kexec, not all relids will be reset by the host.
When the second kernel boots and if the guest receives a vmbus interrupt during
vmbus driver initialization before vmbus_connect() is called, before it finishes,
or if it fails, the vmbus interrupt service routine is called which in turn calls
relid2channel() and can cause a null pointer dereference.

So Make relid2channel() check if vmbus channels is allocated first, and if not
print a warning and return NULL to the caller.

Fixes: 8b6a877c060e ("Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
Changes from v1:
	* Corrected and detailed description in commit message
	* Added detailed warning message
---
 drivers/hv/connection.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..82876e84f719 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -409,6 +409,10 @@ void vmbus_disconnect(void)
  */
 struct vmbus_channel *relid2channel(u32 relid)
 {
+	if (vmbus_connection.channels == NULL) {
+		WARN(1, "Requested relid=%u, but channel mapping not allocated!\n", relid);
+		return NULL;
+	}
 	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
 		return NULL;
 	return READ_ONCE(vmbus_connection.channels[relid]);
-- 
2.38.1

