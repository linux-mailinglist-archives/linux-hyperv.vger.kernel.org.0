Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5B3C7BF3
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jul 2021 04:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237490AbhGNCs1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 22:48:27 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbhGNCsW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 22:48:22 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5BF9220B8010; Tue, 13 Jul 2021 19:45:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5BF9220B8010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1626230731;
        bh=PKFf+8kO5A52jhZV/QqpXtSFFDIo+ssp3V5q80tnB24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D/yF84j6oYhathmAUX2BExJbnLWTpK2yERECcajBskmEbY57tYOxgE+AM4fpHnueP
         Uq+KqoVYPpa45Kmzv9Bz8eZ0WpHfwKKTS1yL+PC4ERmt0AbOXWPgNfOqg2TOZaj8Sl
         pNWbqGE0Yjg4qUV9wXVXVIbIo77DxxCkbckl9C14=
From:   longli@linuxonhyperv.com
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [Patch v3 3/3] Drivers: hv: Add to maintainer for Azure Blob driver
Date:   Tue, 13 Jul 2021 19:45:22 -0700
Message-Id: <1626230722-1971-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
References: <1626230722-1971-1-git-send-email-longli@linuxonhyperv.com>
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

