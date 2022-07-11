Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C350B570969
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Jul 2022 19:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGKRsy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Jul 2022 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiGKRsx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Jul 2022 13:48:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2107.outbound.protection.outlook.com [40.107.244.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF6013D1E;
        Mon, 11 Jul 2022 10:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIfex6yhJSAelM6OMx+G6V4aeq7/Mk80PcfjfiK4vMREzYqTlth61il2vjMfLmvXhkknRXOeXZf1+SarDM5ct6BE4Zi8bT0YB5ZytOU5A3/SOM7QPueyDVk0Q4tBeSulK6lzRuFJDmltS4seuKc+AngfxNnHfAi9EvHOe0NbyKLoU4jpNhh9RLscEzrwmgOP0PLz17F9mLoCHAPlh6nw8ppmng+wVM+xfQBOXYDS/6ypI3Anuh+Ik6kZaAI+v1PCSdJdy019wIoaMiB0c8Kjg/mSAklBDHBD7xFYH/6kabEBFgseYMYd1rL0JMOSU5wH/mSGUudlg+59mm9oZLKfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aem48oJEVWgZkJlbVKsiXfnWlhd6TvtfYMFzOebWRGM=;
 b=Zyd6C1zcfIt8y69i/6F/K4ebyVNhq9s8KhkJGHjWFzKu1Pk7xnqKbkwZmMbaocPlqBZPOOxr+6+oYqut1q/LHAFzwwecgs25D6CIIL2KdNbd2mRkjSffGiiyMJ9t0Qn1tzUR3A4H3NKbF+401V/FUGBmlCipVAQWNmKf+Ar8l5KIHSmmRcanFWUAhmFAcVPGZG1UazqH6KFg1ivd7Xyb6kH3mQc1fyYX4aJSCsMMOv7C1yAXriz/4KrbrWZ/d32T5ABjv1x3BnqZu+G3OCx22bj6uqsQpQA1sAXl2whJIulaJfXz51n1RV2s8d3E8cZPohJkwBhCn9uVZTABYT1efQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aem48oJEVWgZkJlbVKsiXfnWlhd6TvtfYMFzOebWRGM=;
 b=XPxmxwoRII5zjAE0Ky4Zc6yDIdciE4b42D3ZGR6uhqlDn+5JMKzJyXphjes647OqSPdQ0BXTRqegrkib4dGx7PLllkbbv6+R/w/PDeRbrdrdp9vmb779naD21ozkqddopPkFF2gGvRyBOb1wYFxiqNK7LWGdwYHayemr5EK4cik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by DM6PR21MB1321.namprd21.prod.outlook.com (2603:10b6:5:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.7; Mon, 11 Jul
 2022 17:48:51 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::684f:525a:aab1:bba6%4]) with mapi id 15.20.5417.010; Mon, 11 Jul 2022
 17:48:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH v2 0/3] Documentation: hyperv: Add basic info on Hyper-V enlightenments
Date:   Mon, 11 Jul 2022 10:48:21 -0700
Message-Id: <1657561704-12631-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0013.namprd21.prod.outlook.com
 (2603:10b6:302:1::26) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993616d1-ca37-4b66-7cbd-08da63659d42
X-MS-TrafficTypeDiagnostic: DM6PR21MB1321:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRNUiGZiHJge13SjbKrxv/IRaw54YPamHGkOA0QMV/niN6i8eX3lCPXF71uCPKeVcqLpK4Jh0dKAKcS/HXWlIrWC6ipIatfKl5UjzjEZnRx4v1dWNrgCdlcrVGduHcqfSGkabkoJ3ToVpwMKZ0rXnO3mTvxGDzOBnnAdcGY7Fb16Lz/4Nd2xodasp0oN+otqceIL6h4AP7ODiPrDMOEjLli6VxZgAFpD/wUP/vg8NnZ8Mfihfb6ICE1X+VtXiNO9mIVjqNFI/iOE9ZRUUbGUT2+l/3QcENXfS2iegeDmsDPM7kaoaECu8EVWISaNmDzZrBhasaCtXiWLv7sf5MbZCP8iizRBIigCutBkwkb11GmqByLxPdXXNpokK5Ys+abTVhqyDsxvR/pisoKf/T40CfcGaLQtp4WyD2k5ZIUPvkEr8k8YdIInuQyvElHCLQ8gdVwKBfHT4FiLLXwBKAD+DEgjJcUFpGqXtoyNOY4gmUyE7FPdAfAjYGeoU4pn0J7mc79V+k9nTbFf3CM7RMQeT+29f4IEvOTMvYFhI2JpZniyTDukFbijRTvcZ7KmRDBEe8OQlw1dIR0AVOKxU6j546ZMYsgHTtJ0H3bqNNQqJtGcMMQP7208nup6i3KtCSJvpoNrUUepWHfUsAFXyqaCt0bDxmrSqIFpFff89czTk+fzxcE23x9VbaOYqYSOKEoUtDwK02RMjKNCZdeQ6wV2HUbp+ELvPkxfGjEJ5ixFHXYW0OFGo6AEbGccKewNBaVtAs8rkH86Ul/Z1Jun7TmOJDYuBf4vZINEzDGvrPHiH/Y5aAWgAEaekxfG4kDguq/dyNpVrMl7dR2zu72n3AOl4IBdvWMhaQnuboyN3m3YnyY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199009)(26005)(82950400001)(8936002)(5660300002)(2906002)(36756003)(6506007)(82960400001)(66476007)(10290500003)(478600001)(86362001)(4326008)(66946007)(8676002)(6486002)(66556008)(41300700001)(2616005)(38100700002)(83380400001)(107886003)(6512007)(186003)(38350700002)(6666004)(316002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pdOdaXtbOkgCuxE8BqoKbmwfC/Qtc+9ZwayPPpCFnHJMPP1neqr/keCn+CHJ?=
 =?us-ascii?Q?SzIQKVDGbI4so9HAhuKeHexZKbGX6pCoANm3No8aQndxA3ziNvQ107qpV1Zp?=
 =?us-ascii?Q?jmSP5J/I4M5qdPjslGLNionT4xOhVVcP2ViLS/sBoGPmRIEzYWgheTphRcPO?=
 =?us-ascii?Q?AzW/CaamFKJqgoSAOBJreWHDzL51seZUezTrZVxhU5lRuyd5bUAYszqNrMkw?=
 =?us-ascii?Q?pP5WaLN1Atx4GxN64vDchOvu9r1YoklJDTWtcinuc+EwvMFzcssi73yUDs3B?=
 =?us-ascii?Q?2N4YGokjg6pD3+LnVx9aL/2b9a0dwnmQ5RXIfpMidH77WI/W532EaB1TVR1d?=
 =?us-ascii?Q?dyqV6Z/ibtbx6iDMMrNDIusDJidOMh3vY/8bDOr2uWLYpa6YO95HwZeLZJW4?=
 =?us-ascii?Q?ZAHf426SIILIMGTCw56WQbJyqiM9P01nZ8K4ihtlFQknas4UrWNaHG7rXopC?=
 =?us-ascii?Q?JQObmBiZ9GMfRIgiV1imSRtyJKhubNxdDkIAxEaEN4vjYmMd2Iq7yJMPPmVP?=
 =?us-ascii?Q?TXA1IFeW2xI5/guWfMgshlqtYH6CmoNRBNXqBG441NXO2a4oFEsrCK6a7tZa?=
 =?us-ascii?Q?AgrisJAit3uqPUjuX4Yng7Gsqqark0X0tbV77OTK6zERP2gBTtz2kX7L5ZwE?=
 =?us-ascii?Q?AtLYul/Mo+opSSHd7FHUgEtVfbZXWLTFGwBFesqWaxX56kfGCWlVwdC9pevR?=
 =?us-ascii?Q?rDIRFeDYMOkxezs75NlbvcM/plCDUvIqqQ1gwerFfYkSzw5e2Yr/KRTHcZAO?=
 =?us-ascii?Q?VCdtlyilSwf/R09Iw4TntnTnxy1Q0l099r4drUlxRU9glULQF5WaLhDtQkbM?=
 =?us-ascii?Q?dz7f2+mJ/sVu8VXMk/nZDJuWSwK9k4pa36FqIOd7t6mtTBLKLFzYoXj6JRF/?=
 =?us-ascii?Q?k5bt3QNykhteReRc/cHhM812jHB/qLentzD1wY8qvd5Ss1azatWCWNIjblVE?=
 =?us-ascii?Q?idAzh6FjJ3mLNM/FYvK4DILL+CQw/tBk1EmIUEzcaDy7ueTfOMOfdwKAAgww?=
 =?us-ascii?Q?jJ1/zxv2/nSqLUEWv/OZTKdM9WMOlruvOsD3a/qy/8qt8NcOQsgHf5jUzcAR?=
 =?us-ascii?Q?N33pGqUJ8wSg/mYhISTawad/P/c2/7IqPcp44MCskzhKFlaETCINYToxJkeA?=
 =?us-ascii?Q?buSKgzPeFYkA7egVYC9W+sXNK53qC5vmrsndWi0SKvqEHMsYpVJeERs3h4eR?=
 =?us-ascii?Q?zg+QV/lFmQFMnAdCKVyO8NujOchFQCFiemz2O7DeVEtfUz1K4wdlcdX1w+H2?=
 =?us-ascii?Q?Yin4axWxylvIa1Bt0+72adVQEJRoz3zqCMtLFrrDSvqmcA9qe1gsspMX5ORB?=
 =?us-ascii?Q?h2/CANjA6kXOsVzFPL/hyXpu4Mx8clFfN299BSnwLHzFmifHIdLYYFQnWG1e?=
 =?us-ascii?Q?HsMVaLmb+ik5lZf+VyPk6WzmzMuNwmSPvfijLItiVty8bqeTdueJYjJyitQb?=
 =?us-ascii?Q?dwGguqXxvvURhRK4TIj8v3zW4grYDLy/FNckT5v8eTp0BXw+o9wNUZQ/9Zll?=
 =?us-ascii?Q?N2b9bYsbFMIUK0iY2OyQ0gSdPjWWZYj/Kuh5opCubkydENzkFIgbPae6lofi?=
 =?us-ascii?Q?gGt8b1UvOoSO+N/ifHdbrp1CkuXcsBc6SO0FjKqB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993616d1-ca37-4b66-7cbd-08da63659d42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 17:48:50.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SxF3yxPnBjmyanz+yktkFFBoVdsYlc9kb8arM8wYxJ6vPT0cdcOUsdFPkmL8tLJNicBljmdvX7QPCg7i5maLVA==
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

This documentation is a high level overview to explain the basics
of Linux running as a guest on Hyper-V. The intent is to document
the forest, not the trees. The Hyper-V Top Level Functional Spec
provides conceptual material and API details for the core Hyper-V
hypervisor, and this documentation provides additional info on
how that functionality is applied to Linux. Also, there's no
public documentation on VMbus or the VMbus synthetic devices, so
this documentation helps fill that gap at a conceptual level. This
documentation is not API-level documentation, which can be seen
in the code and associated comments.

More topics will be added in future patches, including:

* Miscellaneous synthetic devices like KVP, timesync, VSS, etc.
* Virtual PCI support
* Isolated/Confidential VMs
* UIO driver

If you think I'm missing a topic that fits into the overall
approach as described, feel free to suggest text, or let me
know and I can add it to my list.

Changes in v2:
* Updated clocks.rst to use section hierarchy that matches
  overview.rst and vmbus.rst [Wei Liu]

Michael Kelley (3):
  Documentation: hyperv: Add overview of Hyper-V enlightenments
  Documentation: hyperv: Add overview of VMbus
  Documentation: hyperv: Add overview of clocks and timers

 Documentation/virt/hyperv/clocks.rst   |  73 ++++++++
 Documentation/virt/hyperv/index.rst    |  12 ++
 Documentation/virt/hyperv/overview.rst | 207 ++++++++++++++++++++++
 Documentation/virt/hyperv/vmbus.rst    | 303 +++++++++++++++++++++++++++++++++
 Documentation/virt/index.rst           |   1 +
 MAINTAINERS                            |   1 +
 6 files changed, 597 insertions(+)
 create mode 100644 Documentation/virt/hyperv/clocks.rst
 create mode 100644 Documentation/virt/hyperv/index.rst
 create mode 100644 Documentation/virt/hyperv/overview.rst
 create mode 100644 Documentation/virt/hyperv/vmbus.rst

-- 
1.8.3.1

