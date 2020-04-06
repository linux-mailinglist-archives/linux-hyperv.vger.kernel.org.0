Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA20E19EED5
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgDFAQz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Apr 2020 20:16:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgDFAQw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Apr 2020 20:16:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so15254050wru.13;
        Sun, 05 Apr 2020 17:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y8yb+UNSTHMOMu0ZtwVJ7+JWaA/eqRrXDNRUIaGXBaw=;
        b=uiRhbigM0ULnPLt1VDeAy8g5bdEexxjUpxFSSvQr0VjVvXRb0omGwuR85x7wDv1aPv
         uAftY9UYX6IXF9O9PXWfc1hTtiwXwoVrH1Lp004xCBAeNKRJOwL0n64p8ZDITkEyhTwp
         4PWNX0KSqchuJrBT5wPg1sugt780a8bQvl5/Tfe221DJNvqAmRiNL4LjyPM+tet3+Yrn
         mUXfAQha+JtGkVtH0I6B1OKO2cmYs9YCo/wKbF63tp/wAuwdFhGVESsMGVO6dwWgAS9L
         /c1fPqZc92AxLauvk9PEgSYYp6p8RJhUgrIghNt9ccCl5IYzrjNfmOjDRGLyoSXU1MRT
         YMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y8yb+UNSTHMOMu0ZtwVJ7+JWaA/eqRrXDNRUIaGXBaw=;
        b=r2fMzTIDKS92H0mj3ol+uXjYPka4ojxAmLhi2xFB50l96UAxzFS7h5TxKw8cIe5oe4
         VinGqr8Tgq4rASeZlI2vZP4iXo8p8KT/mLIXdR+bFP9APxkYcBbv5zcmYQaaHPN0Hsmi
         blfv8TNAQMp/I3o+QGJ/1FVxhFf/W5Oq5UBPh2heX1qy4SwgUsgbVFvvWQfmg8y5kxL0
         Nhd0fodIMad4fgWRKA3wa6UYzvjSqcxrwIUoPFRu5+1jUa+a93MdEt8upcqLPYgO0yde
         PHg+iDdXljj4jNHlGAJuqIxAhjwfdgL98dJu7KrhXcR367uYKu8Z+hfjRjV0V78syWMW
         KezQ==
X-Gm-Message-State: AGi0PuaBJ5qlZI4qj5NkPnn+lLgAFcnxa47z/2TKMFpOM2/bc2SdiZWy
        /buCRxj8O4EVAge51q6OCxhiRIGH47SvSw==
X-Google-Smtp-Source: APiQypLHaw94/UqXPevrU2LSEdlJt42aTUDi1m/2cxDEKF14f7TuFhLFnBfYZ8Y3ANHDjEInoi8DeA==
X-Received: by 2002:a5d:60cc:: with SMTP id x12mr22756902wrt.149.1586132208942;
        Sun, 05 Apr 2020 17:16:48 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id j9sm817432wrn.59.2020.04.05.17.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:16:48 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH 05/11] hv_utils: Always execute the fcopy and vss callbacks in a tasklet
Date:   Mon,  6 Apr 2020 02:15:08 +0200
Message-Id: <20200406001514.19876-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200406001514.19876-1-parri.andrea@gmail.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The fcopy and vss callback functions could be running in a tasklet
at the same time they are called in hv_poll_channel().  Current code
serializes the invocations of these functions, and their accesses to
the channel ring buffer, by sending an IPI to the CPU that is allowed
to access the ring buffer, cf. hv_poll_channel().  This IPI mechanism
becomes infeasible if we allow changing the CPU that a channel will
interrupt.  Instead modify the callback wrappers to always execute
the fcopy and vss callbacks in a tasklet, thus mirroring the solution
for the kvp callback functions adopted since commit a3ade8cc474d8
("HV: properly delay KVP packets when negotiation is in progress").
This will ensure that the callback function can't run on two CPUs at
the same time.

Suggested-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
---
 drivers/hv/hv_fcopy.c     | 2 +-
 drivers/hv/hv_snapshot.c  | 2 +-
 drivers/hv/hyperv_vmbus.h | 7 +------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index bb9ba3f7c7949..5040d7e0cd9e9 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -71,7 +71,7 @@ static void fcopy_poll_wrapper(void *channel)
 {
 	/* Transaction is finished, reset the state here to avoid races. */
 	fcopy_transaction.state = HVUTIL_READY;
-	hv_fcopy_onchannelcallback(channel);
+	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
 }
 
 static void fcopy_timeout_func(struct work_struct *dummy)
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 1c75b38f0d6da..783779e4cc1a5 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -80,7 +80,7 @@ static void vss_poll_wrapper(void *channel)
 {
 	/* Transaction is finished, reset the state here to avoid races. */
 	vss_transaction.state = HVUTIL_READY;
-	hv_vss_onchannelcallback(channel);
+	tasklet_schedule(&((struct vmbus_channel *)channel)->callback_event);
 }
 
 /*
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 41b7267da529a..8df138f98e9e5 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -377,12 +377,7 @@ static inline void hv_poll_channel(struct vmbus_channel *channel,
 {
 	if (!channel)
 		return;
-
-	if (in_interrupt() && (channel->target_cpu == smp_processor_id())) {
-		cb(channel);
-		return;
-	}
-	smp_call_function_single(channel->target_cpu, cb, channel, true);
+	cb(channel);
 }
 
 enum hvutil_device_state {
-- 
2.24.0

