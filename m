Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F00A4FB48B
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Nov 2019 17:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKMQCw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 13 Nov 2019 11:02:52 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:21167 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMQCw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 13 Nov 2019 11:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573660970;
        s=strato-dkim-0002; d=aepfle.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=I73G9HN3FlFTa8LqWbK87pCnw61L83mZNnFTq0Yp9x0=;
        b=Z9sWOyY1uQdbrxbpYa831J8UTed15dUWw/62VKQ4oGCHXDjEgrjTATUNcMzaHqqTF+
        7IxBMO3v0rID+XrNBT5sB2pMyx+imDIjOXuLrdIVHCE/SE+RoGKPk+XphU2/nyiaHcLE
        inRXMB6J5sTmDRHcbCLVKdJCJqqJeNAY+2VsOE8QU+mNTfvWbLRe3L/PtuvkrJcb/g4O
        wslf00/bSkqALtvZ846iGBu/63yhAEKCRiwi1ul3cud06NjWhocY16zRou601sKb23eo
        Ba8f6tJnrUISvODIZAS7Zyb/LIqVY+jotQWg3MO1HB7/zA1MCZvsbSY2vSMV1YGthwVv
        /Yvw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS325Pjw=="
X-RZG-CLASS-ID: mo00
Received: from sender
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id 20735bvADG2oGi2
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Nov 2019 17:02:50 +0100 (CET)
From:   Olaf Hering <olaf@aepfle.de>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS)
Cc:     Olaf Hering <olaf@aepfle.de>
Subject: [PATCH v1] tools/hv: add .gitignore
Date:   Wed, 13 Nov 2019 17:02:46 +0100
Message-Id: <20191113160247.26294-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hide build artefacts in "git status" output.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/hv/.gitignore | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/hv/.gitignore

diff --git a/tools/hv/.gitignore b/tools/hv/.gitignore
new file mode 100644
index 000000000000..88b05e35a6e0
--- /dev/null
+++ b/tools/hv/.gitignore
@@ -0,0 +1,3 @@
+hv_fcopy_daemon
+hv_kvp_daemon
+hv_vss_daemon
