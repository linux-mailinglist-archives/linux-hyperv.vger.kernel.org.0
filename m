Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1CB69B41A
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 21:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBQUpM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 15:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBQUpM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 15:45:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDBF56EC2
        for <linux-hyperv@vger.kernel.org>; Fri, 17 Feb 2023 12:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676666665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0I9ueToxVrXN9UqJYuEBwbdaS1arwR4HV499olCRxkk=;
        b=f+nQuyAjeikCL8bT2lFqMmebJ2G4TxwNivC6Jg3geBwsrbAIo+/a3PKectSIfYikGLuvKK
        1cscTKa2eYJjOIQfHFNM4H7+iNTKrqCPNzrwjpkYnFH3pwMBEarrsNaAZnnuy+XaSqSIkx
        MeVmMz74Nci0uzYD/d0KRfrHX2e6HBw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-98-Kme6cr8HPXqsxvCzsno-wg-1; Fri, 17 Feb 2023 15:44:20 -0500
X-MC-Unique: Kme6cr8HPXqsxvCzsno-wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C3953C025C3;
        Fri, 17 Feb 2023 20:44:20 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-208-9.brq.redhat.com [10.40.208.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2C64C410B1ED;
        Fri, 17 Feb 2023 20:44:14 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     decui@microsoft.com, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        vkuznets@redhat.com, xxiong@redhat.com,
        Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH v3] Drivers: vmbus: Check for channel allocation before looking up relids
Date:   Fri, 17 Feb 2023 22:44:11 +0200
Message-Id: <20230217204411.212709-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

Print a warning and error out in relid2channel() for a channel id that's invalid
in the second kernel.

Fixes: 8b6a877c060e ("Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
Changes from v2:
	* Changed commit message
	* Use pr_warn_once() instead of WARN() with a shorter message
	  for less overall noise
---
 drivers/hv/connection.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..da51b50787df 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -409,6 +409,10 @@ void vmbus_disconnect(void)
  */
 struct vmbus_channel *relid2channel(u32 relid)
 {
+	if (vmbus_connection.channels == NULL) {
+		pr_warn_once("relid2channel: relid=%d: No channels mapped!\n", relid);
+		return NULL;
+	}
 	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
 		return NULL;
 	return READ_ONCE(vmbus_connection.channels[relid]);
-- 
2.38.1

