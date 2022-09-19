Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637FD5BD6C4
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Sep 2022 00:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiISWE5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Sep 2022 18:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiISWEz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Sep 2022 18:04:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4A7F1CFC5;
        Mon, 19 Sep 2022 15:04:54 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 748362052E21;
        Mon, 19 Sep 2022 15:04:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 748362052E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663625094;
        bh=Z73JSV/NwhC08GlZ1iQvd8d8O8nbwnonCMrxhLYMe/E=;
        h=From:To:Subject:Date:From;
        b=f1t2S5sryT2te3gjuH5G1QBHZ2snAba19S984SOU7Fi7eafpWiIl7GcXey5xpM7wR
         V/9p+dtipSqPJ7Hac0lrUPe92+N4tkYRX18edKIQdJcN8+MGcC1kpjvRY32pY4BHbb
         rnS3dQzDzGdMYsw5uKposMD/QlaxTROBRvAYMuc0=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Use PCI_VENDOR_ID_MICROSOFT define instead of magic number
Date:   Mon, 19 Sep 2022 15:04:43 -0700
Message-Id: <1663625084-2518-1-git-send-email-eahariha@linux.microsoft.com>
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

From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

pci_ids.h already defines PCI_VENDOR_ID_MICROSOFT, and is included via
linux/pci.h. Use the define instead of the magic number.

base-commit: f0880e2cb7e1f8039a048fdd01ce45ab77247221

Easwar Hariharan (1):
  hv: Use PCI_VENDOR_ID_MICROSOFT for better discoverability

 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.8.3.1

