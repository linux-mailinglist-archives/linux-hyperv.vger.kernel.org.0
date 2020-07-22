Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E04229EFE
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jul 2020 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgGVSKz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jul 2020 14:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVSKy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jul 2020 14:10:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618DC0619DC;
        Wed, 22 Jul 2020 11:10:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so1816427pjc.4;
        Wed, 22 Jul 2020 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:reply-to
         :content-transfer-encoding;
        bh=4bTtBQ7yXHkaoasiaxmFnO7oa9s0p9Y0Xwq4E/P0kGQ=;
        b=R6mvOm8HOCRvymu5Gb+BUEPcZ4A0OUGmjvFmEE6RLUBks77EVtmhw4h0WgaICqgbg4
         uZ40fdZXlhyGzDqlc+Z6kvfE8YSEQlX5jH9cJG58TUX9xUoGXtwqPnRx9skk0Vo3CmkW
         MdtWjXYUDRp6YggMY3iL96mEwcEaUrbMrTFK7SJnKy3IiVksPzj7XR1tmpcbSvjXEPaR
         nvcnGYc8jAwXx8pMHm9k3Ktyo2+fCw2o+QD6SqOnwSBf9GSLhomQ1kn3iF+JpZ1Kmu5b
         P8aNrL4jraDJUq+IP/9RY4hA+Bv7iJ8mi6XUe0goceM5BHwMp1ts54xpLtG4v4cr5lbU
         fc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :reply-to:content-transfer-encoding;
        bh=4bTtBQ7yXHkaoasiaxmFnO7oa9s0p9Y0Xwq4E/P0kGQ=;
        b=QOGuPaXIRLssfy0hPh9sP1oZx+u+tEhO5BYcqF9MGh4GZsbKoEDSmPoZ2wsdDs+g0h
         /Iwz4b/pM5RyxsPnOPpLfG6Ylx+9nvOzWJe60W7hMk+IHmZqYuLiQFXs5cdRewrcu/NI
         dFvb5L+h7wDTNp7cg7JnRiQ7OeVvLrBbBjZgPqhtuBpDAfTdx3hGbGsPihfDE+v4Rm+3
         I+XgOOMCkExVyRLLPtnJCIHEOVvMPeXI6mPNcmx6MaqPQWPwzh2VtEd3oe+Czu4h7f/c
         S8ceNumbGDAOF7WVSB5OAS/2FBPv90DGYPgBn1liXuYVUwelrSkmcd3aKEJlSjhm26A/
         /d9A==
X-Gm-Message-State: AOAM530LmskQpT/YsN6VZqfS4WS/n9TMM0T07enxQc+jpC4KY8R/rQWm
        aUTfFXJ0JMOZ/QqGFgYRoCw=
X-Google-Smtp-Source: ABdhPJwWWoueMaO6nSvWZLn3qIbzSQ91In01yJwAJO4gJnb4SrvlziEU9pQSFASmMzDvGwELqwZMng==
X-Received: by 2002:a17:902:7807:: with SMTP id p7mr608618pll.242.1595441454186;
        Wed, 22 Jul 2020 11:10:54 -0700 (PDT)
Received: from localhost.localdomain ([131.107.159.194])
        by smtp.gmail.com with ESMTPSA id y80sm259958pfb.165.2020.07.22.11.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:10:53 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        Andres Beltran <lkmlabelt@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v5 0/3] Drivers: hv: vmbus: vmbus_requestor data structure for VMBus hardening
Date:   Wed, 22 Jul 2020 14:10:48 -0400
Message-Id: <20200722181051.2688-1-lkmlabelt@gmail.com>
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

 drivers/hv/channel.c              | 175 ++++++++++++++++++++++++++++++
 drivers/net/hyperv/hyperv_net.h   |  13 +++
 drivers/net/hyperv/netvsc.c       |  79 +++++++++++---
 drivers/net/hyperv/rndis_filter.c |   1 +
 drivers/scsi/storvsc_drv.c        |  85 +++++++++++++--
 include/linux/hyperv.h            |  22 ++++
 6 files changed, 350 insertions(+), 25 deletions(-)

-- 
2.25.1

