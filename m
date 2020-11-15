Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF02B3938
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Nov 2020 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgKOUqr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Nov 2020 15:46:47 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.206]:22685 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727879AbgKOUqr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Nov 2020 15:46:47 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id D022CE9D
        for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2020 13:57:43 -0600 (CST)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id eO9fkceShAAk4eO9fkAPzz; Sun, 15 Nov 2020 13:57:43 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CcsvbMHn+/SbpDuqZOJKhcdXk5aFt0XA8jSjf4vZeiM=; b=r3Pq4uxrenY5R6h5JHnj8sBYeW
        2svAz818m/O+8Juaqd7Ee6chb2qufsg1QvVBck2BIWZmnf8vddO7CidfjRsmxOJqZ446tcsnUnBbd
        QJF/w+LgBq0dyiGxs4s7DxD1+APdShtuDjS47Xwa2Kbq3iN/FQGSkv6TWKpYG+uk6TCP60MVEO1UU
        JEtXNibh/hIw0BitxLlrwwuqMgodnbuaQqJ9VoK+K3SsI9sokgZO4Mdu4Rfq8Pb6xEB3SxNtqvGn7
        tFTHp+SW9GFYOSNrUtnxRW0w5Q0mbUgFLmsxzdw22s7Eiw5bxbY/su1Ei+WmgEXPzALvq4WcADiTB
        dxC7awqA==;
Received: from 179-197-124-241.ultrabandalargafibra.com.br ([179.197.124.241]:50406 helo=DESKTOP-TKDJ6MU.localdomain)
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1keO9f-000kPb-7R; Sun, 15 Nov 2020 16:57:43 -0300
From:   Matheus Castello <matheus@castello.eng.br>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     sashal@kernel.org, Tianyu.Lan@microsoft.com, decui@microsoft.com,
        mikelley@microsoft.com, sunilmut@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 0/6] Add improvements suggested by checkpatch for vmbus_drv
Date:   Sun, 15 Nov 2020 16:57:28 -0300
Message-Id: <20201115195734.8338-1-matheus@castello.eng.br>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 179.197.124.241
X-Source-L: No
X-Exim-ID: 1keO9f-000kPb-7R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 179-197-124-241.ultrabandalargafibra.com.br (DESKTOP-TKDJ6MU.localdomain) [179.197.124.241]:50406
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 4
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series fixes some warnings edmited by the checkpatch in the file
vmbus_drv.c. I thought it would be good to split each fix into a commit to
help with the review.

Matheus Castello (6):
  drivers: hv: Fix hyperv_record_panic_msg path on comment
  drivers: hv: vmbus: Replace symbolic permissions by octal permissions
  drivers: hv: vmbus: Fix checkpatch LINE_SPACING
  drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
  drivers: hv: vmbus: Fix unnecessary OOM_MESSAGE
  drivers: hv: vmbus: Fix call msleep using < 20ms

 drivers/hv/vmbus_drv.c | 55 +++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

--
2.28.0

