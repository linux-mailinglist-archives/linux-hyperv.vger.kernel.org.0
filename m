Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72824680491
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 05:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjA3EAF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 29 Jan 2023 23:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjA3EAE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 29 Jan 2023 23:00:04 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC41449E;
        Sun, 29 Jan 2023 19:59:50 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1675051187;
        bh=wWKFYgFhVzpvhYIRwOMjSib0YpKzgvkigV7Zrc6HeW8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hoz3HgsJzR0HTU0L5O2nJpYL3V+6uM21jhOK1b4Z6Q5YB0tD/2S75VKCMvXkhX+Jz
         F7KhGTndvpYZ8k68Nvi8nzXpe/NiEb1bG68yl+M75HlybfPqgkl9Hs6OS+3AzzrAZ5
         LEaOJDGgmawvwrcGShwZqTKndDA8MV/CL/Lo9cy8=
Date:   Mon, 30 Jan 2023 03:59:39 +0000
Subject: [PATCH 3/9] HID: logitech-dj: Constify lowlevel HID driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230130-hid-const-ll-driver-v1-3-3fc282b3b1d0@weissschuh.net>
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
In-Reply-To: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1675051185; l=1277;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wWKFYgFhVzpvhYIRwOMjSib0YpKzgvkigV7Zrc6HeW8=;
 b=gHbhnd+URi4q5m2WIF53+0lFoz9hkcicfRZ9MlD4AWMcgO2mt1jPTSl50kDCl6ERuZDRGRfFwG8U
 SqNvJZPhDzF9MWbKxyaUPTAkJdQC/v0+f3n1IAj0D489WHHxZ6bg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Since commit 52d225346904 ("HID: Make lowlevel driver structs const")
the lowlevel HID drivers are only exposed as const.

Take advantage of this to constify the underlying structure, too.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hid/hid-logitech-dj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index c358778e070b..62180414efcc 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -554,7 +554,7 @@ static const u8 hid_reportid_size_map[NUMBER_OF_HID_REPORTS] = {
 
 #define LOGITECH_DJ_INTERFACE_NUMBER 0x02
 
-static struct hid_ll_driver logi_dj_ll_driver;
+static const struct hid_ll_driver logi_dj_ll_driver;
 
 static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev);
 static void delayedwork_callback(struct work_struct *work);
@@ -1506,7 +1506,7 @@ static bool logi_dj_ll_may_wakeup(struct hid_device *hid)
 	return hid_hw_may_wakeup(djrcv_dev->hidpp);
 }
 
-static struct hid_ll_driver logi_dj_ll_driver = {
+static const struct hid_ll_driver logi_dj_ll_driver = {
 	.parse = logi_dj_ll_parse,
 	.start = logi_dj_ll_start,
 	.stop = logi_dj_ll_stop,

-- 
2.39.1

