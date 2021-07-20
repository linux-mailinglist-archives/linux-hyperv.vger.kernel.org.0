Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C373CF2A5
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 05:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhGTCwK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jul 2021 22:52:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:40702 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243645AbhGTCvK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jul 2021 22:51:10 -0400
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 5F4A920B6C14; Mon, 19 Jul 2021 20:31:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F4A920B6C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1626751908;
        bh=FpUpE/kH1TL3NjUJ1UQsRvPrqprv/gk6sqCAkenAfcU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGEjY2NB4iJndPBIFPnoUP5lq5p9H//2vZ+kRxGoLbbW6Sd/eilNJCGN+DH1REzlW
         EKw2q2Dn4zChwvZM1bZfHUDrCwouCX3wE6BoEs17bYdfUHo72m+nsQIAJd6wPAOINd
         n+uYiu46LZ0GrxDKybdGyZ0cpbI/g5F4gFnQr9ko=
From:   longli@linuxonhyperv.com
To:     linux-fs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [Patch v4 3/3] Drivers: hv: Add to maintainer for Hyper-V/Azure drivers
Date:   Mon, 19 Jul 2021 20:31:06 -0700
Message-Id: <1626751866-15765-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
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
index 948706174fae..bbf062936f21 100644
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
2.25.1

