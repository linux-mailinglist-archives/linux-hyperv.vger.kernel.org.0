Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFC61D9C8
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Nov 2022 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKEL5p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Nov 2022 07:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEL5o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Nov 2022 07:57:44 -0400
X-Greylist: delayed 160 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Nov 2022 04:57:41 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E211C2CC80;
        Sat,  5 Nov 2022 04:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667649278;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=7YDfkPsK/ndAgrRcWqtUv7HJFVVzJ/jwYcicDhBFNFQ=;
    b=YmdgYV8oGp+u8dHD1527OBZALAmGAoaMVf1FIQL27MIc6Z8RkFmPL3vc/SVRYUjl8R
    l+nFmrXmb3NQAneqwJy8pQSAh7235flb71ZT4Ea6S2Ca+KGOhk2M4kL4zVQMf3O1qY8M
    hL1alk/KlZrRM9Anig7LzqYbRD4Rp8qUDpR/JZvFr4CXqBp9jZVxQgkYdlTmPEjVlCqh
    CwjEuzXTGfiWa0EHj/scUYwJcs6F/gEoNUnvW8TzXrNH1uuIeSmUklNMFJIM3v+HxYHt
    HeIckTRM/DvpimRZ09NYmpHjxoVE8B9EO682e9eQgiVj43/ODfmlD4nLGLgVuaT42wdt
    XuLg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4wrVv7EJ8tYgyIiB0X4jURJx/8eeVDQqGGs4HbcQ=="
X-RZG-CLASS-ID: mo00
Received: from sender
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id gb94dfyA5BscjqT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 5 Nov 2022 12:54:38 +0100 (CET)
From:   Olaf Hering <olaf@aepfle.de>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] hv: fix comment typo in vmbus_channel/low_latency
Date:   Sat,  5 Nov 2022 11:54:01 +0000
Message-Id: <20221105115401.21592-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

morev vs. more.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 include/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3b42264333ef..13801b582ea6 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -969,7 +969,7 @@ struct vmbus_channel {
 	 * mechanism improves throughput by:
 	 *
 	 * A) Making the host more efficient - each time it wakes up,
-	 *    potentially it will process morev number of packets. The
+	 *    potentially it will process more number of packets. The
 	 *    monitor latency allows a batch to build up.
 	 * B) By deferring the hypercall to signal, we will also minimize
 	 *    the interrupts.
