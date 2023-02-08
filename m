Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C168EE03
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 12:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBHLfb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Feb 2023 06:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHLfb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Feb 2023 06:35:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB4239CDA
        for <linux-hyperv@vger.kernel.org>; Wed,  8 Feb 2023 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675856090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6QVzqzYYSONauQ1oMma59adaZFUAEvsQTHqbimo6Io4=;
        b=HCQLleA6qHShGUVd0UrXCZskU4A1cIzdqeuCTIXDKlGXyM19Vc4f8sXTESeAHSSrgGdOgK
        eW6G0fRtfx1+ZPZpE0/qu8zdYTTG0GFTnWP/oiZwEXsO5abBzr1NpiyvANWr0ngaW0NpnR
        xontHbWeS3+cp7OctTLOg8jPCwJ3fso=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-lW7c3MWLPhyn2sa47BuU4Q-1; Wed, 08 Feb 2023 06:34:47 -0500
X-MC-Unique: lW7c3MWLPhyn2sa47BuU4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 011E585A5A3;
        Wed,  8 Feb 2023 11:34:47 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-208-16.brq.redhat.com [10.40.208.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 989EF492B01;
        Wed,  8 Feb 2023 11:34:43 +0000 (UTC)
From:   Mohammed Gamal <mgamal@redhat.com>
To:     linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        parri.andrea@gmail.com, wei.liu@kernel.org
Cc:     linux-kernel@vger.kernel.org, decui@microsoft.com,
        haiyangz@microsoft.com, vkuznets@redhat.com,
        Mohammed Gamal <mgamal@redhat.com>
Subject: [PATCH] Drivers: vmbus: Check for channel allocation before looking up relids
Date:   Wed,  8 Feb 2023 13:34:24 +0200
Message-Id: <20230208113424.864881-1-mgamal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
However, if the guest receives a vmbus interrupt during driver initialization
before vmbus_connect() is called or if vmbus_connect() fails, the vmbus
interrupt service routine is called which in turn calls relid2channel()
and can cause a null pointer dereference.

So Make relid2channel() check if vmbus channels is allocated first and return
NULL to the caller if not allocated.

Fixes: 8b6a877c060e ("Drivers: hv: vmbus: Replace the per-CPU channel lists with a global array of channels")

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 drivers/hv/connection.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..5c603c4f75a2 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -409,6 +409,8 @@ void vmbus_disconnect(void)
  */
 struct vmbus_channel *relid2channel(u32 relid)
 {
+	if (WARN_ON(vmbus_connection.channels == NULL))
+		return NULL;
 	if (WARN_ON(relid >= MAX_CHANNEL_RELIDS))
 		return NULL;
 	return READ_ONCE(vmbus_connection.channels[relid]);
-- 
2.38.1

