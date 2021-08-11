Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523F03E94A5
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Aug 2021 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhHKPhE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Aug 2021 11:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhHKPhC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Aug 2021 11:37:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0CCC061765;
        Wed, 11 Aug 2021 08:36:38 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s184so4229577ios.2;
        Wed, 11 Aug 2021 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H0aePHbvBlMQFFOlxS/RlBo9IjhQNt3o+m5ARm3Lb0E=;
        b=KSxqYJ+KWw7Gg3DhQLJkgDY1JuTJXIjrCvPJgn3MOCKyuVYdmdz68zetkXAXt3bu4x
         ES6AUIJPnki5DiPDmJ8aDEAo+XTY5BJ7Kg1rKv0gTRR+0i2E6TJO6igmNq15J3L5y3kv
         x+7brmJEjp2AiWLmaoPuAXa/PABSGWuETv74xIQmjrTlKl40vcEthWTA1Gr/CWv2lLQN
         khucthDm/e6F/W6tTJb9zWZ+/5HTQrjlwe94h4NDZ+/5C7i4lyeaPA2J2CXH2JitEFDw
         fNVbFqtmVgDS4r35EnL6xOX8mTE93LdZ61zLRoZiGGDhJUDGXWYWD3kKsMFiIdcR/DQd
         gonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H0aePHbvBlMQFFOlxS/RlBo9IjhQNt3o+m5ARm3Lb0E=;
        b=TSw1kqU0t7mDMW5wtuEOVV0/Uz6XjrB43Pi8XeqKjo3tW/N6fxHBiDT5c6bmVeFapn
         brCvnCmlx4uP92zJwyEh+7MoU2SuKbaNtusm3j7xsxDQXmgxPz82FisqcmlvLaBFJVbH
         vmdTKtC1iv1o08D4d2uf+5lwmtnUoBKuj4heRC5TFCTaKvzP7FP/CXDmQvyVbCKyUS+G
         pxwNKfSio0Vf1SDk9VjrttzVTus3/Z70rfIUz9+kPkUGSG5col+Jz3a+jE3zDUhNvVVq
         2ocdEkmu/A/zOnBY+Qg6slLMqA6tZsViyq9rJQ3hURnYUXc+LT0IkHevyiY1+H0/TC6m
         /2pw==
X-Gm-Message-State: AOAM532vWDdFMK3eyanaqVjNuAmK5Kr4JTkAdoyOvBGqeuoZCDK+l2Fm
        p2YbOC4yZwlX2WWUDn4/f9E=
X-Google-Smtp-Source: ABdhPJw4swY5OoR9NWjAtDhIiSaQ+1h4/lWhktDxZBX90x+/YF3KS5bdFjgKxgydOLGMjvvdPVEdyA==
X-Received: by 2002:a6b:b502:: with SMTP id e2mr256604iof.152.1628696198048;
        Wed, 11 Aug 2021 08:36:38 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x11sm14111871ilu.3.2021.08.11.08.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 08:36:37 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7433527C0054;
        Wed, 11 Aug 2021 11:36:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Aug 2021 11:36:36 -0400
X-ME-Sender: <xms:hO4TYbcSvMjpM1tgcNbpy7qUhra4u1o9fBhA8dv0IzJj5Kt06dPoMA>
    <xme:hO4TYRN-jqsnnep_xFgLuq_BY3aM7M_yypzuarvrqlxZYwegG00WfEnNLHaNmLWp_
    9qPSlVAQsleXvfH_w>
X-ME-Received: <xmr:hO4TYUgY1btGJMOlUKpzZI2_ofu5U2fVjB5e1Cw1ouitT3Ld30xuMwt5rhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkedugdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehvdevteefgfeiudettdefvedvvdelkeejueffffelgeeuhffhjeetkeeiueeu
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:hO4TYc9yz4TsXCXf5UdxdbonZj894YFEIk0XIFIU1a34ecBubWrE7w>
    <xmx:hO4TYXugkYKQDjTUI-Tw44PIL-EN8C0cI9lUUIR2rbdaAiXNZqMwzg>
    <xmx:hO4TYbFyeoo6NSM8caQmPZVUH974BMrgNr79JRQl0wPyfQGA-HaKbQ>
    <xmx:hO4TYQMeNHif_jNNpfSo3NPiKPai0NvNkj7Zgb-YaPVV1_XtMbXaSl0bJp4>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Aug 2021 11:36:36 -0400 (EDT)
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
Subject: [RFC 2/5] PCI/ACPI: Store ACPI device information in the host bridge structure
Date:   Wed, 11 Aug 2021 23:36:16 +0800
Message-Id: <20210811153619.88922-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811153619.88922-1-boqun.feng@gmail.com>
References: <20210811153619.88922-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In order to decouple the ACPI device information of a PCI host bridge
from the sysdata, ->private of pci_host_bridge is used to store the ACPI
device, and it's done by the new pci_create_root_bus_priv().

A reader function is also added, to retrieve the ACPI device information
in pci_host_bridge.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 drivers/acpi/pci_root.c  | 5 +++--
 include/linux/pci-acpi.h | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d7deedf3548e..82824841cbda 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -894,8 +894,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 
 	pci_acpi_root_add_resources(info);
 	pci_add_resource(&info->resources, &root->secondary);
-	bus = pci_create_root_bus(NULL, busnum, ops->pci_ops,
-				  sysdata, &info->resources);
+	bus = pci_create_root_bus_priv(NULL, busnum, ops->pci_ops, sysdata,
+				       &info->resources, &root->device,
+				       sizeof(struct acpi_device *));
 	if (!bus)
 		goto out_release_info;
 
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 5ba475ca9078..21d4cc80aa55 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -80,6 +80,11 @@ extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 					    struct acpi_pci_root_ops *ops,
 					    struct acpi_pci_root_info *info,
 					    void *sd);
+static inline struct acpi_device *
+acpi_pci_root_device(struct pci_host_bridge *bridge)
+{
+	return *((struct acpi_device **)bridge->private);
+}
 
 void acpi_pci_add_bus(struct pci_bus *bus);
 void acpi_pci_remove_bus(struct pci_bus *bus);
-- 
2.32.0

