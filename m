Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB764C13D5
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 14:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240806AbiBWNQe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 08:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbiBWNQe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 08:16:34 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE1A9E38;
        Wed, 23 Feb 2022 05:16:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id r7so18945095iot.3;
        Wed, 23 Feb 2022 05:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/ZngmccxHK3xdUdzMq14bcJ4elOS/xqvsQ5qkzb4so=;
        b=U3H73Mij6jCZ7Vg+VLx8hPjGaqz3dZIn++n5JILJULeHGYCjuLNox0L2nXxoPn968O
         ZGTBLdQ/McZSxzbOYUDywVOpPRgEPZQSCSwXce8PCVC62iovckv9Y2chwn+/rUrMiX6J
         t6l3+HXgWAhhaM30vqyMhnChV4quWoqOsbaq6VRM26iXZGPzUEJBrHhrNJZ+HZcZ7wwU
         iR5J6WxSkdUIl5PI69tVZ0O1tYot7r0lifZbDCWQhFT/UgTCuy4YFAHFUj3wJCeAKckY
         9WZ1nBl1lRk33Zs+2WPsyDFoIb2L5wxzvnnGbdvJA+Kz5jzP0d3CA9hnDy6jGJ86v5Dg
         8XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N/ZngmccxHK3xdUdzMq14bcJ4elOS/xqvsQ5qkzb4so=;
        b=XbE5yrGiMFtfssU2YDR9GdloYmBw7t1etr3jOWIKwNrbiEvaT6qTdVpdA2dXE+5brL
         zEI38lLPsQXjb4Z1eaRM+fHRltZneYRJeAoBW6dvU4K7Lj4KUe6QwC0dZDRIuZiDZv7l
         0zku04wCjDwLTnt1wd17dZrO/4PflSvWRpuzU5rI9wBHQGY7v5V1rwHX+XdlxRnCZZtx
         vajibPGGmeoVhWhnvIefYSnjnUX4J9g3oN8RS3/WADo22hweV5ymRsbf4ms5pm1Wcpvy
         ieo5aXkJadfqfxOg+uBtjmdO6TZRfrnUYiuiSHtp1lv2/gUTWshq9Zz4BuoImVoNdwG/
         HKvA==
X-Gm-Message-State: AOAM5302zi+3Cis/tihVTKy7KJTx2YD4yRKSZY3LUJlCbiadcOc5eQoq
        +Li5ouH9MR2n5xyCHFgRxnk=
X-Google-Smtp-Source: ABdhPJyDlLYi8num6aKaORYvJbsGJ0QW0RvaOActL9DYdJiQUbpgVFQhFGv5VJ9YWS49FpFUZls3MA==
X-Received: by 2002:a6b:640c:0:b0:641:31c0:53f9 with SMTP id t12-20020a6b640c000000b0064131c053f9mr8706519iog.192.1645622166089;
        Wed, 23 Feb 2022 05:16:06 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i16sm3677914ilk.14.2022.02.23.05.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:16:04 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 88DD127C005A;
        Wed, 23 Feb 2022 08:16:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 23 Feb 2022 08:16:03 -0500
X-ME-Sender: <xms:kjMWYj-S0HEl9I0P9Sx4CrRmiRwo2n7RaYzKJF-1PVJKiRL5S2OXNQ>
    <xme:kjMWYvv6PJVPhSq-hIZSS_aXfhK28uTyGcWO4mjczICZ1yJD33xi96rwv-aa3t2gR
    zS7S4e0JBhe3kHWaA>
X-ME-Received: <xmr:kjMWYhC3OFVynqeKR8EMTt6yyBLpYpcYZhcTJ_DXVgSCQUMvx5YOvsVk-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeiueevjeelheduteefveeflefgjeetfeehvdekudekgfegudeghfduhfetveejuden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:kjMWYve9QSVKeSWU-7_i00oQCKd_hRZEjnrDLpI43jiH4ypzuA060A>
    <xmx:kjMWYoOQoXtTc3zyDc13OALZGFfiGeddTHV3DCfr6iXq-Mdy4shLMQ>
    <xmx:kjMWYhnWSh_OSQY49Bq6QkdJbYS4pYNcOCMqqjaSrmqfxuyYtdlDIQ>
    <xmx:kzMWYnpKLsopf0keQ3AwrdRoQF5I5hBr9fMb_DCxExs9d7kaWGrsa7r_WC8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 08:16:01 -0500 (EST)
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
Subject: [RFC 0/2] Drivers: hv: balloon: Temporary fixes for ARM64
Date:   Wed, 23 Feb 2022 21:15:46 +0800
Message-Id: <20220223131548.2234326-1-boqun.feng@gmail.com>
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

Boqun Feng (2):
  Drivers: hv: balloon: Support status report for larger page sizes
  Drivers: hv: balloon: Disable balloon and hot-add accordingly

 drivers/hv/hv_balloon.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.35.1

