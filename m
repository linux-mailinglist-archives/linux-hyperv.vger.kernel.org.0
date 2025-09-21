Return-Path: <linux-hyperv+bounces-6968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72239B8DF46
	for <lists+linux-hyperv@lfdr.de>; Sun, 21 Sep 2025 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2577216712F
	for <lists+linux-hyperv@lfdr.de>; Sun, 21 Sep 2025 16:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795A213E7A;
	Sun, 21 Sep 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y+fkZzDM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601F1B7F4;
	Sun, 21 Sep 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758471365; cv=none; b=AsmNqJCBeICijMLeRHesipbIL28RH7CeyOzSGSpdGMs95cDWKt+KFJ6OCADjvnUheEp08t8IZzIT0lgISGUOW5nmT7XQfMas1xxwOIhELLYgZ1sGypoziTJIdD/1xc2kSgbi+JcjwGjen8kUtKDyMtwRg1VJtNcGcVTBpKHqu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758471365; c=relaxed/simple;
	bh=BXNTdIu/HuKliIIZrJb95YqqbOr5ZDBQFxKEGrAWlXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eH1Yu16Q4pYv7leKhm+D7VTIzLT1L8jnn3cqcixHTwJjgwDDewqg64iSuJtjaW6fb/0hzAjbZf3IGb/hj7wpWKV4dB79/kaUVeMDgvQVijeSila/6QfY/RWWfc8jndvuKtTMtlPsgqRiA2bcy4NxBoJRVR4ZoYp+7m0YXVDPU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y+fkZzDM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LFmQqb016374;
	Sun, 21 Sep 2025 16:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=X6MABP9tiU0aFptJdMUuo2CJNl4k0
	E947uMCZ27uwQs=; b=Y+fkZzDM25py2WOpoDa1x9Lv/6+9mqDK/eAZX3rTvqiZJ
	NXkw0/wkOeJpQAJmJxYTz9mrsIY05hy1m7GRwN1EOIhjWUzui0vdezMDgLCUh9jJ
	YkINAmjHCECDl+sTNERoh/47uJMqpiqEGE9VaxDPJUfEx/MSmKArTiALXbevUFTL
	zcoZJP+NH1wM3zQmpCFyUAa7Ow3Kn3SFCK+giXBwlLyhoWqHGeYpYAEvinfiZrf7
	kGb706xFLJQpzvpmDuLbqImwNZlqVnZR+EmuXt7MZykSpFBxI2yA5Wi4Gh6H/22s
	smAWZFYIK4q6wd0yFcOPHzPGV9dNFOiGGGFFX+Ysg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvts4bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 16:14:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58LEYP5r002154;
	Sun, 21 Sep 2025 16:14:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq5y2fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Sep 2025 16:14:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58LGEdIX003470;
	Sun, 21 Sep 2025 16:14:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 499jq5y2fc-1;
	Sun, 21 Sep 2025 16:14:39 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: thomas.petazzoni@bootlin.com, pali@kernel.org, lpieralisi@kernel.org,
        kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
        bhelgaas@google.com, joyce.ooi@intel.com, alyssa@rosenzweig.io,
        maz@kernel.org, jim2101024@gmail.com, florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, rjui@broadcom.com,
        sbranden@broadcom.com, ryder.lee@mediatek.com,
        jianjun.wang@mediatek.com, sergio.paracuellos@gmail.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        shawn.lin@rock-chips.com, heiko@sntech.de, michal.simek@amd.com,
        bharat.kumar.gogada@amd.com, will@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        linus.walleij@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, rric@kernel.org, nirmal.patel@linux.intel.com,
        toan@os.amperecomputing.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH RFC] PCI: Convert devm_pci_alloc_host_bridge() users to error-pointer returns
Date: Sun, 21 Sep 2025 09:14:07 -0700
Message-ID: <20250921161434.1561770-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509210167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfXzlPYwnoKCGVY
 wXTxp4g9DKp1B6/Qn/FmIu692T4MTNh8Q/XcBP0jS6VkmnypNDCobfp1wRAzlEH0MNHHMy+FkkJ
 ippEn4viHCC/n4yo80jYs/l/3WJIbxgoX1HvUBgsCIua/R71016woVSCjPoazuec+49tJd9QOjf
 Gek4xSfdkgBD+8r/xE06K5gvDIPtYHrHoVBgD8ciQ1xtdE4xZpOrn8/Pm0ng0b41k1IW0Qi2B05
 G2O9abfXgLTNSgqSpg9wfhr8wu+fCeFFmo8qHZA8XvWGLn2In4s00FNm2lB+C3UabL+QVcRK/z8
 zV9w4LnkSDz9RlqzIEh8FO+DdwjMD5cF3SxVEtA9cB4tTtZq7EqZ5VvyOJnVO2y66W7UtPjOtJO
 Hm7izmtB
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d02471 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=zziB279VngeVmd15e9YA:9
X-Proofpoint-GUID: uKjH41pSl18bL479v-94jj5_JFtLEnSg
X-Proofpoint-ORIG-GUID: uKjH41pSl18bL479v-94jj5_JFtLEnSg

devm_pci_alloc_host_bridge() and pci_alloc_host_bridge() previously
returned NULL on failure, forcing callers to special-case NULL handling
and often hardcode -ENOMEM as the error.

This series updates devm_pci_alloc_host_bridge() to consistently return
error pointers (ERR_PTR) with the actual error code, instead of NULL.
All callers across PCI host controller drivers are updated to use
IS_ERR_OR_NULL()/PTR_ERR() instead of NULL checks and hardcoded -ENOMEM.

Benefits:
  - Standardizes error handling with Linux kernel ERR_PTR()/PTR_ERR()
    conventions.
  - Ensures that the actual error code from lower-level helpers is
    propagated back to the caller.
  - Removes ambiguity between NULL and error pointer returns.

Touched drivers include:
 cadence (J721E, cadence-plat)
 dwc (designware, qcom)
 mobiveil (layerscape-gen4, mobiveil-plat)
 aardvark, ftpci100, ixp4xx, loongson, mvebu, rcar, tegra, v3-semi,
 versatile, xgene, altera, brcmstb, iproc, mediatek, mt7621, xilinx,
 plda, and others

This patch updates error handling across these host controller drivers
 so that callers consistently receive ERR_PTR() instead of NULL.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 arch/mips/pci/pci-xtalk-bridge.c                       | 4 ++--
 drivers/pci/controller/cadence/pci-j721e.c             | 4 ++--
 drivers/pci/controller/cadence/pcie-cadence-plat.c     | 4 ++--
 drivers/pci/controller/dwc/pcie-designware-host.c      | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom.c                 | 4 ++--
 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c | 4 ++--
 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c   | 4 ++--
 drivers/pci/controller/pci-aardvark.c                  | 4 ++--
 drivers/pci/controller/pci-ftpci100.c                  | 4 ++--
 drivers/pci/controller/pci-host-common.c               | 4 ++--
 drivers/pci/controller/pci-hyperv.c                    | 4 ++--
 drivers/pci/controller/pci-ixp4xx.c                    | 4 ++--
 drivers/pci/controller/pci-loongson.c                  | 4 ++--
 drivers/pci/controller/pci-mvebu.c                     | 4 ++--
 drivers/pci/controller/pci-rcar-gen2.c                 | 4 ++--
 drivers/pci/controller/pci-tegra.c                     | 4 ++--
 drivers/pci/controller/pci-v3-semi.c                   | 4 ++--
 drivers/pci/controller/pci-versatile.c                 | 4 ++--
 drivers/pci/controller/pci-xgene.c                     | 4 ++--
 drivers/pci/controller/pcie-altera.c                   | 4 ++--
 drivers/pci/controller/pcie-brcmstb.c                  | 4 ++--
 drivers/pci/controller/pcie-iproc-bcma.c               | 4 ++--
 drivers/pci/controller/pcie-iproc-platform.c           | 4 ++--
 drivers/pci/controller/pcie-mediatek-gen3.c            | 4 ++--
 drivers/pci/controller/pcie-mediatek.c                 | 4 ++--
 drivers/pci/controller/pcie-mt7621.c                   | 4 ++--
 drivers/pci/controller/pcie-rcar-host.c                | 4 ++--
 drivers/pci/controller/pcie-rockchip-host.c            | 4 ++--
 drivers/pci/controller/pcie-xilinx-cpm.c               | 4 ++--
 drivers/pci/controller/pcie-xilinx-dma-pl.c            | 4 ++--
 drivers/pci/controller/pcie-xilinx-nwl.c               | 4 ++--
 drivers/pci/controller/pcie-xilinx.c                   | 4 ++--
 drivers/pci/controller/plda/pcie-plda-host.c           | 4 ++--
 drivers/pci/probe.c                                    | 8 ++++----
 34 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
index e00c38620d14..c2c8ed8ecac1 100644
--- a/arch/mips/pci/pci-xtalk-bridge.c
+++ b/arch/mips/pci/pci-xtalk-bridge.c
@@ -636,8 +636,8 @@ static int bridge_probe(struct platform_device *pdev)
 	pci_set_flags(PCI_PROBE_ONLY);
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*bc));
-	if (!host) {
-		err = -ENOMEM;
+	if (IS_ERR_OR_NULL(host)) {
+		err = PTR_ERR(host);
 		goto err_remove_domain;
 	}
 
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 6c93f39d0288..3b8afaef21a6 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -475,8 +475,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
-		if (!bridge)
-			return -ENOMEM;
+		if (IS_ERR_OR_NULL(bridge))
+			return PTR_ERR(bridge);
 
 		if (!data->byte_access_allowed)
 			bridge->ops = &cdns_ti_pcie_host_ops;
diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers/pci/controller/cadence/pcie-cadence-plat.c
index 0456845dabb9..7570cb5998f6 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
@@ -66,8 +66,8 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
-		if (!bridge)
-			return -ENOMEM;
+		if (IS_ERR_OR_NULL(bridge))
+			return PTR_ERR(bridge);
 
 		rc = pci_host_bridge_priv(bridge);
 		rc->pcie.dev = dev;
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..b2b99f275c19 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -467,8 +467,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	raw_spin_lock_init(&pp->lock);
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pp->bridge = bridge;
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e..34d35c925c62 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1809,8 +1809,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		struct pci_config_window *cfg;
 
 		bridge = devm_pci_alloc_host_bridge(dev, 0);
-		if (!bridge) {
-			ret = -ENOMEM;
+		if (IS_ERR_OR_NULL(bridge)) {
+			ret = PTR_ERR(bridge);
 			goto err_pm_runtime_put;
 		}
 
diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
index 4919b27eaf44..f9ebefc71be3 100644
--- a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
+++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
@@ -207,8 +207,8 @@ static int __init ls_g4_pcie_probe(struct platform_device *pdev)
 	}
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	mv_pci = &pcie->pci;
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
index c5bb87ff6d9a..9d2e3b0bc866 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -27,8 +27,8 @@ static int mobiveil_pcie_probe(struct platform_device *pdev)
 
 	/* allocate the PCIe port */
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->rp.bridge = bridge;
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e34bea1ff0ac..4b75a451efe4 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1740,8 +1740,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	int ret, irq;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct advk_pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 28e43831c0f1..0618d70fbdda 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -419,8 +419,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	u32 val;
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*p));
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	host->ops = &faraday_pci_ops;
 	p = pci_host_bridge_priv(host);
diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 810d1c8de24e..28c5d55062ed 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -60,8 +60,8 @@ int pci_host_common_init(struct platform_device *pdev,
 	struct pci_config_window *cfg;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	of_pci_check_probe_only();
 
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index d2b7e8ea710b..0b88e396c323 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3759,8 +3759,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
index acb85e0d5675..422ec30757ee 100644
--- a/drivers/pci/controller/pci-ixp4xx.c
+++ b/drivers/pci/controller/pci-ixp4xx.c
@@ -528,8 +528,8 @@ static int __init ixp4xx_pci_probe(struct platform_device *pdev)
 	int i;
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*p));
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	host->ops = &ixp4xx_pci_ops;
 	p = pci_host_bridge_priv(host);
diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index bc630ab8a283..b832d79faf52 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -326,8 +326,8 @@ static int loongson_pci_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
-	if (!bridge)
-		return -ENODEV;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	priv = pci_host_bridge_priv(bridge);
 	priv->pdev = pdev;
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index a72aa57591c0..c0fd8efaf540 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1456,8 +1456,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	int num, i, ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct mvebu_pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/controller/pci-rcar-gen2.c
index d29866485361..845347e0317e 100644
--- a/drivers/pci/controller/pci-rcar-gen2.c
+++ b/drivers/pci/controller/pci-rcar-gen2.c
@@ -284,8 +284,8 @@ static int rcar_pci_probe(struct platform_device *pdev)
 	void __iomem *reg;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*priv));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	priv = pci_host_bridge_priv(bridge);
 	bridge->sysdata = priv;
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 467ddc701adc..dc45692e9906 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2568,8 +2568,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(host);
 	host->sysdata = pcie;
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 460a825325dd..6f1f82e4228d 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -715,8 +715,8 @@ static int v3_pci_probe(struct platform_device *pdev)
 	int ret;
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*v3));
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	host->ops = &v3_pci_ops;
 	v3 = pci_host_bridge_priv(host);
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index e9a6758fe2c1..b367c17db667 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -72,8 +72,8 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	versatile_pci_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(versatile_pci_base))
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index b95afa35201d..3b3a6e08d17b 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -622,8 +622,8 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 				     "MSI driver not ready\n");
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	port = pci_host_bridge_priv(bridge);
 
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 3dbb7adc421c..92f976bea8ef 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -995,8 +995,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	const struct altera_pcie_data *data;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9afbd02ded35..c683418c176c 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1874,8 +1874,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	data = of_device_get_match_data(&pdev->dev);
 	if (!data) {
diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
index 99a99900444d..d2adc4162a6c 100644
--- a/drivers/pci/controller/pcie-iproc-bcma.c
+++ b/drivers/pci/controller/pcie-iproc-bcma.c
@@ -39,8 +39,8 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 
diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 0cb78c583c7e..8f6843ce573e 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -46,8 +46,8 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 97147f43e41c..e3e908236238 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1175,8 +1175,8 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(host);
 
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 24cc30a2ab6c..7a2c74996ace 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1083,8 +1083,8 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!host)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(host);
 
diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
index 01ead2f92e87..9dfa5075b980 100644
--- a/drivers/pci/controller/pcie-mt7621.c
+++ b/drivers/pci/controller/pcie-mt7621.c
@@ -480,8 +480,8 @@ static int mt7621_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->dev = dev;
diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index fe288fd770c4..47500ed59608 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -952,8 +952,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	host = pci_host_bridge_priv(bridge);
 	pcie = &host->pcie;
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..225a5200f7a6 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -934,8 +934,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rockchip));
-	if (!bridge)
-		return -ENOMEM;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	rockchip = pci_host_bridge_priv(bridge);
 
diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
index d38f27e20761..1c14c5328ae0 100644
--- a/drivers/pci/controller/pcie-xilinx-cpm.c
+++ b/drivers/pci/controller/pcie-xilinx-cpm.c
@@ -574,8 +574,8 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
-	if (!bridge)
-		return -ENODEV;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	port = pci_host_bridge_priv(bridge);
 
diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
index b037c8f315e4..0e68026671b8 100644
--- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
+++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
@@ -771,8 +771,8 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
-	if (!bridge)
-		return -ENODEV;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	port = pci_host_bridge_priv(bridge);
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 05b8c205493c..a23f5e677c17 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -834,8 +834,8 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	int err;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENODEV;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	platform_set_drvdata(pdev, pcie);
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 937ea6ae1ac4..7631af1ef6af 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -574,8 +574,8 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENODEV;
+	if (IS_ERR_OR_NULL(bridge))
+		return PTR_ERR(bridge);
 
 	pcie = pci_host_bridge_priv(bridge);
 	mutex_init(&pcie->map_lock);
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 8e2db2e5b64b..28d638067adc 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -598,8 +598,8 @@ int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
 				     "failed to map config memory\n");
 
 	bridge = devm_pci_alloc_host_bridge(dev, 0);
-	if (!bridge)
-		return dev_err_probe(dev, -ENOMEM,
+	if (IS_ERR_OR_NULL(bridge))
+		return dev_err_probe(dev, PTR_ERR(bridge),
 				     "failed to alloc bridge\n");
 
 	if (port->host_ops && port->host_ops->host_init) {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca7..e627f36b7683 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -686,18 +686,18 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
 
 	bridge = pci_alloc_host_bridge(priv);
 	if (!bridge)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	bridge->dev.parent = dev;
 
 	ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
 				       bridge);
 	if (ret)
-		return NULL;
+		return ERR_PTR(ret);
 
 	ret = devm_of_pci_bridge_init(dev, bridge);
 	if (ret)
-		return NULL;
+		return ERR_PTR(ret);
 
 	return bridge;
 }
@@ -3198,7 +3198,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	bridge->dev.parent = parent;
 
-- 
2.50.1


