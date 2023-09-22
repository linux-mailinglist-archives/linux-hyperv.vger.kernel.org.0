Return-Path: <linux-hyperv+bounces-199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC8B7ABA1C
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 21:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id A5DBE1F2340D
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Sep 2023 19:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2001645F71;
	Fri, 22 Sep 2023 19:31:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B145F68
	for <linux-hyperv@vger.kernel.org>; Fri, 22 Sep 2023 19:31:51 +0000 (UTC)
X-Greylist: delayed 161 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Sep 2023 12:31:49 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A2394;
	Fri, 22 Sep 2023 12:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695410924; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hqw57XLZtkDLU8tskHINx6s05s6dT3HJ2PDb01kxB7u4aGhj37MyVrmBdAtpLsqm9q
    B/Fr2g9wSvBYqbT043zbYDiwkj0Brw2z5XeQ+hUV2nUU4JxAHeZN09sOzbb0Opir+lRc
    EdQn6qVc9DoSPHvtGx5oulk/ToC+Z3rvLWhk5dmyM5f44Sbb7n6Kzl0Vnn9aAr6V3ZJr
    KjhmwRyTmxzN6bfURpTkejXVg7RS9utu+PwBbFeFv62AhF/Q3Ig0hczqP8kB7hZ3vlXg
    zOirTBsRSsIdIeNQjfbZyM/uw0Fj0D8fQRiXG4aD11gGL8l2ZlT3rVEFnT2Zscdad5lW
    dU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695410924;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zk3k328hgovnBCBlDXuQXLcoaZsgP5mLEqng5TkR5JQ=;
    b=n7FHynLHt8a877V/qdEH0TVb466kYjSBKOa2DxYXGIS7WGJwDyKj5nagM7sNKkD9fr
    p59IR/rPzKeK4/1N72bgR6Z2drU+FVHW2Ws/7Tx4RqZx79UtMDHDcAlVsj8hclE1VsnE
    STJFDAE8SBJhijE1bmfY2+mGvFIkEhfy9OcPGNGbtbzrnnVF6qn5rS6Us//Rpv6XqVKz
    stjGelvHqTs83L2LP7HobPWP32QKqy9aRLMq7WgOvSGeskhLJNRsgyWFr0H0u7bJYLjf
    LkmEBUgvGlFqXmCIJFDWl6reVTWFfxYpjsdw8cugVj52+AMkGOLHTnHfDEIz13oj0wBp
    CqXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695410924;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zk3k328hgovnBCBlDXuQXLcoaZsgP5mLEqng5TkR5JQ=;
    b=nl/fH7u6+eOm3Wql3zmZe66L7utnN43GSBmn7WarrEn4dsKKr+nlRWGpAYqz2sQIpw
    Ty2dKfYyfgQZodmTaeFfw0sH1JNfFpKKnkEW1GjvBi6B5nxmRJJadNePgt+mBtVum05r
    dxTn4OPVbx/2RX0RjbdunyJPgfDOZ+5pzf0AHoQlIUT3gzfTWJ3cNiuzrIAj9acVIqY8
    xDFW75wv3HtXmF9xnyMpEQeNgGUaWQI6Vz638FERA9MyY3ibI9Qj0HdMC31voZedEgJh
    ZR9Zg52KKkPMjllnXRG2fjben53vZ/JERBrSpbgv9EMhM0aWSzzeFN9ynvE23Qf6e3mg
    Dd0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695410924;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zk3k328hgovnBCBlDXuQXLcoaZsgP5mLEqng5TkR5JQ=;
    b=aJi8fSp0jDQCL+Ql5tLsPIyOVOM5PP9Obox0IbfK55BLJA+7GG7owagLBhFRUWGGtc
    2cxfafHFPcguif0asEAg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzoZG0ivpswfW93lKL5OLSJeaogTnBaSYHCSFyJtwcJv0YWEnfIN"
Received: from sender
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id C041b2z8MJSiHhR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 22 Sep 2023 21:28:44 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] hyperv: reduce size of ms_hyperv_info
Date: Fri, 22 Sep 2023 21:28:40 +0200
Message-Id: <20230922192840.3886-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the hole prior shared_gpa_boundary to store the result of get_vtl.
This reduces the size by 8 bytes.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
v2: move vtl up, as suggested by Dexuan Cui

 include/asm-generic/mshyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index cecd2b7bd033..430f0ae0dde2 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -36,6 +36,7 @@ struct ms_hyperv_info {
 	u32 nested_features;
 	u32 max_vp_index;
 	u32 max_lp_index;
+	u8 vtl;
 	union {
 		u32 isolation_config_a;
 		struct {
@@ -54,7 +55,6 @@ struct ms_hyperv_info {
 		};
 	};
 	u64 shared_gpa_boundary;
-	u8 vtl;
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;

