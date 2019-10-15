Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5C52D7572
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJOLrK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 07:47:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfJOLrJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 07:47:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so23447287wrq.10;
        Tue, 15 Oct 2019 04:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rFh15VrB4DEKcYfjt476nNyBnV2R8iO+x5S3m+Zx9s=;
        b=M44lzqYZ55PCUtw3DvsrdQZn/ARc2y7bf3Hs+7Tj2fei/jNSDBfdWh8cfXKTOAKsvY
         SHBv/u9sMAP43yNXWl6wBlr/leLB/Xuqni4a+YYvCQtR7yQN5R68epVhwzU+XsKyjeWL
         kGDErTlZZhuc9so36ovhMRIf6P1VE8xM7UIbrLULMmsYRLAoPO8t0zY/3eccNgWeyb3y
         qFSQfD69DPfuX3E/abCstS+DW5K6Ct+roBaizDHaBuUxincE2mpMvsMyieSsxvEcI04C
         JT+MHdwFI9OczZFDIFcpUYLaXxcO1NsgDFB+ZGEWFQew9k+NZAqaofjWtQy3iox9unY9
         xLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rFh15VrB4DEKcYfjt476nNyBnV2R8iO+x5S3m+Zx9s=;
        b=p4uWHH7GymW+MzlBjqvFd7sGmfvQpo6/Hc8Dr0ytNW43uMVouz4TVkvRNcdBRK0VxC
         AlT5RUwUWWAkcVN7/qLxL1zowA4/hNbWlFs/9uECpxEbQNM1j2Fo5MDKGGWj349T0ykM
         mTEtc15tEQzu6IZ4A+IoPlW9whSN6ru83zEuDJpTVZtwVoONxsEqRhdu56oWEamlOeBZ
         ZX3wjVauxwmMRY5trKc+ViOK/Ht/BnMRDJESnJiINgG47JdgiFffyp5S/rPmJIM+FaRb
         3Jh12pSeBYOZHoxxMNDZ92CYycOZEeC/2n3/ryX5SLALXEaScu1J1IQaO/IiPeRPwxzl
         Pegw==
X-Gm-Message-State: APjAAAX83mIMumSqlw4KJYEE3KkYXblQdrfuI1iWgY94zPMK86Sj2mmJ
        TH+00ccSwbPqwiLgZtwaxQJDEAjJUaI3qw==
X-Google-Smtp-Source: APXvYqzfLHeVyovVfvjsOtMX1WbIcgz8S/+Bh0XBIL8YKw8jbzwdIlKeIIEmB8ocHE7M5CxvuheMJw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr26160793wrv.8.1571140026937;
        Tue, 15 Oct 2019 04:47:06 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1010:8d42:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id u11sm20237307wmd.32.2019.10.15.04.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:47:05 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 0/3] Drivers: hv: vmbus: Miscellaneous improvements
Date:   Tue, 15 Oct 2019 13:46:43 +0200
Message-Id: <20191015114646.15354-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

The patchset:

  - refactors the VMBus negotiation code by introducing the table of
    VMBus protocol versions (patch 1/3),

  - enables VMBus protocol version 4.1, 5.1 and 5.2 (patch 2/3),

  - introduces a module parameter to cap the VMBus protocol versions
    which a guest can negotiate with the hypervisor (patch 3/3).

Thanks,
  Andrea

---
Changes since v2 ([1]):
  - refactor the loop exit path in vmbus_connect() (Michael Kelley)
  - do not rename VERSION_WIN10 (Michael Kelley)

Changes since v1 ([2]):
  - remove the VERSION_INVAL macro (Vitaly Kuznetsov and Dexuan Cui)
  - make the table of VMBus protocol versions static (Dexuan Cui)
  - enable VMBus protocol version 4.1 (Michael Kelley)
  - introduce module parameter to cap the VMBus version (Dexuan Cui)

[1] https://lkml.kernel.org/r/20191010154600.23875-1-parri.andrea@gmail.com
[2] https://lkml.kernel.org/r/20191007163115.26197-1-parri.andrea@gmail.com

Andrea Parri (3):
  Drivers: hv: vmbus: Introduce table of VMBus protocol versions
  Drivers: hv: vmbus: Enable VMBus protocol versions 4.1, 5.1 and 5.2
  Drivers: hv: vmbus: Add module parameter to cap the VMBus version

 drivers/hv/connection.c | 72 +++++++++++++++++++++--------------------
 drivers/hv/vmbus_drv.c  |  3 +-
 include/linux/hyperv.h  | 12 ++++---
 3 files changed, 45 insertions(+), 42 deletions(-)

-- 
2.23.0

