Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11DD3639B
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 20:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfFESvU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 14:51:20 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35959 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFESvT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 14:51:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so15364321pfm.3
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Jun 2019 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avnH/rTOKRMkgxFUDWDVsgJ2ihOT3G2xoITfG7gj3qA=;
        b=LJvajUz6kOCmKIvRa9mXKVaL4E/MUcumUj4nqHD4mOVPjPVTDcK5v/F44sicMM0qnE
         RYsFTKA7+88OCVGnQYWS2hFkJ3MwQFPuX+Xx07GJTqk/72ka5RI6RTUKV/7Wk4njlK27
         1aZPOSx1/q01z8mvg52O2XTg1t6blV5QxgB/4n/vlJQuo6zd65XuLpkaja6u94YS1XWk
         EgWGXhehBde80hiZiS40uTuXtqziiMFotJXXtZuNGSCP5fZTgGSAN4U/5ssOq356KhNu
         YUPkuf/NAOLOm5vzVu0hK3289JQJSccDlrD36EQ20hFSotnx+rvKNPUEK73oVWKmqXX9
         mURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avnH/rTOKRMkgxFUDWDVsgJ2ihOT3G2xoITfG7gj3qA=;
        b=A0keoLAkBZbbXI7eczfFiG4nj6HgeIfRQAJCbKyGCy0x56xQxw7kM6/yP1AayzF7TC
         mzKpvqxJnfw8xMzrA57lgylQwTF/4Xlb2sk+rtmHCNfev8xCdppMHOpku9Fc/CwPwo96
         /FGjxbFBYDk6vigRAldHEZQ3K27Ugh5tMRGGrcnYK2OnlhuQusFNjjo/p7FNEZTiQDHp
         9D0yT+l1DXkuR5Ee8ET+/lv5fiJjESGs74yzxgznyE1MhqwGF8m7KsdLDuES49hu/6nj
         4KttF/c3Hk8ULz1pItMR3p4NJrMqUChBHFjyaIBh6ycD4W5eS2EQ/iEQrbwUHAmoWo9z
         4azw==
X-Gm-Message-State: APjAAAWLSJ4n09Nf7j3z/it8l6T7K83IsTXYziJbQwzO1US4/X5fMPKs
        NB+PQq+hftVqcx6k3tGRDbSDXQ==
X-Google-Smtp-Source: APXvYqyV/VN+NomYp9iM62pXrywv+7KniaTRJNmOSaONG6DQ0PAUNDOq/b6pUKqKobKqIXPFxCEkxg==
X-Received: by 2002:a62:7990:: with SMTP id u138mr4592791pfc.191.1559760679194;
        Wed, 05 Jun 2019 11:51:19 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id l7sm27713688pfl.9.2019.06.05.11.51.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 11:51:18 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     netdev@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH] revert async probing of VMBus network devices.
Date:   Wed,  5 Jun 2019 11:51:14 -0700
Message-Id: <20190605185114.12456-1-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Doing asynchronous probing can lead to reordered network device names.
And because udev doesn't have any useful information to construct a
persistent name, this causes VM's to sporadically boot with reordered
device names and no connectivity.

This shows up on the Ubuntu image on larger VM's where 30% of the
time eth0 and eth1 get swapped.

Note: udev MAC address policy is disabled on Azure images
because the netvsc and PCI VF will have the same mac address.

Fixes: af0a5646cb8d ("use the new async probing feature for the hyperv drivers")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/net/hyperv/netvsc_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 06393b215102..1a2c32111106 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2411,9 +2411,6 @@ static struct  hv_driver netvsc_drv = {
 	.id_table = id_table,
 	.probe = netvsc_probe,
 	.remove = netvsc_remove,
-	.driver = {
-		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-	},
 };
 
 /*
-- 
2.20.1

