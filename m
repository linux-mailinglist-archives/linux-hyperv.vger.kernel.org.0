Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE346DB580
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Apr 2023 22:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDGU4m (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 7 Apr 2023 16:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGU4h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 7 Apr 2023 16:56:37 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 252CD7ABA;
        Fri,  7 Apr 2023 13:56:37 -0700 (PDT)
Received: from skinsburskii.localdomain (unknown [131.107.1.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6BFFF213B62E;
        Fri,  7 Apr 2023 13:56:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6BFFF213B62E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1680900996;
        bh=YRUkOLHXWLdwt0GZfM9eUMnSSmOnnB/oKT8xHXr5G0k=;
        h=Subject:From:Cc:Date:From;
        b=mgve/NmyqWzUSZ8UBg62cuLIg3K1Aa/PgmTrOGnekjdCNmyKbRlWX/DBI0YLDjly+
         jv0bS6wbgdXbAhqSEif3+9cswO7RtbQY3uIUiS82WfY2UBGHjdNhxjfRASY2fzjdrP
         FYGSzfF9OXrqJA7REyAWK6Z0jfefQ6cTuEYrBO1I=
Subject: [PATCH 0/2] Fix MSI interrupts for nested Hyper-V root partition
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        linux-hyperv@vger.kernel.org,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Date:   Thu, 06 Apr 2023 09:31:44 -0700
Message-ID: <168079806973.14175.17999267023207421381.stgit@skinsburskii.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.2 required=5.0 tests=DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,
        MISSING_HEADERS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hyper-V root partition needs to map MSI interrupts differently in case of
nested setup and this series addresses the case.

The following series implements...

---

Stanislav Kinsburskii (2):
      x86/hyperv: Expose an helper to map PCI interrupts
      PCI: hv: Deal with nested MSHV setup


 arch/x86/hyperv/irqdomain.c         |   40 +++++++++++++++++++++++++----------
 arch/x86/include/asm/mshyperv.h     |    2 ++
 drivers/pci/controller/pci-hyperv.c |   11 +++++++++-
 3 files changed, 40 insertions(+), 13 deletions(-)

