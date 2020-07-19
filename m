Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD1224E5B
	for <lists+linux-hyperv@lfdr.de>; Sun, 19 Jul 2020 02:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgGSA2t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 18 Jul 2020 20:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSA2t (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 18 Jul 2020 20:28:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE39C0619D2;
        Sat, 18 Jul 2020 17:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=63jCr+SCeOP67cD87Ufv+yP7Y+AW/h262jPGrG3odrY=; b=YNv4rELCMJK1Zk/pg46gSXJ78R
        uzxV0wSgCMEZX60aujeGwAJHKzRpKrfEhdLfCp22+NFicbFTMVuzPaftwwHG0v0qCS7hkFjqsQFsH
        s8GGuoBanWsv02rWybxrNqvd0Jp58q10UxjHCijneu1s6iZOhSLw4646esovee5CmrXyGosY1D/fW
        ExPxvNxj8gvuKm/uUW2uu9Vnn2Cuq/eCSZhF4t1fobS5AkYsmWoXY6pRH/K1Rmd/1YmjZe+gWi2Mb
        E0LGzKvf7JHjHELfYa1oq3RhYGKtOld73AjCaL9ocxctET12V2Hen3i3x8S3yDg74O/E7oo03QJZO
        mz+7i19A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxCA-0002hT-Cc; Sun, 19 Jul 2020 00:28:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH] hyperv: hyperv.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:28:41 -0700
Message-Id: <20200719002841.20369-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org
---
 include/uapi/linux/hyperv.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/uapi/linux/hyperv.h
+++ linux-next-20200717/include/uapi/linux/hyperv.h
@@ -219,7 +219,7 @@ struct hv_do_fcopy {
  * kernel and user-level daemon communicate using a connector channel.
  *
  * The user mode component first registers with the
- * the kernel component. Subsequently, the kernel component requests, data
+ * kernel component. Subsequently, the kernel component requests, data
  * for the specified keys. In response to this message the user mode component
  * fills in the value corresponding to the specified key. We overload the
  * sequence field in the cn_msg header to define our KVP message types.
