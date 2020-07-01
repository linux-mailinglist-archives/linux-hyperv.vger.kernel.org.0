Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310E2100EE
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2020 02:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgGAAMe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 30 Jun 2020 20:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgGAAMe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 30 Jun 2020 20:12:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4789C061755;
        Tue, 30 Jun 2020 17:12:33 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c1so2973399pja.5;
        Tue, 30 Jun 2020 17:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:reply-to
         :content-transfer-encoding;
        bh=IRZheiJuzy+5wxD4JtSWywrlJPopBnm+xAxcV5ALEK8=;
        b=c+8UcBTI83BIWdNQFHbFJgJg3GaO30Ru6Uwo1sYQGcYSiXRaohfbSqsuTDDOjuY4IQ
         PmnSo0IUkXkCKUZM5FMvhnujNb4avUnOef6OB9GmfaiuQuDqdjikVp/IsNzP+wQJB7oN
         oWgAx0SAIcW38Yy9lCCKFz8f9Zhm3BX86n7YHUrrfJrVumzQAJYoknTEhUR8EloyyyDw
         ymRJIYveJjmZ8+MkiAKY/AW7rclQpaCN3JvneNhWCxliL/ZIE1v+RgVV1BqxXY1Vocyw
         i36cnCBhGXHNBcqFGoV1zNZ3G/n9SN0u0lYSx+VBPplvUT2td5iYuqTn/dGIH9WHOozB
         jt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :reply-to:content-transfer-encoding;
        bh=IRZheiJuzy+5wxD4JtSWywrlJPopBnm+xAxcV5ALEK8=;
        b=BxCLn/9T95klxU6z9SGJ9z4QJxE9bmJsF3bcCcWSXJgk3Kac30RqRDhupuCUGKR+hA
         9uiim70QlXofwDx7nNMPSGutB82/NkN4gKThgSX3OpNHw39B2v98azW9PRxEQct2YnA9
         Yz4ZosvkKpuMz5/wAy6Yshk36kZ2PsNJ0M16hjmvFFdqVUHqDWbjQkhMlrojRmC0tDu3
         SiXeszYJVHa4UX9LEiWkm2/n81pbXwKGIyJRffrXP+L3LItmOay3rbr6dLLc96JHe3KM
         2t1dmqBswsrBGTBVxfx59aIa8mnwGp6Y1VxjWlGh/W8EG4YZIO12hzBFEyzGbZml5mu9
         OuzA==
X-Gm-Message-State: AOAM533jBAz+g18uZPqcgApRb4gmk2MypVslvqKFvL8JtIqN9cjDjhaz
        Z/YKd3v+nXYb03PAfQd5NWA=
X-Google-Smtp-Source: ABdhPJwU3JL6ELhhNYwToC3cqIlZoSg6qdtFifb8hXB6dtpYRLwETKEJNxNQaL0AW7PdNh0zxuZ5sQ==
X-Received: by 2002:a17:902:7788:: with SMTP id o8mr20927849pll.166.1593562353382;
        Tue, 30 Jun 2020 17:12:33 -0700 (PDT)
Received: from localhost.localdomain ([131.107.147.194])
        by smtp.gmail.com with ESMTPSA id t2sm3268588pja.1.2020.06.30.17.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 17:12:33 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        Andres Beltran <lkmlabelt@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v4 0/3] Drivers: hv: vmbus: vmbus_requestor data structure for VMBus hardening
Date:   Tue, 30 Jun 2020 20:12:18 -0400
Message-Id: <20200701001221.2540-1-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Reply-To: t-mabelt@microsoft.com
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, VMbus drivers use pointers into guest memory as request IDs
for interactions with Hyper-V. To be more robust in the face of errors
or malicious behavior from a compromised Hyper-V, avoid exposing
guest memory addresses to Hyper-V. Also avoid Hyper-V giving back a
bad request ID that is then treated as the address of a guest data
structure with no validation. Instead, encapsulate these memory
addresses and provide small integers as request IDs.

The first patch creates the definitions for the data structure, provides
helper methods to generate new IDs and retrieve data, and
allocates/frees the memory needed for vmbus_requestor.

The second and third patches make use of vmbus_requestor to send request
IDs to Hyper-V in storvsc and netvsc respectively.

Thanks.
Andres Beltran

Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: David S. Miller <davem@davemloft.net>

Andres Beltran (3):
  Drivers: hv: vmbus: Add vmbus_requestor data structure for VMBus
    hardening
  scsi: storvsc: Use vmbus_requestor to generate transaction IDs for
    VMBus hardening
  hv_netvsc: Use vmbus_requestor to generate transaction IDs for VMBus
    hardening

 drivers/hv/channel.c              | 158 ++++++++++++++++++++++++++++++
 drivers/net/hyperv/hyperv_net.h   |  13 +++
 drivers/net/hyperv/netvsc.c       |  79 ++++++++++++---
 drivers/net/hyperv/rndis_filter.c |   1 +
 drivers/scsi/storvsc_drv.c        |  85 +++++++++++++---
 include/linux/hyperv.h            |  22 +++++
 6 files changed, 333 insertions(+), 25 deletions(-)

-- 
2.25.1

