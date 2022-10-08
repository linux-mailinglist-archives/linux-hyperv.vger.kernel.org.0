Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1845F8444
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Oct 2022 10:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJHIcR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 8 Oct 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiJHIcQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 8 Oct 2022 04:32:16 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5845B520B3;
        Sat,  8 Oct 2022 01:32:15 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 2CFAB1E80D72;
        Sat,  8 Oct 2022 16:26:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Epqull-euYaK; Sat,  8 Oct 2022 16:26:25 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 5B1CB1E80D4D;
        Sat,  8 Oct 2022 16:26:25 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] hv: Remove unnecessary (void*) conversions
Date:   Sat,  8 Oct 2022 16:32:06 +0800
Message-Id: <20221008083206.4486-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

addrp is a void pointer and does not require a cast type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 tools/hv/hv_kvp_daemon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1e6fd6ca513b..445abb53bf0d 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -772,11 +772,11 @@ static int kvp_process_ip_address(void *addrp,
 	const char *str;
 
 	if (family == AF_INET) {
-		addr = (struct sockaddr_in *)addrp;
+		addr = addrp;
 		str = inet_ntop(family, &addr->sin_addr, tmp, 50);
 		addr_length = INET_ADDRSTRLEN;
 	} else {
-		addr6 = (struct sockaddr_in6 *)addrp;
+		addr6 = addrp;
 		str = inet_ntop(family, &addr6->sin6_addr.s6_addr, tmp, 50);
 		addr_length = INET6_ADDRSTRLEN;
 	}
-- 
2.18.2

