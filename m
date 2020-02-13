Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28415B675
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 02:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgBMBP2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Feb 2020 20:15:28 -0500
Received: from gateway31.websitewelcome.com ([192.185.144.219]:33793 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729289AbgBMBP2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Feb 2020 20:15:28 -0500
X-Greylist: delayed 1474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Feb 2020 20:15:27 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 3224F9E3D1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Feb 2020 18:50:53 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22iTj7EBbvBMd22iTj5qLZ; Wed, 12 Feb 2020 18:50:53 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oNtS80ALTefLju8sXnhUYyqruAR8Cl5rZOZKlDdi3/o=; b=O6E89Kl1z/UOh3gllATe8Wi3cR
        x/TDcLBjptHyATw2n2/d70Tr9OQ6VklUFJ3eo1Dch4M/zLSE3I86K4Z0l6QofCllkVSMqjzWASmgb
        mwO7JjC7vu/UR8xY4HZbrhTQv86mqRvXFBL/mpmKOXR6cWHbyz9qEk3s7M/Jq+VIbh1lQ3JAW2fAa
        g00iYXlgXl4PSG+tjDrntzMx2Lnkzp95Ydn0Llxu3ctF2XvNAbFqYBatLgJWt9CqJ/ATAcf/xiRII
        H4X74kdy9YqbtQ6XiZ1gi3NjY7Q2CSLPjW5wSXLL7FvRpazRxUu3ospLuWRT2i6Oyt9RwDmv78VGa
        4dlntZ9w==;
Received: from [200.68.141.42] (port=17629 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22iQ-003lou-MG; Wed, 12 Feb 2020 18:50:51 -0600
Date:   Wed, 12 Feb 2020 18:50:48 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PCI: hv: Replace zero-length array with flexible-array member
Message-ID: <20200213005048.GA9662@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22iQ-003lou-MG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:17629
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 71
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pci/controller/pci-hyperv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9977abff92fc..be957268f9d6 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -260,7 +260,7 @@ struct pci_packet {
 				int resp_packet_size);
 	void *compl_ctxt;
 
-	struct pci_message message[0];
+	struct pci_message message[];
 };
 
 /*
@@ -296,7 +296,7 @@ struct pci_bus_d0_entry {
 struct pci_bus_relations {
 	struct pci_incoming_message incoming;
 	u32 device_count;
-	struct pci_function_description func[0];
+	struct pci_function_description func[];
 } __packed;
 
 struct pci_q_res_req_response {
@@ -508,7 +508,7 @@ struct hv_dr_work {
 struct hv_dr_state {
 	struct list_head list_entry;
 	u32 device_count;
-	struct pci_function_description func[0];
+	struct pci_function_description func[];
 };
 
 enum hv_pcichild_state {
-- 
2.23.0

