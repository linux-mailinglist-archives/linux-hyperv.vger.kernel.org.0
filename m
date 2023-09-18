Return-Path: <linux-hyperv+bounces-107-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0087A4E0B
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Sep 2023 18:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896AF1C2145D
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Sep 2023 16:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D39210F3;
	Mon, 18 Sep 2023 16:05:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A121360
	for <linux-hyperv@vger.kernel.org>; Mon, 18 Sep 2023 16:05:10 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986F03C13;
	Mon, 18 Sep 2023 09:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695052925; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pvP79mxSIzR8bl+ycoQCPTSq3/RqkpCUNtaGVAn5fqW/LazgJ/6Fi0tMgOmLfqOAFO
    27inCowafwAyXUvq8U3TWiEzsysP1aO898Ece1gvAKPkZemazTyIFDol0qSOnHUKnG3b
    i1cUQEmiyKNcVvfIzKfr/dCzFuPjukZCK+ZC2/bpHjPkcGxfWk0gb6cOANKR5TBdnCYc
    qyT3QpMD/Gq5SA+/Y6GVWubQiLLHlUlJEQApGkCW9ZBDvWB2q02QveRC1PfGzZFd/GLS
    cSupHKWN5Fsfy0q6vJI38JppkoGNyKpxeu3/uDHty7RVBDVLmMEwvtP/YK16M+ZSREv9
    F1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695052925;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yd6kyYrWj6oCQzFKUGHBarpAI0TUx5LPFaSLdyNH3nY=;
    b=Nnp9/8M42n+EdljYtcUUih3JATBJ8wrX2GbOBptWi3F0ylpG6hC/0W/i/1scLHUh6R
    91ldGT9Z7pQ7C504NoYbEgM64OXeoQzHi1sqGjHI4DwMcQ8gTVmVJH3Vp2luk4Io7uZV
    RIlmihk+sfqZoRhrz0A/jHDanFjq5sr3MFya3smPtqZLsTavjj9kfzxZBdP/RiULWuIu
    ij6Mzeyl7nP4kKyWTNbu9h389B0A5GhliVcLKtaueP9bF7KimZc19JR6/5tmaUqlhJJ6
    SRJT7dRtPVAFes/7krIUGz8rvMEIj+hDvCHPRM1F3qRdPTbcnXKo1rNNxILKADCO0aja
    4dfg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695052925;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yd6kyYrWj6oCQzFKUGHBarpAI0TUx5LPFaSLdyNH3nY=;
    b=fUDjsb7ilDKCZPHca3zLwykO/DSnGifRcqDB5uo77H9C3Yva24rxuS2vqXa34EVMsW
    TYDsHdgJUrgQegwlr1Mouj23l8qBo5ohY6VKjhzELfHn+nqNOSK1sZ7Y2pAG29g9ebZq
    WOc3J6EJv9v28ncVPrZ/tPhh6aqtseaWN0bcswLO5prz0ff3OmY+FUU6ewJeervQE23C
    wCf3Byj1OvSY2AwiEYUPjaquEvuKlc/R7/RmtIgpjImU9ZRVOTWq9S3Bl4Giyna6Py87
    JrFf6CcFdQSzcq90EU/DUpYNdKk79/yaSwE8C+rPR+vDQyslZqvoq0IH8ong+gec21nc
    sNpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695052925;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=yd6kyYrWj6oCQzFKUGHBarpAI0TUx5LPFaSLdyNH3nY=;
    b=7oT3j3lZWjQ/Kq1bVlBzamIjnCIecoSDJNXOcpTsnkAKQ6C0S/+aNoxnAuYvtthPx4
    iP5tLxUrs75idd7LsIDg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4wqFn7GpQtMwqaqfdp7uT2JYghpVgZry79i6M1qA=="
Received: from sender
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id C041b2z8IG25yDi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Sep 2023 18:02:05 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1] hyperv: reduce size of ms_hyperv_info
Date: Mon, 18 Sep 2023 18:01:40 +0200
Message-Id: <20230918160141.23465-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Use the hole prior shared_gpa_boundary to store the result of get_vtl.
This reduces the size by 8 bytes.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 include/asm-generic/mshyperv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index cecd2b7bd033..bdee5fbaaf40 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -53,8 +53,8 @@ struct ms_hyperv_info {
 			u32 reserved_b2 : 20;
 		};
 	};
-	u64 shared_gpa_boundary;
 	u8 vtl;
+	u64 shared_gpa_boundary;
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;

