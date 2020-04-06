Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9919F3B1
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 12:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDFKmC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 06:42:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47594 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726926AbgDFKmB (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 06:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FqGYEjIImdWTgee2fIf/zfTRdiurl1mO572U3AitAp0=;
        b=QH8n09btlsvNIiBo8OYun0AOV70jz1uFFTPafaZzw8sYLdHTe+W+OJdu1Mga0JDnqnWhuG
        lTOBku2gb29MU/EjbDUIWjKMIvYXaJf8qDJgwGVtMuWYngZDnZ7mBPCjAykE8VWFnxIgfx
        uVfzQrhOmyW4jLwCppwqhbg3Ftw0C2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-k2X3gRLGMJOSGA8yVoaxOA-1; Mon, 06 Apr 2020 06:41:58 -0400
X-MC-Unique: k2X3gRLGMJOSGA8yVoaxOA-1
Received: by mail-wm1-f72.google.com with SMTP id d134so1152280wmd.0
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Apr 2020 03:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FqGYEjIImdWTgee2fIf/zfTRdiurl1mO572U3AitAp0=;
        b=AOvMOu+UIQsdC0HLp2I4znzAhKNyIv34ZqcJljc03u3PheyxymWqMXNRTarH77QGnh
         qUrXone//YgeaEbihe8KzmQVqhUi7P6WGpdeoEBPmdqlqSq1RIZP59f5xpP50aSI59i8
         AU4ioAXPR5ToGECb4rRxWO4XlSxKHh0OmEg1iS6AVpktqbGzcCE2KIpV25R1UmQwK91x
         ZNng4+ebzbBOhN0/9dSW0hYmvl4GcUjTN5RSEvEUAsiDFoWw79oZlCFEm2SKSRI+1ukC
         o2z3aockyOtqTi+5p5BuLjZbee54iumShsHTEK+OMz+0WaeXFLLneAmqC3dw0SSvq2TP
         JHlg==
X-Gm-Message-State: AGi0Pubk8+foVbFIZfYTi9jbvG4AXVbPjaaI8sH8ZivtvKLvtRjXqDex
        0Kd3cr6CGhOXkRi+sl5kMnkqQ7M+VXZit3BEc8Ykd3XPXLPHgiil802BKpWosA9b6TmrdlGhw0P
        1nNh/Stj+UkD+VXdSrbUHIqyr
X-Received: by 2002:a05:600c:2910:: with SMTP id i16mr21518941wmd.43.1586169717440;
        Mon, 06 Apr 2020 03:41:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypJPzINmfQ385QW26xQbfnWPsO2PkLIbN8craOWxA1Q9iUGl6xZlmMVJwWqmHJOQT0x2ogPi1A==
X-Received: by 2002:a05:600c:2910:: with SMTP id i16mr21518922wmd.43.1586169717258;
        Mon, 06 Apr 2020 03:41:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a2sm17305337wra.71.2020.04.06.03.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:41:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 0/5] Drivers: hv: cleanup VMBus messages handling
Date:   Mon,  6 Apr 2020 12:41:49 +0200
Message-Id: <20200406104154.45010-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A small cleanup series mostly aimed at sanitizing memory we pass to
message handlers: not passing garbage/lefrtovers from other messages
and making sure we fail early when hypervisor misbehaves.

No (real) functional change intended.

Changes since v1:
- Check that the payload size specified by the host is <= 240 bytes
- Add Michael's R-b tags.

Vitaly Kuznetsov (5):
  Drivers: hv: copy from message page only what's needed
  Drivers: hv: allocate the exact needed memory for messages
  Drivers: hv: avoid passing opaque pointer to vmbus_onmessage()
  Drivers: hv: make sure that 'struct vmbus_channel_message_header'
    compiles correctly
  Drivers: hv: check VMBus messages lengths

 drivers/hv/channel_mgmt.c | 61 ++++++++++++++++++++-------------------
 drivers/hv/hyperv_vmbus.h |  1 +
 drivers/hv/vmbus_drv.c    | 40 ++++++++++++++++++++-----
 include/linux/hyperv.h    |  2 +-
 4 files changed, 66 insertions(+), 38 deletions(-)

-- 
2.25.1

