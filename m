Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC29A9274E
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Aug 2019 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSOoO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Aug 2019 10:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbfHSOoN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Aug 2019 10:44:13 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AD35C057F31
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Aug 2019 14:44:13 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id o13so5332207wrx.20
        for <linux-hyperv@vger.kernel.org>; Mon, 19 Aug 2019 07:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TF+A3q0AGPqtPsFHg+fVpmCHghsk6iALe9Z0fNSb534=;
        b=ReNR5tfH59kQcuIydSVtub2cUTZG4Vam5SToQO+wXMaSpfIvYmMwSWM/asOeQX8g1O
         Vp2QDjRt5vwvU5swMTKcasCaxjeq5Lz4wy5u1ACGy9ttNj1bcouMOY12p31y9Zvr7s/H
         HfAx+a3AhZxz9rfseMiF6Tnl79W2RxDyEVWD5j74YjOE7KnLARHqGFL0T1TKOZ2BWV4Y
         VpET5AwOEcyg/4HDVPkkh12WbTYTSPRYubRqFcizH31tFrkyh34OQXTZktUEKHMu3qrH
         hOPyWwUCHFgiT48+jdx7Ggz0/W3cjLodXcFr6VEPEumJn87NFy1PuvP7Hpk34z0qek4w
         Wd/w==
X-Gm-Message-State: APjAAAVJPh97ya8dWz66JRrN6WX5zqY92Wuoy2WVZWgLA127OBQCQ9IM
        sv2Jocs1b2XNynZT7K3Jd+2712jDc7I689YdFkD7CPMuKQynuHZI2kGe1RdmDZEtZeIynckl//9
        H9nSNqbaGlxXg3Wa6GBh5Vrcg
X-Received: by 2002:a5d:5041:: with SMTP id h1mr29807443wrt.30.1566225851861;
        Mon, 19 Aug 2019 07:44:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyA26JO1FFWwEAiE1hEocCfZzTUcXX4NgdVBXA3fvIQBxVanf3Ieaz/oxscAleno0wwfLc2jw==
X-Received: by 2002:a5d:5041:: with SMTP id h1mr29807411wrt.30.1566225851669;
        Mon, 19 Aug 2019 07:44:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i66sm12621685wmg.2.2019.08.19.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:44:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Tools: hv: kvp: eliminate 'may be used uninitialized' warning
Date:   Mon, 19 Aug 2019 16:44:09 +0200
Message-Id: <20190819144409.13349-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When building hv_kvp_daemon GCC-8.3 complains:

hv_kvp_daemon.c: In function ‘kvp_get_ip_info.constprop’:
hv_kvp_daemon.c:812:30: warning: ‘ip_buffer’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct hv_kvp_ipaddr_value *ip_buffer;

this seems to be a false positive: we only use ip_buffer when
op == KVP_OP_GET_IP_INFO and it is only unset when op == KVP_OP_ENUMERATE.

Silence the warning by initializing ip_buffer to NULL.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index d7e06fe0270e..6d809abaf338 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -809,7 +809,7 @@ kvp_get_ip_info(int family, char *if_name, int op,
 	int sn_offset = 0;
 	int error = 0;
 	char *buffer;
-	struct hv_kvp_ipaddr_value *ip_buffer;
+	struct hv_kvp_ipaddr_value *ip_buffer = NULL;
 	char cidr_mask[5]; /* /xyz */
 	int weight;
 	int i;
-- 
2.20.1

