Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF3F499DD
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 09:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfFRHF7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 03:05:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36677 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFRHF7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 03:05:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so7101409pfl.3;
        Tue, 18 Jun 2019 00:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KY0hOmAa86HuZE0h9c7QHLSN/sFybZcvdeeWuBmi/OU=;
        b=Ue8LR2Qk7y+EWsK1kXFMPLzPeXzkdfH0ztEPZVb5Jfusm1NYSEeT8qzhlDfQo/Mo7m
         l9409MLPWW+t0N0zo++a14pi+SGGltJ0SS42uhY4SXXGgGi8HAOE+LIGSyFLRA3NfbtE
         zisJAa/0g+CPDB7AKAO2nYYFmLPH0ypBESfc0UCOavmrIrB0PoXhmASaaXN1DbY2quVq
         lIdZ3KIjdRBUdJMe5gTa05BWd2YrDH+OAptQsADdxajQOZBK8XWvB/Rz4HWFSdGFYwBy
         gvcj70OXo+RRh5f5nWUyIdktSspfSuZQBQ3QsJqNz1KMuGqDklr9UxiZHVATVylJMcyH
         4Gpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KY0hOmAa86HuZE0h9c7QHLSN/sFybZcvdeeWuBmi/OU=;
        b=iTPL4beohlgK0QWR+SH1a9kEirgWvihaXVFnjMi76HFnxjASzOzBJRVIUvJU2WGVzV
         WzfI3VOgjHyV9An/oKIo6DLaDYp7z3R/tzDq0XsFSBbfooj2AHYv0vrweMJp3gKiuuid
         oahgx2lVr76P3UTgsxW8b0sNqb88Rua2Hy3UvYxk1NZ4CmHyzDDUKZ0//ktFSkW4985v
         MCpY/3dSSQayj6HCq3as9jYVnl4yRepxF8ktvWlJ/WD+adHnvBwbv2m3ifZ3mMouyB6h
         V0Cqgxy7w6UHjP8G8HQfj9Tn7FY7rCT3TAPSLZHiEGFbkxLj+OIlKi400UvJD7SJ5OpJ
         Um+g==
X-Gm-Message-State: APjAAAVvjP6uulz8yfrrg/2KJ0w4wH2eN21mH5Ae3ozVSKfo9hrEQPng
        8WrNN2kjfqo90q6+qb2UTpVgJ1JsWJA=
X-Google-Smtp-Source: APXvYqxTytyfk9wnV8foDumcE1FOZD+ACJGrgFdfF44453aFg6xoz3efdMevejBUgM67y8CrZf3Wng==
X-Received: by 2002:a17:90a:9b08:: with SMTP id f8mr3264521pjp.103.1560838638921;
        Mon, 17 Jun 2019 23:17:18 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id y185sm14143581pfy.110.2019.06.17.23.17.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 23:17:18 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:17:18 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] Input: hv: Remove dependencies on PAGE_SIZE for ring
 buffer
Message-ID: <78f6e9646f762c51febba6c5a52eb777c238d4aa.1560837096.git.m.maya.nakamura@gmail.com>
References: <cover.1560837096.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560837096.git.m.maya.nakamura@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Define the ring buffer size as a constant expression because it should
not depend on the guest page size.

Signed-off-by: Maya Nakamura <m.maya.nakamura@gmail.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/input/serio/hyperv-keyboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 8e457e50f837..88ae7c2ac3c8 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -75,8 +75,8 @@ struct synth_kbd_keystroke {
 
 #define HK_MAXIMUM_MESSAGE_SIZE 256
 
-#define KBD_VSC_SEND_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
-#define KBD_VSC_RECV_RING_BUFFER_SIZE		(10 * PAGE_SIZE)
+#define KBD_VSC_SEND_RING_BUFFER_SIZE		(40 * 1024)
+#define KBD_VSC_RECV_RING_BUFFER_SIZE		(40 * 1024)
 
 #define XTKBD_EMUL0     0xe0
 #define XTKBD_EMUL1     0xe1
-- 
2.17.1

