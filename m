Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78733742392
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jun 2023 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjF2KAq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Jun 2023 06:00:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42492 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjF2J6p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Jun 2023 05:58:45 -0400
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id F30CC208395B; Thu, 29 Jun 2023 02:58:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F30CC208395B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1688032724;
        bh=XGi0Xfbla6zy1W1JQmGRgBhHp8TXf7aa805AEzMwfpM=;
        h=From:To:Cc:Subject:Date:From;
        b=OqwpSIc2mI4wBBiJZzndArFVjfoCtY2cq4zL2esKlYkJPPdr1gh+dgYOWAiVO1jSD
         0xibWswzVhybPzZhec0OUQmb8i/v+11mIBm6hnhSdcGP/ior5rW23WnoiNIYQ9nQkG
         WIqgGFAZ7kam3SJpyRsX8DL5BCMRDquwmrliljw8=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] hv_netvsc: support a new host capability AllowRscDisabledStatus
Date:   Thu, 29 Jun 2023 02:58:39 -0700
Message-Id: <1688032719-22847-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

A future Azure host update has the potential to change RSC behavior
in the VMs. To avoid this invisble change, Vswitch will check the
netvsc version of a VM before sending its RSC capabilities, and will
always indicate that the host performs RSC if the VM doesn't have an
updated netvsc driver regardless of the actual host RSC capabilities.
Netvsc now advertises a new capability: AllowRscDisabledStatus
The host will check for this capability before sending RSC status,
and if a VM does not have this capability it will send RSC enabled
status regardless of host RSC settings

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 3 +++
 drivers/net/hyperv/netvsc.c     | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index dd5919ec408b..218e0f31dd66 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -572,6 +572,9 @@ struct nvsp_2_vsc_capability {
 			u64 teaming:1;
 			u64 vsubnetid:1;
 			u64 rsc:1;
+			u64 timestamp:1;
+			u64 reliablecorrelationid:1;
+			u64 allowrscdisabledstatus:1;
 		};
 	};
 } __packed;
diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index da737d959e81..2eb1e85ba940 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -619,6 +619,14 @@ static int negotiate_nvsp_ver(struct hv_device *device,
 	init_packet->msg.v2_msg.send_ndis_config.mtu = ndev->mtu + ETH_HLEN;
 	init_packet->msg.v2_msg.send_ndis_config.capability.ieee8021q = 1;
 
+	/* Don't need a version check while setting this bit because if we
+	 * have a New VM on an old host, the VM will set the bit but the host
+	 * won't check it. If we have an old VM on a new host, the host will
+	 * check the bit, see its zero, and it'll know the VM has an
+	 * older NetVsc
+	 */
+	init_packet->msg.v2_msg.send_ndis_config.capability.allowrscdisabledstatus = 1;
+
 	if (nvsp_ver >= NVSP_PROTOCOL_VERSION_5) {
 		if (hv_is_isolation_supported())
 			netdev_info(ndev, "SR-IOV not advertised by guests on the host supporting isolation\n");
-- 
2.34.1

