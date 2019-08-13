Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0FFD8AF22
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2019 08:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHMGEf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Aug 2019 02:04:35 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36791 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfHMGEe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Aug 2019 02:04:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id j17so21901640lfp.3;
        Mon, 12 Aug 2019 23:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrEVxpcyV4DCMvRSKxFdoalgE5BxnEvtduw2O/ncmic=;
        b=CH03GcsRDfIFs7I2m4ENoc6GLIoCVBM2g0Xk+IPc8RN0i32k1xTcbqfbCh07zoJD3g
         HUZppBws/OsZbqUyAtPxcfI0Nv0igGGzIad4id8RzYH88Eqc11MNA4J1S7XXoGWwNHC0
         q4Kl5tOEr9vkXWT/Myai4XuwDX+xjl54mbE9mBiV0EhCo1WsWHabN0jMOGbrjYPdMz8I
         xXZ60uNoXG4R2qg4ai7etwr0LCApNiVFgMi5VEhsQPll/+Mbi4NIS1NXsaWomKRFt8W4
         KdhM4a9+1gFwSGS+70ezanX7qABnofRVrQJZjqrMo1X+e25YPHXeJGpYINfE0KGSxl/2
         aZtA==
X-Gm-Message-State: APjAAAVyUClfCa77wZkt/UFcosqeAtwgegQiTyanqaWNWFIt3yCsCP4C
        /+7ez8R0N3z+TN6s96kU/3C6wCZoOZc=
X-Google-Smtp-Source: APXvYqzOX0mWizuXqkZv2Us/VAQ5DA4Vdhvcexj1vcgAkJjLiVHUm11+eQXxaf59C/MGSUHfrVNWBA==
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr22298150lfp.61.1565676272527;
        Mon, 12 Aug 2019 23:04:32 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id f22sm2316967ljh.22.2019.08.12.23.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 23:04:32 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kernel@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, joe@perches.com,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Hyper-V: Fix typo in a filepath
Date:   Tue, 13 Aug 2019 09:04:22 +0300
Message-Id: <20190813060422.12634-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325212516.26489-1-joe@perches.com>
References: <20190325212516.26489-1-joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix typo in hyperv-iommu.c filepath.

Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org
Fixes: 29217a474683 ("iommu/hyper-v: Add Hyper-V stub IOMMU driver")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2764e0872ebd..51ab502485ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7452,7 +7452,7 @@ F:	drivers/net/hyperv/
 F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
-F:	drivers/iommu/hyperv_iommu.c
+F:	drivers/iommu/hyperv-iommu.c
 F:	net/vmw_vsock/hyperv_transport.c
 F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
-- 
2.21.0

