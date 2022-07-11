Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E25957096F
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 19:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiGKRs4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 13:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGKRsz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 13:48:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1513D07;
        Mon, 11 Jul 2022 10:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3XLXF75rLyMWFqw36X8ZZcQT87VCvTpvi+jKSiOQNWWIKyZC0QdurCqDkHg23ycesFBfCz2AfLrJvEoUl0KUfQDg/HhJ8s15wSuiZWA8ULxY29KbA46D7yeudX2PRSJmElVt8qwXGXaXsKZbVLLUOEsaI4mSAuQW0JVizR0gUkH6Ljfhqbdgl+iwa1XF1s+SKKRrH4D7eYzbsUJEH0Yj8uJYvQqrK1Fa3osxgr/wcIvipKdmsGGCO37dTT3YAl5jeMRSS2jqzf5uqLThxpsqioyZ7WrVaEyQbdDRGDtQNAYtxRhzZ8fNg/dKehH0UXdpJJaeMD4OVkmP2DfCA+R/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0estcobQMwuwBu15qB655d3pqGrdqiDGURVJH7AEyj4=;
 b=Jw1M4++yOjMXR5f69ZLLBPrBsagfEXr07L6LfFUZv8cv20q7dosdVgzvbJu/Rqk7gnhhUN0Rl/nLuValP+8oKXDkXHHn1peld81qhFqxyQzEq+bLpn/JZBiP6rD8wrKWzJn0SJH4Ka2xHO3JL+IC2tyynWm4n+ooYlTCakBmEJoV5+zsLfKkY+/6yMUr6jnCRc1va996gXv7uKDZAwcCJHbHhndmfjuF7Elh5apYszuzrSBLM8yGfIFoIYaWUiFGoY6ZS325EMUtocJ7KFnER3ptu3nRjVuaS7WQDcI5v4SBBdDuo4ZQwwlrmBtb5ctDOjpM9SsLK2xjoSfbn60Nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0estcobQMwuwBu15qB655d3pqGrdqiDGURVJH7AEyj4=;
 b=RHGNHswTjM6I6RMSQsv18XftqNZO5PrK8kdR3BglHaHlNNlF5u8sGQFBP0fJ0d6h19ZFEOO4Z2/CrDRs39sBiRXycJObKMzjzuhFLNbntVt36JQNv0khgD+cTThzHndp5t3HfavNLVy8iq4DMVGo/G7jiADBq09NL72Iejhdteg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1321.namprd21.prod.outlook.com (2603:10b6:5:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7; Mon, 11 Jul
 2022 17:48:52 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Mon, 11 Jul 2022
 17:48:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 1/3] Documentation: hyperv: Add overview of Hyper-V enlightenments
Date:   Mon, 11 Jul 2022 10:48:22 -0700
Message-Id: <1657561704-12631-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
References: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc01d33-0179-4e1a-15cd-08da63659e19
X-MS-TrafficTypeDiagnostic: DM6PR21MB1321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJfyKAGkFrsmzd1SqJGauHdQtqCuzKELYHQ4jvHjNiLpIKV45NQx9CmK6IaYHnkjIl5HCAxApGr2Z/JDvs99Iv+LQVhBxeWrypvV9ehcxBC60Ui79mJHHl7W/GqqxtcsCpJmxO6WhJRNb5Uza63Mc1JtPGqFC0pRnfs9Ts2Jl0O9mxK7AxL9kLcUsHFueF9dDn2aMznC9yEGZrVEd+VTy9mOjhHEB2FlVNIUquiutSJfcZUNUhbmGg4yP7+CxKcySx02hHWg4blZzFCqk1+1LR5cKADfyuUEpyhA0aWlt4Mw8oixxJbfEsGZJuMp8BCexiHIbPhphfvlbirymh6SyKjhmGbZe6tWjSVjCVhXE7TvonL8NQUBx2+e/1yEk/PtuUrj+ZzuKDYNYd86tGh8gJbTQw0WKUrgdJErkKST4IGse3OEV61hm/Qqt0gzPeMycLdObSa5/ALaeEtOyO8Ou4lTp21//CQ4249cP8Z3/9QGycyhkgRPgxn83vfuTd1Xk2W/7btkAchXBDxgZZh3iF/hqA5NZnJGAxTRjbh8gaE14ghtBaUWrsn6LjGJ+gawBQaZgD9vdrgrKko+W1dyak5NI8xF+IngvVcag55iMREoyOYy1v6/FG2OOMRS1foaAjDM4qhuH5JU1T7upWe4H+LpJjPlAcyQShMSzVnnBIFA/n9yKtkvHji+m2iW6qoPDW3dKrZ9DBfQD4A2lkBAVkmUBuMqBj8bU4S7rJLYsvyIcKffZJHbUiylTdTf/7w0JRPB09YdqF4KkmEJ5jv/ve1sYtTyhDlOQPmS+mXoeSQB9AedmDcRlvPsSPeQ72yBesgkoiVe1j+tFEChIYo++GsKXJyo7QFSKG38jxHEHbols0y+f0s47vl2+v3q4pMzh+jehTTQXOJha6nLyRtiJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199009)(26005)(82950400001)(8936002)(5660300002)(2906002)(36756003)(6506007)(82960400001)(66476007)(10290500003)(478600001)(86362001)(4326008)(66946007)(8676002)(6486002)(966005)(66556008)(30864003)(41300700001)(2616005)(38100700002)(83380400001)(107886003)(6512007)(186003)(38350700002)(6666004)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mk1RIbuHmzF5vUQvGXWk7KXHupDH8MBG/dCGDjjDDJ5bW7DpmPy6dIROg1wz?=
 =?us-ascii?Q?ZE1F3L8jLEtZ+Ra3GhfymGIbSFz574+ngPwjBskqo5efQhZqeHhj8vRoeZHF?=
 =?us-ascii?Q?PsgIKVjBJBYxKcxug115JQsLCuFad2yGfRIfSKfQ7uHvvTrGQubN9/bngRNk?=
 =?us-ascii?Q?zG4ztrzMddv2i5PT0ZbqX1DHVlvZcjpDW01JoGxG8UPNj7mj71iqJVUF1Ks2?=
 =?us-ascii?Q?eq047+GcgaiSyHfwT9kM0fnWL33G/WsA3uVa81EY1jl0uw+2NCzscxoTIfAy?=
 =?us-ascii?Q?N+Nzcqd85Lbvn8ORPM5w12FAnKPFNPPcxqqgWw2q953XL1HbF7JS1ZMI3U3H?=
 =?us-ascii?Q?NZNJZ5YZUQTDyjUK6D2S3IWca5HfLQL3+RixnrS/tN0P47ErQll3Dkp7Vfi9?=
 =?us-ascii?Q?WysDoxeWk6bCw8a5h/6LWmqVQhuFeFKRFk+jpLUaEBVDY0tEM8u5+keqtDre?=
 =?us-ascii?Q?Y9zbtR7P8tFvV65iouCm++Jepzi2uVv9rGpA9GxoAuh/fPiZPYba56IHUFqu?=
 =?us-ascii?Q?vO6ffG8hxIj+MhCelU7hEcxKYAzMDFzWqUkYA94hm9TmdLbr1iUu6jMAI6ns?=
 =?us-ascii?Q?5du/6jz3Ba3mSUMt4v03sOSN1YuafL3cJU0Rhiy072ntmMmELDL0vrpx2BQ9?=
 =?us-ascii?Q?T3i3vl0KCDuEiJEke+WGHP8No54EDJm+d9vWG60DGnKZIxH61nbVRQO5y75P?=
 =?us-ascii?Q?g+MayRg2vSgSwXYlQFnZXjmHJNxcZyIY2sH5zpFK6aEnuQyOP7APm0V2KTD7?=
 =?us-ascii?Q?De32b4cr3kttwNg7HkTph/11v146Akq5uu/P9q69av88/hRXcF6T6rnemGRC?=
 =?us-ascii?Q?owIEosVEcp70bek4WfjW0mLJ6qaKmCJTT19o6XddT7rGopx3f7YsOfjNNHYP?=
 =?us-ascii?Q?kvh90QN/YAlT7E0u5q5wCiSp2ftFa5Zp4MCxhUCwUJj2vP2EezP/tG2g+7oc?=
 =?us-ascii?Q?wucQqlSj731Hupy4Um/iOPSjZ9eAK0ZL740/kmnahyOeSoA1CDmBJoiN97v4?=
 =?us-ascii?Q?MVvDzutjsFXb0Hxnysre3QBXaPj61e3BXZNgyb+qfxw76Q7acwR8BaM0AcXc?=
 =?us-ascii?Q?L09JrEsUjmMVzxnKq/3+dUN6VSg4U6OTJL2gn2YKgeEahCePnVIR04/SqHcJ?=
 =?us-ascii?Q?ycvIXTFkeOzPt5QX1I6Da1sjgnDY66kzglsd1hn8rPaXP6JmMRRz1/RMrQyf?=
 =?us-ascii?Q?RvVfbl1IKLV/eLfDf/rItJDGMEyYyrpKpZu2DYCBUQ9EAg1fmhJF8m4i4Tis?=
 =?us-ascii?Q?LvxyZgRzjnwLZs4Bp44i1qOzVxToJh9wZ+yRSkscmPPTTsdeCw5h2j6h+Fdl?=
 =?us-ascii?Q?P5KgR4HZ6lPiuwTcYJGF1Wb91tQ86/4o72bR2Z9TdFh70ilfRWP5RUSNRgmy?=
 =?us-ascii?Q?6C+nPvChSttBEpF4mgijqAbNgIGX2G66QYwTdb4rdBskqoO58RQxZ1ElAuoW?=
 =?us-ascii?Q?S9vvS0MrzIQz8L78aXcVoRhwqhOGS2VQg1Bc1ruuVRwo19drJHTYf3cenS9r?=
 =?us-ascii?Q?cI1jgnHGl9vhpCgbeshgGYyLQnrodTj/cFwLRTWyOtxpanz7vTMIawc0y3OB?=
 =?us-ascii?Q?bQhMQjpwNpD+CT7xaVSoihAXBQ1Zy9AGiGMcA0mf?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc01d33-0179-4e1a-15cd-08da63659e19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:48:52.2731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD71kjfOpfabHcvU7UuNLDkUNSqGhLfbjvysZsrmZygAZ8qvvAuMOGW19kRbr9d/SsZecpV3LQd392k7bluGkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1321
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add an initial documentation topic for Linux enlightenments to
run as a guest on Microsoft's Hyper-V hypervisor, linked under
the "virt" documentation area. Update the virt doc index.rst
and the MAINTAINERS file.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 Documentation/virt/hyperv/index.rst    |  10 ++
 Documentation/virt/hyperv/overview.rst | 207 +++++++++++++++++++++++++++++++++
 Documentation/virt/index.rst           |   1 +
 MAINTAINERS                            |   1 +
 4 files changed, 219 insertions(+)
 create mode 100644 Documentation/virt/hyperv/index.rst
 create mode 100644 Documentation/virt/hyperv/overview.rst

diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
new file mode 100644
index 0000000..991bee4
--- /dev/null
+++ b/Documentation/virt/hyperv/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Hyper-V Enlightenments
+======================
+
+.. toctree::
+   :maxdepth: 1
+
+   overview
diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
new file mode 100644
index 0000000..cd49333
--- /dev/null
+++ b/Documentation/virt/hyperv/overview.rst
@@ -0,0 +1,207 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Overview
+========
+The Linux kernel contains a variety of code for running as a fully
+enlightened guest on Microsoft's Hyper-V hypervisor.  Hyper-V
+consists primarily of a bare-metal hypervisor plus a virtual machine
+management service running in the parent partition (roughly
+equivalent to KVM and QEMU, for example).  Guest VMs run in child
+partitions.  In this documentation, references to Hyper-V usually
+encompass both the hypervisor and the VMM service without making a
+distinction about which functionality is provided by which
+component.
+
+Hyper-V runs on x86/x64 and arm64 architectures, and Linux guests
+are supported on both.  The functionality and behavior of Hyper-V is
+generally the same on both architectures unless noted otherwise.
+
+Linux Guest Communication with Hyper-V
+--------------------------------------
+Linux guests communicate with Hyper-V in four different ways:
+
+* Implicit traps: As defined by the x86/x64 or arm64 architecture,
+  some guest actions trap to Hyper-V.  Hyper-V emulates the action and
+  returns control to the guest.  This behavior is generally invisible
+  to the Linux kernel.
+
+* Explicit hypercalls: Linux makes an explicit function call to
+  Hyper-V, passing parameters.  Hyper-V performs the requested action
+  and returns control to the caller.  Parameters are passed in
+  processor registers or in memory shared between the Linux guest and
+  Hyper-V.   On x86/x64, hypercalls use a Hyper-V specific calling
+  sequence.  On arm64, hypercalls use the ARM standard SMCCC calling
+  sequence.
+
+* Synthetic register access: Hyper-V implements a variety of
+  synthetic registers.  On x86/x64 these registers appear as MSRs in
+  the guest, and the Linux kernel can read or write these MSRs using
+  the normal mechanisms defined by the x86/x64 architecture.  On
+  arm64, these synthetic registers must be accessed using explicit
+  hypercalls.
+
+* VMbus: VMbus is a higher-level software construct that is built on
+  the other 3 mechanisms.  It is a message passing interface between
+  the Hyper-V host and the Linux guest.  It uses memory that is shared
+  between Hyper-V and the guest, along with various signaling
+  mechanisms.
+
+The first three communication mechanisms are documented in the
+`Hyper-V Top Level Functional Spec (TLFS)`_.  The TLFS describes
+general Hyper-V functionality and provides details on the hypercalls
+and synthetic registers.  The TLFS is currently written for the
+x86/x64 architecture only.
+
+.. _Hyper-V Top Level Functional Spec (TLFS): https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
+
+VMbus is not documented.  This documentation provides a high-level
+overview of VMbus and how it works, but the details can be discerned
+only from the code.
+
+Sharing Memory
+--------------
+Many aspects are communication between Hyper-V and Linux are based
+on sharing memory.  Such sharing is generally accomplished as
+follows:
+
+* Linux allocates memory from its physical address space using
+  standard Linux mechanisms.
+
+* Linux tells Hyper-V the guest physical address (GPA) of the
+  allocated memory.  Many shared areas are kept to 1 page so that a
+  single GPA is sufficient.   Larger shared areas require a list of
+  GPAs, which usually do not need to be contiguous in the guest
+  physical address space.  How Hyper-V is told about the GPA or list
+  of GPAs varies.  In some cases, a single GPA is written to a
+  synthetic register.  In other cases, a GPA or list of GPAs is sent
+  in a VMbus message.
+
+* Hyper-V translates the GPAs into "real" physical memory addresses,
+  and creates a virtual mapping that it can use to access the memory.
+
+* Linux can later revoke sharing it has previously established by
+  telling Hyper-V to set the shared GPA to zero.
+
+Hyper-V operates with a page size of 4 Kbytes. GPAs communicated to
+Hyper-V may be in the form of page numbers, and always describe a
+range of 4 Kbytes.  Since the Linux guest page size on x86/x64 is
+also 4 Kbytes, the mapping from guest page to Hyper-V page is 1-to-1.
+On arm64, Hyper-V supports guests with 4/16/64 Kbyte pages as
+defined by the arm64 architecture.   If Linux is using 16 or 64
+Kbyte pages, Linux code must be careful to communicate with Hyper-V
+only in terms of 4 Kbyte pages.  HV_HYP_PAGE_SIZE and related macros
+are used in code that communicates with Hyper-V so that it works
+correctly in all configurations.
+
+As described in the TLFS, a few memory pages shared between Hyper-V
+and the Linux guest are "overlay" pages.  With overlay pages, Linux
+uses the usual approach of allocating guest memory and telling
+Hyper-V the GPA of the allocated memory.  But Hyper-V then replaces
+that physical memory page with a page it has allocated, and the
+original physical memory page is no longer accessible in the guest
+VM.  Linux may access the memory normally as if it were the memory
+that it originally allocated.  The "overlay" behavior is visible
+only because the contents of the page (as seen by Linux) change at
+the time that Linux originally establishes the sharing and the
+overlay page is inserted.  Similarly, the contents change if Linux
+revokes the sharing, in which case Hyper-V removes the overlay page,
+and the guest page originally allocated by Linux becomes visible
+again.
+
+Before Linux does a kexec to a kdump kernel or any other kernel,
+memory shared with Hyper-V should be revoked.  Hyper-V could modify
+a shared page or remove an overlay page after the new kernel is
+using the page for a different purpose, corrupting the new kernel.
+Hyper-V does not provide a single "set everything" operation to
+guest VMs, so Linux code must individually revoke all sharing before
+doing kexec.   See hv_kexec_handler() and hv_crash_handler().  But
+the crash/panic path still has holes in cleanup because some shared
+pages are set using per-CPU synthetic registers and there's no
+mechanism to revoke the shared pages for CPUs other than the CPU
+running the panic path.
+
+CPU Management
+--------------
+Hyper-V does not have a ability to hot-add or hot-remove a CPU
+from a running VM.  However, Windows Server 2019 Hyper-V and
+earlier versions may provide guests with ACPI tables that indicate
+more CPUs than are actually present in the VM.  As is normal, Linux
+treats these additional CPUs as potential hot-add CPUs, and reports
+them as such even though Hyper-V will never actually hot-add them.
+Starting in Windows Server 2022 Hyper-V, the ACPI tables reflect
+only the CPUs actually present in the VM, so Linux does not report
+any hot-add CPUs.
+
+A Linux guest CPU may be taken offline using the normal Linux
+mechanisms, provided no VMbus channel interrupts are assigned to
+the CPU.  See the section on VMbus Interrupts for more details
+on how VMbus channel interrupts can be re-assigned to permit
+taking a CPU offline.
+
+32-bit and 64-bit
+-----------------
+On x86/x64, Hyper-V supports 32-bit and 64-bit guests, and Linux
+will build and run in either version. While the 32-bit version is
+expected to work, it is used rarely and may suffer from undetected
+regressions.
+
+On arm64, Hyper-V supports only 64-bit guests.
+
+Endian-ness
+-----------
+All communication between Hyper-V and guest VMs uses Little-Endian
+format on both x86/x64 and arm64.  Big-endian format on arm64 is not
+supported by Hyper-V, and Linux code does not use endian-ness macros
+when accessing data shared with Hyper-V.
+
+Versioning
+----------
+Current Linux kernels operate correctly with older versions of
+Hyper-V back to Windows Server 2012 Hyper-V. Support for running
+on the original Hyper-V release in Windows Server 2008/2008 R2
+has been removed.
+
+A Linux guest on Hyper-V outputs in dmesg the version of Hyper-V
+it is running on.  This version is in the form of a Windows build
+number and is for display purposes only. Linux code does not
+test this version number at runtime to determine available features
+and functionality. Hyper-V indicates feature/function availability
+via flags in synthetic MSRs that Hyper-V provides to the guest,
+and the guest code tests these flags.
+
+VMbus has its own protocol version that is negotiated during the
+initial VMbus connection from the guest to Hyper-V. This version
+number is also output to dmesg during boot.  This version number
+is checked in a few places in the code to determine if specific
+functionality is present.
+
+Furthermore, each synthetic device on VMbus also has a protocol
+version that is separate from the VMbus protocol version. Device
+drivers for these synthetic devices typically negotiate the device
+protocol version, and may test that protocol version to determine
+if specific device functionality is present.
+
+Code Packaging
+--------------
+Hyper-V related code appears in the Linux kernel code tree in three
+main areas:
+
+1. drivers/hv
+
+2. arch/x86/hyperv and arch/arm64/hyperv
+
+3. individual device driver areas such as drivers/scsi, drivers/net,
+   drivers/clocksource, etc.
+
+A few miscellaneous files appear elsewhere. See the full list under
+"Hyper-V/Azure CORE AND DRIVERS" and "DRM DRIVER FOR HYPERV
+SYNTHETIC VIDEO DEVICE" in the MAINTAINERS file.
+
+The code in #1 and #2 is built only when CONFIG_HYPERV is set.
+Similarly, the code for most Hyper-V related drivers is built only
+when CONFIG_HYPERV is set.
+
+Most Hyper-V related code in #1 and #3 can be built as a module.
+The architecture specific code in #2 must be built-in.  Also,
+drivers/hv/hv_common.c is low-level code that is common across
+architectures and must be built-in.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 492f092..2f1cffa 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -14,6 +14,7 @@ Linux Virtualization Support
    ne_overview
    acrn/index
    coco/sev-guest
+   hyperv/index
 
 .. only:: html and subproject
 
diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9..fd2e5ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9172,6 +9172,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
+F:	Documentation/virt/hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
 F:	arch/arm64/hyperv
 F:	arch/arm64/include/asm/hyperv-tlfs.h
-- 
1.8.3.1

