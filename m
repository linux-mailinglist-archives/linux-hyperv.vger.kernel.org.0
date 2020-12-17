Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EEB2DDA20
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 21:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgLQUe2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 15:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgLQUe1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 15:34:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7002AC061794;
        Thu, 17 Dec 2020 12:33:47 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t30so9880322wrb.0;
        Thu, 17 Dec 2020 12:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upsPvCXgarWjSOTfL+u8RB8Ef6zumQjh/qznjX5cBM4=;
        b=pKuyGqr+W7PpYe7m+mR44aNDDrW2nAGWMmNZAU2MIfhHdUUwh8hrZ2Dls0uL+D7ePE
         oZ/jxj7Hci2gQ5P/W+c526HEr5vCIxtaNkcZrB6AE5ixISwpWMpc+auXLo2Se9ir8KBV
         /Gos29/dkUwaS7nr6+98H7XSuDtMbK3ePp1ynzF5rFlDWjFoebt5qONSM7HTGbf1u6Lz
         oNxRAOgJ1BwvhJxuelgM8zxkUkZXQcgfBTVfc0nYnlH4Y+PTsXjA0itF2hk76HJt/Iw0
         AcRRycbVBTTMu+q9KkngHvXO07bZn/hTHslKeNmnjg8mRaStLPzgqHoaZcJO9tJR11u+
         RrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=upsPvCXgarWjSOTfL+u8RB8Ef6zumQjh/qznjX5cBM4=;
        b=qoosb+ep6lYh4F8cv+LF/T9Q/ZDkHxfQ1rW7dvJTEhtibC5HrXN5ITJNVmdkhRD1zW
         7BCXGas9mRoCP+vYDpa3kfxYt+bs49Kdl8Tccmz2ECKvMjEgsPFowbIIpXJAG+qOIVod
         oOFFIJ/xaIEhwuXg9Ca4LNmem8TiUxQVZrJwcmEpu23EEzBIpDX1ot+G3qTTCOEujNgZ
         uaCH/GWIxuFgP+eJiYuPaiSLemeU2RNSi9CUAAIdHNXlKcqpAYOMYUA7wnJN/MFAZGLp
         7n4wnxgCy6H5lUc2XQBV7c7f9vO9JPzb/e2vgPrex9abykfDy0pqXs6nIGMUzZX9ghr+
         6q9w==
X-Gm-Message-State: AOAM532Bwr1wKyYjn1TYht1oNuthuy3q1qZNemy6M7k1CyEEZ2fcSC/y
        eiNO2X8sWfLrJSD4b39ttpE5iStYxQ8MCA==
X-Google-Smtp-Source: ABdhPJwJI3Zpl+xfmWyETTz4aOWk+w6jh0G5RzV4Fwr/bHHW9dODJjhlKpIBaVWluY4WrvzUFo3szg==
X-Received: by 2002:adf:a441:: with SMTP id e1mr566101wra.385.1608237225841;
        Thu, 17 Dec 2020 12:33:45 -0800 (PST)
Received: from localhost.localdomain (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id a62sm11729128wmh.40.2020.12.17.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:33:45 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 0/3] scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback() -- Take 2
Date:   Thu, 17 Dec 2020 21:33:18 +0100
Message-Id: <20201217203321.4539-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi all,

This series is to address the problems mentioned in:

  4da3a54f5a0258 ("Revert "scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()"")

(cf., in particular, patch 2/3) and to re-introduce the validation in
question (patch 3/3); patch 1/3 emerged from internal review of these
two patches and is a related fix.

Thanks,
  Andrea


Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org

Andrea Parri (Microsoft) (3):
  scsi: storvsc: Fix max_outstanding_req_per_channel for Win8 and newer
  scsi: storvsc: Resolve data race in storvsc_probe()
  scsi: storvsc: Validate length of incoming packet in
    storvsc_on_channel_callback()

 drivers/scsi/storvsc_drv.c | 58 +++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 22 deletions(-)

-- 
2.25.1

