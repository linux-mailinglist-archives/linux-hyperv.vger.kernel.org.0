Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841F84E6C91
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Mar 2022 03:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357778AbiCYCen (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 22:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357774AbiCYCem (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 22:34:42 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E46AE1A;
        Thu, 24 Mar 2022 19:33:08 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id d65so1563785qke.5;
        Thu, 24 Mar 2022 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXFrpdSrsWxPJJKP0L3fMCW4KHzAGEDahZ4BTeY25yA=;
        b=Q9pj/sZr5QY+q11G2WBBcCqSkmfQvsi70r24pAGLdOMDRpZ6IWjI8npDn67bPSf1wE
         oSy39cN+T/NitKrQRrw44b8NQdE41dDRLno4F3fLQGe9rbwo+rg0FBuXXYlqpLEnzuo7
         aCYIF5U22rsDXy0sCTfhj6rr5TTi9CPNWlcy1/Tgkf1BWBtv5Rf3tdUKfMOxwYsBb29N
         HzewAy8WR+4b7HHI7R4SlmFkGT60EoUcC51YNJvNqkmo5VerJ4GhxExM3BAc36yYtebU
         yOlru3me8lMHMHFm+XvAzYo+se5C7NV2P/aA+/mCoPE7xO8vE+RBJSJGZO3eyPrBLTq9
         eLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXFrpdSrsWxPJJKP0L3fMCW4KHzAGEDahZ4BTeY25yA=;
        b=DSaj9Ibg4ggRXk9LturNVMNKQtfXKwM+T8z76Yva9xf0gyu1y2xP38Sylef2HwmXB6
         4kyIBzjLch8Kbipb0v9xhUautJymbtSDCAR4BYA/tGQS+MNDPjWYBhK6rWoj7MGG2L++
         bvOf0n/TlZfpDycw6SJYvzW1btJOfJL++PWV8flHyjapXfNgI/qOvvt5vhHyQgdXbhX9
         +sBkGWrDP41VkfPxLNuPW5hitnciyhyWy7XMAD1iFDfcot0fs2AuOvKO75h4z6kGIAiq
         0xnxsAzKX1lu82CXnr//VdieJHkQzd7oX962MnQnC3Fe4qUIMYawE80ccM2r0bL/ZO1+
         r64Q==
X-Gm-Message-State: AOAM532obIhCLV27TV8eO5JE/1FxwNqM1dif3i663r7H23alT2C/iIjs
        nVNX6VsogNq4wz9tRdK+/BI=
X-Google-Smtp-Source: ABdhPJwRIkBJF3/tva+2snizZ+0mfh59yzMMWS3os+L8hOlcezIpErwoN/IZd/GREGBdesLN/1l/yw==
X-Received: by 2002:a05:620a:4142:b0:67b:3150:219e with SMTP id k2-20020a05620a414200b0067b3150219emr5543922qko.189.1648175587692;
        Thu, 24 Mar 2022 19:33:07 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm2588391qkb.74.2022.03.24.19.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 19:33:06 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id C55CC27C0054;
        Thu, 24 Mar 2022 22:33:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 24 Mar 2022 22:33:05 -0400
X-ME-Sender: <xms:4Sk9YqI42SQFkSutgk8zmX8C-G2YIQRqfA6paMpz5UZc7owP-SUX3Q>
    <xme:4Sk9YiLFrNK6jaMnv6cPt56ss6Qn5_muQnaV_Xzjew3g-U8yf19_abMCHBPEqcs8z
    gZZ70-C824wsLFAUg>
X-ME-Received: <xmr:4Sk9YqvTZBtp2HGG99CmK-UULaT8pTdSewNI6aEe10EwE-XDVzY0LXnhUtI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehtddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4Sk9YvYtofAT42Hdf1BaHoYURxCV0vbPoXC-sBKK5bqmW5HHQtD2SQ>
    <xmx:4Sk9YhZa9zKtzsS5ZfQWmjZw3_8NYraS6PABRCPx1gFOniOBso3nOQ>
    <xmx:4Sk9YrC7b48LGzbtQy_WU2feWvKCNc5FiDvUh4Kg1HM8Veu_V4mF_w>
    <xmx:4Sk9Yjm41YuESiF1OCNVGWfC2-3pz5CyK5RuwREhBfQg-gODtqNthg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 22:33:05 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-hyperv@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 2/2] Drivers: hv: balloon: Disable balloon and hot-add accordingly
Date:   Fri, 25 Mar 2022 10:32:12 +0800
Message-Id: <20220325023212.1570049-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325023212.1570049-1-boqun.feng@gmail.com>
References: <20220325023212.1570049-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently there are known potential issues for balloon and hot-add on
ARM64:

*	Unballoon requests from Hyper-V should only unballoon ranges
	that are guest page size aligned, otherwise guests cannot handle
	because it's impossible to partially free a page. This is a
	problem when guest page size > 4096 bytes.

*	Memory hot-add requests from Hyper-V should provide the NUMA
	node id of the added ranges or ARM64 should have a functional
	memory_add_physaddr_to_nid(), otherwise the node id is missing
	for add_memory().

These issues require discussions on design and implementation. In the
meanwhile, post_status() is working and essential to guest monitoring.
Therefore instead of disabling the entire hv_balloon driver, the
ballooning (when page size > 4096 bytes) and hot-add are disabled
accordingly for now. Once the issues are fixed, they can be re-enable in
these cases.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/hv/hv_balloon.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 062156b88a87..eee7402cfc02 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1660,6 +1660,38 @@ static void disable_page_reporting(void)
 	}
 }
 
+static int ballooning_enabled(void)
+{
+	/*
+	 * Disable ballooning if the page size is not 4k (HV_HYP_PAGE_SIZE),
+	 * since currently it's unclear to us whether an unballoon request can
+	 * make sure all page ranges are guest page size aligned.
+	 */
+	if (PAGE_SIZE != HV_HYP_PAGE_SIZE) {
+		pr_info("Ballooning disabled because page size is not 4096 bytes\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static int hot_add_enabled(void)
+{
+	/*
+	 * Disable hot add on ARM64, because we currently rely on
+	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
+	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
+	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
+	 * add_memory().
+	 */
+	if (IS_ENABLED(CONFIG_ARM64)) {
+		pr_info("Memory hot add disabled on ARM64\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 static int balloon_connect_vsp(struct hv_device *dev)
 {
 	struct dm_version_request version_req;
@@ -1731,8 +1763,8 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	 * currently still requires the bits to be set, so we have to add code
 	 * to fail the host's hot-add and balloon up/down requests, if any.
 	 */
-	cap_msg.caps.cap_bits.balloon = 1;
-	cap_msg.caps.cap_bits.hot_add = 1;
+	cap_msg.caps.cap_bits.balloon = ballooning_enabled();
+	cap_msg.caps.cap_bits.hot_add = hot_add_enabled();
 
 	/*
 	 * Specify our alignment requirements as it relates
-- 
2.35.1

