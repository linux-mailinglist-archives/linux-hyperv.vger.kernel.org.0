Return-Path: <linux-hyperv+bounces-11624-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gU98EPlQMGqcRQUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11624-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 21:22:33 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A106A6896A5
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 21:22:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=gmrWJfYi;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11624-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11624-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD9AC302E7F0
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jun 2026 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3C33AC0CB;
	Mon, 15 Jun 2026 19:22:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493B2E7374;
	Mon, 15 Jun 2026 19:22:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781551349; cv=none; b=SUrgLgvA8Vx8k4aubNa/k31JQI9bcNnWsYC3gmsjSfPxmI/YaLvrIBxL7cHEuRscMTQZesah+c091fHbGSD7ZjX4B8BPuBhwe//o9QNA6OMdujmyZZvqGuoSCB71C33MWHGvpGIELc1QLcuVxFRFc5zMyuW8XXr/Qd75EpxOuPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781551349; c=relaxed/simple;
	bh=o3F7A/bnAq0XW5a21IEGDfKW43mfbG3ce8tXJR48iAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3gI2W9ACxGcd5MvoPvhIGPwgOQ9ELmvKWqoFwCYVnMgNWUD5zd8EZ/RfapheiBtTKO1amtJ/bZjibYxfrnpioog7G885JsMQWmf+LMx+ya/566y/Ve6dRZ1oBKtuOdoyg5lkF3aOBBAGB+XJPDV75qIuSpgzeeJy38VuNJyzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gmrWJfYi; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJIEdu3289605;
	Mon, 15 Jun 2026 19:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2Ul6nM7ohRVaXLyZbA2q+iy5yeHdJ9qor+CXP+6ek
	8A=; b=gmrWJfYij8KI+pZjeonZXvKhkT14HMHi5Wj2ig/UL7hnV7GYy0D+rz33h
	mXsM7ghGodLChYjlruPtL+hIf1lAghcIiz1arsMQZYOuEoKyo6Hox4E3hacDfqhj
	bUuiPqcStJDdZSKQGiZCFnuvwM1vzAqsu6aNitTChr4HUZ9cyqx4XMYfr9OtUCyq
	vZo8zbiPfBtVaLFMT+LuC8y2FcCnmj7kDQy8m5G2IuyIXj0P31MqlUfARioOfqwS
	PT2arz1Ngt/vh6bCWizwK51FuoVOVr9wvBdCb9dOPxOCIWpzbXdnRGJoPdMBM4L7
	Vp+UHZuCozRCAKI7IutGBNz9uXk2Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nj7yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 19:22:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FJJdcR010461;
	Mon, 15 Jun 2026 19:22:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk00vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 19:22:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FJM4Jh9831074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 19:22:04 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D63C458052;
	Mon, 15 Jun 2026 19:22:03 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DE5658067;
	Mon, 15 Jun 2026 19:22:01 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.247.102])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 19:22:01 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, giovanni.cabiddu@intel.com, alifm@linux.ibm.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        dennis.dalessandro@cornelisnetworks.com, jgg@ziepe.ca, leon@kernel.org,
        vikas.gupta@broadcom.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, michael.chan@broadcom.com,
        pavan.chebbi@broadcom.com, claudiu.manoil@nxp.com,
        vladimir.oltean@nxp.com, wei.fang@nxp.com, xiaoning.wang@nxp.com,
        anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, longli@microsoft.com, richardcochran@gmail.com,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        qat-linux@intel.com (open list:QAT DRIVER),
        linux-crypto@vger.kernel.org (open list:CRYPTO API),
        linux-rdma@vger.kernel.org (open list:HFI1 DRIVER),
        netdev@vger.kernel.org (open list:BROADCOM BNG_EN 800 GIGABIT ETHERNET DRIVER),
        imx@lists.linux.dev (open list:FREESCALE ENETC ETHERNET DRIVERS),
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-hyperv@vger.kernel.org (open list:Hyper-V/Azure CORE AND DRIVERS)
Subject: [RFC PATCH v1] PCI: Remove pcie_flr() and convert all callers to use pcie_reset_flr()
Date: Mon, 15 Jun 2026 12:21:58 -0700
Message-ID: <20260615192200.3489-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a3050de cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=rrdNmPcgNGMj36RtdNMA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNCBTYWx0ZWRfX15D2ERi6K36E
 cfuKhpGulDA1q5GV1D4QABpqX93qm1T2iLTDzg+x2djf44fCjprtYNs/z6Cgxr+9JzS4ZJPUxG/
 bWItgek2EE45W2AKmoHWGBOqz8IbnPY9czT9fZ55OKmhaId3EaEvVqSc7SqjPdf+/EKFIqXnDLa
 GB/CkvFOkhJDMj9DIfnsVMVjgHqJbTYbro+YZnLFWZuLaVxT7IsqPFnD/cTkoRe/NUKTJpHE9UT
 KpGxtCexYwDpp7HVl5zpW5M5JKwWtJNvGxIHHagTUBbN6MF1o8qFpxHPmF9FH4vgObHUAYmuZSp
 OiZ9gdzTUT63mbLuB43NcwvV4PjrpAzNnTWZrb5nAxTzxUe+UP7jZTMDnBX1h/rtYDp8wP21ygC
 KapFBjkV+9up+O9lzChzbcxkZoNRqaRlB/rJki5AWgaRk4cG3NrTWLbMu15U8JvBJrZ6l3I/upp
 DULV8mTLV54wYMit44g==
X-Proofpoint-GUID: 0_j4JWqQX8RSuVA9OmMvQpFslvkDXYKl
X-Proofpoint-ORIG-GUID: fD3CfdWkUO2xFqIwvrcrU9u1pqC9A76p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNCBTYWx0ZWRfXxPPmC5y5Uuy0
 +P87YY4UR8RCkU8E8NytutzriOGmKekg289scdUV2wkw95TKaGVZY+CfgiuwPSpzP9UmhzMzSQO
 K07q5C5Zhu7FmIb2aOvPYnjEWcZvlC8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150204
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11624-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,linux.ibm.com,gondor.apana.org.au,davemloft.net,cornelisnetworks.com,ziepe.ca,broadcom.com,google.com,redhat.com,nxp.com,microsoft.com,gmail.com,lunn.ch,vger.kernel.org,lists.linux.dev,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:giovanni.cabiddu@intel.com,m:alifm@linux.ibm.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:dennis.dalessandro@cornelisnetworks.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:vikas.gupta@broadcom.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:claudiu.manoil@nxp.com,m:vladimir.oltean@nxp.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:bhelgaas@google.com,m:qat-linux@intel.com,m:linux-crypto@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:netdev@vger.kernel.org,m:imx@lists.linux.dev,m:intel-wired-lan@lists.osuosl.org,m:linux-hyperv@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A106A6896A5

The pcie_reset_flr() function includes validation checks to verify FLR
support before performing the reset, while pcie_flr() performs the reset
unconditionally. Having both functions creates unnecessary complexity.

Commit 56f107d7813f ("PCI: Add pcie_reset_flr() with 'probe' argument")
introduced pcie_reset_flr() and removed pcie_has_flr(), converting callers
that previously used the pcie_has_flr() + pcie_flr() to use
pcie_reset_flr() instead. However, it did not convert all pcie_flr()
callers, leaving two different FLR mechanisms in the kernel.

One of the callers of pcie_flr(), the Intel 82599 Virtual Function has a
defect where FLR works despite not advertising FLR support in the PCIe
Device Capability register.  Rather than using pcie_flr() to work around
this, enable the FLR capability bit in devcap via an early quirk. This
allows the device to use the standard pcie_reset_flr() path instead of
requiring a device-specific reset method.

Remove pcie_flr() entirely and convert all remaining callers to
pcie_reset_flr(), ensuring consistent validation across the kernel.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/crypto/intel/qat/qat_common/adf_aer.c |  2 +-
 drivers/infiniband/hw/hfi1/chip.c             |  4 +-
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  4 +-
 .../ethernet/cavium/liquidio/lio_vf_main.c    |  2 +-
 .../ethernet/cavium/liquidio/octeon_mailbox.c |  3 +-
 drivers/net/ethernet/freescale/enetc/enetc.c  |  2 +-
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
 drivers/net/ethernet/microsoft/mana/mana_en.c |  3 +-
 drivers/pci/pci.c                             | 38 ++++++------------
 drivers/pci/quirks.c                          | 40 +++++++++----------
 drivers/ptp/ptp_netc.c                        |  2 +-
 include/linux/pci.h                           |  1 -
 15 files changed, 49 insertions(+), 60 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_aer.c b/drivers/crypto/intel/qat/qat_common/adf_aer.c
index ed01fb9ad74e..a2364a59bc7f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_aer.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL_GPL(adf_reset_sbr);
 
 void adf_reset_flr(struct adf_accel_dev *accel_dev)
 {
-	pcie_flr(accel_to_pci_dev(accel_dev));
+	pcie_reset_flr(accel_to_pci_dev(accel_dev), PCI_RESET_DO_RESET);
 }
 EXPORT_SYMBOL_GPL(adf_reset_flr);
 
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 44c524e45396..9f53d73e5e76 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -14042,7 +14042,7 @@ static int init_chip(struct hfi1_devdata *dd)
 		dd_dev_info(dd, "Resetting CSRs with FLR\n");
 
 		/* do the FLR, the DC reset will remain */
-		pcie_flr(dd->pcidev);
+		pcie_reset_flr(dd->pcidev, PCI_RESET_DO_RESET);
 
 		/* restore command and BARs */
 		ret = restore_pci_variables(dd);
@@ -14054,7 +14054,7 @@ static int init_chip(struct hfi1_devdata *dd)
 
 		if (is_ax(dd)) {
 			dd_dev_info(dd, "Resetting CSRs with FLR\n");
-			pcie_flr(dd->pcidev);
+			pcie_reset_flr(dd->pcidev, PCI_RESET_DO_RESET);
 			ret = restore_pci_variables(dd);
 			if (ret) {
 				dd_dev_err(dd, "%s: Could not restore PCI variables\n",
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_core.c b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
index 68b74eb2c3a2..4aec01f53e54 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_core.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_core.c
@@ -274,7 +274,7 @@ static int bnge_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (is_kdump_kernel()) {
 		pci_clear_master(pdev);
-		pcie_flr(pdev);
+		pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 	}
 
 	rc = bnge_pci_enable(pdev);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 35e1f8f663c7..21f8dcbe671e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16918,7 +16918,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	if (is_kdump_kernel()) {
 		pci_clear_master(pdev);
-		pcie_flr(pdev);
+		pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 	}
 
 	max_irqs = bnxt_get_max_irq(pdev);
@@ -17203,7 +17203,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
 		netif_close(dev);
 
 	if (bnxt_hwrm_func_drv_unrgtr(bp)) {
-		pcie_flr(pdev);
+		pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 		goto shutdown_exit;
 	}
 	bnxt_ptp_clear(bp);
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 43c595f3b84e..7f3557d36341 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -429,7 +429,7 @@ static void octeon_pci_flr(struct octeon_device *oct)
 	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
 			      PCI_COMMAND_INTX_DISABLE);
 
-	pcie_flr(oct->pci_dev);
+	pcie_reset_flr(oct->pci_dev, PCI_RESET_DO_RESET);
 
 	pci_cfg_access_unlock(oct->pci_dev);
 
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
index ad685f5d0a13..be08e213aa9a 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
@@ -260,7 +260,8 @@ static int octeon_mbox_process_cmd(struct octeon_mbox *mbox,
 		dev_info(&oct->pci_dev->dev,
 			 "got a request for FLR from VF that owns DPI ring %u\n",
 			 mbox->q_no);
-		pcie_flr(oct->sriov_info.dpiring_to_vfpcidev_lut[mbox->q_no]);
+		pcie_reset_flr(oct->sriov_info.dpiring_to_vfpcidev_lut[mbox->q_no],
+			       PCI_RESET_DO_RESET);
 		break;
 
 	case OCTEON_PF_CHANGED_VF_MACADDR:
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aa8a87124b10..c1c1b523abb5 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -3635,7 +3635,7 @@ int enetc_pci_probe(struct pci_dev *pdev, const char *name, int sizeof_priv)
 	size_t alloc_size;
 	int err, len;
 
-	pcie_flr(pdev);
+	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(&pdev->dev, err, "device enable failed\n");
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index e108cac8288d..cfccfca1981d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -73,7 +73,7 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
-	pcie_flr(pdev);
+	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 	err = pci_enable_device_mem(pdev);
 	if (err) {
 		dev_err(dev, "device enable failed\n");
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fbe111f849..14b8a90625a8 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5180,7 +5180,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	if (is_kdump_kernel()) {
 		pci_save_state(pdev);
 		pci_clear_master(pdev);
-		err = pcie_flr(pdev);
+		err = pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 		if (err)
 			return err;
 		pci_restore_state(pdev);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 2646ee6f295f..d8796a68094f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8318,7 +8318,7 @@ static void ixgbe_check_for_bad_vf(struct ixgbe_adapter *adapter)
 		if (status_reg != IXGBE_FAILED_READ_CFG_WORD &&
 		    status_reg & PCI_STATUS_REC_MASTER_ABORT) {
 			ixgbe_bad_vf_abort(adapter, vf);
-			pcie_flr(vfdev);
+			pcie_reset_flr(vfdev, PCI_RESET_DO_RESET);
 		}
 	}
 }
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index c9b1df1ed109..e51c1170aba7 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3305,7 +3305,8 @@ static int mana_dealloc_queues(struct net_device *ndev)
 			}
 			if (atomic_read(&txq->pending_sends)) {
 				err =
-				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
+				    pcie_reset_flr(to_pci_dev(gd->gdma_context->dev),
+						   PCI_RESET_DO_RESET);
 				if (err) {
 					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
 						   err,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..878556ea50de 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4321,16 +4321,25 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_wait_for_pending_transaction);
 
 /**
- * pcie_flr - initiate a PCIe function level reset
+ * pcie_reset_flr - initiate a PCIe function level reset
  * @dev: device to reset
+ * @probe: if true, return 0 if device can be reset this way
  *
- * Initiate a function level reset unconditionally on @dev without
- * checking any flags and DEVCAP
+ * Initiate a function level reset on @dev.
  */
-int pcie_flr(struct pci_dev *dev)
+int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
 	int ret;
 
+	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
+		return -ENOTTY;
+
+	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
@@ -4357,28 +4366,7 @@ int pcie_flr(struct pci_dev *dev)
 done:
 	pci_dev_reset_iommu_done(dev);
 	return ret;
-}
-EXPORT_SYMBOL_GPL(pcie_flr);
-
-/**
- * pcie_reset_flr - initiate a PCIe function level reset
- * @dev: device to reset
- * @probe: if true, return 0 if device can be reset this way
- *
- * Initiate a function level reset on @dev.
- */
-int pcie_reset_flr(struct pci_dev *dev, bool probe)
-{
-	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
-		return -ENOTTY;
-
-	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
-		return -ENOTTY;
-
-	if (probe)
-		return 0;
 
-	return pcie_flr(dev);
 }
 EXPORT_SYMBOL_GPL(pcie_reset_flr);
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index caaed1a01dc0..564f581599b8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2019,6 +2019,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_0,	quirk_pc
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXH_1,	quirk_pcie_pxh);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_PXHV,	quirk_pcie_pxh);
 
+#define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
+static void quirk_intel_82599_sfp_virtfn(struct pci_dev *dev)
+{
+	/*
+	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controller-datasheet.pdf
+	 *
+	 * The 82599 supports FLR on VFs, but FLR support is reported only
+	 * in the PF DEVCAP (sec 9.3.10.4), not in the VF DEVCAP (sec 9.5).
+	 * So enable PCI_EXP_DEVCAP_FLR directly without first checking if it is
+	 * supported.
+	 */
+
+	dev->devcap |= PCI_EXP_DEVCAP_FLR;
+}
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF, quirk_intel_82599_sfp_virtfn);
+
 /*
  * Some Intel PCI Express chipsets have trouble with downstream device
  * power management.
@@ -3944,20 +3961,6 @@ DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
  * reset a single function if other methods (e.g. FLR, PM D0->D3) are
  * not available.
  */
-static int reset_intel_82599_sfp_virtfn(struct pci_dev *dev, bool probe)
-{
-	/*
-	 * http://www.intel.com/content/dam/doc/datasheet/82599-10-gbe-controller-datasheet.pdf
-	 *
-	 * The 82599 supports FLR on VFs, but FLR support is reported only
-	 * in the PF DEVCAP (sec 9.3.10.4), not in the VF DEVCAP (sec 9.5).
-	 * Thus we must call pcie_flr() directly without first checking if it is
-	 * supported.
-	 */
-	if (!probe)
-		pcie_flr(dev);
-	return 0;
-}
 
 #define SOUTH_CHICKEN2		0xc2004
 #define PCH_PP_STATUS		0xc7200
@@ -4058,7 +4061,7 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 				      PCI_MSIX_FLAGS_ENABLE |
 				      PCI_MSIX_FLAGS_MASKALL);
 
-	pcie_flr(dev);
+	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 
 	/*
 	 * Restore the configuration information (BAR values, etc.) including
@@ -4070,7 +4073,6 @@ static int reset_chelsio_generic_dev(struct pci_dev *dev, bool probe)
 	return 0;
 }
 
-#define PCI_DEVICE_ID_INTEL_82599_SFP_VF   0x10ed
 #define PCI_DEVICE_ID_INTEL_IVB_M_VGA      0x0156
 #define PCI_DEVICE_ID_INTEL_IVB_M2_VGA     0x0166
 
@@ -4150,7 +4152,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev, bool probe)
 
 	pci_iounmap(dev, bar);
 
-	pcie_flr(dev);
+	pcie_reset_flr(dev, PCI_RESET_DO_RESET);
 
 	return 0;
 }
@@ -4207,7 +4209,7 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 	val = val | HINIC_VF_FLR_PROC_BIT;
 	iowrite32be(val, bar + HINIC_VF_OP);
 
-	pcie_flr(pdev);
+	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 
 	/*
 	 * The device must recapture its Bus and Device Numbers after FLR
@@ -4238,8 +4240,6 @@ static int reset_hinic_vf_dev(struct pci_dev *pdev, bool probe)
 }
 
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
-	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
-		 reset_intel_82599_sfp_virtfn },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M_VGA,
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 94e952ee6990..24bae237926a 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -802,7 +802,7 @@ static int netc_timer_pci_probe(struct pci_dev *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	pcie_flr(pdev);
+	pcie_reset_flr(pdev, PCI_RESET_DO_RESET);
 	err = pci_enable_device_mem(pdev);
 	if (err)
 		return dev_err_probe(dev, err, "Failed to enable device\n");
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..345f0821471a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1468,7 +1468,6 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 int pcie_link_speed_mbps(struct pci_dev *pdev);
 void pcie_print_link_status(struct pci_dev *dev);
 int pcie_reset_flr(struct pci_dev *dev, bool probe);
-int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
-- 
2.43.0


