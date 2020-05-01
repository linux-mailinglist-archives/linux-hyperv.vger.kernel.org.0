Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D696C1C0DD0
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 May 2020 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgEAFiH (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 1 May 2020 01:38:07 -0400
Received: from mail-eopbgr690131.outbound.protection.outlook.com ([40.107.69.131]:64043
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbgEAFiG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 1 May 2020 01:38:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj6v7ui2SuDIwgibgTbI2Kd71WPqKwFrSNodFmbrsRtrvkA8FdXXvFiuVFtBrQIKvBY7Wg1OvGRRlRN5lhPjKXybOxzJilARcoG5yq8KGIUmBtEbioEByMKJFRSFPfpExjeQAZGdg2LDC56LK+2sUZhYIGqNpwc6KteGgdAGhBL2OiYZYRVQloxJzapVlq2Hc528MrjyNXlHapfG/kc6L7GFB0UYhI3DHv7cnJOEiA1j0hfd5eqnqklZCk6dc+u0zd/MD8knYE7B6hLVZYXGBJJruZmj2mkVIlEWz1grQRMaXAsPw4TVXUXnVplTO3KUXDCs1SWkqB5i4T5TkO95Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKFVlzUIW4xVhlfs4E5qk5bCEg1g3RRToHvxtByxeKU=;
 b=dFQxTpBuMSXL5O3SmGgDByrXtbQ9sCPYDHXxM/5dgEhQJnshbrLY0uifclyEeblNkB9aBsLJwzp/3jVnWvZJTUjpevTtW8ETL0OzD7EXx1pJKmxsTwtBXJnvQBiERPN3dYw67ZSymOOGkWkEoIu7QQN5jLNW1Rr9poyC5e++oOxQm6hNJgzgZzkMJyJZmzbvSOAsGOz8CNOvjzb+E8aROdSGf9yoaAN+0uBozMnam53qoEhj+bi1Q94nj63wupa5idqg+38L3wk7M2FNyxb4FQUQXLhYi0jFOMI5VBhb8pX2CEZFYCwYQHCfnSjpNq3o1BJbcngS4pFIWyuhlqQ7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKFVlzUIW4xVhlfs4E5qk5bCEg1g3RRToHvxtByxeKU=;
 b=SOlYIYKmnEp9TGV9go/sTyFrq2d/SORW5FMoKpMwPhisvuesJPP4BoBNPm0/uPS8hww47n6Oswt4dWHdmsYuUEyW4MXk/nCujJwxjVvNH4yYos7mTamxrcADA264zTnqGECaz9mxMQEmFAxY6ZaFqzqLWDPRIB8JEGnxrPh7gD4=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
 by SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.9; Fri, 1 May
 2020 05:38:02 +0000
Received: from SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55]) by SN6PR2101MB1021.namprd21.prod.outlook.com
 ([fe80::a9e6:4244:f67e:c55%5]) with mapi id 15.20.2979.009; Fri, 1 May 2020
 05:38:02 +0000
From:   Wei Hu <weh@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        decui@microsoft.com, mikelley@microsoft.com
Cc:     Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 2/2] PCI: hv: Retry PCI bus D0 entry when the first attempt failed with invalid device state
Date:   Fri,  1 May 2020 13:37:28 +0800
Message-Id: <20200501053728.24740-1-weh@microsoft.com>
X-Mailer: git-send-email 2.20.1
Reply-To: weh@microsoft.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0601CA0004.apcprd06.prod.outlook.com (2603:1096:3::14)
 To SN6PR2101MB1021.namprd21.prod.outlook.com (2603:10b6:805:8::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weh-g1-u1904d-testwin10.corp.microsoft.com (167.220.255.113) by SG2PR0601CA0004.apcprd06.prod.outlook.com (2603:1096:3::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 05:37:58 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [167.220.255.113]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5314ff8-2513-422f-fd22-08d7ed91d0ab
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1021:|SN6PR2101MB1021:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR2101MB1021AB97DC3E6F52AC9801CBBBAB0@SN6PR2101MB1021.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IryDP4zP+ifU163KqAlPa4YQU6TpqHsF0TJPKEPnMYCdhpkBcX9uvC3drhiva7Uy4Q634Ff4nHT9zQkMqonfxyvQTBCSN1btk1DQhuBzD9mK/eGhd8iyNqQUORlf1PBCke3bU4LByzil2ywuYSvQfYjHekyrQ5wpCOK287TidgtkUqR8Prpn5kh84FC0YCp91SgAn7JEd9DAIkIVjL1NQ1xCO01bIW7cHzkejSBm+M4K7F9hn5w21G7QcUhsXaHNcbuCrp4sSyEclsrsa+CNzt4zfoV/LVbx5WRwxmA+mQyCfokNGH+D3ZVJP+bEA4S6e4LiEqmm0W4TL9VUav8cEnUscYrMBJb2XE2pns2NomNt2Z3hoES/X2jqWU/R+NCnlAcN4s/VZaJfLGIoZO8oaMfvQL8xtCdMPEz9bUJb8vsEm+AjUalmG0I5Cd8vIfvl/lj2MXLP2RgGs+IbmwikI8yhDGv4hwvkn5XqDVsQidE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1021.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(66946007)(66476007)(66556008)(7696005)(82960400001)(52116002)(316002)(4326008)(3450700001)(107886003)(1076003)(2906002)(6636002)(186003)(16526019)(10290500003)(6666004)(8936002)(5660300002)(82950400001)(478600001)(8676002)(6486002)(36756003)(2616005)(26005)(956004)(86362001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FTF4kdtREN+Nxdcmcjzy2ihJLI2R6n6RBQ4VTvS25K/1UjlzjuDO7gKpkL+TMuoJKMETfaZgO5mcpNKx9hrJnCvCy51j2CsAKPeNngfuTrfLA33HSaxKfNgNuY3aqa/bBJWsqX7qwhw6+eTGq8v72lKNRvsCe4U6r4YF2vxb6FmkCGXT+I4RV/lHrQLu8/n8jvRmp1kKXK9d2Z+KNsbYuAXAIZwl2AqEIzA6nfkLelYry9B01XdSQNrJk8RS2p0JxoztvS4gKlTjawKzxzPANW3S6dJ/fQpmpKAzb6uZliQvUBdP/Uy42U/H4B0JJ2vnXC6rM+L4zl3v9eIpJShqQt+po5f3DZJ2KHNWcbSjYl/ah3KyMXwhWDo4uGhJZYSrtPVtucNdxot9SXZCspM+Tvu+eiP+6kXQh1NEe18r77QECi2a0RaVBg76e4gZdm+FY0JC/PbfgZyLOSaFzqPEKVRxaASMC3t7VZsK/68qpc0fHIZgAhQ9bnASbS+k/oe4ZOHGOVLJll7Afn3Nl7qAA2ejF6KcavJiSTn9FFXA+DEZZZ+Fc8q55m52H874NYeWmWBrr6Bw02mvjTJhBKzftb72xTjpcvs742eJEsC8k1r8kMnpllGVVle7N4Y4rLpmy311ZFithsqKwcIfVo5sl+qy3RE/a6C89RhHXpLktqHMVy1jK3GEEfIlOrBVQK8iQCAvGiPpbckPzWP5WDlVQ2FYDJZ8qxCrsgHSdKZjbx1bTWNm5dGXdNKr7E0KoA4fXAM7Y/SFSqi3SOf3zBv+RKwy6pROv4IbUrpB1g5lBXDtXdci0HvF0DF4lxJk/Nov
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5314ff8-2513-422f-fd22-08d7ed91d0ab
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 05:38:02.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzpvR8NFkK5Hlaqbl5S9yhuALfrxnoevU01lmBKJfNiDXUmPeO3TMvydLsmROVCZzsJIgTg+yAsLq2vwQQiyFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1021
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In the case of kdump, the PCI device was not cleanly shut down
before the kdump kernel starts. This causes the initial
attempt of entering D0 state in the kdump kernel to fail with
invalid device state returned from Hyper-V host.
When this happens, explicitly call PCI bus exit and retry to
enter the D0 state.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
   v2: Incorporate review comments from Michael Kelley, Dexuan Cui and
   Bjorn Helgaas

 drivers/pci/controller/pci-hyperv.c | 40 +++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index e6fac0187722..92092a47d3af 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2739,6 +2739,8 @@ static void hv_free_config_window(struct hv_pcibus_device *hbus)
 	vmbus_free_mmio(hbus->mem_config->start, PCI_CONFIG_MMIO_LENGTH);
 }
 
+static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs);
+
 /**
  * hv_pci_enter_d0() - Bring the "bus" into the D0 power state
  * @hdev:	VMBus's tracking struct for this root PCI bus
@@ -2751,8 +2753,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -2779,6 +2783,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	if (ret)
 		goto exit;
 
+	/*
+	 * In certain case (Kdump) the pci device of interest was
+	 * not cleanly shut down and resource is still held on host
+	 * side, the host could return invalid device status.
+	 * We need to explicitly request host to release the resource
+	 * and try to enter D0 again.
+	 */
+	if (comp_pkt.completion_status < 0 && retry) {
+		retry = false;
+
+		dev_err(&hdev->device, "Retrying D0 Entry\n");
+
+		/*
+		 * Hv_pci_bus_exit() calls hv_send_resource_released()
+		 * to free up resources of its child devices.
+		 * In the kdump kernel we need to set the
+		 * wslot_res_allocated to 255 so it scans all child
+		 * devices to release resources allocated in the
+		 * normal kernel before panic happened.
+		 */
+		hbus->wslot_res_allocated = 255;
+
+		ret = hv_pci_bus_exit(hdev, true);
+
+		if (ret == 0) {
+			kfree(pkt);
+			goto enter_d0_retry;
+		}
+		dev_err(&hdev->device,
+			"Retrying D0 failed with ret %d\n", ret);
+	}
+
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -3185,7 +3221,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 	return ret;
 }
 
-static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
+static int hv_pci_bus_exit(struct hv_device *hdev, bool keep_devs)
 {
 	struct hv_pcibus_device *hbus = hv_get_drvdata(hdev);
 	struct {
@@ -3203,7 +3239,7 @@ static int hv_pci_bus_exit(struct hv_device *hdev, bool hibernating)
 	if (hdev->channel->rescind)
 		return 0;
 
-	if (!hibernating) {
+	if (!keep_devs) {
 		/* Delete any children which might still exist. */
 		dr = kzalloc(sizeof(*dr), GFP_KERNEL);
 		if (dr && hv_pci_start_relations_work(hbus, dr))
-- 
2.20.1

