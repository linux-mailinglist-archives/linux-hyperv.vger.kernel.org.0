Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F19371702
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 May 2021 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhECOsy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 3 May 2021 10:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhECOst (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 3 May 2021 10:48:49 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F167C061343;
        Mon,  3 May 2021 07:47:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 76so3413939qkn.13;
        Mon, 03 May 2021 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmxD0ZZWyLDmbUI7WJl5Chz/U5d4iCfhGGuYidByI1Y=;
        b=c/7Dh3OQepXd3Gk7+Ktnjc/Q1371ta4WGDJVxAkXb0L72Joe3A+fNs0b5ySNu/jZoD
         vinJS+TmbfjEYKiAEX4R9lq6tDPkYOlWnfW54p6wLHRr16yh3U1nPH5k8cw29O2XuN5k
         vAgrU/G3YbZF6jq8+W/77AmS/QUqQxehMoC6oWYfDJgT9B+ih0/CTwM5oXYYkg9hzn9C
         2/zxwc8VAuPm2b+ki/jnLscwtksaMRdc10Lek3dsjl+SYRhwAS6OlUjtFBRxb1pPCRNS
         ZRvP6/1CemSsV4rUkXoJhE4rNVLeT2q6wdJPPc0vcgkcq3gL/3jdWjNCpoQ0GlrKVTxf
         FbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmxD0ZZWyLDmbUI7WJl5Chz/U5d4iCfhGGuYidByI1Y=;
        b=VLVmEFfedjjofQdF4YLfMTC0aQd7GCpH/Y7OQft17FAuJtx/fMiqVtq/xBkM6UVreo
         sVQXle+cYD4iXvmFt2NEci04fS6e9abXEosaq+0+Dl1TnyDoc+5ifd9pol/zLa0hBy92
         IykLge47BB11lWZyWx5uq9D7dR4Cxu9dmqMQYA4HHuS1E8Cpe+lD8A+BQE2Kuav6K7jF
         pfgXEYxWR+9bsjanB1CxQBC5BkY3CnXxWJuiC20TUkPabycfdjbRKwJ9aZTt2Y/yABNQ
         +VbTOoojMrwPrK0YSUxkagjUy4MzMPq4lhV2POZ07NRmDLlwqX+Q5oozZIn+BHDlkkmO
         lKNA==
X-Gm-Message-State: AOAM530f7d0lJdmP4Aji7M6sXTCiElZs81iMY4JDikF1LxLyAlwmlOiy
        RHRWYo9P2N3B4MHIfigM+faPZ2d9u1gd2w==
X-Google-Smtp-Source: ABdhPJwJQTQ+i5t7XI+bNqjB0PUR0SiUXldDNi1Jbkj/jxzJyLKY99BDP7WgJCH0Jv+QngE01hMA2g==
X-Received: by 2002:a37:7004:: with SMTP id l4mr19996241qkc.476.1620053272797;
        Mon, 03 May 2021 07:47:52 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id w4sm7801qti.6.2021.05.03.07.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:47:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7B8A627C0054;
        Mon,  3 May 2021 10:47:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 May 2021 10:47:51 -0400
X-ME-Sender: <xms:Fw2QYKAMV2YY3e9DWQM9hC5fPMX8x2pWfqhVkZrGe6YODq8l71YDgw>
    <xme:Fw2QYEg83nOj3kLAjTv4Kb_hezeg7H9lkzll_1yU5Os59Zw_wJpej5DHu94357xVq
    ZC64Jg9R0qn3vOsyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppedufedurddutdejrddurddvheegnecuvehluhhsthgvrhfuihiivgepvd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Fw2QYNmyiPkrIgDUleqv7SkxfCgmvSitHf5xSRZ2Mz0vNiTSnNaIqA>
    <xmx:Fw2QYIyI0mIwPN1bIem3JVuOKawnd5OS4IJ7jM8IP-c0GVeA_gWxDQ>
    <xmx:Fw2QYPSvpb8OYowgS3MjofiRg47N0KZo5tbD1Y4MkBG8bd-D8JGhGw>
    <xmx:Fw2QYHpEvU4s0FC5c9z1u-rgMTlP-JWr8gqllXXg4QF1NNnpwm5_HBNTZS1smiVm>
Received: from localhost (unknown [131.107.1.254])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Mon,  3 May 2021 10:47:50 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: [RFC v2 7/7] PCI: hv: Turn on the host bridge probing on ARM64
Date:   Mon,  3 May 2021 22:46:35 +0800
Message-Id: <20210503144635.2297386-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503144635.2297386-1-boqun.feng@gmail.com>
References: <20210503144635.2297386-1-boqun.feng@gmail.com>
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
index 4ec7839d0adf..75ff47bedf2a 100644
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
@@ -3102,7 +3107,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 dom_req, dom);
 
 	hbus->bridge->domain_nr = dom;
+#ifdef CONFIG_X86
 	hbus->sysdata.domain = dom;
+#endif
 
 	hbus->hdev = hdev;
 	refcount_set(&hbus->remove_lock, 1);
-- 
2.30.2

