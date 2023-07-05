Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899387485A0
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jul 2023 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjGEOCx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jul 2023 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjGEOCv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jul 2023 10:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB6211B;
        Wed,  5 Jul 2023 07:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC71A61568;
        Wed,  5 Jul 2023 14:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4E5C433C7;
        Wed,  5 Jul 2023 14:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688565769;
        bh=8Pv519rVX2nyzfcP+WWJAfxHrjLTPQrVejjsds7b0e8=;
        h=From:To:Cc:Subject:Date:From;
        b=bTRx9QYeOOUu652xyFmZdnhpFBlT1LXlf0Ecjj9AqPmaZ+k4P5cbVpk6enhALEj+4
         a++Be9rRcL1yiFdllRaQpJkGq+/dACPEV0zCo8uGcqIMkwlkcT4Ast+4B3zEqtA1my
         1yBNwB/rHhuV7+nPSGNDHyjhl1Y31bpbXvZr1mlYn5elxSVYB5RM2nn4wn9qN5bmxL
         FhXk8K0TM+LeSS3LrDieZiEoszeAJyznP28Jfz7n7JlnTk3REgjOePQES9Lrc3TQHq
         SlhmZXawVNCyXfrzkOfyjPxviE83s/157jrxJcl8wZPOP79iNgmJs7hVoxKps5UvLW
         XTlf78IsOIZ2w==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hyperv: avoid struct memcpy overrun warning
Date:   Wed,  5 Jul 2023 16:02:24 +0200
Message-Id: <20230705140242.844167-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A previous patch addressed the fortified memcpy warning for most
builds, but I still see this one with gcc-9:

In file included from include/linux/string.h:254,
                 from drivers/hid/hid-hyperv.c:8:
In function 'fortify_memcpy_chk',
    inlined from 'mousevsc_on_receive' at drivers/hid/hid-hyperv.c:272:3:
include/linux/fortify-string.h:583:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  583 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

My guess is that the WARN_ON() itself is what confuses gcc, so it no
longer sees that there is a correct range check. Rework the code in a
way that helps readability and avoids the warning.

Fixes: 542f25a944715 ("HID: hyperv: Replace one-element array with flexible-array member")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/hid-hyperv.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 49d4a26895e76..f33485d83d24f 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -258,19 +258,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 
 	switch (hid_msg_hdr->type) {
 	case SYNTH_HID_PROTOCOL_RESPONSE:
+		len = struct_size(pipe_msg, data, pipe_msg->size);
+
 		/*
 		 * While it will be impossible for us to protect against
 		 * malicious/buggy hypervisor/host, add a check here to
 		 * ensure we don't corrupt memory.
 		 */
-		if (struct_size(pipe_msg, data, pipe_msg->size)
-			> sizeof(struct mousevsc_prt_msg)) {
-			WARN_ON(1);
+		if (WARN_ON(len > sizeof(struct mousevsc_prt_msg)))
 			break;
-		}
 
-		memcpy(&input_dev->protocol_resp, pipe_msg,
-				struct_size(pipe_msg, data, pipe_msg->size));
+		memcpy(&input_dev->protocol_resp, pipe_msg, len);
 		complete(&input_dev->wait_event);
 		break;
 
-- 
2.39.2

