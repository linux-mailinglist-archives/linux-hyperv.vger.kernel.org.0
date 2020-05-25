Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7231E175E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2020 23:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbgEYVuN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 May 2020 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYVuJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 May 2020 17:50:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC9C061A0E;
        Mon, 25 May 2020 14:50:09 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k5so22128796lji.11;
        Mon, 25 May 2020 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SN+dpM083Q42WyxXGNQ6xV5UDjJbvXB3xjH8Bfi3+R4=;
        b=iNPRVl1+0sXuFo5rG2XVtbvjpacafwwSP9/HHJnuwh78ckDWfgnyiZtoN8D79+H04L
         lBo4mzux5NhMOXTMZ9+0mZQmU9FkdFhKDbiFSjXWOLq2XZ22HfmikY7OK67WjWgsCiwU
         erBDnzlqYd1nNgSOwSkIYkhZNU2H1nK+/g3awgjOMwWcK7HAABBFoAuC/sJwItRZT0su
         7z0d+hgxWhI4j4Oop9DWoPFXeNjrW3W9TW0vKmpx8sxH0ffJiSLgLTj4RI9/Xa6V8xHY
         centR91Xm2qya/eiDtv8aPXy6SDfJVJL1x3liEYifA7kaPMKwjufG6g0jxoe2XQp4Ifb
         006A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SN+dpM083Q42WyxXGNQ6xV5UDjJbvXB3xjH8Bfi3+R4=;
        b=dc3zByWpyotdL2aOgLu1NK69x4DV10Qo27wJclngBBs60p8sukYFBWtPEdDlZBQ5vQ
         hvaN2xmleSEDh3SiByiqrqWybOEOSLi9Fbe/2e9/1y2W9qUbbNpzqmYO4+qfsf6W/FJ+
         pAhMPa4uBfZQg66oN6IP5mzwrRvKQrYtiCVA3vyqxxZspbCFbuuKTDYGufH/OvDjYwpA
         sttw3WtoLsu57Lscna5a+J4qAUN0TB3+z6V/n+FvrJmTcvd5teVthtD0AD0tgMAVloeI
         UG7hfFQcabVNFvC/NRpACgLnAAuUPEhSXc7p1HS4IeHcm2TCZRtNepR8j1qxfmbvy3QZ
         bOYw==
X-Gm-Message-State: AOAM53397LZatpuhYKHDkOL/xD1yjy929aWQ/PvLsKmKMFHCSCLKU0n9
        +vTc3vImKdKbDYgVjf2iOeo=
X-Google-Smtp-Source: ABdhPJxnTbunGio3cdXh+qjthmCHup2QsAXievRHBLyH46bK73IEPo4+D9loPtgYWGKOYBGDBCRTMw==
X-Received: by 2002:a2e:a318:: with SMTP id l24mr13657060lje.45.1590443407765;
        Mon, 25 May 2020 14:50:07 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id e21sm3893338ljj.86.2020.05.25.14.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 14:50:07 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] drivers/iommu: Constify structs
Date:   Mon, 25 May 2020 23:49:56 +0200
Message-Id: <20200525214958.30015-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Constify some structs with function pointers to allow the compiler to
put them in read-only memory. There is not dependency between the
patches.

Rikard Falkeborn (2):
  iommu/hyper-v: Constify hyperv_ir_domain_ops
  iommu/sun50i: Constify sun50i_iommu_ops

 drivers/iommu/hyperv-iommu.c | 2 +-
 drivers/iommu/sun50i-iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2

