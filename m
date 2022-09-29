Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DCC5EF363
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Sep 2022 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiI2KZM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Sep 2022 06:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiI2KYv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Sep 2022 06:24:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C7B42ED49;
        Thu, 29 Sep 2022 03:24:50 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 22B7B20DEE6F; Thu, 29 Sep 2022 03:24:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22B7B20DEE6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664447090;
        bh=33c+IysfP1nl2vviiqkB7+1UrsmV1vFHMMgfRpYodcc=;
        h=From:To:Cc:Subject:Date:From;
        b=mdfXJ5M4B75XJz3s4dQNhleREvvlToHImVy+O05Ec3I5zejCyXnDMiWv9qk3V6yiX
         7mpum4UwPQICSwyrMrqhCzzAEd0W0thHeDybTz3FeHz8s0wmz/cKOFiCqk3ORy377Z
         fBsX8ueWxhLDK/F2r5i2+m4k+Gozr8uBTRUJIMeM=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 0/2] Configurable order free page reporting in hyper-v
Date:   Thu, 29 Sep 2022 03:24:39 -0700
Message-Id: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
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

Configurable order free page reporting is enabled in page_reporting
driver in mm tree. However, changes need to be made in drivers like
hyper-v's hv_balloon to make it aware of the page order.
These patches add support for the same.
In the page_reporting driver we export the page_reporting_order module
parameter. Following precedence is added in setting the reporting order
        a. Value of page_reporting_order parameter
        b. Value of order passed while registering with the driver
        c. default value (pageblock_order)
Besides this, in the page_reporting module a check is added to ensure
that whenever the page_reporting_order value is changed, it is within
the prescribed limits.

The hv_balloon side changes include consuming the exported
page_reporting_order. Making changes in reporting these variable order
free pages as cold discard hints to hyper-v and dropping and refining
checks that restrict the order to a minimum of 9(default).

Shradha Gupta (2):
  mm/page_reporting: Add checks for page_reporting_order param value
  hv_balloon: Add support for configurable order free page reporting

 drivers/hv/hv_balloon.c | 94 ++++++++++++++++++++++++++++++++---------
 mm/page_reporting.c 	 | 50 ++++++++++++++++++++++++++++++++++++++++-----
 2 file changed, 118 insertions(+), 26 deletions(-)

-- 
2.37.2

