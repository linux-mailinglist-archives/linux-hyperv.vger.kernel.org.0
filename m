Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42F399162
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFBRWz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51126 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0E7CA20B8008;
        Wed,  2 Jun 2021 10:21:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0E7CA20B8008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=bdIspM+906AG35yJz2nnaofawzQEw5MGY/4+8MOQ86M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bij6xm9NyDnauIrKMGbcVZtZcR9yBB6/rODpI4JALU0TXK72SnWSExgSDTZwI2jPb
         iu+h1idV8X14BGDwTjA8YDJEk5nGx2XAZ8lyT7w0QDaaVEcYQ7PJvsM0JkdKmbCz3O
         d/uwFhp+p6CvFrA+w5RRmPA6ATj/7VZRhnO0UnYI=
From:   Vineeth Pillai <viremana@linux.microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH 03/17] acpi: export node_to_pxm
Date:   Wed,  2 Jun 2021 17:20:48 +0000
Message-Id: <021058682b0a386145972c2c7430e7d3958bdc83.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is needed in the next patch in the series for a
code refactor. No intended change in functionality.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/acpi/numa/srat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 6021a1013442..c9e610b4b642 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -48,6 +48,7 @@ int node_to_pxm(int node)
 		return PXM_INVAL;
 	return node_to_pxm_map[node];
 }
+EXPORT_SYMBOL(node_to_pxm);
 
 static void __acpi_map_pxm_to_node(int pxm, int node)
 {
-- 
2.25.1

