Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D186C62D5
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Mar 2023 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCWJJc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Mar 2023 05:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWJJS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Mar 2023 05:09:18 -0400
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06C41A95B
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Mar 2023 02:08:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679562206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lTe9LISs2pflvSiuzz8njOhESiOpw5ulrZFB1bo8ej0=;
        b=uYcoUfKDkxNQ6Id+Oa4CLl9EGelbi8sUDea8HTVwAAcsDQDyAVWO1CZOtQpqSBg17uAAXh
        My6s84gYx4X746OVkTIgmvhoXolDbjHgA9Kkg8EjTb7bRU0la49hQCaCO8BCOTQ//RyOAy
        KJhdS0oIe2rn0GN5fBK0vtCp5+r/btY=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Dariusz Marcinkiewicz <reksio@newterm.pl>,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Jian Shen <shenjian15@huawei.com>, Hao Lan <lanhao@huawei.com>,
        Jie Wang <wangjie125@huawei.com>,
        Long Li <longli@microsoft.com>, Jiri Pirko <jiri@resnulli.us>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 1/8] net: liquidio: Remove redundant pci_clear_master
Date:   Thu, 23 Mar 2023 17:03:00 +0800
Message-Id: <20230323090314.22431-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/net/ethernet/cavium/liquidio/lio_main.c    | 1 -
 drivers/net/ethernet/cavium/liquidio/lio_vf_main.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index fd7c80edb6e8..9bd1d2d7027d 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -1129,7 +1129,6 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 
 		fallthrough;
 	case OCT_DEV_PCI_ENABLE_DONE:
-		pci_clear_master(oct->pci_dev);
 		/* Disable the device, releasing the PCI INT */
 		pci_disable_device(oct->pci_dev);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index ac196883f07e..e2921aec3da0 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -577,7 +577,6 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 
 		fallthrough;
 	case OCT_DEV_PCI_ENABLE_DONE:
-		pci_clear_master(oct->pci_dev);
 		/* Disable the device, releasing the PCI INT */
 		pci_disable_device(oct->pci_dev);
 
-- 
2.34.1

