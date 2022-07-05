Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4065672F2
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiGEPpC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 11:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiGEPpA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 11:45:00 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F416582;
        Tue,  5 Jul 2022 08:44:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7MRc3krSPMoVjrFOtvGaGA/m5DiKGvqKzUMocU/t4Mv/rDthiOaweNk0qzVkZWupYEGRGkvIx+6kdOVnuF9fAgtoUjlQ2HJ20OGtQTQADuBuTNRZCO7ApfM07BlZQQCvLCkOwHu8N3ic1Lr5AWizgkKMZgoJhbVfBYJkj7BcPs/i1T2NyQEqthwyXEhXqMBKR3cd01rYDxwgQ51CMJ6ZANBx//TZXA+UwB8TlSLPf0mz06R7I+7Uwg4qxlFtBWasW/8LTuBYxava7yhr/nPbHK6gc6CxhgfOarV0ddchFOJZW5uXp4CuMPaeRt9VbKtVUKS0iFhhxccMnhHbsLYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0estcobQMwuwBu15qB655d3pqGrdqiDGURVJH7AEyj4=;
 b=ZezcF9I4/m0xLlpYD8CAljOF6TMX6lw/Ws0fuyAbbt6ZF15o/64QCyq4KPDFZ43D+Y48rMiLj+lKOKuiRSpeBzBpg54D9odwBCLgN/pXuiqyAoBo62sDKeVXsZ6Pq1rYoTDm2JJym0+aRUk8OYy0o/g3pH2rO8wo2+YD/wLasN2MwPrqUwBXUtSGcxNvNp+hZKl7QyBUIBiQehR9GALInLragSyqJXLaLguc3XJaQCh1Ohevn9W8sG1IcV/KElVYW0Ze9U7gkULaTvGpj1m+WVkwIWUlc55qyugPpK/bzSjRNwhFzLPC57DlpMD1DLOJcxl0/vfpm/fxwwUlp0psjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0estcobQMwuwBu15qB655d3pqGrdqiDGURVJH7AEyj4=;
 b=I9k9uD4RRdN0u81K+1ocj6TBWMGuGHbDTels5PTzt8U6zbTmhtT1TKH8gRcRWSdBEsx3PrtGjPl9FEjNtGA9wQATx2OD3qSePi2D/7VH7N+ENvlZW9Rl1u4pBXvOI0Rp7AIK+TZRuWncTrKHtiSjGBmDZVv1CxnxF40ZEQP0FuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1322.namprd21.prod.outlook.com (2603:10b6:5:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 15:44:56 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Tue, 5 Jul 2022
 15:44:56 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 1/3] Documentation: hyperv: Add overview of Hyper-V enlightenments
Date:   Tue,  5 Jul 2022 08:43:40 -0700
Message-Id: <1657035822-47950-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
References: <1657035822-47950-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:300:ae::24) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 702575af-9a7d-4fd5-22b9-08da5e9d4fa5
X-MS-TrafficTypeDiagnostic: DM6PR21MB1322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iaqy1Qgn3HDvArACT8mwK+IbN0H7a304rngf9Rn8CML/pO/YztPuAGIOtfg6lPxhlIvQsq8gsJlH4dVTjIKPzTV9R7QQZN3LTRXmoSmC+176a8sMaBWU94w8lDWEUtHCv4Oh0BNBGGJqcNTI4s17ixadPZwYs7VyeWLNUhuCv7xs7FtH5mJL4di+HLQtf+eUrMlO1IXmDuPaNbAjc9hU05uInXHMr2253/8ZbcynZjUieJRDYA39PFBXpzcwf5hJ1Bo3Zw4NXvluKXEH9mXPihoME5+H9oZVtG+CWJB69zpcuCRHvySqOEAMqHtFw366cf/Bac6C8Rx2cn5N00i+nph4i3fppJroATibU216RC1P5mHDh9QjhFXWWKrnA5bWuCfXmuLDNuz+3NhFZfzJE5c8Y6A0/YAr/nzON4HqTmY6cstaz0lc/9mt3N5VXNT+QR70C5i+OGYvy6VKQPosc0asW3UchxbVarDH8Eo+znZZs0gnLZ/QI0q2E2fya+3gPTOzj6MqqRJhZmwAsEDvbRkpaPD0t5TDiSJSeL498O5LNiK1iIX5gPTm0vYZDVmMTBK5iqb6YucTj4xa8IhJUcVFlXPXIO8w8ZLuBs0I9rZcbs+or7bn6CEyDcxuBVRHIvfEWyf1wgv+MGNFMJqQBuKW+E+Y8aHXasCuD7MOOg1T0wbydZaKI9d4wPNJRvPCn8dKQLZYHoVKeBJhXnZnttTa+ZN1HExQiNjknGmilB33MKkoA/HpFerKYTcUKi6raIKf28YRRLyVHYxb2g5CjCNXT+sq3cJgSSEnJ+sn9xnPMmR2PVD/knV9GBRO+O9AFtTTJQldbITOJcelKAAumbEEXCgT0NOSdquHsig57IAYYaGkuyT7nYzNgg6GRYpZ2Wy85/WhWb5fBDGKu0YRyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199009)(26005)(41300700001)(6506007)(2616005)(2906002)(6666004)(107886003)(66476007)(186003)(52116002)(83380400001)(30864003)(6512007)(478600001)(6486002)(966005)(86362001)(5660300002)(8936002)(4326008)(36756003)(38100700002)(38350700002)(82960400001)(66556008)(316002)(82950400001)(10290500003)(8676002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JSB+/hhhximwy9xPP4TM33dod/B4iwxxcMMnw8JFA6eAQTrLQBT/pa5phuRU?=
 =?us-ascii?Q?lqbXuNPMyFONcHeVgUXsmuG3pvLv/JeEkwTQdlP0kbibdjMWB/PPAPs6AwfO?=
 =?us-ascii?Q?x6DKxyorcMjNilRN1g7RGp3yIJVLLrtjqOVrW8WPnRV6xpW4TUKishUaSHI6?=
 =?us-ascii?Q?uVBa7r5OI3vSVEAkFdrH/p4bM2zbAySK/l/ub+q7BlucvAkOf8CPiYOMLgrj?=
 =?us-ascii?Q?GbOl1ZSAOBjwGi7WJQIhSZ/0FvAOh3pTM0KsEx6cmzdNu1rtmdP4N+BKgEvm?=
 =?us-ascii?Q?sYzfxd2JIYyVMwv3TxJAO2YXoYIzlsvk4bGzK2yz8kXai2eUAWFMzQcOiB/H?=
 =?us-ascii?Q?IRw9TQOf3hYjH9/urM1UYVZNeNquvurmtXQQg713w4ontrPoA80ctntlO6IM?=
 =?us-ascii?Q?XjTbZNII0QI7E65TSVfLY0ptGjVrzYcbAmaszpOcxymO30MvcrgaI3ImgwY3?=
 =?us-ascii?Q?1lPTyJMiWIxIW1TKJ3MIZpVE9foA/BEZRmpgbRnGnY5nY057SIn+wj2IWDv8?=
 =?us-ascii?Q?sQSjsCj/Gs6EMQFCRM9lFFtiTsviBvsEOqXT9eOE05bCoxV6Ww3MlS/G3AXE?=
 =?us-ascii?Q?cXLDM6w8SpA81te+5JP1dTv/gHkm/HRdR93TBLccZtQxxPIso9G3myPImlYV?=
 =?us-ascii?Q?eGcbl6q7vjooLGOQ/1R2GIW48Jrlh+M19j4Y6k3+9xpGoDZ5gTznZ2hoaaiq?=
 =?us-ascii?Q?22OeDF2rTB5eXUdk0I1zQ29KjG8ow+Ai5ptcs/d86r/w4s0XVYyGmTGUIMWR?=
 =?us-ascii?Q?4WT0GDMqarZaun7C2xqRpdQoKHbQJMy30G+GMZab+AxbHSqXws057SUMGXVb?=
 =?us-ascii?Q?y2T5OwjFisYxbab91ZRT+2wV4Oj/DiWVqJH34nIGfpB3FT8KkAvvG41jamGp?=
 =?us-ascii?Q?KYHhsd0o7tDkES3KE+ZLysdh4zeIP7BNGIRAG7hKUQ0HvSc7wtQT6PTbw30P?=
 =?us-ascii?Q?47kLDo8QhNxt9tHfsUJMKBMguV+DD2o7L3x94CIxmScmkl2rVp02SMiqKTso?=
 =?us-ascii?Q?dI7UbAjWxvUro+Lk13zgJjRZvakTGv76Bhu8x8/MDWVd3kGqQ2baD9pTHpDs?=
 =?us-ascii?Q?ZA1uioNe+oQyyVPxEnT7bCHbwzhLuGKxn4yQkQVK40+2W0U2ckGpJKA315lo?=
 =?us-ascii?Q?4craaEHSWQlCd17rnQDqhkmfAAKoAoXWgQMi/U7uFUc6Tyz5vNXV9pg5183s?=
 =?us-ascii?Q?rowcMB1taZO2pcWqYL2mCfSXgj7K9gh6O0uf+wWSJue9EUt4h8vr9R0ODPM0?=
 =?us-ascii?Q?ixorPsjvJYJjDCKdXCADTPGgBLRPpf8iyo9Wlm4/oHjjIkL/bSuemxFLJR5R?=
 =?us-ascii?Q?xYu9QbxlIv3t6lwlD+6xwgnWpaSIk17QUihXqdEk8ctCDJCqk1XQMm9iy4Ss?=
 =?us-ascii?Q?Xk2ukfEy/o5Q3wuUT+JjqFkqkfU9J+5X71u2JPNpr4GzvEZpJgZsYmFd8hF6?=
 =?us-ascii?Q?K5+TOhH46guWIYe/tKVOsIlQL2B/LHBMyP3MeExHT2sriktxN3RYtwriki+1?=
 =?us-ascii?Q?VrJA0Q5TU0M2yC62/+P59SFLMksQw3ZIIWhEomgKqolLZj/ecOSjWo/UWVyI?=
 =?us-ascii?Q?6SYzD0/JvLX4MpSHeheoB+q6d+1DeSEf45yXryXejqc2gSR3Za2dkS4RUpdF?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702575af-9a7d-4fd5-22b9-08da5e9d4fa5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:44:56.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/T4vfCWpXx98ZrhFWK02+HiYYFBw2MYNspr8V+vpYCVsIkG4j2mcsERGA/n6RNVga2KWfmAuGPjHjUgnKo9WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1322
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

