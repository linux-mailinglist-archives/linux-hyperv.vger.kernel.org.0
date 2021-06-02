Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A33399161
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Jun 2021 19:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFBRWz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Jun 2021 13:22:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51118 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFBRWy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Jun 2021 13:22:54 -0400
Received: from viremana-dev.fwjladdvyuiujdukmejncen4mf.xx.internal.cloudapp.net (unknown [13.66.132.26])
        by linux.microsoft.com (Postfix) with ESMTPSA id EBA9720B8006;
        Wed,  2 Jun 2021 10:21:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EBA9720B8006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1622654471;
        bh=MlLboQA27FgnDDkz/hKI8tPNjyR0apDJ50rsqtpaKiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ID8iwHwOjVTVtO5Y0phixx1WXFsCBUxx0qkvMRTENadrlS+us0AYPiUXPSt8eGz7x
         W0xz+j7Vbn08CsGmIK0wC+5gKvZL/Y7iMHSnLQGcTInqUxnVspwxubL+cJIzZgbLMo
         jR5zJoS9nNd7N3FPtz3H9GXJHr2Qm+jCLAYHPDnQ=
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
Subject: [PATCH 02/17] drivers: hv: vmbus: Use TLFS definition for VMBUS_MESSAGE_SINT
Date:   Wed,  2 Jun 2021 17:20:47 +0000
Message-Id: <00fe2e0602b31fd40788f6282796774fa2eec6af.1622654100.git.viremana@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use the TLFS definition macro for VMBUS_MESSAGE_SINT

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 drivers/hv/hyperv_vmbus.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 42f3d9d123a1..6edf6f0cee64 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -112,7 +112,7 @@ enum {
 	VMBUS_EVENT_PORT_ID		= 2,
 	VMBUS_MONITOR_CONNECTION_ID	= 3,
 	VMBUS_MONITOR_PORT_ID		= 3,
-	VMBUS_MESSAGE_SINT		= 2,
+	VMBUS_MESSAGE_SINT		= HV_SYNIC_VMBUS_SINT_INDEX,
 };
 
 /*
-- 
2.25.1

