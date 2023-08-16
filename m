Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5F77D973
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Aug 2023 06:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241571AbjHPEfG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 16 Aug 2023 00:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbjHPEeo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 16 Aug 2023 00:34:44 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C7D32126;
        Tue, 15 Aug 2023 21:34:43 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B2065211F5FB;
        Tue, 15 Aug 2023 21:34:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2065211F5FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692160482;
        bh=q0idsYJtleym2/hMi7dG82Ppc5kTKugctTjWAAk4t1U=;
        h=From:To:Cc:Subject:Date:From;
        b=OooeRJFzpaQPZ4OEgv4F+7Z/D2eX3Vju+50i23C0yM3wYNkNTQexdrehptX9rLxJC
         kiaBqG4IasDVQXS8Z3hcqTg2grfkc01VdmexrDwSI7re54a756BogHLR1mE2uT4B+2
         zLqnkKbdY9xiWQ9pdcepPBgAH6lMUxJv0vVYt/GY=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com
Subject: [PATCH v2] hv: hyperv.h: Replace one-element array with flexible-array member
Date:   Tue, 15 Aug 2023 21:34:38 -0700
Message-Id: <1692160478-18469-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

One-element and zero-length arrays are deprecated. Replace one-element
array in struct vmtransfer_page_packet_header with flexible-array
member. This change fixes below warning:

[    2.593788] ================================================================================
[    2.593908] UBSAN: array-index-out-of-bounds in drivers/net/hyperv/netvsc.c:1445:41
[    2.593989] index 1 is out of range for type 'vmtransfer_page_range [1]'
[    2.594049] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.5.0-rc4-next-20230803+ #1
[    2.594114] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 04/20/2023
[    2.594121] Call Trace:
[    2.594126]  <IRQ>
[    2.594133]  dump_stack_lvl+0x4c/0x70
[    2.594154]  dump_stack+0x14/0x20
[    2.594162]  __ubsan_handle_out_of_bounds+0xa6/0xf0
[    2.594224]  netvsc_poll+0xc01/0xc90 [hv_netvsc]
[    2.594258]  __napi_poll+0x30/0x1e0
[    2.594320]  net_rx_action+0x194/0x2f0
[    2.594333]  __do_softirq+0xde/0x31e
[    2.594345]  __irq_exit_rcu+0x6b/0x90
[    2.594357]  irq_exit_rcu+0x12/0x20
[    2.594366]  sysvec_hyperv_callback+0x84/0x90
[    2.594376]  </IRQ>
[    2.594379]  <TASK>
[    2.594383]  asm_sysvec_hyperv_callback+0x1f/0x30
[    2.594394] RIP: 0010:pv_native_safe_halt+0xf/0x20
[    2.594452] Code: 0b 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 05 35 3f 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
[    2.594459] RSP: 0018:ffffb841c00d3e88 EFLAGS: 00000256
[    2.594469] RAX: ffff9d18c326f4a0 RBX: ffff9d18c031df40 RCX: 4000000000000000
[    2.594475] RDX: 0000000000000001 RSI: 0000000000000082 RDI: 00000000000268dc
[    2.594481] RBP: ffffb841c00d3e90 R08: 00000066a171109b R09: 00000000d33d2600
[    2.594486] R10: 000000009a41bf00 R11: 0000000000000000 R12: 0000000000000001
[    2.594491] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.594501]  ? ct_kernel_exit.constprop.0+0x7d/0x90
[    2.594513]  ? default_idle+0xd/0x20
[    2.594523]  arch_cpu_idle+0xd/0x20
[    2.594532]  default_idle_call+0x30/0xe0
[    2.594542]  do_idle+0x200/0x240
[    2.594553]  ? complete+0x71/0x80
[    2.594613]  cpu_startup_entry+0x24/0x30
[    2.594624]  start_secondary+0x12d/0x160
[    2.594634]  secondary_startup_64_no_verify+0x17e/0x18b
[    2.594649]  </TASK>
[    2.594656] ================================================================================

With this change the structure size is reduced by 8 bytes, below is the
pahole output.

struct vmtransfer_page_packet_header {
	struct vmpacket_descriptor d;                    /*     0    16 */
	u16                        xfer_pageset_id;      /*    16     2 */
	u8                         sender_owns_set;      /*    18     1 */
	u8                         reserved;             /*    19     1 */
	u32                        range_cnt;            /*    20     4 */
	struct vmtransfer_page_range ranges[];           /*    24     0 */

	/* size: 24, cachelines: 1, members: 6 */
	/* last cacheline: 24 bytes */
};

The validation code in the netvsc driver is affected by changing the
struct size, but the effects have been examined and have been determined
to be appropriate.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2]
 - Added more info in commit message regarding netvsc validation code
   affected by change of this struct.

 include/linux/hyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 3ac3974b3c78..5c66640ea8db 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -348,7 +348,7 @@ struct vmtransfer_page_packet_header {
 	u8  sender_owns_set;
 	u8 reserved;
 	u32 range_cnt;
-	struct vmtransfer_page_range ranges[1];
+	struct vmtransfer_page_range ranges[];
 } __packed;
 
 struct vmgpadl_packet_header {
-- 
2.34.1

