Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB62E10B9
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Dec 2020 01:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLWANl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Dec 2020 19:13:41 -0500
Received: from mail-bn8nam12on2108.outbound.protection.outlook.com ([40.107.237.108]:26401
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgLWANl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Dec 2020 19:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB0R4zzFu+ayWk73yTktn4evJA6HZJYHPY1+1G1/exZe2WjZr9vHyXNQVfYq1ofyWY8zp/6R0HhjHOI2QPeyJb5ifbE7/BWdDMPhyACOfCZD+L9zC+FDUZEAmplpw7DIBfN+z8MIdOkn8dZF/9f7UqwW7UzYK7BfB7ufGaTA5ZggHcu+9PwFlrYQMtrnzdoDXwZTMsUPwyQm0ddmEg9N7H7onZTKqJ0ScL97in76x2cGcVjFVguCX+jfhzDiMvI4K36oOlrXft2BwF3y6wkCbR2moZdMUcjIC0/6TwHuVTSSxVKgSHETrfbwG7/S6psLzyyX7xL5hlMiCUdorbW8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjnFD9bnKV2w0dKnVj30qkcxtiDXwD0+jEIYTIHUP3A=;
 b=evnF9MmW3Rcj0NTFeLQ9IKnAuK/pHtCgf2XR1oDe0SKbOQfVGED0DL9I+A/XilSXWtSk/1DRIC/AvdW7ISbIs+hjXb7BeS0xU05ccmiXDOJi9EHkhcRuNtZ9CfJ/stDxf0sA5sO1JZ08POLFkOT0mQDR/Hh+D+HOPitcLM9iMdyYxSok2djM9NR6LMTo7hwjQBk46MAow1eslj8mvrVZ1o4wnIe7TZR0yeaT8Ug/wy3NXWBtwBdKMefO7a21Eu8p36bdz9aodaDIxNKw366CFBUPmVALhSwREE6ufOXzNbA3lmacY7AyCiRRifw5koiQj893XQdKxIllt2UXZSCU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjnFD9bnKV2w0dKnVj30qkcxtiDXwD0+jEIYTIHUP3A=;
 b=H/OBqZAJx5xxyrXCAimNF3h76fttT55VI4KioK6tVeRTHVUiV+2QjiOzPmhw+Ih2C8PAoT02DYkXT4LuheMwjCkasMFFvBSIahjlEaj2NhYVRL3R9BNW3LyH6Q7dyJcY+goTSEs6dD6fiqSgtybnr1NwYjoH5hmSmd2QGurSfkY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:207:37::26) by
 BL0PR2101MB0932.namprd21.prod.outlook.com (2603:10b6:207:30::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.6; Wed, 23 Dec
 2020 00:12:53 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::adcd:42ae:1c83:369%7]) with mapi id 15.20.3721.008; Wed, 23 Dec 2020
 00:12:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Drivers: hv: vmbus: Add /sys/bus/vmbus/supported_features
Date:   Tue, 22 Dec 2020 16:12:22 -0800
Message-Id: <20201223001222.30242-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:9:6208:7fb4:4337:2292]
X-ClientProxiedBy: MWHPR1201CA0020.namprd12.prod.outlook.com
 (2603:10b6:301:4a::30) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:37::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:9:6208:7fb4:4337:2292) by MWHPR1201CA0020.namprd12.prod.outlook.com (2603:10b6:301:4a::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 00:12:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc02fc5b-617a-4b31-d617-08d8a6d77df8
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0932:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR2101MB0932A904D2BE582C203C989ABFDE9@BL0PR2101MB0932.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lkMScksywziVBb+6C+V8Jm0QyWtyXL1oMIeIzCt/pSEbg/OLN0Yhw/z499h3pcfgEB7M8MNkrjNzUocPqxJsk24TBVVsf/r6uJur6ktUiCZ9otMVoxlmre3v1s0w9nOfT5IQOY4tj0Y0OO1oT0V9vCDr7bFZY0jDyvJlSWFx1KnPKmNe5V/KLtG22GaSDDPnYAMo1Z/1XcWEV+PDhdM5A0r4EO0+KxEldSK7UkC2Z9Fv5sG69E46APNyWOUE62V9kM4uaaK23ad/5fODBtFFDUbdIZTYMjw7RlFL0IBi/v+VL0MHUhZo8fyiaT1McW7loxQ4yjPplRqfp461qou42rlPHnQ35B40iVmeiCVj86SYrFUnt7KDliH5vMKKLFyy1Rk8kEeSqk7CMoZd7y0ulujIUwVkpxVVtr2gsaRnv1xdvpW5m6CFA0QdsV9+DRIbLLunW6DF9Ebm2KpHCTnExg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(10290500003)(82960400001)(478600001)(2616005)(82950400001)(966005)(66556008)(66946007)(2906002)(1076003)(6666004)(4326008)(86362001)(66476007)(5660300002)(3450700001)(316002)(83380400001)(8936002)(186003)(107886003)(6486002)(36756003)(7696005)(8676002)(16526019)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QLRdKMc5GLrDBjFHb8kB7rgyq1DLyVtsWDxoC9poT06tA23/B1Uk5S+gfehf?=
 =?us-ascii?Q?YeoWAepoFT4prVxDw2PZIWjxZnpLH1yBudK0ffrFBUT34ogA1BUFP5TNt9aI?=
 =?us-ascii?Q?oPDJ4gv+8RquWovz6YZZB1smjENnQ3hJcigdXyMJlUHtepRpByYhUp+2zKMI?=
 =?us-ascii?Q?sRmd7JSdzPAe4J0i6Bqy2rM15K4kQFO9Oqgy9Wnad4Pq3POj0X143jQ8t5KC?=
 =?us-ascii?Q?3BCecOO9WCt+2pgFLteVkrdZGVryJf/sSekg5qEnX1BqbGqXBXFraTgjw40H?=
 =?us-ascii?Q?Cb3YrlUtnoihwxflulUvrJqZtUBEugqxGnmTGeRiBmOrXI4ORd2sAUIgp9dV?=
 =?us-ascii?Q?eqPBhmzfN/aTgTqiFKcl0gd0+3OCFZrSGG3suZtI/PDpSC4Cz281zq8CM0ik?=
 =?us-ascii?Q?eQ2xIobywvo9GfcNgUEfI7NwGiG+xBJpCtQ5I48iy9MQRuCWA88Ql/2FXxuI?=
 =?us-ascii?Q?WfZh2Xc1jlI0vt3YIlOwbz3OVCEZ+NLapHubv1vy3FfkCM39ZBashRouC7BN?=
 =?us-ascii?Q?5DZ/76y4yjbggTU0YMmmJ/XtW7a9Txu8CWECwRby1qLamU3bj6hqSgxbdrqA?=
 =?us-ascii?Q?I2cGAd0e+/Lh1oFuQP/ElFjvWNdGruUBE6NtFINWAgsqNzB53bxJYUwAvd4S?=
 =?us-ascii?Q?AfBGXw5N+Wradpdc68a8+kyu7VFZSwBDKglau39ukIXwn1zCLBSghetXdq9z?=
 =?us-ascii?Q?Tc5XfuDY/jIeldaCre/VdUXAk1hQdoa8nc+I0oZB/CEzVh3g3tyO+348C/Me?=
 =?us-ascii?Q?fXzT6XdY7CLWVRNJZNPKAHYTcI90wSYTpDCvs31sgcLJ+i50P0R82cz7KWRn?=
 =?us-ascii?Q?SyG9rbPSe7ouIQToHkQT+llTft3NiS2bc247s9606pc8a1vRLZ4GcVs1Kd2H?=
 =?us-ascii?Q?H1DR+ygscSloEk7JritofetR7gmAxheVEYTIGCwk5oLCc3FfJRMbMQKTCjZS?=
 =?us-ascii?Q?xEhRH+hI7O+DIyUOw861A89DU1sqZWSMy/4t1B4O2QHdwBSobotcxeL37Dh/?=
 =?us-ascii?Q?tE5mL5+JWQZZqXgYHnFrWyKI7IUAb5bm+lBHuz9zwAKyUz4=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 00:12:53.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: dc02fc5b-617a-4b31-d617-08d8a6d77df8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qB+Kg/2ZWtzc63XJhM+p3hLt/kCGcGRaNtaeV7UJaN5jY+l+VCcDCuIJrOF7RBk3BrHPDtlzB1PsdomS92Q8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0932
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
 Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
 drivers/hv/vmbus_drv.c                   | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index c27b7b89477c..3ba765ae6695 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -1,3 +1,10 @@
+What:		/sys/bus/vmbus/supported_features
+Date:		Dec 2020
+KernelVersion:	5.11
+Contact:	Dexuan Cui <decui@microsoft.com>
+Description:	Features specific to VMs running on Hyper-V
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

