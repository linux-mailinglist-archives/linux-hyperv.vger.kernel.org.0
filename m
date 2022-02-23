Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2CD4C13D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiBWNQq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 08:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240823AbiBWNQp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 08:16:45 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0639A9E38;
        Wed, 23 Feb 2022 05:16:17 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id r7so18945825iot.3;
        Wed, 23 Feb 2022 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8in0yHTin9rid2JL1h9UHz/ZWLH7UBtkPLk0yjciWo=;
        b=o0aEcJLwb5KuL077sU08l8nAD6z9CaYSS+zIHw1N1qn8BbmG9yBhjK4La7DlYUS68v
         AV90yu4k9fqjO3SsYOEgrsqPFJ14ZbJtHV4kHExqj8wdMacxR7hSM153DOjKe1eymZ3/
         jLUagLLLUhCJbtqmuGm8vzzq5scFkGx9D5Du9kBQnGxv0P9hk/Ai8HFez5s2ZeLRiARI
         4lSCAxyu7DEHQ+/oUMlMei/6o1y/mR94iXPV1pIuHDy34xvfkqefyG2iAOYX98DaKpMm
         7wV48TefocxDu1Ht/buxjNsvkheppZ36vXScCzWktgckjNrhTYoP6hvRRkWG/QW/J8s1
         KRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8in0yHTin9rid2JL1h9UHz/ZWLH7UBtkPLk0yjciWo=;
        b=TJ8pek0SyqrXsqTtnZBI7AIZGWdQG3ce/tbdSE3oWWhC6zKTwRtdt0eb6Kl2N5SIlk
         5iewUsEYd/d64dFddF0k3pUQYMIHV2iTDK9C0/eJbTFaam/OG5xWye9gUykfqXGoqdRX
         mPT7LztomPKPX6YBg7nHgHBcYImXA9uU2qh/sNFKkyntP3mEJvKab6PFw/ZXY7Cy+nV3
         RMskMuCa4AQy8z7T3cDF2tlpHfzoMsP4XmLH1MkIWuXpdR5c3x38tVIYukjTrIIdyP1T
         GLZ3y/69gf+VjoTOJLZEq7VnjsCKjbvS5MjxTALe0sIhKy0AHfdK06F19SODNT4xCYvf
         gysg==
X-Gm-Message-State: AOAM5325HLTuzKWQazLgEv5Zx1BTATHstWaqCo9T8OotWUjDTAuypv5s
        gupAB75YE+yHHJKscmgdKuY=
X-Google-Smtp-Source: ABdhPJzicFqUDPkW4Be0U6VpPioCzuvMlHyqli2pDCwuVxwUb1ugoQq8nTcJ0/GFAizHCeNXiWejig==
X-Received: by 2002:a6b:8f83:0:b0:613:8b75:b76d with SMTP id r125-20020a6b8f83000000b006138b75b76dmr23134754iod.77.1645622177188;
        Wed, 23 Feb 2022 05:16:17 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b1sm11526077ilj.76.2022.02.23.05.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:16:16 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 856EF27C0054;
        Wed, 23 Feb 2022 08:16:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 23 Feb 2022 08:16:15 -0500
X-ME-Sender: <xms:nzMWYogrPCD5YHap9MTKfka32zIMGVL6n71BfQF_qtsB0sEjcmoDfw>
    <xme:nzMWYhDVECLRJf_zb1E79awfGNVKPC7aPFH-D1lLV7ZfR124sk27iKdoT5PezwadZ
    LUc6c-_1TIbn3jykw>
X-ME-Received: <xmr:nzMWYgFwt-ICKunEDGpeG8RC7mp_aS4maIHF1Dpxmop8tgr2Q6xw_NJkUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:nzMWYpQCi7pd01qw25cDY3lXLld2VZgq5BbkgLCgI_ImwGc66OebIg>
    <xmx:nzMWYlzVNEbga3d7cf3s0N9-I_WmwsjPcEmpJlNjkEBo1E0mLQ6_HA>
    <xmx:nzMWYn4c5lVbZFBwORKMY7vfEsTLtOl2bTVC49yvFix6ZPqva-KD0g>
    <xmx:nzMWYlfwdTuSA8FIPIeiN1cJy28UvLffsrFxAcbQVtt0SA9xAj-s1_LnvVw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 08:16:14 -0500 (EST)
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
Subject: [RFC 2/2] Drivers: hv: balloon: Disable balloon and hot-add accordingly
Date:   Wed, 23 Feb 2022 21:15:48 +0800
Message-Id: <20220223131548.2234326-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223131548.2234326-1-boqun.feng@gmail.com>
References: <20220223131548.2234326-1-boqun.feng@gmail.com>
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
	because it's impossible to partially free a page.

*	Memory hot-add requests from Hyper-V should provide the NUMA
	node id of the added ranges or ARM64 should have a functional
	memory_add_physaddr_to_nid(), otherwise the node id is missing
	for add_memory().

These issues require discussions on design and implementation. In the
meanwhile, post_status() is working and essiential to guest monitoring.
Therefore instead of the entire hv_balloon driver, the balloon and
hot-add are disabled accordingly for now. Once the issues are fixed,
they can be re-enable in these cases.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/hv/hv_balloon.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 062156b88a87..35dcda20be85 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1730,9 +1730,19 @@ static int balloon_connect_vsp(struct hv_device *dev)
 	 * When hibernation (i.e. virtual ACPI S4 state) is enabled, the host
 	 * currently still requires the bits to be set, so we have to add code
 	 * to fail the host's hot-add and balloon up/down requests, if any.
+	 *
+	 * We disable balloon if the page size is larger than 4k, since
+	 * currently it's unclear to us whether an unballoon request can make
+	 * sure all page ranges are guest page size aligned.
+	 *
+	 * We also disable hot add on ARM64, because we currently rely on
+	 * memory_add_physaddr_to_nid() to get a node id of a hot add range,
+	 * however ARM64's memory_add_physaddr_to_nid() always return 0 and
+	 * DM_MEM_HOT_ADD_REQUEST doesn't have the NUMA node information for
+	 * add_memory().
 	 */
-	cap_msg.caps.cap_bits.balloon = 1;
-	cap_msg.caps.cap_bits.hot_add = 1;
+	cap_msg.caps.cap_bits.balloon = !(PAGE_SIZE > 4096UL);
+	cap_msg.caps.cap_bits.hot_add = !IS_ENABLED(CONFIG_ARM64);
 
 	/*
 	 * Specify our alignment requirements as it relates
-- 
2.35.1

