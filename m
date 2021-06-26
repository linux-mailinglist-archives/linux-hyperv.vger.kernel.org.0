Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D703B4D1B
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Jun 2021 08:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhFZGdR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 26 Jun 2021 02:33:17 -0400
Received: from linux.microsoft.com ([13.77.154.182]:52366 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhFZGdQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 26 Jun 2021 02:33:16 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 59DE520B6C14; Fri, 25 Jun 2021 23:30:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 59DE520B6C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1624689054;
        bh=PKFf+8kO5A52jhZV/QqpXtSFFDIo+ssp3V5q80tnB24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9dSMw47n7UIQ4Zl3nvtVritfc5mbxq4euFN+vhIPpFhinYsCRaMKAp5sPYn4Fbec
         r2Bsi+ttTVZWLKbbchY6pPJewODp3WuvfVof0qGWGh6j4ey6yB7ZvheKM+iymnCnxD
         bXpdEZx92cdcccIOSEBZwR4T6yBuoH9A65/HP9Lo=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [Patch v2 3/3] Drivers: hv: Add to maintainer for Azure Blob driver
Date:   Fri, 25 Jun 2021 23:30:20 -0700
Message-Id: <1624689020-9589-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Add longli@microsoft.com to maintainer list for Azure Blob driver.

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9487061..b547eb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8440,6 +8440,7 @@ M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Stephen Hemminger <sthemmin@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Dexuan Cui <decui@microsoft.com>
+M:	Long Li <longli@microsoft.com>
 L:	linux-hyperv@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
-- 
1.8.3.1

