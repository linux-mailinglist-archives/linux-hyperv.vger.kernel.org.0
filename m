Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334B91933F5
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 23:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCYW4d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 18:56:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34565 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYW4d (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 18:56:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id 65so5643158wrl.1;
        Wed, 25 Mar 2020 15:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=STF+myRLvSklth1zGxjEGvZIDu7LBm45ZrQEkt2K5mo=;
        b=qDNV2Go+Rh81SktAZfMei8oG+Ak88qULfReq0euWC7FcvFwjVEm1D1VgP1x96xOAg2
         CJ+fOsnNqDJqHWJbBVpwtlz96Fg/Hj4g0AsgkdutDESlWU6xUme3Yls1a2DQkAKotZ3E
         TxzuT77rXfVgvOAt8VYlxWl9bCyDKo03/xKzvN9MxfejxlqADldkC9RzIJ6t7sd+r0oT
         AMb+z2VooZ0jxFuyskw43aZvD9t6212kT96FwbF0noge+QyDormnJPBen5TWTtDhs8Q/
         dpupFOVXARhn73XfqV7yS3q3aIKDH/qD1fj5HwswTHZnarWiL+1ltjRyNge104WBYJ1j
         9FWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=STF+myRLvSklth1zGxjEGvZIDu7LBm45ZrQEkt2K5mo=;
        b=ZQBwXAqNzDZAUjyIAuHRyuCKeSMZvBxJZneuPzHdyGhFUw7Mua72235C7H+5Ok78aR
         oUabXatxvFcq7p640oSMhxBjoAJjr6jyX8xiQQT82UNxDXjcCliHb0hBSD/P5ZkBCjkc
         OC3KtyhcFt3aO9i6wDz1V8u4WvbSNmg8i7q+dH85Hn+wfA9wpgHQjIe5QYwSf2JwmR3Y
         WDU4TdtnaLapsEP0E9589Xt8OX36RzFR648A/t51NL0/MUDiJjeabonN9fc8sje55Mb3
         w15apafd3lO7dFYrR+3cs6MWjMKz7e7GoOgv4rfVrGh9nq17Tk4kKRL/g+vwmuSAsnNc
         Jv1g==
X-Gm-Message-State: ANhLgQ0QaaOFkmnjvf2fdm7YJlAfnI246XxlyM88n91Y64/JTaJoaIGi
        0ETRS/cEECITt0QmOwhQYkAhfYioZaUWMVwm
X-Google-Smtp-Source: ADFU+vvVOPi3PA+74IhM+oTcYjcGWYajfhcjZIu0iMPv/+PUFCAYV4G8aSwNSqs/zMql4+YbT7W5sA==
X-Received: by 2002:adf:8b5c:: with SMTP id v28mr5479675wra.98.1585176990917;
        Wed, 25 Mar 2020 15:56:30 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id q72sm790278wme.31.2020.03.25.15.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:56:30 -0700 (PDT)
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
Subject: [RFC PATCH 05/11] hv_utils: Always execute the fcopy and vss callbacks in a tasklet
Date:   Wed, 25 Mar 2020 23:54:59 +0100
Message-Id: <20200325225505.23998-6-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200325225505.23998-1-parri.andrea@gmail.com>
References: <20200325225505.23998-1-parri.andrea@gmail.com>
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
index 2216cd5e8e8bf..ff187cf5896b9 100644
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

