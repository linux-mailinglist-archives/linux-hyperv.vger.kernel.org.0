Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A54422A279
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Jul 2020 00:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgGVWjH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 18:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVWjH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 18:39:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD6DC0619DC;
        Wed, 22 Jul 2020 15:39:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a14so2032669pfi.2;
        Wed, 22 Jul 2020 15:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IC3o6yjGzCG7gAqk+Nb7m2wM2CI6KG8OLBTCBd6z02g=;
        b=W6qz92svLM56Rquk9l7A85Cd6t4smWOm7DFY6BgNwhj/eo59el4Lv233G2Y190U1Al
         6EMiWCfRLVmTmUISq5YP3mpNLi5cTvZsb/V6ByUWl+5xlJ2GJwZKoU25UOXAZ47Xm0jo
         j3NBTeDhBU5bqMdslxKZaCPvWzEB1LG2VHQM2Z0pvKSAu9lMABDkSwf3C0PAOiBRMKA0
         2AvjIuMYOqp0rLyU044Rie3wo6hW7L0mDwDnF1GExo9wNKZnkawCdsGgTsWmicVrnlot
         3B2dVNMmQGsSe7Avh0+DTE+LeXOA6WTxtqf3uyo0Cjsv9++hzIwCAZWeSmJAhef6XiVJ
         Gybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IC3o6yjGzCG7gAqk+Nb7m2wM2CI6KG8OLBTCBd6z02g=;
        b=V0upWA6BkP6eCeJ+mDGFVnYS4JoaM4dyvUAg03+OIG4GhbvVkVi0ONMd740bbePmgF
         eY69oCkv/G0vSdPWFvAka0SNDMiMVKqKzLfaybLxnHV1Ic8zNTd537prVnZLViqARi0V
         MuYb7fIqdGILFNCfJJBL56PMrtKP+RAZ7pZ3cUON3YuM0rZT0f0EUIXhArO7zZgaR0IY
         LJ8cHQm9HMgCNwxrcVFpqo8ylfQJ95X253Jg2Qpl31iAleG3oK26ehZvSExsMin1a5Lo
         JZixmdz9aqKyoULVJY+dcIh2SXZsKb++W7T25icNTiPleY0L5hEr4qWbfeWFb1pAE10e
         ZunA==
X-Gm-Message-State: AOAM532b1AKo4iIh6i8eXU/hTGgOD3D0b99M7sZzuq+9jthEkMcBhyfg
        axsOctl3hoGnu13hZN2tET0=
X-Google-Smtp-Source: ABdhPJyFbfDEkHoRCJg7rpCqD3eI9STIvelQYI2Tivn2b2V4uGbgdFWYbBXSE0jfztLd6/mWSLwN2w==
X-Received: by 2002:aa7:9ac3:: with SMTP id x3mr1510121pfp.261.1595457546498;
        Wed, 22 Jul 2020 15:39:06 -0700 (PDT)
Received: from localhost.localdomain ([131.107.159.194])
        by smtp.gmail.com with ESMTPSA id r70sm625760pfc.109.2020.07.22.15.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:39:06 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        Andres Beltran <lkmlabelt@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v6 0/3] Drivers: hv: vmbus: vmbus_requestor data structure for VMBus hardening
Date:   Wed, 22 Jul 2020 18:39:01 -0400
Message-Id: <20200722223904.2801-1-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

 drivers/hv/channel.c              | 170 ++++++++++++++++++++++++++++++
 drivers/net/hyperv/hyperv_net.h   |  13 +++
 drivers/net/hyperv/netvsc.c       |  79 +++++++++++---
 drivers/net/hyperv/rndis_filter.c |   1 +
 drivers/scsi/storvsc_drv.c        |  85 +++++++++++++--
 include/linux/hyperv.h            |  22 ++++
 6 files changed, 345 insertions(+), 25 deletions(-)

-- 
2.25.1

