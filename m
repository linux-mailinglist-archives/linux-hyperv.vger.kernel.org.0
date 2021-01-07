Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531AC2EC7CC
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Jan 2021 02:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbhAGBrL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 20:47:11 -0500
Received: from mail-dm6nam12on2102.outbound.protection.outlook.com ([40.107.243.102]:62913
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725822AbhAGBrL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 20:47:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhq2QZJ/uhbF+x060iNeJHnQI6xepv82DGytl/0ug4AwoQ0KAv6+FDZII5DHU2S31bE6bkg/zlKwF+YecLgRPEHLvLAZZOzJ2HlZ5LkmheQk7cf2dNu2W2nTnOULd+MUxYLLxA4f1OOvEULc2DMf8RYaONzGz6n8QOti4WMgQC2nIHSUhevphupnVIs66MkHN2EwyqxZ08EpRlsre2RbhFUGn25q/rHLUKet7asnxl7LJpliVJua698TaMRvy/vCu66RQ0fbsugJfiOhshlZkYRVOBPd28CiwWb1ReTGeKhZ0qmu9twv2c2LOK03xdt0ms826YGyURJD1JxLSzJX/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRUi6ve3j+3dDadQ0TORDv/AbrflFw+kGN6SMtTSwRU=;
 b=VOkUHYz0+oXJDGAOrpr2yVJbyAddsI5DpjwDnZTxs2txCJ+FcfapOf2ILhuat9Y10PQQP7xl3DdcZZ6HpVXlZumlbTzXSJL7XhYuCBMg7jLX9zVVoLcmxw2wBJHEd2r5IOO7rtv950OhLndamwbLam/QIHkAHJ34jI0EHJPHyK78MpUObIpptYi0NxJHTN8blb1csh5TS2RTYZHOoqJXOiMU+iMylSmWyE3dNScD+Gg5bsxBY9D4AtlBBO+EOjx364ivxoTSygWBnLevFyU5oBS4+SxE4+hcJHkktj7iGEL9KrwoSjTNlA/i7KAWHurp8fOj3Osga60lRRO+0frMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRUi6ve3j+3dDadQ0TORDv/AbrflFw+kGN6SMtTSwRU=;
 b=CaSHik79FGVzTILjYkIcdDtAenwWqv7Zteu0FL37wTvHJZur4ue0X/NEvRD97NSpBZqYSqWUq2ETsnfPHsuHkfwcSRlydNoV9G3trq1kJ7LWAjzdlIADbJ+madYUrzWZmXpjCXaVSipgTFHcs/2OL1O+DZW6ZLcdyKftqoukq7U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from (2603:10b6:4:a2::17) by
 DM5PR2101MB0997.namprd21.prod.outlook.com (2603:10b6:4:a8::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Thu, 7 Jan 2021 01:46:23 +0000
Received: from DM5PR2101MB1095.namprd21.prod.outlook.com
 ([fe80::8848:d9d:cfb:d941]) by DM5PR2101MB1095.namprd21.prod.outlook.com
 ([fe80::8848:d9d:cfb:d941%5]) with mapi id 15.20.3763.002; Thu, 7 Jan 2021
 01:46:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikelley@microsoft.com,
        vkuznets@redhat.com, marcelo.cerri@canonical.com
Cc:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3] Drivers: hv: vmbus: Add /sys/bus/vmbus/hibernation
Date:   Wed,  6 Jan 2021 17:45:52 -0800
Message-Id: <20210107014552.14234-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-Originating-IP: [2001:4898:80e8:7:585a:fb33:5490:4e5]
X-ClientProxiedBy: CO2PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:104:4::28) To DM5PR2101MB1095.namprd21.prod.outlook.com
 (2603:10b6:4:a2::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from decui-u1804.corp.microsoft.com (2001:4898:80e8:7:585a:fb33:5490:4e5) by CO2PR04CA0174.namprd04.prod.outlook.com (2603:10b6:104:4::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 01:46:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3a496347-a1c9-4058-95fd-08d8b2ae0a22
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0997:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR2101MB099720308143B33829E77054BFAF9@DM5PR2101MB0997.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3G5WD6lOjwpEscQQB0LecWIIoVK5STzuR7jQrUWnc2kkDmTxFx7j8Vx3Pj+D9dHhJjwy5J4xa6a/I/oRRmw5srhOyX49ortrsfd3h9DHCTAfoHUStY7Gouhh/5/bIxkCNTBtIAiuqknlFNek+adEtjjGkfIAyJjVK55EWAAUPDvH38f26wCYXzvtxcq+y2YLcq5gLnEnUetiR3fCStZtW3avVRN+j3J+OHYYp91q1EIcjgx0uHGQIGZxaobyEnx2hqzgfxfVfNlfWRLfGRXoMrZUtt/w416s6S+y8itIb0q7rxcGvWB7aa/hKSxLiUj0keEu8woz7Mtg6z11gKKZ6V5D/nDo9Bhk2k019kiHLZ9Otw2dNs1fdC5cUGcnza79fjI1Qi4SXwC6AjeCcZzF2VTLTqLs6wQVLvnFdoT55en2lxLTw6q6p4igFxJD8SF3LWwpW0Qq3zPOlFePm8YYT2qv8NIRFFufdX4+cy9hFMROHd4WmyEliron/0g3cdnlmwBU8XCiDaacNQcG5L7fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1095.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(4326008)(478600001)(66556008)(10290500003)(5660300002)(66946007)(86362001)(6666004)(6486002)(66476007)(7696005)(107886003)(966005)(82960400001)(82950400001)(1076003)(2906002)(2616005)(186003)(3450700001)(8676002)(8936002)(83380400001)(36756003)(316002)(16526019)(52116002)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g2/Cc420d6/K5SyxY49z+8wTe3SaFjITF873b/zge5tuskJC7Mt2kSF9ZjLl?=
 =?us-ascii?Q?wddCEXLhZgxUx8MzlQiazwm8sn6ifHAGpqfQ5fctVF/u1mgIxc2fi1DIfpov?=
 =?us-ascii?Q?98SyYZVvoxnhV2He/VrFI3wVOgjKqA2uno12pr+Jh2O6ZC13xD68iuKq/fl2?=
 =?us-ascii?Q?c8u87fL45hPWPjulA5sJl1HVUWun9/udQ+I6uyPGxnJz/RkhzaoD86HJdR00?=
 =?us-ascii?Q?vCCW1OvxEvyE1Wh6eGHrgd9CwLTtDP8p/Mn6Ya5oG6bSybrFZCPR2VpGGHLa?=
 =?us-ascii?Q?zooIQmrwpVcqtsXx3NqCay7aaZFWO0Am/gEKXUqBqvU/NF9UbuyOne+awm4w?=
 =?us-ascii?Q?SQp3hVC3qMUsD/l23sNIkvFJoWHIIR+864XsQTFPTv0+n+cOG6J2TUy8vjkX?=
 =?us-ascii?Q?ipxNLGR79uaJUl3A1hAqO2h8leIsRH4L7D/sF+dGAd2ewX7xtFbPUv6lqsK6?=
 =?us-ascii?Q?835YYMRvU6Loc+xUHFmOFoqLIaPDPw/i4A2IMDVUm2k5pcl2/BEgiiXu5WIT?=
 =?us-ascii?Q?YbuWKJtAiPiiCByBZGRMGddrZHfHgEWyFOIWUmq1EfZfdU5MdeLe7c/tkooj?=
 =?us-ascii?Q?+BTqybG7jOpzHCLqmLpE2rz0V9r/Bp64tNWse5pk+NNX/xMIXq3ORlvHmM8D?=
 =?us-ascii?Q?FClh8kq0bTtfMWVxUrVUKDPCh3YW45tbt47yJF6CZFzS6IpTbK/YKFgJo0lo?=
 =?us-ascii?Q?qyMAgDlSZW3McxgCOKzp1fwYEbRMr5vF4us3yzXOTQ9nLLu2Q4rh6QZFFqRM?=
 =?us-ascii?Q?Dyj5Vl7teyzF8X+pCa0zjTNMWt3HsLxiegEQRGwyNTvUS26RqxaT6Z3odcPy?=
 =?us-ascii?Q?YvEFCDe9RJjS5B+7hYLLw7RRGz3QgmZygEzdf9CuCILXsVHLFf3JDzcHB3fM?=
 =?us-ascii?Q?7U/9FqALgXc7r6FDy3OWCT4AIgxAqmEdulDwsCBbfjsLwJ92M39NFjk8Clq+?=
 =?us-ascii?Q?ldQHZDj0OS02prMeC/g9Uh9d/uGYMWU1QLdWcDnz1oojnNU9UJdRdkU9MEFt?=
 =?us-ascii?Q?93NWn19PD47wdVGoUIySri62P/jKBpz3Z/vL2o4UDzb7jjk=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1095.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 01:46:23.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a496347-a1c9-4058-95fd-08d8b2ae0a22
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cphPdYhZFtRaNN8w11I8IjgXU7679/7XmwxO8Cyt+O+CNYEJiLYtIPlHaCnxGkiWSt2SOQrbHj+M+N9WX1m8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
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
/sys/bus/vmbus/hibernation for this purpose.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

This v3 is similar to v1, and the changes are:
  Updated the documentation changes.
  Updated the commit log.
  /sys/bus/vmbus/supported_features -> /sys/bus/vmbus/hibernation

The patch is targeted at the Hyper-V tree's hyperv-next branch.

 Documentation/ABI/stable/sysfs-bus-vmbus |  7 +++++++
 drivers/hv/vmbus_drv.c                   | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-bus-vmbus b/Documentation/ABI/stable/sysfs-bus-vmbus
index c27b7b89477c..42599d9fa161 100644
--- a/Documentation/ABI/stable/sysfs-bus-vmbus
+++ b/Documentation/ABI/stable/sysfs-bus-vmbus
@@ -1,3 +1,10 @@
+What:		/sys/bus/vmbus/hibernation
+Date:		Jan 2021
+KernelVersion:	5.12
+Contact:	Dexuan Cui <decui@microsoft.com>
+Description:	Whether the host supports hibernation for the VM.
+Users:		Daemon that sets up swap partition/file for hibernation.
+
 What:		/sys/bus/vmbus/devices/<UUID>/id
 Date:		Jul 2009
 KernelVersion:	2.6.31
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d491fdcee61f..4c544473b1d9 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -678,6 +678,23 @@ static const struct attribute_group vmbus_dev_group = {
 };
 __ATTRIBUTE_GROUPS(vmbus_dev);
 
+/* Set up the attribute for /sys/bus/vmbus/hibernation */
+static ssize_t hibernation_show(struct bus_type *bus, char *buf)
+{
+	return sprintf(buf, "%d\n", !!hv_is_hibernation_supported());
+}
+
+static BUS_ATTR_RO(hibernation);
+
+static struct attribute *vmbus_bus_attrs[] = {
+	&bus_attr_hibernation.attr,
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
@@ -1024,6 +1041,7 @@ static struct bus_type  hv_bus = {
 	.uevent =		vmbus_uevent,
 	.dev_groups =		vmbus_dev_groups,
 	.drv_groups =		vmbus_drv_groups,
+	.bus_groups =		vmbus_bus_groups,
 	.pm =			&vmbus_pm,
 };
 
-- 
2.19.1

