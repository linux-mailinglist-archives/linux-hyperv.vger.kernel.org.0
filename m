Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735D03435C2
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Mar 2021 00:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhCUXbr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 21 Mar 2021 19:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhCUXba (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 21 Mar 2021 19:31:30 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A3C061574;
        Sun, 21 Mar 2021 16:31:29 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id 94so11151236qtc.0;
        Sun, 21 Mar 2021 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdmaB0Yld3dKYOhG0bV3X546Bx/5HR4YRhSUHcMQp6s=;
        b=RFql0t34URoS+0ZT7Imvks0REQBkpi4+BPpBBqGZNgOxRGLsjZxUv07a52tWRCFrPn
         8GbrewoIdk3whsbFZxGKf7fOs341zPLhSVyW+jYqF9srC4+AP0Ic00sx1IRl+JUg8fxq
         IcDcUAOhKPL+wg7sZ7tz0gThFTfEPdlLoA+vbencP6eZik8uxtd2nmXyM6JjPjbxvPWK
         dDpxyIReIIc/PPry28ChmwgSL4PcHyK0c/CiouO7lIbFRs9TBoXjPE4a2hAiZv8k2Tgn
         IVz8DKUHqYeim7pcOX/llXpmk69H0oV2SsLAsf3jVJCTso4e/a8+UnXlBuBhC4wNzGVl
         pXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdmaB0Yld3dKYOhG0bV3X546Bx/5HR4YRhSUHcMQp6s=;
        b=s05ijHFghykd6oGdPdZBcaY+g/aE0QdxPAgfNMwUylJ10GDLLZKRb3ktBQejCujdf+
         wKA6aSU/PxLOX9c7ZQvqiV/HHs5fjkWjOwwJ2GUtBSt7LJw4PMdOId3YbbfUhuhoq+EV
         Bc+m911B0JT1vWNIcF3NDcPLXTc8Ywb2FhjpfF9ctnHt/BJzwtBVaYSSXTOPcixPbPeG
         C2Qiy2ZvoqLWZ2DQ342Z+ov7NaapNisJwoQyW2Aifp2FiwU/Uat/esd68R8LlAzIw9U2
         dxNYwLhC00MQOdAFjS6c7cRL1DCb3qIz6Vlk+X36Jq7zQJKOP5fZThW9iuCt5AGxZWPi
         hmbQ==
X-Gm-Message-State: AOAM533g1oU/9WiFisE8Ge64kbLuFjFjNItMWuwEVoQt4p5xUR6EPjEc
        gpHozwLLulTwzg6RrVF//XU=
X-Google-Smtp-Source: ABdhPJxqeeIr3tUoUR4/WBHcVi21W4ncqeypHbBW29vAV+RnTfyi41zPM5rOXrzs+V5/xbN1MlBnIw==
X-Received: by 2002:ac8:5e0b:: with SMTP id h11mr7661567qtx.194.1616369489043;
        Sun, 21 Mar 2021 16:31:29 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.54])
        by smtp.gmail.com with ESMTPSA id q15sm7891946qtx.47.2021.03.21.16.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 16:31:28 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] hyperv: Few mundane typo fixes
Date:   Mon, 22 Mar 2021 05:01:08 +0530
Message-Id: <20210321233108.3885240-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


s/sructure/structure/
s/extention/extension/
s/offerred/offered/
s/adversley/adversely/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 include/linux/hyperv.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f1d74dcf0353..2c18c8e768ef 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -284,7 +284,7 @@ struct vmbus_channel_offer {

 		/*
 		 * Pipes:
-		 * The following sructure is an integrated pipe protocol, which
+		 * The following structure is an integrated pipe protocol, which
 		 * is implemented on top of standard user-defined data. Pipe
 		 * clients have MAX_PIPE_USER_DEFINED_BYTES left for their own
 		 * use.
@@ -883,11 +883,11 @@ struct vmbus_channel {
 	 * Support for sub-channels. For high performance devices,
 	 * it will be useful to have multiple sub-channels to support
 	 * a scalable communication infrastructure with the host.
-	 * The support for sub-channels is implemented as an extention
+	 * The support for sub-channels is implemented as an extension
 	 * to the current infrastructure.
 	 * The initial offer is considered the primary channel and this
 	 * offer message will indicate if the host supports sub-channels.
-	 * The guest is free to ask for sub-channels to be offerred and can
+	 * The guest is free to ask for sub-channels to be offered and can
 	 * open these sub-channels as a normal "primary" channel. However,
 	 * all sub-channels will have the same type and instance guids as the
 	 * primary channel. Requests sent on a given channel will result in a
@@ -951,7 +951,7 @@ struct vmbus_channel {
 	 * Clearly, these optimizations improve throughput at the expense of
 	 * latency. Furthermore, since the channel is shared for both
 	 * control and data messages, control messages currently suffer
-	 * unnecessary latency adversley impacting performance and boot
+	 * unnecessary latency adversely impacting performance and boot
 	 * time. To fix this issue, permit tagging the channel as being
 	 * in "low latency" mode. In this mode, we will bypass the monitor
 	 * mechanism.
--
2.31.0

