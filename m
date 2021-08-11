Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7223E94AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Aug 2021 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhHKPhK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Aug 2021 11:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhHKPhH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Aug 2021 11:37:07 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB5C061765;
        Wed, 11 Aug 2021 08:36:43 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id f11so4203490ioj.3;
        Wed, 11 Aug 2021 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQztCj7/CCGbKaKfsGCj2ylvssWy2hoSLtQUB8lGvqA=;
        b=XxdVMm6fenLsjMT3qAxdEjlJ+RMQ5X4WvI9Cx8RWNlvtVC+bhg0+IiOIOWs6QAXGzW
         jkQe1TurjzzTv9GUVGVu0YTsBAO3Q9XHzzW4O88HO8drG9qcx8EKovfgNPMeut0/preL
         3FCzsFlWsg7vGO1XaDZhP1CcV8lkQYW5VV8mja8Yf+odS6OlCePmYV0P9s6UaHmmEW7f
         ziS2asakbEYEYnsvZLuj4tJpGTNJGpKB8WjhZFG8t4r1A9hMqA4oaVQ7Ko6ueU17dW8z
         SKaBDqcbedh7KSlTBOD4QTvLHGsU3gpdmmTaBb3PaUhQpaE7hpGwgStS9ew5DUu7zjWw
         EtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQztCj7/CCGbKaKfsGCj2ylvssWy2hoSLtQUB8lGvqA=;
        b=c1V6yf4ydZYgDshpfzhPPZQUecgqciATTKQdwucPF6FV+NXVSqA5e0oZwr3C2gKWUZ
         +CjO3Gnsj+Y1uKmxCVR611/xKQhIYPq9bwYUP3xzVixKmSG7BWUP3PPv5Z2wYipk44TZ
         VKQrkfd5H/hnYvKSp4wvjrhRkhvCaVbrgdNq88YsB71+0TuMyen36nBBZUUULiiuFAwX
         EuGUdES8iPTxCaPiiR1R4JH7mP+RNpH/0Dm8WPhY565BOsnBQpw4n9pKs3acp8AXOVZC
         /HnObZbp+T19XXfKudlYnpj5aaa7cTPkbb6QfqDDWzJpeK86PbihPUsfg/+N3pwCE6B7
         o3Ag==
X-Gm-Message-State: AOAM533kBtKRcH+ovgfHQsUrYL0Jkk1DH7dEiyBiQH6MBQJXO0K9Mcje
        e8ImDhoVKyJRPnm52qlmjR4=
X-Google-Smtp-Source: ABdhPJzLLBPJ4N7FhEZx/e0t1/uMyV5jGKrTQJ5t5039LpTMBPPzh67wbfKPDN5YlpUF01jwpsVe+w==
X-Received: by 2002:a05:6602:1848:: with SMTP id d8mr32570ioi.72.1628696202630;
        Wed, 11 Aug 2021 08:36:42 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id m1sm13261529ilf.24.2021.08.11.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:36:42 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3382527C0054;
        Wed, 11 Aug 2021 11:36:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Aug 2021 11:36:41 -0400
X-ME-Sender: <xms:ie4TYX__WNm_LqhpksbKe9hAsHIXSu5NRoUpwbU1NOH8hU0z-RfY1g>
    <xme:ie4TYTv_enOdoztyFnoVAU5DBUExdONTgXxGLtrLgAKC07M9TEqFBxR0EF50nNcAt
    JDrq4NXv0Ou4CSL3Q>
X-ME-Received: <xmr:ie4TYVAGchhwuW7PhrRxv1lcSjZsAvQsewZeXiRbWX-Z8o6jc7kPSck7zxU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:ie4TYTf821BJaqMun-Y5D6I7bQu-FlzSbtHpM-WP1VPiPPqLAYFgVQ>
    <xmx:ie4TYcORO4PI1MV3xQSJ-Q15Tm9agf1MrO1hXYCp59CBCHT1TuwMNQ>
    <xmx:ie4TYVne_F9V00hKRN_TueK8axD93c22u49MsVo-hTkUWDBxdqg7Bg>
    <xmx:ie4TYYsfJzubIFYpBd01A2FWdBf7kpiivc1U9iN_2CS1YwA72BTwfO3WU5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 11:36:40 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 5/5] PCI: hv: Remove the dependency of pci_config_window
Date:   Wed, 11 Aug 2021 23:36:19 +0800
Message-Id: <20210811153619.88922-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811153619.88922-1-boqun.feng@gmail.com>
References: <20210811153619.88922-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The ACPI device information is now correctly set via ->private of
pci_host_bridge, therefore no need to use pci_config_window in
hv_pcibus_device, so remove it.

Note we still need an empty pci_sysdata structure for non-x86, because
it's x86-specific.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/pci/controller/pci-hyperv.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index fd3792b5edcc..f2b977ef7b84 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -448,12 +448,17 @@ enum hv_pcibus_state {
 	hv_pcibus_maximum
 };
 
+/*
+ * Defines a empty struct for non-x86 architecture, this is OK because we only
+ * use this field as an "anchor" to get back to hv_pcibus_device object on
+ * non-x86 architecture.
+ */
+#ifndef CONFIG_X86
+struct pci_sysdata { };
+#endif
+
 struct hv_pcibus_device {
-#ifdef CONFIG_X86
 	struct pci_sysdata sysdata;
-#elif defined(CONFIG_ARM64)
-	struct pci_config_window sysdata;
-#endif
 	struct pci_host_bridge *bridge;
 	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
-- 
2.32.0

