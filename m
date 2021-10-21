Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558EF436528
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Oct 2021 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJUPMF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Oct 2021 11:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJUPME (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Oct 2021 11:12:04 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878B0C0613B9;
        Thu, 21 Oct 2021 08:09:48 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so5972767pjq.0;
        Thu, 21 Oct 2021 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TfHsGP2yi6lWLecTIcZVrIhetTubqUKD7yLErDw3x2w=;
        b=EUZaSbSsvxfgQPDyiZv6K9FvbiaFo8lnIoEmpC0ubPuoqxNOuIOf4K8ZsIh578ws0Z
         2EDdrEbYHum8lqROFe1C/onYlVaB50CDb5AwppL0LpxiFNIEWdnc8cQjEFdXeAobfidj
         x8qfJAw0gdtPVdlvPc21q9Yxry610dr7WFKlVHFUO1eyzNlo/F03H3hyjJckpZwfON5S
         b21ly6HIsBApY6VwbYgoI1P/Fu0X1AZm7c/Cai3cT3TlLzr9REQ44ISEUK3PawQUbAVm
         ZC1Qe6WDuHchsm5VVBggdsA8zJ1Xgd6h2KTs8gi19LGsz2M2EyYOMMdey6IAUQiBbt/o
         +Ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TfHsGP2yi6lWLecTIcZVrIhetTubqUKD7yLErDw3x2w=;
        b=hMbFAjGWeF5HtbledEOQn4mwZraG0Xq7EPug3qqVmFqva9+xVpfhr92V8sp5Go/A2z
         7K2Xkf41Vs+TSkjHdxEXOLvE8hjZwn8npusOvhX1xqwAonW7WRPTe9b3gPx6B+9I62nx
         VffquK5koCdh2V+luLBRZ773jo4pVTQyA40mTewdoLMYx9OZaC75EUfaPM9DRP5k8EOk
         7xoZA7KEebk4i+8CZ/n0GSFLMT/6/jGZbBwch5WY2NULN8fbU9oLoCfNvjG5flVbvuWO
         LzxclB3tccZ/bswlwqs39OQ+xje343oWOhhUX3gnZoYELpST+2PiQO9ecHMY2KyhoE3k
         1RrQ==
X-Gm-Message-State: AOAM532ez8WxjX+rGe/jMsP55a6mNCPyXRAgkx3aY+n78rIN5G7Ynabl
        cgXqskLRqVEh+QN3mBXDQmg=
X-Google-Smtp-Source: ABdhPJxCZzHdSx53dvdDywLg2snzLq3kKzeBkBrose+fBiquWSSELbthuFAJlsRxyfUjW/fn7V8LMg==
X-Received: by 2002:a17:902:d4d1:b0:13f:af7:9068 with SMTP id o17-20020a170902d4d100b0013f0af79068mr5714981plg.20.1634828988016;
        Thu, 21 Oct 2021 08:09:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id c9sm5508027pgq.58.2021.10.21.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:09:47 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        skhan@linuxfoundation.org, Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Toan Le <toan@os.amperecomputing.com>
Subject: [PATCH v3 02/25] PCI: Set error response in config access defines when ops->read() fails
Date:   Thu, 21 Oct 2021 20:37:27 +0530
Message-Id: <56642edd0d6bf8a8e3d20b5fcc088fd6389b827f.1634825082.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634825082.git.naveennaidu479@gmail.com>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value with error
response (~0), when the PCI device read by a host controller fails.

This ensures that the controller drivers no longer need to fabricate
(~0) value when they detect error. It also  gurantees that the error
response (~0) is always set when the controller drivers fails to read a
config register from a device.

This makes error response fabrication consistent and helps in removal of
a lot of repeated code.

Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..0f732ba2f71a 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -42,7 +42,10 @@ int noinline pci_bus_read_config_##size \
 	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
 	pci_lock_config(flags);						\
 	res = bus->ops->read(bus, devfn, pos, len, &data);		\
-	*value = (type)data;						\
+	if (res)							\
+		SET_PCI_ERROR_RESPONSE(value);				\
+	else								\
+		*value = (type)data;					\
 	pci_unlock_config(flags);					\
 	return res;							\
 }
@@ -228,7 +231,10 @@ int pci_user_read_config_##size						\
 	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
 					pos, sizeof(type), &data);	\
 	raw_spin_unlock_irq(&pci_lock);				\
-	*val = (type)data;						\
+	if (ret)							\
+		SET_PCI_ERROR_RESPONSE(val);				\
+	else								\
+		*val = (type)data;					\
 	return pcibios_err_to_errno(ret);				\
 }									\
 EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
-- 
2.25.1

