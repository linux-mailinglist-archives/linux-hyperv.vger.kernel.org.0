Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41E4E6C8F
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Mar 2022 03:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357738AbiCYCel (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Mar 2022 22:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357767AbiCYCek (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Mar 2022 22:34:40 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83297B97;
        Thu, 24 Mar 2022 19:33:06 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z19so2265181qtw.2;
        Thu, 24 Mar 2022 19:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzUtMlMUd1IXg+EKJtmTFQNZsOnG6D5eD7yULBI8dvw=;
        b=JqvlNDn2FGsVLxshI49rQ+8zQjmV89cfIwMG6WLgc9rkFhQ7kczF3p7rqZ4SphexL8
         LkEsswGZeer8mdy4BOs9AXKSjRg06TTgI828nSfBDkgwkqa/o8pqF8ZiMTHQV1jqFUwb
         abxzYHb6NrflWjIVlq6PYhWmVlajQoZvVbvHPOU0XQewW7iwkRtiUAKJ6eaBl9UiJG2E
         CpkffWI7CLnmdrBCjabz2wWi7lPvuAitpfHce7NkXY9bm0rb6DiO80igTaLCixx68uKH
         SvDvBZm5p/yF+sJ/AGctV1K/JoHgoV2AmLkKzeYrxj+tStqfczK898qNVtAmRkxPFblw
         fn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzUtMlMUd1IXg+EKJtmTFQNZsOnG6D5eD7yULBI8dvw=;
        b=yad5BcfwHNlsqEB4ihP2yYu7CkWzd0LqWrhI3bLM3LbjjEVtWQ3TMqRyqOpWtH+SE4
         CUTArm/kpsbjeilXX2v7cjtzPIWyFAh12492pc0LmfuuAG9GboyCusByUuwl0Yb9QuNz
         v3UmIrePXRfuMJ376vjNnVTjMOLn6QN4kjYu2WYPTDTUwSKDSaQl+nWqmpKvs/HgYiYJ
         DbVJHdkIekhWaF4QuWzB132AHXhd79rsT1QNUIdE6+crOfKzCFvg1HI+K0ddgngvkEDc
         JTmcnihaI+sg+tPDYXqGtGzdqAoMrdKM+rhJJ+AbvKfMMZCjN8JlxwMAzUZ9C6BkR0wy
         WfzA==
X-Gm-Message-State: AOAM5318EYwKdxOo6/3hCIMRnIbMTi4mldtFqf4uq1Hhh639UNm498pQ
        RXOsCGeG7ow04mocnG+AbzIztSZFRPo=
X-Google-Smtp-Source: ABdhPJzQ3PUnzsxZdnMKw5Qj23LChpDBlCowbS14v1EqvGtqh73fIXHOuvTwUwzLfVukpX5sYfGpig==
X-Received: by 2002:a05:622a:14d1:b0:2e2:3242:4c25 with SMTP id u17-20020a05622a14d100b002e232424c25mr7277904qtx.1.1648175585647;
        Thu, 24 Mar 2022 19:33:05 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id j8-20020a05622a038800b002e236535929sm3842533qtx.32.2022.03.24.19.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 19:33:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 194C527C0054;
        Thu, 24 Mar 2022 22:33:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 24 Mar 2022 22:33:03 -0400
X-ME-Sender: <xms:3ik9Ypvdqv_uGpMjICCQXhfuzSD-AyFUYJakRCFUiGU-Ud4_zFKdnA>
    <xme:3ik9Yie5s1t_yYmwlDMMoH8v6gmsUoBtTmKV95qk4PFREEfoJPaZMTszJ6Ic99ORO
    cfwSKQ1kelSSfaSRQ>
X-ME-Received: <xmr:3ik9Ysw3M_2s3khE3eL0yAh4nKlrkUmX_Jhpxrfmy0PRIspKjzLZnLJIQ7k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehtddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepieeuveejleehudetfeevfeelgfejteefhedvkedukefggedugefhudfhteevjedu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:3ik9YgN242_uLUZFLBJfO7e2AJHJDIfsDV-FgzkfKYFA67f2F07xvA>
    <xmx:3ik9Yp-156D7sqj8Y4JznM08mqQUum6I3JbDx3Ky3BzAHsRSlwfFWg>
    <xmx:3ik9YgXLT4FhNU5kcfRP5kC9llAr6SpIzvJstK8JYF3_MMRADhsDFw>
    <xmx:3ik9YoYdHuZS38_YfzZck1WcZ67L1Xa-63s6gI2p21KYSUAVoV-InQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Mar 2022 22:33:02 -0400 (EDT)
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
Subject: [PATCH v2 0/2] Drivers: hv: balloon: Temporary fixes for ARM64
Date:   Fri, 25 Mar 2022 10:32:10 +0800
Message-Id: <20220325023212.1570049-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.35.1
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

v1: https://lore.kernel.org/lkml/20220223131548.2234326-1-boqun.feng@gmail.com/

Changes since v1:

*	Wording changes suggested by Michael Kelley.

Since Hyper-V always uses 4k pages, hv_balloon has some difficulties
working on ARM64 with larger pages[1]. Besides the memory hot add
messages of Hyper-V doesn't have the information of NUMA node id of the
added memory range, and ARM64 currently doesn't provide the conversion
from a physical address to a node id, as a result the hv_balloon driver
couldn't handle hot add properly when there are more than one NUMA node.

Among these issues, post_status() is easy to fix, while the unballoon
issue and the hot-add issue requires more discussion. To make the
hv_balloon driver work at the best effort, this patchset fixes the
post_status() and temporarily disable the balloon and hot-add
accordingly.

Looking forwards to comments and suggestions.

Regards,
Boqun

[1]: https://lore.kernel.org/lkml/20220105165028.1343706-1-vkuznets@redhat.com/

*** BLURB HERE ***

Boqun Feng (2):
  Drivers: hv: balloon: Support status report for larger page sizes
  Drivers: hv: balloon: Disable balloon and hot-add accordingly

 drivers/hv/hv_balloon.c | 49 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

-- 
2.35.1

