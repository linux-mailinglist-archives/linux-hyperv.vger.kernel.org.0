Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD52EB6AD
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 01:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAFAFp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 19:05:45 -0500
Received: from mail-eopbgr700132.outbound.protection.outlook.com ([40.107.70.132]:53535
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbhAFAFo (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 19:05:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+hTtAmin//dEqN5JYl2eKmSqNbyAG/muqJt0t5Q6c7o4gjR4RrIkvDbdIKXlUkE+zmrS5DtnglR8PpgoLIOyjxCXUdp1/Xa+oCxbffeW8T0219GAJHXErAY/s1zG/rWOGNJsss981HMF7d7h5ltAjFUZ1LS4VLYDH6iM1PUB2A5hynwPtZxMaxrvmedS2HJpKazwBwDpyrbhYvATGxfFJ77zddWLSKzxQ9+2PEBUMa6Im3Exp4JJhMCGDVYyG6M3Up+jb7tnsj+uivwCwCWnjSmcP2dRypQxFE181YWy+MzIMc+FhIIcyFnndgX/GgWYZlNvc8/bt6nnVq5aJyktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDrXPlpXQvhE79pOhKU9w2KN0iAokz7m2iCv9UGV/No=;
 b=Q5VhXoCBKQ5wufPE2JFS+Gxlw+s9avCUDMdBUs/tATXAd0aNBXe45FZVIGmnpYjup/TbO+y1s+WuntoHLj4nDJDSuo9MSacuhITEKlkfFmiLvRuEAxiXJIy2YD9XfjbFTBpRI4iLNuFBnw5OS9jQkWOaGxcoS+1qk13EuihKSFTh4zngXCUnqWijS6W5XtQevAmL9lor13XfpZ9mWOKCEn1nZ1IDMRt7Gy7mWE8O4bBJ0r3VHLpWlsEEvoT4k2DQC2h4j7XmmrHSJSMn2NiBaFwfyvsuCQpJ/SCjVq6wgyu0n+1f7oqirIllsS73+qI7XxwaFLAxJkwbFHmkEhy72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDrXPlpXQvhE79pOhKU9w2KN0iAokz7m2iCv9UGV/No=;
 b=b5tAJyG1mILbf0Go7waqugBHS454NlhYJZS14PgxKTDznIdMfllofuO4KhPmJTT9n67+xrE+lrtQbfzVMdsAJ7KnedvH1QOIfV6r/3tqH0EnCSLX/0CEWVlj68LNlvfeGrKgijZ6jinilJqshBYxraaLOCf5xFbHN+6zUIYF9Ns=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:207:37::26) by
 BL0PR2101MB1043.namprd21.prod.outlook.com (2603:10b6:207:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2; Wed, 6 Jan
 2021 00:05:01 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%8]) with mapi id 15.20.3763.002; Wed, 6 Jan 2021
 00:05:01 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Date:   Tue,  5 Jan 2021 16:04:34 -0800
Message-Id: <20210106000434.5551-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:a:f0e5:a9bf:e220:5e1d]
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:a:f0e5:a9bf:e220:5e1d) by MW4PR04CA0353.namprd04.prod.outlook.com (2603:10b6:303:8a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Wed, 6 Jan 2021 00:05:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28a22d00-c08e-489d-9370-08d8b1d6b653
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1043:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR2101MB10435BE6A22CC5FFB12A2C5DBFD09@BL0PR2101MB1043.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: makbqdd7g+YMQd3Dxe+POtCh0eCgYky5Ri+NOeg+XNwO9kit+JkyAmplaR3T/4DgtZa4cdtWC0hKl6UACgvHYxgsfNotcHGUMeqEcd0Rebay/Y0K0gn2cJQfMDiukvoejgVVLM9xDMe9t/ZUFS13inFypLul3bul6/8eh3xa3NnlZRH8pBaqrQ1o59xQNEnKfJ1Y1TbCnumFvzmB0CDFTLMiWFv8Ji070yIdhDT9r9cLpxgQcnPYJUhmD8wh+jcHGpwd5J/443dSBT9ga9ul/8ITJKyCVve1fCn/c8CCQ/VYkGiaPPBhSyexo0U9tsRFEFSldyTREjL+DJdiSJFmFDfDMq3zXyh6cP3lOFVxH0eekoSPAJIVvRKh1XpVmwUWXOjZCcgSt9QKcGAyUddrhmwAN2gCFLlmO7MXcnZw3tc/FgsOXu8JrT69ZC2oSG9S8jaVbXTyYaH08WoEn4pDLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(186003)(4326008)(36756003)(83380400001)(66556008)(66476007)(1076003)(16526019)(6666004)(2616005)(7696005)(52116002)(107886003)(316002)(3450700001)(6486002)(66946007)(82950400001)(82960400001)(2906002)(8936002)(10290500003)(86362001)(5660300002)(8676002)(966005)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?F7qsLTDml5yt3VXuuaI02w2o8dCdT/oxLkRdTvuUGGfbTWkUYhYf2kvXqfjW?=
 =?us-ascii?Q?jk9Rozmb1tHGGFtr3mFzV3rGupCXZ6gXO6swI/OPbZrkAMmOoHRkoMOV/cBc?=
 =?us-ascii?Q?0Nu32hRaxrkEcgSejExqyZF0jjZtkwo2HXuk/ovbZ1/cDMbm1hpRfTtH7EuM?=
 =?us-ascii?Q?TM3sgVQJBZqjbpzaOIMj5PNw8/AEfy5Ksc+7h8C/zHLJd1lGEh0M/ZuhM3gr?=
 =?us-ascii?Q?jOUUSL7uoB7TixpA0K2nkxUVTKt2YnBgFAyu+iZvArTG2ZuouBw6hqv822G5?=
 =?us-ascii?Q?FipLC3Bfq9tVoaP5r1ygh6emifDwe64dGX/6382uSzv5l5cFT/xYSagoHt84?=
 =?us-ascii?Q?/d6ryq4MhTxehHqFk/HujASg8reYhXilTrJYejqFn6nKdiruLvIamfMedXVV?=
 =?us-ascii?Q?2GQC967pPZYISOUrx4gwSLkR9JlcV3oXMAvI9driW3eEk0OiNxLrhjNqInLV?=
 =?us-ascii?Q?ywctDlHvsPT6BHvfV770gKDqcrzR015WNblEmayZv48WLPKKm41a9lfDKvqV?=
 =?us-ascii?Q?dr/2T5NCFoOjt8HUrDo1zDK1cVWz55WE09UQplJ6X7yZOrESbHUX5UXX7DHB?=
 =?us-ascii?Q?nrrs+5vERkscGFyySzlvMo9e0L/6AZWEUiNVPlcFC+Nyd5ls9vquF5pcpDDa?=
 =?us-ascii?Q?zD3HPbrrqS4ofLw8V8HnhplHAHmTZxnve/2T5GEbaANxf+daSLwUFH20+5nn?=
 =?us-ascii?Q?3N0Z1KDssAzblKU/EU7X2FNXWZO4ozqACqLLK61dEyZfaCjbNRtV8xpxKCc7?=
 =?us-ascii?Q?S/xb3jbXiImbycpElCvncfhQfaMd708k3ti52uF1c+hK+bwkljGZbreT8g+t?=
 =?us-ascii?Q?FuRpnpYJl+4KQxN766FhXLwUiOAILAD7Ms1yUWhR0RvwVnrbP7C5y94PLnMy?=
 =?us-ascii?Q?gsJw3Jy2exbEId5pm+zK6Ikq1l+pB9j5i3WvfqEWI7f2jfNKROHsk2EA900Y?=
 =?us-ascii?Q?aQ4ZZIlhxc+shwD18rtNnB/j1Gc3e/GbGTZVnqBY3VQtmCTDhn413EOOgKC0?=
 =?us-ascii?Q?kjWEkN/Xsza0OGtw2r12LCuoF/eORIa2xIiybePM7kHtlIQ=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 00:05:01.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a22d00-c08e-489d-9370-08d8b1d6b653
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltOo2A6EP+g8EY/KqTQ+BSpURi3KVaI6zRfrcfUL2crJISvs/ieAKEKjKAfyBdVDIS/0tR3ZKtAB9+9Tu3xUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1043
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When a Linux VM runs on Hyper-V, if the host toolstack doesn't support
hibernation for the VM (this happens on old Hyper-V hosts like Windows
Server 2016, or new Hyper-V hosts if the admin or user doesn't declare
the hibernation intent for the VM), the VM is discouraged from trying
hibernation (because the host doesn't guarantee that the VM's virtual
hardware configuration will remain exactly the same across hibernation),
i.e. the VM should not try to set up the swap partition/file for
hibernation, etc.

x86 Hyper-V uses the presence of the virtual ACPI S4 state as the
indication of the host toolstack support for a VM. Currently there is
no easy and reliable way for the userspace to detect the presence of
the state (see https://lkml.org/lkml/2020/12/11/1097).  Add
/sys/bus/vmbus/supported_features for this purpose.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Change in v2:
	Added a "Values:" section
	Updated "Date:"

 Documentation/ABI/stable/sysfs-bus-vmbus |  9 +++++++++
 drivers/hv/vmbus_drv.c                   | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index c27b7b89477c..c8d56389b7be 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -1,3 +1,12 @@
+What:		/sys/bus/vmbus/supported_features
+Date:		Jan 2021
+KernelVersion:	5.11
+Contact:	Dexuan Cui <decui@microsoft.com>
+Description:	Features specific to VMs running on Hyper-V
+Values:		A list of strings.
+		hibernation: the host toolstack supports hibernation for the VM.
+Users:		Daemon that sets up swap partition/file for hibernation
+
 What:		/sys/bus/vmbus/devices/<UUID>/id
 Date:		Jul 2009
 KernelVersion:	2.6.31
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d491fdcee61f..958487a40a18 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -678,6 +678,25 @@ static const struct attribute_group vmbus_dev_group = {
 };
 __ATTRIBUTE_GROUPS(vmbus_dev);
 
+/* Set up bus attribute(s) for /sys/bus/vmbus/supported_features */
+static ssize_t supported_features_show(struct bus_type *bus, char *buf)
+{
+	bool hb = hv_is_hibernation_supported();
+
+	return sprintf(buf, "%s\n", hb ? "hibernation" : "");
+}
+
+static BUS_ATTR_RO(supported_features);
+
+static struct attribute *vmbus_bus_attrs[] = {
+	&bus_attr_supported_features.attr,
+	NULL,
+};
+static const struct attribute_group vmbus_bus_group = {
+	.attrs = vmbus_bus_attrs,
+};
+__ATTRIBUTE_GROUPS(vmbus_bus);
+
 /*
  * vmbus_uevent - add uevent for our device
  *
@@ -1024,6 +1043,7 @@ static struct bus_type  hv_bus = {
 	.uevent =		vmbus_uevent,
 	.dev_groups =		vmbus_dev_groups,
 	.drv_groups =		vmbus_drv_groups,
+	.bus_groups =		vmbus_bus_groups,
 	.pm =			&vmbus_pm,
 };
 
-- 
2.19.1

