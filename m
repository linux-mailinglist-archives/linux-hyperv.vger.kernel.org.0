Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1675F046D
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Sep 2022 08:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI3GBz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 30 Sep 2022 02:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiI3GBw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 30 Sep 2022 02:01:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B497116C1D;
        Thu, 29 Sep 2022 23:01:51 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id 5AA1020E0A4E; Thu, 29 Sep 2022 23:01:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5AA1020E0A4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664517711;
        bh=qRoWZWlP4PyLwwF+NTY7O5tHe3fxjaFBPD6xLZ+mKKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=colrSgEc59NLFwQiwI2jCC5sN1D3He9ulH/DmgqQDdnA4f+alTCq0XYDNqrIDUVIA
         rKSYF9L6GI9w/1CxE0NRPiYV0D3i9nXbQW2bhlVyX+bcK7kTFQpJNOLXmT/M9Nxelj
         Xvu8C9bNQKzv+33IMROMgwG7io03DJgTLtG70DTk=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v2 0/2] Configurable order free page reporting in hyper-v
Date:   Thu, 29 Sep 2022 23:01:37 -0700
Message-Id: <1664517699-1085-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1664447081-14744-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In some scenarios Hyper-V needs to manage memory more tightly, so it needs as
much information as possible about unused guest pages. To that end Hyper-V
now allows free page reporting in chunks smaller than 2 Mbytes. Because of
the performance tradeoffs, we want to make the chunk size configurable. Since
there's already a free page reporting module parameter, let's use that rather
than creating yet another parameter.

Configurable order free page reporting is enabled in page_reporting
driver in mm tree. However, changes need to be made in drivers like
hyper-v's hv_balloon to make it aware of the page order.
These patches add support for the same.
In the page_reporting driver(patch 1) we export the page_reporting_order
module parameter. Besides this, in the page_reporting module a check is
added to ensure that whenever the page_reporting_order value is changed, it
is within the prescribed limits.

The hv_balloon side changes(patch 2) include consuming the exported
page_reporting_order. Making changes in reporting these variable order
free pages as cold discard hints to hyper-v and dropping and refining
checks that restrict the order to a minimum of 9(default).

---
Changes in v2
  * Add more details in the cover letter about the motivation
  * Fix the threading between dependent patches

Shradha Gupta (2):
  mm/page_reporting: Add checks for page_reporting_order param
  hv_balloon: Add support for configurable order free page reporting

 drivers/hv/hv_balloon.c | 94 ++++++++++++++++++++++++++++++++---------
 mm/page_reporting.c     | 50 +++++++++++++++++++---
 2 files changed, 118 insertions(+), 26 deletions(-)

-- 
2.37.2

