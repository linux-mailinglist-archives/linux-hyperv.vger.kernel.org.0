Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4676C66CAD4
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 18:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAPRIG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 12:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjAPRHm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 12:07:42 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B21C45215;
        Mon, 16 Jan 2023 08:48:14 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D6E5920DFE77;
        Mon, 16 Jan 2023 08:48:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D6E5920DFE77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673887692;
        bh=JmHVRvhu2m1jE9Odz0SHFNYNcSPlbL+fxlhzMHCCfx8=;
        h=From:To:Subject:Date:From;
        b=pd1PaLE/zfCFwE5hLx+g8Tp+Mfr1Lriqofl5Pjuog40oChiS3FmZWPzaaSRtZkruU
         PZ7S6y8kxZrR8jlCiAe+zWPafx0Gof98G81+yhK5HadU+gNMK/yvbmtsMrSSQYmtho
         SRuIhvDnyIU1Y3Mb3kIhTYNcmjqt7KQ8XWJzT+54=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH 0/4] Device tree support for Hyper-V VMBus driver
Date:   Mon, 16 Jan 2023 08:48:04 -0800
Message-Id: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
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

This patch set expands the functionality of the VMBus driver by adding
support for device tree on x86/x64 architectures.

The first two patches enable Hyper-V builds for non-ACPI systems, while
the third patch adds device tree support into the VMBus driver, in
addition to its pre-existing support for ACPI. The fourth patch includes
the necessary device tree bindings for the VMBus driver.

Saurabh Sengar (4):
  drivers/clocksource/hyper-v: non ACPI support in hyperv clock
  Drivers: hv: allow non ACPI compilation for
    hv_is_hibernation_supported
  Drivers: hv: vmbus: Device Tree support
  dt-bindings: hv: Add dt-bindings for VMBus

 .../devicetree/bindings/hv/msft,vmbus.yaml         |  34 ++++
 drivers/clocksource/hyperv_timer.c                 |  15 +-
 drivers/hv/hv_common.c                             |   4 +
 drivers/hv/vmbus_drv.c                             | 190 +++++++++++++++++----
 4 files changed, 206 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hv/msft,vmbus.yaml

-- 
1.8.3.1

