Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153D58C8AF
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Aug 2022 14:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242359AbiHHMyV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Aug 2022 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiHHMyL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Aug 2022 08:54:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C109DF21
        for <linux-hyperv@vger.kernel.org>; Mon,  8 Aug 2022 05:54:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E593A37ACE;
        Mon,  8 Aug 2022 12:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659963248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au1PbrBym0RDvBK59gzpYLmZ5lBCOOF2TJfnVZ03KeI=;
        b=A6IyIml1ehWWPn5/77sPeEDw/XDPl4/2QiX94X+YCc1eMqCNB9IsAnb2eay6OMK2YBYbs4
        ZWr11e40xwZXCDE864iRl/8ZbWuYQdfqq/9xdlp5eOgHmK1BJ47vcaea/JG/CpI4RubcMa
        PJP9w/+8BNuXur2857Y6d5PLTql2jWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659963248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=au1PbrBym0RDvBK59gzpYLmZ5lBCOOF2TJfnVZ03KeI=;
        b=n16QRsxNOLQ1lSZJxtOxmQYqXgZ8dOOAmjeuemCUbTMQC5fhaAyIQnY9+Z18BcgpBNWtOr
        VUTtPZronTGC+ICg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 914C413ADE;
        Mon,  8 Aug 2022 12:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kCdiInAH8WLHUgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:08 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, noralf@tronnes.org,
        drawat.floss@gmail.com, lucas.demarchi@intel.com,
        david@lechnology.com, kraxel@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 01/14] iosys-map: Add IOSYS_MAP_INIT_VADDR_IOMEM()
Date:   Mon,  8 Aug 2022 14:53:53 +0200
Message-Id: <20220808125406.20752-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
References: <20220808125406.20752-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add IOSYS_MAP_INIT_VADDR_IOMEM() for static init of variables of type
struct iosys_map.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/iosys-map.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
index a533cae189d7..cb71aa616bd3 100644
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -46,10 +46,13 @@
  *
  *	iosys_map_set_vaddr(&map, 0xdeadbeaf);
  *
- * To set an address in I/O memory, use iosys_map_set_vaddr_iomem().
+ * To set an address in I/O memory, use IOSYS_MAP_INIT_VADDR_IOMEM() or
+ * iosys_map_set_vaddr_iomem().
  *
  * .. code-block:: c
  *
+ *	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(0xdeadbeaf);
+ *
  *	iosys_map_set_vaddr_iomem(&map, 0xdeadbeaf);
  *
  * Instances of struct iosys_map do not have to be cleaned up, but
@@ -121,6 +124,16 @@ struct iosys_map {
 		.is_iomem = false,	\
 	}
 
+/**
+ * IOSYS_MAP_INIT_VADDR_IOMEM - Initializes struct iosys_map to an address in I/O memory
+ * @vaddr_iomem_:	An I/O-memory address
+ */
+#define IOSYS_MAP_INIT_VADDR_IOMEM(vaddr_iomem_)	\
+	{						\
+		.vaddr_iomem = (vaddr_iomem_),		\
+		.is_iomem = true,			\
+	}
+
 /**
  * IOSYS_MAP_INIT_OFFSET - Initializes struct iosys_map from another iosys_map
  * @map_:	The dma-buf mapping structure to copy from
-- 
2.37.1

