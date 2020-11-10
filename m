Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6C52ADF03
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Nov 2020 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJTCd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Nov 2020 14:02:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:35100 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTCd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Nov 2020 14:02:33 -0500
Received: from localhost.localdomain (c-71-231-190-134.hsd1.wa.comcast.net [71.231.190.134])
        by linux.microsoft.com (Postfix) with ESMTPSA id C887F20C27C5;
        Tue, 10 Nov 2020 11:02:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C887F20C27C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605034953;
        bh=0+7JgM+4vm1ixk2Q3YFgtJOVqHKLd386H8RppwZJm0M=;
        h=From:To:Cc:Subject:Date:From;
        b=tDMCrs93uCqojL0gwwUy4jZ1FpoVuRSAtpeX7zXx1t2RL5FH+9hL7QBL4ZBq5D7/K
         tBPTR1UndEWHBfdFjfDGP18s3kTWTQ+EzhPMG8hAALdNRdz/PQYBwKXvwd6yq9vaoE
         ZVcj2sE7DBqVF5GIvV7ywZIGRKavcpioSlsr6rdA=
From:   Chris Co <chrco@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, chrco@microsoft.com, mikelley@microsoft.com,
        andrea.parri@microsoft.com, parri.andrea@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU if disconnected
Date:   Tue, 10 Nov 2020 19:01:18 +0000
Message-Id: <20201110190118.15596-1-chrco@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Chris Co <chrco@microsoft.com>

When invoking kexec() on a Linux guest running on a Hyper-V host, the
kernel panics.

    RIP: 0010:cpuhp_issue_call+0x137/0x140
    Call Trace:
    __cpuhp_remove_state_cpuslocked+0x99/0x100
    __cpuhp_remove_state+0x1c/0x30
    hv_kexec_handler+0x23/0x30 [hv_vmbus]
    hv_machine_shutdown+0x1e/0x30
    machine_shutdown+0x10/0x20
    kernel_kexec+0x6d/0x96
    __do_sys_reboot+0x1ef/0x230
    __x64_sys_reboot+0x1d/0x20
    do_syscall_64+0x6b/0x3d8
    entry_SYSCALL_64_after_hwframe+0x44/0xa9

This was due to hv_synic_cleanup() callback returning -EBUSY to
cpuhp_issue_call() when tearing down the VMBUS_CONNECT_CPU, even
if the vmbus_connection.conn_state = DISCONNECTED. hv_synic_cleanup()
should succeed in the case where vmbus_connection.conn_state
is DISCONNECTED.

Fix is to add an extra condition to test for
vmbus_connection.conn_state == CONNECTED on the VMBUS_CONNECT_CPU and
only return early if true. This way the kexec() path can still shut
everything down while preserving the initial behavior of preventing
CPU offlining on the VMBUS_CONNECT_CPU while the VM is running.

Fixes: 8a857c55420f29 ("Drivers: hv: vmbus: Always handle the VMBus messages on CPU0")
Signed-off-by: Chris Co <chrco@microsoft.com>
Cc: stable@vger.kernel.org
---
 drivers/hv/hv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 0cde10fe0e71..f202ac7f4b3d 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -244,9 +244,13 @@ int hv_synic_cleanup(unsigned int cpu)
 
 	/*
 	 * Hyper-V does not provide a way to change the connect CPU once
-	 * it is set; we must prevent the connect CPU from going offline.
+	 * it is set; we must prevent the connect CPU from going offline
+	 * while the VM is running normally. But in the panic or kexec()
+	 * path where the vmbus is already disconnected, the CPU must be
+	 * allowed to shut down.
 	 */
-	if (cpu == VMBUS_CONNECT_CPU)
+	if (cpu == VMBUS_CONNECT_CPU &&
+	    vmbus_connection.conn_state == CONNECTED)
 		return -EBUSY;
 
 	/*
-- 
2.17.1

