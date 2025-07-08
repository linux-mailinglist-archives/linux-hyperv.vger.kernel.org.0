Return-Path: <linux-hyperv+bounces-6137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B14AFC1F5
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 07:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B7162854
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 05:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1911C5D77;
	Tue,  8 Jul 2025 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H+asO4gI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E469D27E;
	Tue,  8 Jul 2025 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951938; cv=none; b=hzwmR4/Le+lGZTieijsWItX+cvD/BMS6tAoxVchg/dOVTfu+4EMP6W3fr/3v4hKqiS1sY16JX08K/l7sKM2Cq0jQZOKSxXvSBz5rlq+tEgkaoXe2cC5tg/Q3ANwImbCWbPPZi1WXgU2Gfk9xIk4VU734C+vJNGS17CJliydo5l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951938; c=relaxed/simple;
	bh=JcOYG6Hytfg+NkHrZdnCZK/IQfIS/aAxcC/abiZubgs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iTEEQKNYOyro6wj9CZl6/rX2mebm0+P96pyNQGm3YzTRzHVppw+hVkyXjQlSmk/oxYPSjkz4U6msy81PedTZ1ZKSRJ+Jy8WukFdH6OnSD9FD/wiBTJoGiYHFFFgqlcqZ3UP4f9Y7HKG00NyWlWxHyXWDmVNHIG3xk2wFqSvAIDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H+asO4gI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-Virtual-Machine.mshome.net (unknown [4.213.232.43])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F0AA211223A;
	Mon,  7 Jul 2025 22:18:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F0AA211223A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751951937;
	bh=PcVVGIxWee6vJPNuB047kSubA6+4khe5hkkwNwV4j/8=;
	h=From:To:Cc:Subject:Date:From;
	b=H+asO4gITmjqmqcv4KeiJWyXnPSR9iUdtnUe8EXwcXuHHIlZ25OBu7VOTnmlOuSOw
	 yOz18go2FcNA9I0RNQaCQw4JxBhFKdMR4dYGLd+GwzNp+Dr2uOtVCVKHimAfSewu3v
	 Gs6cn3U9pBLDaqStIX4sygzhatG1pQ6jaUlbIcV4=
From: Naman Jain <namjain@linux.microsoft.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Roman Kisel <romank@linux.microsoft.com>
Subject: [PATCH] PCI/MSI: Initialize the prepare descriptor by default
Date: Tue,  8 Jul 2025 10:48:48 +0530
Message-Id: <20250708051848.3214-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Plug the default MSI-X prepare descriptor for non-implemented ops by
default to workaround the inability of Hyper-V vPCI module to setup
the MSI-X descriptors properly; especially for dynamically allocated
MSI-X.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/pci/msi/irqdomain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 765312c92d9b..655e99b9c8cc 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -84,6 +84,8 @@ static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
 	} else {
 		if (ops->set_desc == NULL)
 			ops->set_desc = pci_msi_domain_set_desc;
+		if (ops->prepare_desc == NULL)
+			ops->prepare_desc = pci_msix_prepare_desc;
 	}
 }
 

base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
-- 
2.34.1


