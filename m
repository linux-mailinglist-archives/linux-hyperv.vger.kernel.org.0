Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8699D3D6674
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jul 2021 20:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhGZR1M (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jul 2021 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhGZR1J (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jul 2021 13:27:09 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40016C061798;
        Mon, 26 Jul 2021 11:07:33 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id k3so9836602ilu.2;
        Mon, 26 Jul 2021 11:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ExxtPk3m7cD/MyVHcJHisgBq5NdaixHar/yvts63oY=;
        b=lu6ztsDonsig5sCIETowNoTKgft3OXEsGkWrfkw8He3KqD/0JU/DK9nSpf258sg0Bz
         i9CfwO0MFWfyclZTqiF/nY+UPtRMwrN26ANS2zqMruPGcvbZGskxaB+8QglMK2oq2+E9
         d+gHrJ+HZLU7yMxzU9WjOL7oluVtm0ZLGtISL9vMNMWIySFEh9LzdRBDSNoFmKc5qEx/
         Tq9YpvdpkkpR5WucSZPhHUJog0DGKCcL9OnvqS94uUV0cEaCaUkNOBtC11zkbFVWFVO1
         s3aeZ7oHB/DX7pFnT9+WCcvGTsySvYYyGQnt4YkvAkLqd8pSSGQ8qgFJXetJNYCsaDIW
         iLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ExxtPk3m7cD/MyVHcJHisgBq5NdaixHar/yvts63oY=;
        b=nyiQedo3i04eUelhplaVnwX+E7u+prCppBubf4n3VK2nKqiybdY8BhgKGvzE2teRBE
         8R74wXxk2GI9Di5BpSGo4wLET35pcra6E+UvRb5RzkJgy3uxfOXyfmS8YG0KT/3rf/1y
         ceMaslPT6Xx3lL9yHx7oIY1djhGM4ADhr0L9pVj+hwy7E/qS47HJHuzbZYcPUrbuqInR
         Ymnuom6nVK768Od0rtZYt+173kffzWeTlre+INip9dO4vMOTYsNSSO5o8xwbYH5pzghI
         AKcV8QaGO74hp3ji65Jf5HzeiQ+7ZIC3ko1MNDN/89sOAzDQdHiNBdNftqoVvWvZ6GKX
         q12Q==
X-Gm-Message-State: AOAM532nswhd555C/viGp7VWu9vzNEeGWiLlcgFLLxhsfXnV6b9tJYYK
        FJUdEJbs61mWZRAlhYYHtHg=
X-Google-Smtp-Source: ABdhPJwjo+fF9BZyZ1BakHMFl5O/MdShV0ZbSl+l/TnHSzCFG+swYnuCtJh3DE0ifq0bZhyUxaJHcg==
X-Received: by 2002:a92:260f:: with SMTP id n15mr13843918ile.143.1627322852708;
        Mon, 26 Jul 2021 11:07:32 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t2sm269781ilq.27.2021.07.26.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 11:07:32 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id E2BD227C0068;
        Mon, 26 Jul 2021 14:07:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 26 Jul 2021 14:07:30 -0400
X-ME-Sender: <xms:4vn-YFIjPVrX3C1_ocxwjJBa5NCRtSAeoVxZyiJujjVVcEeeGU3F8Q>
    <xme:4vn-YBLSUU37kuuJ-iDMn6qQzoW5wzFHR2zjYiEtEYJ2k83VXWbNqTkynKZXjpFoo
    9QCFQpoUA6jwKKt1Q>
X-ME-Received: <xmr:4vn-YNv1iqoyaUa3OFLUBcm_wwh3f6DnxU4EzZZoyGnFDtqaKNvGLNt7AiI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeehgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:4vn-YGbc1Ep22IZL8CsUSBhg_Af3l62yNyF-DbwFcMwCv4PImNwnag>
    <xmx:4vn-YMY_8fiC7FduD1Et-GTeQVwNDd9RcQ3oVSWT1RYdQ5O6IGjPrw>
    <xmx:4vn-YKCncr3lz1IAqs31OS6Buzei8GE770tmVaDMvEDQBWi_SEHHHQ>
    <xmx:4vn-YJQfXwm48OQQq4BKhbqTHblNgvIWQ4YJOWhhchE-RKEJyvnjKCa6vtQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 14:07:30 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 8/8] PCI: hv: Turn on the host bridge probing on ARM64
Date:   Tue, 27 Jul 2021 02:06:57 +0800
Message-Id: <20210726180657.142727-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210726180657.142727-1-boqun.feng@gmail.com>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
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
index e6276aaa4659..62dbe98d1fe1 100644
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
@@ -448,7 +449,11 @@ enum hv_pcibus_state {
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
@@ -3075,7 +3080,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 			 dom_req, dom);
 
 	hbus->bridge->domain_nr = dom;
+#ifdef CONFIG_X86
 	hbus->sysdata.domain = dom;
+#endif
 
 	hbus->hdev = hdev;
 	INIT_LIST_HEAD(&hbus->children);
-- 
2.32.0

