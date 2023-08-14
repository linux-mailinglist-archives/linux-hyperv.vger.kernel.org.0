Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4077B116
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 08:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjHNGG6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjHNGGH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 02:06:07 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FEF199B;
        Sun, 13 Aug 2023 23:05:38 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E5dnKn028174;
        Sun, 13 Aug 2023 23:04:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=2e/DgbPH5Z735BTpVc79AFms8kX4Gp8CjDRy+gF54Og=;
 b=E/8P5/+jNOFDXnIeAK6eLktq00L60xiKYdb2qKHYNE+xCpg5uzwBma5HNeeDm5+xDr/z
 PtUPN2CVxipoL7xIRglPjHM0nr73ebcCfiBNHKO+ejsrYpyGT1z5owXlVZBvcqnjQTMi
 xVpi7MTLbBxFyMgVXN2gotRa8b8ZGbhZzCnaie9FgVwAx0KVLDEe3Z0Hs/va3cj30eI3
 bQep63FV2AJCT9K2ToAglpvTN/WgrwwX8gb7FG8I4boMHs0BV/6m7+XurB6k5AN7oOOW
 iqus7BoMwgqKR+ia384IF8M69kir+dL0CX57DDgO8auPhc0KzwAXvTjo5NFnI/q/asdB kQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kj4xs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 23:04:52 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 13 Aug
 2023 23:04:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 13 Aug 2023 23:04:50 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id A95D13F707E;
        Sun, 13 Aug 2023 23:04:25 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>,
        <jiawenwu@trustnetic.com>, <mengyuanlou@net-swift.com>,
        <yang.lee@linux.alibaba.com>, <error27@gmail.com>,
        <linyunsheng@huawei.com>, <linux-hyperv@vger.kernel.org>,
        <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <wei.liu@kernel.org>, <decui@microsoft.com>,
        <longli@microsoft.com>, <shradhagupta@linux.microsoft.com>,
        <linux-hwmon@vger.kernel.org>, <michael.chan@broadcom.com>,
        <richardcochran@gmail.com>, <jdelvare@suse.com>,
        <linux@roeck-us.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <nbd@nbd.name>,
        <john@phrozen.org>, <sean.wang@mediatek.com>,
        <Mark-MC.Lee@mediatek.com>, <lorenzo@kernel.org>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <linux@armlinux.org.uk>,
        <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>,
        <leon@kernel.org>, <gerhard@engleder-embedded.com>,
        <maciej.fijalkowski@intel.com>, <alexanderduyck@fb.com>,
        <wei.fang@nxp.com>, <shenwei.wang@nxp.com>,
        <xiaoning.wang@nxp.com>, <linux-imx@nxp.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <jaswinder.singh@linaro.org>, <ilias.apalodimas@linaro.org>,
        <UNGLinuxDriver@microchip.com>, <horatiu.vultur@microchip.com>,
        <linux-omap@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <simon.horman@corigine.com>, <vladimir.oltean@nxp.com>,
        <rkannoth@marvell.com>, <aleksander.lobakin@intel.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
        <mcoquelin.stm32@gmail.com>, <p.zabel@pengutronix.de>,
        <thomas.petazzoni@bootlin.com>, <mw@semihalf.com>,
        <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <xen-devel@lists.xenproject.org>, <jgross@suse.com>,
        <sstabellini@kernel.org>, <oleksandr_tyshchenko@epam.com>,
        <linux-wireless@vger.kernel.org>, <ryder.lee@mediatek.com>,
        <shayne.chen@mediatek.com>, <kvalo@kernel.org>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>
Subject: [PATCH v1 net] page_pool: Cap queue size to 32k.
Date:   Mon, 14 Aug 2023 11:34:11 +0530
Message-ID: <20230814060411.2401817-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: aFZU2RAx_UAE8R4K6KZZzbh7PQU3_GNE
X-Proofpoint-ORIG-GUID: aFZU2RAx_UAE8R4K6KZZzbh7PQU3_GNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_24,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Clamp to 32k instead of returning error.

Please find discussion at
https://lore.kernel.org/lkml/
CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.
namprd18.prod.outlook.com/T/

Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
ChangeLog:
v0 -> v1: Rebase && commit message changes
---
 net/core/page_pool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index a3e12a61d456..e9dc8d8966ad 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -171,9 +171,10 @@ static int page_pool_init(struct page_pool *pool,
 	if (pool->p.pool_size)
 		ring_qsize = pool->p.pool_size;
 
-	/* Sanity limit mem that can be pinned down */
+	/* Cap queue size to 32k */
 	if (ring_qsize > 32768)
-		return -E2BIG;
+		ring_qsize = 32768;
+
 
 	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.
 	 * DMA_BIDIRECTIONAL is for allowing page used for DMA sending,
-- 
2.25.1

