Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229143E0ECA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 09:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbhHEHA7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 03:00:59 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48672 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbhHEHA5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 03:00:57 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 6F91220B36EA; Thu,  5 Aug 2021 00:00:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6F91220B36EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1628146843;
        bh=pVDKNE7XALWLMR+Ke+o37vD05yBTcZzAJDeQMeIV4wk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKfn1L37/ll4HKUq1Ivk43olUAQ6fFVp0fybEWfcJNZv+6H7gxqMGlqdAcb3O4VfF
         NBF8LgyVFhn5bpN7YPSI0bDZUTReaojO9jyG9qc2+A6S+LykpXG1TVs7IHvBbvDC66
         VWUcVl1ZnLla+WK/oKQEb363oSnhtsokaBqGnLT8=
From:   longli@linuxonhyperv.com
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [Patch v5 3/3] Drivers: hv: Add to maintainer for Hyper-V/Azure drivers
Date:   Thu,  5 Aug 2021 00:00:12 -0700
Message-Id: <1628146812-29798-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Long Li <longli@microsoft.com>

Add longli@microsoft.com to maintainer list.

Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Long Li <longli@microsoft.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9487061..bbf0629 100644
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
@@ -8468,6 +8469,7 @@ F:	include/asm-generic/mshyperv.h
 F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
 F:	include/uapi/linux/hyperv.h
+F:	include/uapi/misc/hv_azure_blob.h
 F:	net/vmw_vsock/hyperv_transport.c
 F:	tools/hv/
 
-- 
1.8.3.1

