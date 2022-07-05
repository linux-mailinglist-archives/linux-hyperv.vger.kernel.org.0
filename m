Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F765672F1
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Jul 2022 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiGEPpD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jul 2022 11:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbiGEPpC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jul 2022 11:45:02 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439BF11A1D;
        Tue,  5 Jul 2022 08:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyouXjCPCn7jtDSoXVpwW4VdNYf+HGPJZWMvfDspZuXfIs0NWMRo3qjSiiLIzUuFvPCJy4zL3p1b2NlfYJnlFkI+OCEOFpmXdJhvaL2wLFOx/6CaoALiSBHEpX6PBkgi0ApQ53Rb/HEjsqzBTOKfLYHjG6y9HmEtdfucwGyQbZJRDq1F6y3e9HgnBCTRk+kyYt5ZupeTZrAbAQ4kTV50RmwHgOKvnzfPNxkK2cC5PCrQ39PGl7WLqExfU9uemebJo8QpMHXej9NB1twzfar0BNiTVJ1CyWO6ClSSk/qpqa7gLzyRtVy6cVK5MU+75lJFBfZEMuBGTMbWLQvt9usE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsPeFnFqp/QHKTTfaOcuAGPTm3tbONgQZt9ZEvaVM98=;
 b=leB86EjX0VsZ2/g9MkhjFAN9G2+6iZwMTB8idYpbz7gKfuZ73Nvz8DvrrLo/YQuViWP7qlTRJYLyzppMqZQy3qp85pJB4qPCFyYp7wxkAGYabOD5iSCatAH6qMgpZ7RGrWivmdttk4xv6imspH/1cqZ6eTrnQRJaYmC7AUQVFaAKp0YIMfZOieH7mTOkRoRnGFHHT6kBxatOxR3NC2ighSZiuDdzQiwl3hPja68ELA+nfdZ2cF1T52piWCE9YI8oSRWodBtYwCpUmv/hRgm1mT6/WrI9z+FewwzUvvGJJ9C6jrSp29ZcN4aQYXLKTe5Vgs+/gezmuaok+DCEFfZM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsPeFnFqp/QHKTTfaOcuAGPTm3tbONgQZt9ZEvaVM98=;
 b=icTVqkECjDC0T6FE0d8ZhH2mlMIjxDzjVZoH/WBDuIyHx7POZ5V9sqkP9HvwVuwiJxeswS32diDq3Ki0Q3OFDrF8P8GYT+BNWISKkAsX1HKdvhvBtI8jMexyapQYy4umRyT7htI/Oh+l9WQlx48BKiOlW2E7oH6Gu7nruzSJW6w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1322.namprd21.prod.outlook.com (2603:10b6:5:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.3; Tue, 5 Jul
 2022 15:44:57 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Tue, 5 Jul 2022
 15:44:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 2/3] Documentation: hyperv: Add overview of VMbus
Date:   Tue,  5 Jul 2022 08:43:41 -0700
Message-Id: <1657035822-47950-3-git-send-email-mikelley@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1da7b165-c81c-4ea6-2fa4-08da5e9d5015
X-MS-TrafficTypeDiagnostic: DM6PR21MB1322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aFw4sn97/SRuJUuqjwAkXBGtOheCmofL/bGmpDGZRWEmK5HshAuCxa8wt+sywWO2N4xs49tKyTTNLqNA4S86Q3LaCR/3yQn1mdrksBQor9QgYJ3jgcNyjCrJzG8Ou2Vv8/pLju1/UdDB97AztXNjNyd8Msc1eK3LSXxRwiy20NXp0rw8PjkJDn6+Uq6z0mtJeGO1hM1C5plxHs6xazO3N9H0hp2bq0EeSwCJdX0i0Is0QCnmlkDPR20dT4/4Tbk47M5tEl/OO08AnFoSBOdHm06FOqT9OubbYJEHuyVxfMmC4H/Zjrrd/XBxbgYrxdXmtkZj/gSVAafRvxRL6S89HsH9x7KfUKGIb3+EH1LAFSCSFfU4kTA7U/3Bu805dvwTKddBtwgP61KAuZAeBjHAANaEJeYNFmnVakzfiPz10ODLqKu4NRlEJ3Hk+mi7ZpzE5r4WsIdALZw5QgXTVFsZVuw/48uS4z/RIeAte2QOeciS/E8npw4Hgm5IWcKf4KpUX/5NjKTnG7fbPWS9SdfYkMbmKIrppvPdTKWpjarrxySJnT/GMCelXvdNX7btmWWKZs87476mOyP6nDBwrPTy6Rae9Nwm/A9SFzFYZbYRWUxaMEngjaEZJ8ZYNcNftR8CEQbRcIuA5E1apUcn7EULsKKLIzPo0mMJrl289jxUwENFcuLPgvKolvMie8Nxy214eBugptVxKYje1+/Sm5o0jgqlzvXovRNWh20XrQwocui7By10PIFvIhMdEzz6I+TRVZHLCIhPTXzf4u/i0ZrQynvJnNWETP44pWB8Ga2+n1hjLvWx8qDwI8LzwlV8j1JnDbAirdVIk2Ytt6i5ReXR8aWI+JnZkcuEletKnUqmz4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199009)(26005)(41300700001)(6506007)(2616005)(2906002)(6666004)(107886003)(66476007)(186003)(52116002)(83380400001)(30864003)(6512007)(478600001)(6486002)(86362001)(5660300002)(8936002)(4326008)(36756003)(38100700002)(38350700002)(82960400001)(66556008)(316002)(82950400001)(10290500003)(8676002)(18074004)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G83/AQeH3Bt7i7j4tKl47C5f9T5Lay19ofmpa7JnAt9aVKys+wov4zkXa3Rh?=
 =?us-ascii?Q?BK5s40+0BOEV+QmnSgeoA6ApNwwMw4IuBRN/DHJfO/HQRtFwy0vCPGj/LIrb?=
 =?us-ascii?Q?7yE/0NwhF5apWsWXH1XrKZCj+3IxMYt1mvAyDiB2ZjjNEExe2BFclNoluWhn?=
 =?us-ascii?Q?TMlJuWewlPUQ9ZxneIdrJMmIzdO5osUU/s2lu7SEbF2o8inSbRagO8S5Y5+N?=
 =?us-ascii?Q?CjCrV4f753cbtodI5WR+5+Zi8tHQoY0VHOCyFJjYtc9EPqZKihIhTek4ium2?=
 =?us-ascii?Q?lhkybG3eG9lsgN2sh4LXRgd5qtAz6/Y1TIcnBqRTI08bSPJtaJYF8r7ECGeU?=
 =?us-ascii?Q?ZWf2IbmhdeV/EaYOKSvve0CSn7vThwjTwlzkjjvKsaa1CsBc7zTNBdlK0AT8?=
 =?us-ascii?Q?BF2JMzBYbISqkFbCCnJRntl4HWUFi4FHx5HtBs0OULKs8urfePax/wuumH7x?=
 =?us-ascii?Q?o3nV4iFOB9KWxMLa9u6Nwes0FehYhAdsSgZ8CpbYJovijvXchhapU1kAW95m?=
 =?us-ascii?Q?70tiD+BeHKmEPJ19wEAO6thXzH1CNDFhK2l3KYa3Ghs20ElUMm993RZnO6sB?=
 =?us-ascii?Q?WdlgC0Zs+RtH4j39zkD5cA6qIl30MlhHLT1ryer70LvK9lWaEYKvo7bcVhiX?=
 =?us-ascii?Q?2yQYH56YnoAhvffG+H5IMnJl3mHJ+bdvW942CpBhiFTqEHg/0Z7zuqFo2lWz?=
 =?us-ascii?Q?MifMfgD5dLr+RyrzS3d621lkH+/g/54g21zqNHLAwW5rVoxQGkCzHRDNPhUW?=
 =?us-ascii?Q?MBsKxjmXs3EZWAAL2VerV+yC0+ZA56/XbbowjS+kW6VlyqgtXqKqaZ+P8soM?=
 =?us-ascii?Q?V2i1aN+rVrH5G9yFPlDJZsdjQNROtx2pXNnotOTyeP0kn6+aT4kGQA+MPVr9?=
 =?us-ascii?Q?gXZ7iLceV4rTvNZVCr/okgFBV6DGyCDsEChNchlrhx33UwBqR28WH4d+c6wR?=
 =?us-ascii?Q?Ff9InFEZwDVdImELxO2uf//wzeIbED4M8ydY8QDauSFoxKF+lt/HQWRIaP5r?=
 =?us-ascii?Q?WMOr+wpOHQG0WB8FnYgCpJMhl37xwgpXv6IbkbT5TQI0+5GPeVZw7azjHiU2?=
 =?us-ascii?Q?7QEuv02DJE74I8g+9ij9vAZVND49tn+9V/m2AW5oGQmY1nYguSi5MQ8llWkw?=
 =?us-ascii?Q?xAaUysdYKw8lF9U8dRh/AzKsZL+8kLvRveSWk84CUJ6dPCTYmE91m1qqlm3e?=
 =?us-ascii?Q?rn0n0vV+ofCVeLhRzdhwAz7e+iFOeqFcNqYPc+r9qFu9DlBwRj34+mAgU4iz?=
 =?us-ascii?Q?PTRHa+yOpEL694bIj6X/zrOGKeR3arOYCpenOhYLLTKKiL4WhkuDuCyP/eKD?=
 =?us-ascii?Q?jj2Deeld+VqTKuO2py30iQZtvx2QjBJZqHxga/P0huZnnHN1MG1WneexLF2N?=
 =?us-ascii?Q?SYluKI+G0GlKJNnZxWGWaJ35R+0Nuq730gZegAWpPXKdUnchEGCT0nugwIb3?=
 =?us-ascii?Q?gkRPDv+Y//szCXhyHadQmUULQWjdLnagcBfqqXKegGIPv3AKAQel7Lkft6nr?=
 =?us-ascii?Q?eIfI5xIJxWMzQ6gwco95XYmaYCds1ooPuJvvfvdSI9tLjvJRCl7zTwyervGM?=
 =?us-ascii?Q?ziMWCA5yL49yn8IdyfeFQ6K7bsfPzq+zxEPC3ZVOeOnvlmj66AizmmZE+uWY?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da7b165-c81c-4ea6-2fa4-08da5e9d5015
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:44:57.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeC7MfUmObtgHjkN1ZvRjazb3V+sweBNG7XjkaL6TzLxZMCsbNQFx22p+/iMPXvijlN/XywmxI42/OXQ5TzR/w==
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
+The guest then tells Hyper-v to "send offers".  Hyper-V sends an
+offer message to the guest for each synthetic device that the VM
+is configured to have. Each VMbus device type has a fixed GUID
+known as the "class ID", and each VMbus device instance is also
+identified by a GUID. The offer message from Hyper-V contains
+both GUIDs to uniquely (within the VM) identify the device.
+There is one offer message for each device instance, so a VM with
+two synthetic NICs will get two offers messages with the NIC
+class ID. The ordering of offer messages can vary from boot-to-boot
+and must not be assumed to be consistent in Linux code. Offer
+message may also arrive long after Linux has initially booted
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

