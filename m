Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3D3A1AFF
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jun 2021 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbhFIQek (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Jun 2021 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbhFIQei (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Jun 2021 12:34:38 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593EC0617A6;
        Wed,  9 Jun 2021 09:32:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id 5so23406635ioe.1;
        Wed, 09 Jun 2021 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15t7ZKTSX9WU503SVEKMIKymOsp0yb03DbikdqeGm38=;
        b=IL895TA+hvrX3n0qdh9JJZDlsA+zMM40QHD9YuLGcFvWyFmOBbWr0lwsaAEA/sDP3K
         iFVOzZzN8SgYt1T/Imb/+iyDliuKqHw3rq4mBWgspDpmiKr06PA6iLRSvIt3hJB4O1aY
         toqIyYe8lCVdoENWwYcnZwWSV+xVpKpFiMnbwCmTqhaDKg6ynHNUHy+4iqZkdyC9pr61
         IZ7qNz3LEV6Ip/F18DKU7VLSouVvRLCcd/xmj5hUBWpvkH8y9VvsFDhs2h0qpbpq4lVg
         rwdBYEpcXvk37O5uAA6bRMrGKBTlcMygnp+qYboJC1W7sp1RKrUtXJsqhZU90Lw0YmG0
         tipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15t7ZKTSX9WU503SVEKMIKymOsp0yb03DbikdqeGm38=;
        b=f8t8VJg5cTanUpEYvbj8DXKrMRaMbCGkN2CK2MYA4cawdZgPwWLwV1twHtbqlHgSnM
         MpI492vA/QZHjwUNXD3pPQciyHAweCHG/uQx9agDHYxocfAsgntZdr57V7RKXI5d7bFp
         D1jHUOuIxTeaSYqn8xy+NmMHwgDxavHQJWeOfUI171qT1+CPcnI6UTOThBskyELHbMzU
         ZV52cv0ZI3wfWVl/iggG90WCbaibKlHz8FV2TEKcachFC7JDqVNtUUqQVKcnMpFWn1tv
         H7j9zwmrA0skC/I/ZWf/3eEU0JbPc7yHNlovgibRUxPO4f7Gf2RJL3KNwDQ00Y9X9SeX
         dGuQ==
X-Gm-Message-State: AOAM531hk9UvxN5oNU0L9BD2oRgOf1dyOkqPQnL2QIvKYeqVUpC8Smtb
        oTrBpPdMWlAWKzcj80spFQQ=
X-Google-Smtp-Source: ABdhPJyhgEqY3+4woUSGc66Hoo7NTM4a2l3JyXWUFWWECsf/CaRguxBXkWADIBSg3+gt9uwmlaziiQ==
X-Received: by 2002:a05:6638:2725:: with SMTP id m37mr461409jav.121.1623256347937;
        Wed, 09 Jun 2021 09:32:27 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i7sm263328ilb.67.2021.06.09.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:32:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7184D27C005C;
        Wed,  9 Jun 2021 12:32:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 09 Jun 2021 12:32:26 -0400
X-ME-Sender: <xms:Gu3AYK6oaCMbx1juskhuPjTdHiGFdoqpKgCgfe5ZRJmba2pRGL-0ww>
    <xme:Gu3AYD5CesdHXVjyQZXgoTmWiKwmfG8RyN9hJkIXqY1AEpv4AtmsUo1q86qCNWRCA
    WXdsQ_LOwrjtwrYTQ>
X-ME-Received: <xmr:Gu3AYJdAGpPvZv-MIojkEuUFMDyzDweNOOhZDnI0R9KQz1Zc8HiKlwsPfe4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeduuddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeei
    ueeuleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Gu3AYHKWTPqi7mrx3YCfmM_X75NrEp410e5FYjlHB1fpPRzM5vVR6Q>
    <xmx:Gu3AYOI-IituoHTHlBE2uRmaUSitVxJ2rKgRk6HjaPqgki2qLDd39A>
    <xmx:Gu3AYIxuUpd10fkpr5VWkGVVTw3zzWfDrUlz9r0g_Bmojh5JUrR8Cw>
    <xmx:Gu3AYD4pUO4ZPuaTls9rcZAk3_OmGiHqhJx77eOmS9HLlLxjrlRI7wB0u1c>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jun 2021 12:32:26 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: [RFC v3 7/7] PCI: hv: Turn on the host bridge probing on ARM64
Date:   Thu, 10 Jun 2021 00:32:11 +0800
Message-Id: <20210609163211.3467449-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609163211.3467449-1-boqun.feng@gmail.com>
References: <20210609163211.3467449-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Now we have everything we need, just provide a proper sysdata type for
the bus to use on ARM64 and everything else works.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 16a779ab9ed4..271d0b6d4796 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -40,6 +40,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/delay.h>
 #include <linux/semaphore.h>
 #include <linux/irqdomain.h>
@@ -449,7 +450,11 @@ enum hv_pcibus_state {
 };
 
 struct hv_pcibus_device {
+#ifdef CONFIG_X86
 	struct pci_sysdata sysdata;
+#elif defined(CONFIG_ARM64)
+	struct pci_config_window sysdata;
+#endif
 	struct pci_host_bridge *bridge;
 	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
@@ -3099,7 +3104,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 dom_req, dom);
 
 	hbus->bridge->domain_nr = dom;
+#ifdef CONFIG_X86
 	hbus->sysdata.domain = dom;
+#endif
 
 	hbus->hdev = hdev;
 	refcount_set(&hbus->remove_lock, 1);
-- 
2.30.2

