Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F856570974
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiGKRs6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiGKRs4 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 13:48:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2090.outbound.protection.outlook.com [40.107.244.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C58713F5E;
        Mon, 11 Jul 2022 10:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1pqpRu2ViyyOZrJGb/buEAkTHSkS46iL2UAiV3ZDqR+IqxtSmZA6mEsvq683QJAsq99sCmpVTtepxvm/ZE0Yq24O3oHbKBattU6j2hGCpHh8CbY8iPixGTSl7O6AsE+c9TxyaPlhnpT8Tav7KhKr7SaF3huvO0Ni1Dei/Ub/gtiqsheWwB07h99X++jYes1PMxbm+TXir7G/2G+XQO2MZoMZMLhiEdp5KQ92ByW8pS9IX0IDZjtLIQR9yddGcCWFc/lm0hcuLkhos9TBSi3am0XNGbw+VIxTFYdPZbpfZCXnlCDBACzanJq+u5xIbwf4iHu0ghLFNT5I3Zpr99u0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USUqWX22yjhg2T5jVcHObqc8/i1/up2CIJq40BN7Bf0=;
 b=KomQzSVu7mcaPxlRV6JcdnXOmZp1cmTsdhxsHofaXgYjwvUK2RiWVgzmm8g+EFV+xujZoVFc+CTABAuSN8gbYa9cufXf/9vo5udlmsWjbaB4Irw6JdsmzseMpTJ3YptKXroX96GZypX8gZ50niuOyo5D48fAIig9xSsSpdJdBGZAzYVvXfncyZU/hB3Y0yfi5ZoKoyTrSImDFnXxqAOptOb9ZGMK0FLfV0MHXSkUcq7rFYEEMRt2H1XhjxFQJ7BppMnjyIFxr7IUub+xWoJvGOWH5lc5BNNKGUinW5FOmkgPBk9OvExD8YWODgP8mvcXfbm1qnOhxvmYHAavGjKQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USUqWX22yjhg2T5jVcHObqc8/i1/up2CIJq40BN7Bf0=;
 b=BrxVNVtPEzdiv/BX44Edc6cREW9Bo2fWufmBuF5FYjWel/XEEHXnby8G+k7+cw4vBBj+Rgs80zoIg8H5uVoeVQFgQAP+czlHw8sh3sPVj44g57cIDzhZm1rwJgZidBzhz+xynDNgghaxUFamwfO2OjHHlrTy5Zkhgx5cDiIvVoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1321.namprd21.prod.outlook.com (2603:10b6:5:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7; Mon, 11 Jul
 2022 17:48:53 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Mon, 11 Jul 2022
 17:48:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 2/3] Documentation: hyperv: Add overview of VMbus
Date:   Mon, 11 Jul 2022 10:48:23 -0700
Message-Id: <1657561704-12631-3-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 973a7343-07a1-4415-8514-08da63659e8b
X-MS-TrafficTypeDiagnostic: DM6PR21MB1321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3/gk9G0Hhx+MVyQp5AMVXdDY0izccUwx/2r6WbrF81knoSjM83rHJMVJid+/LySP9mIt+f+3407C2+3NjQKRg7wpPNVv1qSUqUw3ZQgRIlHewvh6EpGQ5W1pCpyDweVtm9xYQ2yVaJZSh4NvLXZYkj63MkQfYzAxmLVA/0AlTmRQXQBQGEfXxn/TNUw8jTgdG/drUeN6oBKbtC7k9K55pNQ3BtyPArKOoSLDER1m5pJK/n1gZ2iMZj2WBFHa0MjRaF4rEXz5MXDGTHFRxOOfp1c6lFgpOAVTLNjM1go3ALDNMZH4+W9N4DUmG5N8Ux6zedDtjCiCWhzHGw4d8r2SEpSWUJ3luwKySjxnNAqduhRTA+FKiL4ikJ+npKKi1Nf1sUrSBbcfkIKwRhe0lK2L1PCQ1Kcxr17yUnoLtYGlcMPJHkhO43fUaIR2yRI5eZ1+pfxyTEOJaUT9kuFUmBAW3ZelftlZTXqzcNzYBrf6xbccg9dPtm4Ca2rK4WSQWad3PSxKd6cs2wC4Ws3sC8jN+N1c2aKtlx40zvRg+PaRiQyOy+takQ7ExGwjJO7ZjvABBwAjpWyd0EDDWgLcJfG3laPIz2bzdaYCiZcph9lLZb8ruK9/lpRXXiqLZQr4Y60cGje4w3FCkioRSY8eQJ6K1ZEBqEaz3wWHgVvUSiQQk35z/756jNLeCd6LCD0RnR94GWXN5W0oRuyf8l5BAJGj5CK3YURiGkHix7o/spxWpADOnOtdEq5RdnYR3p889NhC2miycmvwmYsxuPihaoNLmtIIHUTF1s/d8Yz2sMQshobjMUSFWHlMb5rCBAQDbhJyruRCv0sh+Aq5ZLINbdeQrNwNHT9UEIG3FvTA+AY9vCo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199009)(26005)(82950400001)(8936002)(5660300002)(2906002)(36756003)(6506007)(82960400001)(66476007)(18074004)(10290500003)(478600001)(86362001)(4326008)(66946007)(8676002)(6486002)(66556008)(30864003)(41300700001)(2616005)(38100700002)(83380400001)(107886003)(6512007)(186003)(38350700002)(6666004)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3FyWIZj+NbJ9rZ/cM3B5TErmX0nC3RALmrq9XYyKGL8lJxpW636tDeH2j3TF?=
 =?us-ascii?Q?m0AvOqsOtenElo1ma8wGoB/9GLSDPDuG1WA9tQl6yXmWubyQ1waBw3IowESy?=
 =?us-ascii?Q?OmtrBRISOH7Fk0cFZJx1H4f6pLGoGkrZF3T+om3jhhxsstvq/jPJeYjHfo6e?=
 =?us-ascii?Q?Re2ulCTW/9YKLagLREOa54W0E3yKBBRGDss/QB74EYvuQzX1O/IUkzbqXIid?=
 =?us-ascii?Q?qVvo/o+5U1nUprUGVaMWQz2qjhDmud1TzEkAxt8LgthEA+YlM7J67r9mXury?=
 =?us-ascii?Q?0SweAoGM8FT/3Ggn8DsY4aMNmSbyuVyidrmMwd218LWc1TOUAhIkxOpbc1v6?=
 =?us-ascii?Q?Bk9zxbQ1p+Y/Q3vivj7ab18xTqXi3V3mguk8Hb+xQyUkhs0oHil55ovTPlAC?=
 =?us-ascii?Q?OFhvVleAtmIjVGowd6nKiSG84NS6foL1dNHXazZrIZQ4hxpDx8NRSo84B5y3?=
 =?us-ascii?Q?3H+gV1SOMfArBieyPShM/3JkzropUMZWOQvztBsP33fhqn3cm9kzXKmnQM6j?=
 =?us-ascii?Q?I9tVjpfIBShA3DofJR8FxBJlP32J9F5b2SF3V4qIoUnW7uMvS9tocnUpoRbB?=
 =?us-ascii?Q?VBER0YV5Fk16iT1YrkDZMvCP18rB6137lIW5fQNQ4BUI/AtKpL4sTD27fc55?=
 =?us-ascii?Q?Wf8QGuA7WUh3fD81WNzfn8cxvURoHaxMUB4alzNf7MS+i3gRZCBIl9vXsgY7?=
 =?us-ascii?Q?Iy0kH1tyojKOOHvw3h6KvY7UrzCjUSdqUDAiW7xMldrd7hD9eAwDv6N+ZRdq?=
 =?us-ascii?Q?U52SwAxo2I+sOuyLRwKo0OmMW56x/2rmQQsBC6wB2WVILKZV4gVYocAjVWov?=
 =?us-ascii?Q?HnqpuNIg3praJtMXmHusNuEgvwO1MLWrEvtoYc9kgjGq8VdTVEQSXxZRSNMK?=
 =?us-ascii?Q?eh0vlaA7PTz9PRtE7AaUznIypZCuQwsp/OZx1vQe6KsXuPG+/lTwMeau42/l?=
 =?us-ascii?Q?GIj4/IJLDSLqOib0T8gCFkZLx/Xy/VJHh/glC8q28xMqS/c0XXRWsnyNc9WW?=
 =?us-ascii?Q?PNfV32yMzEJ0JXQ1rxbuIgslCaNi6cD9Okoz86FPBjY472KuqPhWu3PR6M8Y?=
 =?us-ascii?Q?7zKOdTqvIStm4MIGOsO4hIewg9TgPyZdPRojGxHyx6bJjtBr55XuM3gST6ti?=
 =?us-ascii?Q?aPomibC3M2mgvzk4gPVv8BiuRxKTsaU7t3sjleYqQQbcQDHfN7onrQSrjWTX?=
 =?us-ascii?Q?OIWj93nIHTu40fzJ+znL3VRSaCZJlpv+t2seyZ7lKWRVWzjyEqgGbOGo3Ovw?=
 =?us-ascii?Q?6f5BIQYyiQjP04IxPVS31UPKFiaLth3pfpJexW7e0kCsttAKnqXwi96XCF16?=
 =?us-ascii?Q?liAAlWUzOJG0PRrL6TbqG4ptDR3izAasDw9RjhwqU1ST6etfy5lD0KFMVWpV?=
 =?us-ascii?Q?wsNuAxNl8daXkJA/Jo9WslNfRTowiGyIJ0JgMq4E1rsW+hhAaT7TV4sCnetv?=
 =?us-ascii?Q?w32z+MJuMkY9rYWzNUxDwJ8a6uz8i9I0ufbphG7Gxm83nEyQeUrKUGjBxg1/?=
 =?us-ascii?Q?Na90+80G012NBbzWhRammz9Kw9wxi2Dr/cq+22TFDjZ7MWOHSSx17dFrp4n/?=
 =?us-ascii?Q?BbwodfINKL29nTRZIrZch9VmsHUx/2OiTIGddCNs?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973a7343-07a1-4415-8514-08da63659e8b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:48:53.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QSToKTh/nSga6szNicLlGAdnSb2601VPLFOEiGGMKvgo1gWM7bcO18LAGLyhfGJCrrM8yLekd3tLmjJSnCyyA==
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

Add documentation topic for using VMbus when running as a guest
on Hyper-V.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 Documentation/virt/hyperv/index.rst |   1 +
 Documentation/virt/hyperv/vmbus.rst | 303 ++++++++++++++++++++++++++++++++++++
 2 files changed, 304 insertions(+)
 create mode 100644 Documentation/virt/hyperv/vmbus.rst

diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
index 991bee4..caa43ab 100644
--- a/Documentation/virt/hyperv/index.rst
+++ b/Documentation/virt/hyperv/index.rst
@@ -8,3 +8,4 @@ Hyper-V Enlightenments
    :maxdepth: 1
 
    overview
+   vmbus
diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
new file mode 100644
index 0000000..a9de881
--- /dev/null
+++ b/Documentation/virt/hyperv/vmbus.rst
@@ -0,0 +1,303 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+VMbus
+=====
+VMbus is a software construct provided by Hyper-V to guest VMs.  It
+consists of a control path and common facilities used by synthetic
+devices that Hyper-V presents to guest VMs.   The control path is
+used to offer synthetic devices to the guest VM and, in some cases,
+to rescind those devices.   The common facilities include software
+channels for communicating between the device driver in the guest VM
+and the synthetic device implementation that is part of Hyper-V, and
+signaling primitives to allow Hyper-V and the guest to interrupt
+each other.
+
+VMbus is modeled in Linux as a bus, with the expected /sys/bus/vmbus
+entry in a running Linux guest.  The VMbus driver (drivers/hv/vmbus_drv.c)
+establishes the VMbus control path with the Hyper-V host, then
+registers itself as a Linux bus driver.  It implements the standard
+bus functions for adding and removing devices to/from the bus.
+
+Most synthetic devices offered by Hyper-V have a corresponding Linux
+device driver.  These devices include:
+
+* SCSI controller
+* NIC
+* Graphics frame buffer
+* Keyboard
+* Mouse
+* PCI device pass-thru
+* Heartbeat
+* Time Sync
+* Shutdown
+* Memory balloon
+* Key/Value Pair (KVP) exchange with Hyper-V
+* Hyper-V online backup (a.k.a. VSS)
+
+Guest VMs may have multiple instances of the synthetic SCSI
+controller, synthetic NIC, and PCI pass-thru devices.  Other
+synthetic devices are limited to a single instance per VM.  Not
+listed above are a small number of synthetic devices offered by
+Hyper-V that are used only by Windows guests and for which Linux
+does not have a driver.
+
+Hyper-V uses the terms "VSP" and "VSC" in describing synthetic
+devices.  "VSP" refers to the Hyper-V code that implements a
+particular synthetic device, while "VSC" refers to the driver for
+the device in the guest VM.  For example, the Linux driver for the
+synthetic NIC is referred to as "netvsc" and the Linux driver for
+the synthetic SCSI controller is "storvsc".  These drivers contain
+functions with names like "storvsc_connect_to_vsp".
+
+VMbus channels
+--------------
+An instance of a synthetic device uses VMbus channels to communicate
+between the VSP and the VSC.  Channels are bi-directional and used
+for passing messages.   Most synthetic devices use a single channel,
+but the synthetic SCSI controller and synthetic NIC may use multiple
+channels to achieve higher performance and greater parallelism.
+
+Each channel consists of two ring buffers.  These are classic ring
+buffers from a university data structures textbook.  If the read
+and writes pointers are equal, the ring buffer is considered to be
+empty, so a full ring buffer always has at least one byte unused.
+The "in" ring buffer is for messages from the Hyper-V host to the
+guest, and the "out" ring buffer is for messages from the guest to
+the Hyper-V host.  In Linux, the "in" and "out" designations are as
+viewed by the guest side.  The ring buffers are memory that is
+shared between the guest and the host, and they follow the standard
+paradigm where the memory is allocated by the guest, with the list
+of GPAs that make up the ring buffer communicated to the host.  Each
+ring buffer consists of a header page (4 Kbytes) with the read and
+write indices and some control flags, followed by the memory for the
+actual ring.  The size of the ring is determined by the VSC in the
+guest and is specific to each synthetic device.   The list of GPAs
+making up the ring is communicated to the Hyper-V host over the
+VMbus control path as a GPA Descriptor List (GPADL).  See function
+vmbus_establish_gpadl().
+
+Each ring buffer is mapped into contiguous Linux kernel virtual
+space in three parts:  1) the 4 Kbyte header page, 2) the memory
+that makes up the ring itself, and 3) a second mapping of the memory
+that makes up the ring itself.  Because (2) and (3) are contiguous
+in kernel virtual space, the code that copies data to and from the
+ring buffer need not be concerned with ring buffer wrap-around.
+Once a copy operation has completed, the read or write index may
+need to be reset to point back into the first mapping, but the
+actual data copy does not need to be broken into two parts.  This
+approach also allows complex data structures to be easily accessed
+directly in the ring without handling wrap-around.
+
+On arm64 with page sizes > 4 Kbytes, the header page must still be
+passed to Hyper-V as a 4 Kbyte area.  But the memory for the actual
+ring must be aligned to PAGE_SIZE and have a size that is a multiple
+of PAGE_SIZE so that the duplicate mapping trick can be done.  Hence
+a portion of the header page is unused and not communicated to
+Hyper-V.  This case is handled by vmbus_establish_gpadl().
+
+Hyper-V enforces a limit on the aggregate amount of guest memory
+that can be shared with the host via GPADLs.  This limit ensures
+that a rogue guest can't force the consumption of excessive host
+resources.  For Windows Server 2019 and later, this limit is
+approximately 1280 Mbytes.  For versions prior to Windows Server
+2019, the limit is approximately 384 Mbytes.
+
+VMbus messages
+--------------
+All VMbus messages have a standard header that includes the message
+length, the offset of the message payload, some flags, and a
+transactionID.  The portion of the message after the header is
+unique to each VSP/VSC pair.
+
+Messages follow one of two patterns:
+
+* Unidirectional:  Either side sends a message and does not
+  expect a response message
+* Request/response:  One side (usually the guest) sends a message
+  and expects a response
+
+The transactionID (a.k.a. "requestID") is for matching requests &
+responses.  Some synthetic devices allow multiple requests to be in-
+flight simultaneously, so the guest specifies a transactionID when
+sending a request.  Hyper-V sends back the same transactionID in the
+matching response.
+
+Messages passed between the VSP and VSC are control messages.  For
+example, a message sent from the storvsc driver might be "execute
+this SCSI command".   If a message also implies some data transfer
+between the guest and the Hyper-V host, the actual data to be
+transferred may be embedded with the control message, or it may be
+specified as a separate data buffer that the Hyper-V host will
+access as a DMA operation.  The former case is used when the size of
+the data is small and the cost of copying the data to and from the
+ring buffer is minimal.  For example, time sync messages from the
+Hyper-V host to the guest contain the actual time value.  When the
+data is larger, a separate data buffer is used.  In this case, the
+control message contains a list of GPAs that describe the data
+buffer.  For example, the storvsc driver uses this approach to
+specify the data buffers to/from which disk I/O is done.
+
+Three functions exist to send VMbus messages:
+
+1. vmbus_sendpacket():  Control-only messages and messages with
+   embedded data -- no GPAs
+2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
+   identifying data to transfer.  An offset and length is
+   associated with each GPA so that multiple discontinuous areas
+   of guest memory can be targeted.
+3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
+   identifying data to transfer.  A single offset and length is
+   associated with a list of GPAs.  The GPAs must describe a
+   single logical area of guest memory to be targeted.
+
+Historically, Linux guests have trusted Hyper-V to send well-formed
+and valid messages, and Linux drivers for synthetic devices did not
+fully validate messages.  With the introduction of processor
+technologies that fully encrypt guest memory and that allow the
+guest to not trust the hypervisor (AMD SNP-SEV, Intel TDX), trusting
+the Hyper-V host is no longer a valid assumption.  The drivers for
+VMbus synthetic devices are being updated to fully validate any
+values read from memory that is shared with Hyper-V, which includes
+messages from VMbus devices.  To facilitate such validation,
+messages read by the guest from the "in" ring buffer are copied to a
+temporary buffer that is not shared with Hyper-V.  Validation is
+performed in this temporary buffer without the risk of Hyper-V
+maliciously modifying the message after it is validated but before
+it is used.
+
+VMbus interrupts
+----------------
+VMbus provides a mechanism for the guest to interrupt the host when
+the guest has queued new messages in a ring buffer.  The host
+expects that the guest will send an interrupt only when an "out"
+ring buffer transitions from empty to non-empty.  If the guest sends
+interrupts at other times, the host deems such interrupts to be
+unnecessary.  If a guest sends an excessive number of unnecessary
+interrupts, the host may throttle that guest by suspending its
+execution for a few seconds to prevent a denial-of-service attack.
+
+Similarly, the host will interrupt the guest when it sends a new
+message on the VMbus control path, or when a VMbus channel "in" ring
+buffer transitions from empty to non-empty.  Each CPU in the guest
+may receive VMbus interrupts, so they are best modeled as per-CPU
+interrupts in Linux.  This model works well on arm64 where a single
+per-CPU IRQ is allocated for VMbus.  Since x86/x64 lacks support for
+per-CPU IRQs, an x86 interrupt vector is statically allocated (see
+HYPERVISOR_CALLBACK_VECTOR) across all CPUs and explicitly coded to
+call the VMbus interrupt service routine.  These interrupts are
+visible in /proc/interrupts on the "HYP" line.
+
+The guest CPU that a VMbus channel will interrupt is selected by the
+guest when the channel is created, and the host is informed of that
+selection.  VMbus devices are broadly grouped into two categories:
+
+1. "Slow" devices that need only one VMbus channel.  The devices
+   (such as keyboard, mouse, heartbeat, and timesync) generate
+   relatively few interrupts.  Their VMbus channels are all
+   assigned to interrupt the VMBUS_CONNECT_CPU, which is always
+   CPU 0.
+
+2. "High speed" devices that may use multiple VMbus channels for
+   higher parallelism and performance.  These devices include the
+   synthetic SCSI controller and synthetic NIC.  Their VMbus
+   channels interrupts are assigned to CPUs that are spread out
+   among the available CPUs in the VM so that interrupts on
+   multiple channels can be processed in parallel.
+
+The assignment of VMbus channel interrupts to CPUs is done in the
+function init_vp_index().  This assignment is done outside of the
+normal Linux interrupt affinity mechanism, so the interrupts are
+neither "unmanaged" nor "managed" interrupts.
+
+The CPU that a VMbus channel will interrupt can be seen in
+/sys/bus/vmbus/devices/<deviceGUID>/ channels/<channelRelID>/cpu.
+When running on later versions of Hyper-V, the CPU can be changed
+by writing a new value to this sysfs entry.  Because the interrupt
+assignment is done outside of the normal Linux affinity mechanism,
+there are no entries in /proc/irq corresponding to individual
+VMbus channel interrupts.
+
+An online CPU in a Linux guest may not be taken offline if it has
+VMbus channel interrupts assigned to it.  Any such channel
+interrupts must first be manually reassigned to another CPU as
+described above.  When no channel interrupts are assigned to the
+CPU, it can be taken offline.
+
+When a guest CPU receives a VMbus interrupt from the host, the
+function vmbus_isr() handles the interrupt.  It first checks for
+channel interrupts by calling vmbus_chan_sched(), which looks at a
+bitmap setup by the host to determine which channels have pending
+interrupts on this CPU.  If multiple channels have pending
+interrupts for this CPU, they are processed sequentially.  When all
+channel interrupts have been processed, vmbus_isr() checks for and
+processes any message received on the VMbus control path.
+
+The VMbus channel interrupt handling code is designed to work
+correctly even if an interrupt is received on a CPU other than the
+CPU assigned to the channel.  Specifically, the code does not use
+CPU-based exclusion for correctness.  In normal operation, Hyper-V
+will interrupt the assigned CPU.  But when the CPU assigned to a
+channel is being changed via sysfs, the guest doesn't know exactly
+when Hyper-V will make the transition.  The code must work correctly
+even if there is a time lag before Hyper-V starts interrupting the
+new CPU.  See comments in target_cpu_store().
+
+VMbus device creation/deletion
+------------------------------
+Hyper-V and the Linux guest have a separate message-passing path
+that is used for synthetic device creation and deletion. This
+path does not use a VMbus channel.  See vmbus_post_msg() and
+vmbus_on_msg_dpc().
+
+The first step is for the guest to connect to the generic
+Hyper-V VMbus mechanism.  As part of establishing this connection,
+the guest and Hyper-V agree on a VMbus protocol version they will
+use.  This negotiation allows newer Linux kernels to run on older
+Hyper-V versions, and vice versa.
+
+The guest then tells Hyper-V to "send offers".  Hyper-V sends an
+offer message to the guest for each synthetic device that the VM
+is configured to have. Each VMbus device type has a fixed GUID
+known as the "class ID", and each VMbus device instance is also
+identified by a GUID. The offer message from Hyper-V contains
+both GUIDs to uniquely (within the VM) identify the device.
+There is one offer message for each device instance, so a VM with
+two synthetic NICs will get two offers messages with the NIC
+class ID. The ordering of offer messages can vary from boot-to-boot
+and must not be assumed to be consistent in Linux code. Offer
+messages may also arrive long after Linux has initially booted
+because Hyper-V supports adding devices, such as synthetic NICs,
+to running VMs. A new offer message is processed by
+vmbus_process_offer(), which indirectly invokes vmbus_add_channel_work().
+
+Upon receipt of an offer message, the guest identifies the device
+type based on the class ID, and invokes the correct driver to set up
+the device.  Driver/device matching is performed using the standard
+Linux mechanism.
+
+The device driver probe function opens the primary VMbus channel to
+the corresponding VSP. It allocates guest memory for the channel
+ring buffers and shares the ring buffer with the Hyper-V host by
+giving the host a list of GPAs for the ring buffer memory.  See
+vmbus_establish_gpadl().
+
+Once the ring buffer is set up, the device driver and VSP exchange
+setup messages via the primary channel.  These messages may include
+negotiating the device protocol version to be used between the Linux
+VSC and the VSP on the Hyper-V host.  The setup messages may also
+include creating additional VMbus channels, which are somewhat
+mis-named as "sub-channels" since they are functionally
+equivalent to the primary channel once they are created.
+
+Finally, the device driver may create entries in /dev as with
+any device driver.
+
+The Hyper-V host can send a "rescind" message to the guest to
+remove a device that was previously offered. Linux drivers must
+handle such a rescind message at any time. Rescinding a device
+invokes the device driver "remove" function to cleanly shut
+down the device and remove it. Once a synthetic device is
+rescinded, neither Hyper-V nor Linux retains any state about
+its previous existence. Such a device might be re-added later,
+in which case it is treated as an entirely new device. See
+vmbus_onoffer_rescind().
-- 
1.8.3.1

