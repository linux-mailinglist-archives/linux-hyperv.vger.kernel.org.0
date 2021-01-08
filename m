Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC32EEDE7
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Jan 2021 08:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbhAHHci (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 8 Jan 2021 02:32:38 -0500
Received: from mail-mw2nam12on2108.outbound.protection.outlook.com ([40.107.244.108]:24065
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbhAHHci (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 8 Jan 2021 02:32:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPJZrw6/HcOPD++SigxIVprdoehQuvtUAJfwLhvGUI72nf6YW/8do1KqIYzgFFj2foarUzAINt3AR10MMPQXNcFq3apwgQRmgr6nJ2TURja03wq04kL4jCe9/MtQ3d9GI4uE1hlUnJb55GNlrYZnuFulQOjwJfviXWPWsFIIclB6bdcgHMG2SHWtKKu9O54GnlO6/I7xFcI13l3MEYHG5GaNq/7bqDVaen8w/rMMN47PwF0Imod5gPFSGQsRqLZs015ynp3fqQ0O6NArZXvTRtmSO/0L6Q8OLr0R+pYG4IGGhgejum96COChph7PohSOXYoSP8B4SwrfFPnwybetvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVTxoE1QUzwMKtwMl9XME4rEzaamZPT91LpMepGuOII=;
 b=T/e/TQkd03k6FExKPr34ydH/bzPXPCeC24uadbj5mZ27qlU7tliQnfv6JGY1XLjE2k7CLkjqpsogKBcGcm5F6KUmmmxaEdFylpF2aB31sHE3ljEdLZ3ElzIMCgeFrkO0N6DagjCMr5FemnnlWyUEDSVJXGmembI9Ba/G3Qkv2irMMzfK0CYASDz6n7+VOQN0wgCQQ/1dauUB+o5WV7jjOnErDRlkkNUkYU/cKmX52obzFUQfzY572ivxbGIGqO4h7t+uvKt5oFPUBTlF/9qngepxzeYc3z6lGG9Hdakj9l/lqt04zWkz4EemlA+7tVNoyZdTM7BYPqu6Jd6x2T1TLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVTxoE1QUzwMKtwMl9XME4rEzaamZPT91LpMepGuOII=;
 b=jv1aZDz46vxC7hGTrouXp6JmPAFrLwVsIo1hn27vJfzwyH641hA6EEklaKgPP155hMUE8uTLTDyw/QcXka03J38tCg0/MQbVIMPngijRbgfCdYlljeN5CNrgqNiMRIpJtEBN2T3UrPt3q8Uu6VGXOEpY+5BA/6TS1I+kWqt89sM=
Received: from (2603:10b6:803:51::33) by
 SA0PR21MB1866.namprd21.prod.outlook.com (2603:10b6:806:ed::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.0; Fri, 8 Jan 2021 07:31:19 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::18ca:96d8:8030:e4e8%4]) with mapi id 15.20.3763.002; Fri, 8 Jan 2021
 07:31:19 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "\"H. Peter Anvin\"" <hpa@zytor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/2] Hyper-V: pci: x64: Moving the MSI entry definition to
 arch specific location
Thread-Topic: [PATCH v2 2/2] Hyper-V: pci: x64: Moving the MSI entry
 definition to arch specific location
Thread-Index: Adblj4px1LjTTBMqRhiKACld+P9Rww==
Date:   Fri, 8 Jan 2021 07:31:19 +0000
Message-ID: <SN4PR2101MB08808B1AA7557C198E08EA12C0AE9@SN4PR2101MB0880.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:916:634a:e039:b890]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a516eeff-eeae-4868-2a47-08d8b3a76411
x-ms-traffictypediagnostic: SA0PR21MB1866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR21MB1866F3797CCEF0C05EEE1214C0AE9@SA0PR21MB1866.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+9MnKuwopgLZCNInH51Pp0y5baWaZ69FzyK5LEPogZE1rruowbMHi3oOnWvaiGVQfH8knUb3bS44R8BwSsKrYgqqmqac5IM8OXI3f1WTA42fvizcw1j7ZdNYUNayE0aNCwWoh8g/Y4BMlcslUZ+0KVg5UY3fGE6EZwss+9WVTKJxbR+riIbYFVRkZzTIMlNL4AeLoimVPkiVqAY0YdVq9ZQbBSTQFoiELA5aT/EZ/yZyUJlEoNK5dUAebc1+2JLAhCODrZrjziapPeYdZftr8BuT3c36gP02QCl6LCNyqeYZZEjsE6Rr/sA132sBgq28hrtjq2bGyPtfla54OK+y/hdJblDNmwic9SEGCpL1WGcw8pJFq4+xwvvLPf2OzbK3s1n6C+SS/IuZJw15EMrIQAy3oDZg6r2Wtdi62y9k1W/UfKT9daudSuV3xVfjMAR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR2101MB0880.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(86362001)(6506007)(921005)(8936002)(7416002)(33656002)(4326008)(110136005)(316002)(54906003)(8990500004)(7696005)(8676002)(478600001)(10290500003)(71200400001)(52536014)(186003)(82960400001)(9686003)(5660300002)(76116006)(66476007)(66946007)(83380400001)(64756008)(66556008)(55016002)(82950400001)(2906002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?QrtWd1djOG0MUH7eaNUpSxawgZhGnPVO0SA3Wg6WwUvP1FYApPbFJCEWSNTF?=
 =?us-ascii?Q?Kb/2eZIAClgHAshB+7daAED01cUCsQhUcl0jjoPS/RosT9WzOgHIkU/TpZ29?=
 =?us-ascii?Q?602x+r6mrnLHxkr30XsNaWqOwoXhkgY+f5w0OmCp1Y8s91G0dO+0D4zrYnVS?=
 =?us-ascii?Q?uCk6obhgtoyJbU+cxC82o5PfQKCfgT2nz533rs7zleP3/h1jm5pAusNrCusC?=
 =?us-ascii?Q?Aixpr88Y+/L37TZzx+dYOxTkpww988MDBpuiVidPAKPr1jZdxpVlkI+Wyqx6?=
 =?us-ascii?Q?7PsQx6eBqj433yrAjkiRx/v+nf+0ocsB4GuTYgHijxpvj5Qc/PQCiB+D5RSK?=
 =?us-ascii?Q?qU8YcoYW/21gyZv/grwMAMBum9SLTizu5n8/wdODQTSuK9OOGSmeXAehrPnc?=
 =?us-ascii?Q?IHFyUWP58iJoyKgh+RBD7EHy+lluO1cvHN3Ql5Y9VpyoV5MVPoSg1SbWG9ex?=
 =?us-ascii?Q?z/KwoijI9ti+O1CgDvRRECO1tx0cyqELlVjieYB35eTldyFTzhlXf++qz53H?=
 =?us-ascii?Q?tBAszWjeQYJolqh2w0684RM5S5uhuc26qIHAKM8ULYXUvuNqlm665dVzuwAN?=
 =?us-ascii?Q?2vjGTCXU3hUkytn7ruH13Tc3bGsYCWas5PubL5b/8BpHKnu9yy4rVOBnchDE?=
 =?us-ascii?Q?0pwI2/hTpjPAbNQzbO31fQTSKSHFdMwI9q7QANyh4qj5E+AaNDj3zD8/JCsn?=
 =?us-ascii?Q?U9VR21cJQMo1njPdmi0BoRbxqLrOV4n2LN1fSD6y5xSd81mL4kh97HqRc7Hs?=
 =?us-ascii?Q?4dyUecbtVWC4o2IN4wWvQfHAHoJyT6g8JMUIhBsmF1xVwHPJxsBDtlhrKWoy?=
 =?us-ascii?Q?JRRirQ9Ss5Os3q7KBgObwnBNz2hjxpfabysPhZ7f8OndJvujMdo6Hwyl1P7f?=
 =?us-ascii?Q?3BOio4aVEUmi55RjVFTEq7Qt1/I2Y4bc0qxf3HgRpz5qOEs0/CTcxTrnA7yX?=
 =?us-ascii?Q?u7IeRYgHBp/nRvM40wIpa0XGg+D4SbgskfU22HhIzaEOM0x2MI6TWGg88qK2?=
 =?us-ascii?Q?kJpSv+DzAvAbRpXlfbGy3nAA+gLuzpfitk8ry6OpGLfEzRA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a516eeff-eeae-4868-2a47-08d8b3a76411
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 07:31:19.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeDYkJgRxav/Dsjkv/QHb2yqMp3lee7D0A9iXT09OjmKVwf+e1a7zVwjELoGK+8a8WID4UmKKV/wIP9K20FqektuirUPodgWSIpzK+suBh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1866
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The Hyper-V MSI entry is architecture specific. Currently, it is
defined in an arch neutral location. This patch moves it to an
arch specific location.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 7 +++++++
 include/asm-generic/hyperv-tlfs.h  | 8 --------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hype=
rv-tlfs.h
index 6bf42aed387e..a15c17c7f019 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -523,6 +523,13 @@ struct hv_partition_assist_pg {
 	u32 tlb_lock_count;
 };
=20
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		u32 address;
+		u32 data;
+	} __packed;
+};
=20
 #include <asm-generic/hyperv-tlfs.h>
=20
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv=
-tlfs.h
index e73a11850055..6265f4494970 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -408,14 +408,6 @@ struct hv_tlb_flush_ex {
 } __packed;
=20
 /* HvRetargetDeviceInterrupt hypercall */
-union hv_msi_entry {
-	u64 as_uint64;
-	struct {
-		u32 address;
-		u32 data;
-	} __packed;
-};
-
 struct hv_interrupt_entry {
 	u32 source;			/* 1 for MSI(-X) */
 	u32 reserved1;
--=20
2.17.1
