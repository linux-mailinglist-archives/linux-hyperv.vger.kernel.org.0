Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1F776C3A
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Aug 2023 00:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjHIWgo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Aug 2023 18:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjHIWgn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Aug 2023 18:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21950DA;
        Wed,  9 Aug 2023 15:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD3786408E;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F0DEC433C8;
        Wed,  9 Aug 2023 22:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691620602;
        bh=4BUjLFkJfQA+chP1T8/lb7tqG9vwUxCWszoSKHdT3eE=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=uJZl35QXpiVVmR7onXffLiydLTjAzAL1fzvcV3KaK593lRMauMxyKbhL1iBMvUN19
         6ii2cOb6p2mjNYPK3vqbz1JqHEc/HFofUfi3Sp0j7rlLZ8P6dMLFQLZT8nNhV57yeX
         8vcrv0Lj8gQ61sIA5XoUJ5vSGJInQm7onv8vR5OoQOXQHv8fHsn1OELmFU6MINpvrm
         u80/X9h39D7/pUmJgZ1r18DEvNdUdMzZ3Q/TITdqKycsWIomVjpLqYTr0oCSb0ONI3
         bFatMbtCtWT9ZZWnYgRrUpwMbl913eif6HGpCbiugeezJT9EqjQaVpCiMMaq0BKVaf
         SaCnTRzdFE3Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id DAA22C0015E;
        Wed,  9 Aug 2023 22:36:41 +0000 (UTC)
From:   Mitchell Levy via B4 Relay 
        <devnull+levymitchell0.gmail.com@kernel.org>
Subject: [PATCH RFC 0/2] hyperv: Use raw_spinlock_t when not sleepable
Date:   Wed, 09 Aug 2023 22:36:31 +0000
Message-Id: <20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO8U1GQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwNz3SQT3aKS+IKi1NTcghLdtMwKXWPTRDPTZEuDZLNkSyWgPqAcUBh
 sZrRSkJuzUmxtLQClwbL1aAAAAA==
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691620601; l=1712;
 i=levymitchell0@gmail.com; s=20230725; h=from:subject:message-id;
 bh=4BUjLFkJfQA+chP1T8/lb7tqG9vwUxCWszoSKHdT3eE=;
 b=zwEsCCDdslAFmIWp4oNviyDHd5myOXZRtA1QQR2rS9NQGtc/DMRVBWzSi1Pr59mMz36bE6h/v
 PwwMRSmnPQcBjaCXBrPqy1hROOTwu3N5KyJscY76lir1pZb7CmLb6vw
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=o3BLKQtTK7QMnUiW3/7p5JcITesvc3qL/w+Tz19oYeE=
X-Endpoint-Received: by B4 Relay for levymitchell0@gmail.com/20230725 with auth_id=69
X-Original-From: Mitchell Levy <levymitchell0@gmail.com>
Reply-To: <levymitchell0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When compiled with PREEMPT_RT, spinlock_t is sleepable. While I did not
observe this causing any lockups on my system, it did cause warnings to
be emitted when compiled with lock debugging. This series fixes some
instances where spinlock_t is used in non-sleepable contexts, though it
almost certainly does not find every such instance.

An example of the warning raised by lockdep:
=============================
[BUG: Invalid wait context ]
6.5.0-rc1+ #16 Not tainted
-----------------------------
swapper/0/1 is trying to lock:
ffffa05a014d64c0 (&channel→sched_lock) {...}-{3:3}, at: vmbus_isr+0x179/0x320
other info that might help us debug this:
context-{2:2}
2 locks held by swapper/0/1:
 #0: ffffffff909a9c70 (misc_mtx){+.+.}-{4:4}, at: misc_register+0x34/0x180
 #1: ffffffff9079b4c8 (rcu_read_lock) {...}-{1:3}, at: rcu_lock_acquire+0x0/0x40
stack backtrace:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.5.0-rc1+ #16
Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022

Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
---
Mitchell Levy (2):
      Use raw_spinlock_t for vmbus_channel.sched_lock
      Use raw_spinlock_t in vmbus_requestor

 drivers/hv/channel.c                | 6 +++---
 drivers/hv/channel_mgmt.c           | 2 +-
 drivers/hv/vmbus_drv.c              | 4 ++--
 drivers/pci/controller/pci-hyperv.c | 6 +++---
 include/linux/hyperv.h              | 8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)
---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230807-b4-rt_preempt-fix-35a65c90c6c9

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>

