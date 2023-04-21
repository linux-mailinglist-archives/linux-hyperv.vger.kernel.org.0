Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093FF6EA100
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Apr 2023 03:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjDUBa5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Apr 2023 21:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDUBa4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Apr 2023 21:30:56 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED53AAE;
        Thu, 20 Apr 2023 18:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Itb2AUQzPDkRpnH6UM4S/Q+dSaPYLnM9eVvzrK9piVupdN7Nw1XVuOuMvcOZn5KqKx49o1is3lFiRNdjxwcBaeAxaRgTzatgbgzokipgiwGjQxblmIZjFUM3E+X8zY6QWuhp86AX7MEl69EBzneVfQ/ExC3o0E9NTxs3qWFu2MekjFRsI9aIBpu4qjTqFdBsFBXQoehUdWfKewEtN3VYSlV5Z5oo36g4TxN9gXShU6QaHvSsr3UJUHQLfzGkw+2p8n/umLlsQaZcXzqrHQdmDtFAfQV4FydzeUVU5rXsElZklpHW9k2Rdf4MG2rzRmnYm+2L6fm0MKLQi2g2QsUwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d84u+2yLvgzAvHT2WVxjTNGu3hmoVRlL+sPiDwpVtFI=;
 b=B+iUQmHJeGxLx/gckIh39D9UOt+4sGJ9yo8zSQ69aZFGeEXrjDqWcN6n6Gb2WA4iDFCPOB/VlANe7R5bAb39m7rUzGYcq3P22LNll6ked03o4Fpbbv2+LRxUn8F/1ezAKxzgzdlKvH3A242aQVNN46zjRgN+/E1WHkEGw8fMddSUGC1gf8cwq1UFl1IvByTlt61EQlGvYyM818XYbhK2S+Z3MNrb0uon7qQ4MgZbHHKwDhRAxqxAdQO+RLMifGiw36GdV/oEITaoYzpoOJ1Gi0/lVTyzBxV70ss7JTwlH1RRniNtkDcC5fzrjS49LRVPSDlsAmil3B7LVmmAUwi90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d84u+2yLvgzAvHT2WVxjTNGu3hmoVRlL+sPiDwpVtFI=;
 b=XE6ypfVnM9irrSxDQf6EYlBrTGVGNhbcGBkXI8RBdruhVrAy1+863adW8XDfu7XPHdWYLJ1JZMXmMaKw9flerXWm69KuhIhSlqnAIbqZzByLmQHnAacu1M5LEWrRt4jWWTfSXXES+Ng8TRGNP3z2Qnvz4lpfwMuTYreMpxDTmu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by MW4PR21MB2042.namprd21.prod.outlook.com (2603:10b6:303:11d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Fri, 21 Apr
 2023 01:30:50 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::2a56:2f6e:5e85:3054]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::2a56:2f6e:5e85:3054%5]) with mapi id 15.20.6340.001; Fri, 21 Apr 2023
 01:30:50 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: hv: Replace retarget_msi_interrupt_params with hyperv_pcpu_input_arg
Date:   Thu, 20 Apr 2023 18:30:25 -0700
Message-Id: <20230421013025.17152-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0047.namprd19.prod.outlook.com
 (2603:10b6:930:6::28) To SN6PR2101MB1101.namprd21.prod.outlook.com
 (2603:10b6:805:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1101:EE_|MW4PR21MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 824edf9d-1e93-4571-8f3b-08db420809e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gLl0aLQzuisD5xbx7BEJi9Z93sFJFOiXuKZFw3CVvCxChcPK4i/qcuDYxFahLPfRLuYOcPAcf4zQjmbzpNjXZ5lsrxnHWHfGzQu1Va9ENFPEKcyaEDkh/n6jCK3Y4Mf2poQOfWMzUX/9A5BWFZF9Qvmli/k3QimXYsZIgej1Bhkqv1T1fLYiP1/ayXsxBBWGLH1ad0tEDEpX/Yd53RXvA/pOqW9BbfH+bGSY9m4nYeDAvA98gc+Nfz5nNnjdqqkETy6ohaQsTS83r4/Iswx1O//FY0AJs0qtqcUBTxRCw0G0FBjvhP+nIdPXsD8xHjXz+wwtum8/eKSu9kT6X47N+zUIWUBiDKKuSI3OD19184kfwhGVveXhbWdbSG0X3ByhR24AUJukFovDNnnWPcp3/n0Az/h7Vdc36Ev7roCDwKIDIGoHoQQzsJ+V3KkDNPAZEQUB0d7Ox4jJcO/8QEqbj3YQxWhOEUJ3/LBkUDKIgKLdv6ugSh8Kn2Rrm6hoOsWwKNX03xQZ6TFpVmp/TWviYDYh5nM/laTzoKVebA0Y8Z5J8/pMmae/yC13ruFpx+T8XdJmgKCYTd41mKwErE/RCVS0uigqThsClazJ9FlW/Ksc+Cl6Mx+IQqxy+5JoiTjLxG71BJghke5IR44fvPuKYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199021)(36756003)(4326008)(6636002)(316002)(786003)(66946007)(66476007)(66556008)(52116002)(478600001)(10290500003)(6486002)(6666004)(5660300002)(8936002)(41300700001)(8676002)(2906002)(86362001)(921005)(82950400001)(6512007)(38100700002)(82960400001)(2616005)(6506007)(1076003)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYmEWmNdxg5HZpp+YFNU+ALa9puVERJ0qubsVwfgxy99BvTOOXjCt2c85j0I?=
 =?us-ascii?Q?LN0RbMh8YtuaYSjB2S5JX2PqJi6rVVS1LUl4EXoyD1skpVH9JIB2WB2iyQws?=
 =?us-ascii?Q?O//gNmtkBGLHrnbZbRois9TFHDiwAa3xL0gM9YmFWSJRH8BBA8OFQI1p6Ve+?=
 =?us-ascii?Q?SC98/A4fw26/PkuFFqGZXPz9k5vhz5m8WC5zdbg7vkyeQGNme/ntjtjUEZGL?=
 =?us-ascii?Q?seanbZ5zMhGLf2vwBHYgCEm3Gn77NoEL/WL/4F1YwSBokl2rTqPJuZvmU3yw?=
 =?us-ascii?Q?498++Jkbu9PO1cXkjiGUBMqKhY885VkrsQQVF4dcW7U+fvKy9QCGE06RNBDM?=
 =?us-ascii?Q?wAKJY7HBt52O70BDCkc1uV4hHRZ7tKJUxoNdZoZM16JTC3i/eHc868gpN6qT?=
 =?us-ascii?Q?LmHlkmNQC81/52wCVqbAiyp0c4Laf/+pF/si6M8KlOIR0hXo3bnisaAQTqms?=
 =?us-ascii?Q?zw1e1+Y4KxIE+0+VZ90rpLTk00aBMQxMAblqx1y5NrRtSaZ6jf43DfPs+sFC?=
 =?us-ascii?Q?DwU4/8lPd49nGSPaLYDlsMvxJ5ZOvKzv4U7ehh4qNu5KeLbr90CHjCqXFDdo?=
 =?us-ascii?Q?BK4jOaAKsbobe0QTISKt7G+dII2R323lr/qbAy6pW0/J2oSbqifwj28RFLay?=
 =?us-ascii?Q?W3lMi/dsMtXmQSu4yZG407N4BmElqrgCJ3NYoFL2s6t23/vNpEuWBrGMSGEp?=
 =?us-ascii?Q?B2Uexbez3pnApVoiEP11+ZWvSUrI5pLDNbtLQajeHAdxYRpypHq5E8F+dEQJ?=
 =?us-ascii?Q?1SOEES7uEOntYK/dcQu/mAy0f8V2Nr6PeqDdJY8m8sP1T5biOFBwo/4jmf3q?=
 =?us-ascii?Q?jGp+HJZN+9qRBtgu1Gml1Qf081FL5w1vMS/8mC34DAy3WmlbfRtvneZz9/8j?=
 =?us-ascii?Q?ZzCIHCjAhKST/UPlEUGUecNbVau3APhiEJXmf9/5sswSqdN76W2eAZrb9A2C?=
 =?us-ascii?Q?b5sRes4gmvGyiRhrVd430ILZmwUYTjUe2ryBUI+hnPLOI8n9cOHd2Pxxa90U?=
 =?us-ascii?Q?+GmACGJOng6PU0VJr5j7CqbUsVyc704ENAzVWULjZm4ExTu681718EL4EE6h?=
 =?us-ascii?Q?ZDv9E4Y9nLpr81cxiZPdLDKnQwWr7LSmwmaWz/A4xoCfVJOPWGTCx2/MKgZ+?=
 =?us-ascii?Q?GNgAKbW+U+RNR5SYZkYblKzGx9HFEXPBLcnVN10QJNnbcUJLEdNAEK0zrpcO?=
 =?us-ascii?Q?MHw+C/bQTxos1z5O45eplms8VpClETg21njz9myfKfs34tNJr5xsLHND0r08?=
 =?us-ascii?Q?GEdk6Y/pHsQCjSzsmfLGvdyghNSxttc4Db0SBwUeywSRxWvX5E7aNbH4iv1M?=
 =?us-ascii?Q?qWajua788xonp6PrlNwLVn3IQG5M/HH122TEuuqJldWgrrqqc1I63AM7EVD1?=
 =?us-ascii?Q?Dj3nWFDDcAwd4TV8z1E1lcaifCBCPLuhER9yh/kCCCOxYF1GW3Yuk5ZUFkrc?=
 =?us-ascii?Q?kr5XOlZ3spEbe67J8frMMQbKCfdj5JtGevUKnB+f+6gpnCQxC3jnjEVdavQI?=
 =?us-ascii?Q?7YQo1OCr/ySvXz/m/JDFTuHPAK8m0GOGsUOYhgxEGE/4SpEKDvesIYG2Wx7E?=
 =?us-ascii?Q?+T/chVY7g/5lMD5IMGgPhhn8DsWwvcbGoquzseZ9QdA6rLUnUYdn8H2cOy41?=
 =?us-ascii?Q?K77p816QhxAXDfvvMzxn9D7HkHLMIBKs0g83ihrN2UbO?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824edf9d-1e93-4571-8f3b-08db420809e5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 01:30:50.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: feX62sOMazSvwc7J94qrvtqsCtx8PDPh+yuw8J53iGiqfX6Dh3BK8zw0O8D0SC82HOctaT8W6u0XsI67tvZ4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2042
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

4 commits are involved here:
A (2016): commit 0de8ce3ee8e3 ("PCI: hv: Allocate physically contiguous hypercall params buffer")
B (2017): commit be66b6736591 ("PCI: hv: Use page allocation for hbus structure")
C (2019): commit 877b911a5ba0 ("PCI: hv: Avoid a kmemleak false positive caused by the hbus buffer")
D (2018): commit 68bb7bfb7985 ("X86/Hyper-V: Enable IPI enlightenments")

Patch D introduced the per-CPU hypercall input page "hyperv_pcpu_input_arg"
in 2018. With patch D, we no longer need the per-Hyper-V-PCI-bus hypercall
input page "hbus->retarget_msi_interrupt_params" that was added in patch A,
and the issue addressed by patch B is no longer an issue, and we can also
get rid of patch C.

The change here is required for PCI device assignment to work for
Confidential VMs (CVMs) running without a paravisor, because otherwise we
would have to call set_memory_decrypted() for
"hbus->retarget_msi_interrupt_params" before calling the hypercall
HVCALL_RETARGET_INTERRUPT.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

Changes in v2:
  Fixed the inaccuracy in the commit message (Thanks Michael):
    "Confidential VMs (CVMs)" -> "Confidential VMs (CVMs) running without a paravisor".

  Added Michael's Reviewed-by.

 drivers/pci/controller/pci-hyperv.c | 48 +++++------------------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 337f3b4a04fc0..bc32662c6bb7f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -508,20 +508,11 @@ struct hv_pcibus_device {
 	struct msi_domain_info msi_info;
 	struct irq_domain *irq_domain;
 
-	spinlock_t retarget_msi_interrupt_lock;
-
 	struct workqueue_struct *wq;
 
 	/* Highest slot of child device with resources allocated */
 	int wslot_res_allocated;
 	bool use_calls; /* Use hypercalls to access mmio cfg space */
-
-	/* hypercall arg, must not cross page boundary */
-	struct hv_retarget_device_interrupt retarget_msi_interrupt_params;
-
-	/*
-	 * Don't put anything here: retarget_msi_interrupt_params must be last
-	 */
 };
 
 /*
@@ -645,9 +636,9 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	int_desc = data->chip_data;
 
-	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
+	local_irq_save(flags);
 
-	params = &hbus->retarget_msi_interrupt_params;
+	params = *this_cpu_ptr(hyperv_pcpu_input_arg);
 	memset(params, 0, sizeof(*params));
 	params->partition_id = HV_PARTITION_ID_SELF;
 	params->int_entry.source = HV_INTERRUPT_SOURCE_MSI;
@@ -680,7 +671,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 
 		if (!alloc_cpumask_var(&tmp, GFP_ATOMIC)) {
 			res = 1;
-			goto exit_unlock;
+			goto out;
 		}
 
 		cpumask_and(tmp, dest, cpu_online_mask);
@@ -689,7 +680,7 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 
 		if (nr_bank <= 0) {
 			res = 1;
-			goto exit_unlock;
+			goto out;
 		}
 
 		/*
@@ -708,8 +699,8 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	res = hv_do_hypercall(HVCALL_RETARGET_INTERRUPT | (var_size << 17),
 			      params, NULL);
 
-exit_unlock:
-	spin_unlock_irqrestore(&hbus->retarget_msi_interrupt_lock, flags);
+out:
+	local_irq_restore(flags);
 
 	/*
 	 * During hibernation, when a CPU is offlined, the kernel tries
@@ -3598,35 +3589,11 @@ static int hv_pci_probe(struct hv_device *hdev,
 	bool enter_d0_retry = true;
 	int ret;
 
-	/*
-	 * hv_pcibus_device contains the hypercall arguments for retargeting in
-	 * hv_irq_unmask(). Those must not cross a page boundary.
-	 */
-	BUILD_BUG_ON(sizeof(*hbus) > HV_HYP_PAGE_SIZE);
-
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
 	if (!bridge)
 		return -ENOMEM;
 
-	/*
-	 * With the recent 59bb47985c1d ("mm, sl[aou]b: guarantee natural
-	 * alignment for kmalloc(power-of-two)"), kzalloc() is able to allocate
-	 * a 4KB buffer that is guaranteed to be 4KB-aligned. Here the size and
-	 * alignment of hbus is important because hbus's field
-	 * retarget_msi_interrupt_params must not cross a 4KB page boundary.
-	 *
-	 * Here we prefer kzalloc to get_zeroed_page(), because a buffer
-	 * allocated by the latter is not tracked and scanned by kmemleak, and
-	 * hence kmemleak reports the pointer contained in the hbus buffer
-	 * (i.e. the hpdev struct, which is created in new_pcichild_device() and
-	 * is tracked by hbus->children) as memory leak (false positive).
-	 *
-	 * If the kernel doesn't have 59bb47985c1d, get_zeroed_page() *must* be
-	 * used to allocate the hbus buffer and we can avoid the kmemleak false
-	 * positive by using kmemleak_alloc() and kmemleak_free() to ask
-	 * kmemleak to track and scan the hbus buffer.
-	 */
-	hbus = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	hbus = kzalloc(sizeof(*hbus), GFP_KERNEL);
 	if (!hbus)
 		return -ENOMEM;
 
@@ -3683,7 +3650,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	INIT_LIST_HEAD(&hbus->dr_list);
 	spin_lock_init(&hbus->config_lock);
 	spin_lock_init(&hbus->device_list_lock);
-	spin_lock_init(&hbus->retarget_msi_interrupt_lock);
 	hbus->wq = alloc_ordered_workqueue("hv_pci_%x", 0,
 					   hbus->bridge->domain_nr);
 	if (!hbus->wq) {
-- 
2.25.1

