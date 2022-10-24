Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DFB6097A4
	for <lists+linux-hyperv@lfdr.de>; Mon, 24 Oct 2022 02:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJXA5x (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 23 Oct 2022 20:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJXA5w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 23 Oct 2022 20:57:52 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED330664D6;
        Sun, 23 Oct 2022 17:57:51 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5160245pjc.0;
        Sun, 23 Oct 2022 17:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RBbdDR1qIfFWCpyIS3gw2RrXMuQd+FyAZp7BhoIptWw=;
        b=TfEmQ5FkG7x5JVWSdQrIO7kb0R69TpMR/fvg6OYBSHscSA9xaBfnhT8ppaBNJgGEn+
         79xUr8P7YLN1DNjFnUpxV+Dl6V2GKbQS2mKxv8aRFV+1ImEwOFsgRm15PAwn+UsOMsyY
         hcKQKpSGl8hJsGpTRfVaGTkvhHoPdU2dkmUMRdS9jQWi9vfungHi15Yck1e00OG6tHdZ
         T2IEhgTowvYXT+U+qNEWUP8yZeUKQiBedMU6+JG7nU8Oyqmv/hhRVGejiRWK9sXseSuS
         9a5Gg8lqPnDtpzNdTIowRYihe3rK3YarBfeAA/c6ibYdKr+qvrt4PE/gAlwP5AqinvS7
         /aRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBbdDR1qIfFWCpyIS3gw2RrXMuQd+FyAZp7BhoIptWw=;
        b=npllcqXoNE8LhkIvc3+N8nXgnObSTy57ZARmtsu63bZmnp4mAkk2NesCrjNvaoln4R
         XuQxMnELyE2GdWC4eBBwX1Lhyb2h+jDfbUDlyOz+qnRjQpd7BElrxOyXrJNOxNe1mSIP
         lfMQvKLCDd0PGnhbwlhcZMGnRRQwjhUdGoA1VkhjLWWAWeMvsvOaixG8fosn7NbEalzB
         kfv8Sm0GAiyUVzoQvYYREfc12sPY+4OJC/0fglxFF1YnRKFdjbDEiCKakL8CSy+T1foY
         89ue1SyHzQfW1rwT3jR9gGf4s25XnUw2s8GeJOwiJGvSutf5SBhn5J8whyX8aoZ2ze4V
         4HAw==
X-Gm-Message-State: ACrzQf27ssuBUj1zmVt+GXklOkXVr0zyM5QNtSVrPQAvQsDQWAKqFKzv
        9bCpb6l1cbEprTYL/H2DTo8=
X-Google-Smtp-Source: AMsMyM4OpxA+GdWGSITBBcSmsb5WMO3k/s7ppi2dR0aT9zvC6QCviENvDIFS5HrQFOL6cPrBsTFc3Q==
X-Received: by 2002:a17:90b:254a:b0:200:53f:891d with SMTP id nw10-20020a17090b254a00b00200053f891dmr35813118pjb.168.1666573071288;
        Sun, 23 Oct 2022 17:57:51 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id oj17-20020a17090b4d9100b00205d85cfb30sm3235486pjb.20.2022.10.23.17.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 17:57:50 -0700 (PDT)
Date:   Mon, 24 Oct 2022 13:57:42 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        paulo.miguel.almeida.rodenas@gmail.com
Subject: [PATCH] [next] HID: hyperv: remove unused struct synthhid_msg
Message-ID: <Y1XjBjiE39bPNj1d@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

struct synthhid_msg was meant to be a generic representation of the
possible protocol messages sent through VMBus. In practice, only the
header is read and depending on the message type, a cast to the actual
type is done. Also, SYNTHHID_MAX_INPUT_REPORT_SIZE constant isn't used
which I suspect is a leftover from the refactoring made while this
driver was at the staging folder.

This patch removes struct synthhid_msg and refactor the code
accordingly.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/hid/hid-hyperv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 208cf8d981a5..0be717bb09d4 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -22,9 +22,6 @@ struct hv_input_dev_info {
 	unsigned short reserved[11];
 };
 
-/* The maximum size of a synthetic input message. */
-#define SYNTHHID_MAX_INPUT_REPORT_SIZE 16
-
 /*
  * Current version
  *
@@ -59,11 +56,6 @@ struct synthhid_msg_hdr {
 	u32 size;
 };
 
-struct synthhid_msg {
-	struct synthhid_msg_hdr header;
-	char data[]; /* Enclosed message */
-};
-
 union synthhid_version {
 	struct {
 		u16 minor_version;
@@ -251,7 +243,7 @@ static void mousevsc_on_receive(struct hv_device *device,
 				struct vmpacket_descriptor *packet)
 {
 	struct pipe_prt_msg *pipe_msg;
-	struct synthhid_msg *hid_msg;
+	struct synthhid_msg_hdr *hid_msg_hdr;
 	struct mousevsc_dev *input_dev = hv_get_drvdata(device);
 	struct synthhid_input_report *input_report;
 	size_t len;
@@ -262,9 +254,9 @@ static void mousevsc_on_receive(struct hv_device *device,
 	if (pipe_msg->type != PIPE_MESSAGE_DATA)
 		return;
 
-	hid_msg = (struct synthhid_msg *)pipe_msg->data;
+	hid_msg_hdr = (struct synthhid_msg_hdr *)pipe_msg->data;
 
-	switch (hid_msg->header.type) {
+	switch (hid_msg_hdr->type) {
 	case SYNTH_HID_PROTOCOL_RESPONSE:
 		/*
 		 * While it will be impossible for us to protect against
@@ -309,7 +301,7 @@ static void mousevsc_on_receive(struct hv_device *device,
 		break;
 	default:
 		pr_err("unsupported hid msg type - type %d len %d\n",
-		       hid_msg->header.type, hid_msg->header.size);
+		       hid_msg_hdr->type, hid_msg_hdr->size);
 		break;
 	}
 
-- 
2.37.3

