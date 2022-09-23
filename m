Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905C45E7D72
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiIWOnr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Sep 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiIWOnf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Sep 2022 10:43:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3DB12FF00;
        Fri, 23 Sep 2022 07:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNPVCOW057SiibBaCt6/KUZx55gy9GcPSeyPM4v0lMVX1NFhW+aGcy1AbcZgKKIj7TsT3WPWP1HEZB3lfBVBUxlryIruCBTH8lcp3D+MdUqf+4f39qRudTvixT3rDRsrzkUugXqjsW1i2UBIcdlavKcmmJZEGr7p67Aj1u9hTLuvrZ7MJfBeKmwWd8tGSt7g0pAFDlx+MKtwQtD3kvA/03WtuQKb8nwa4wNf11RTOQvBojF6P87+KZ/ZCP9V1/EMk1QLfGzJcw2L7ZIftoAVJg7nIkfLCInbMg/eqC47vWMxkfTHbd5QxgfLBpZgkcZSwrnUksD/nU0+DvTr01iLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ru/KvvKVueHAwl943nyQ5JXHO7BPxvUwpIJlqUgYFo=;
 b=Q6lJ3Dczem5GyzWnQlKVKIkmah7yuTifpbEmJyNTqyyLIh9bfEyfo2pbzgkzs0o7I+BoErx5jzAfteKnAcE6YFZeW5zUSaQo2cJUTC3b+gbHmyQ70LCmqs8RXGFcG1boIKX5x53u3MfGD/IgSFmslyN1ldTOjWe8vnIcJeGwac+v9oWJcR26x99a6KdpsLGATa2RnhJeQf7Mz/EqyK196WFhYWc3dc3N4ouFrBcmKpFszfvUqDaewLWhaBTa79hk6UCm9T9zwJ02K/+gUqlk6noIUwDVC/iOCd1Tw7dgkouTEjzvfPu8ye0eC9h2dpsiGL/SVw4viIzoxcjMX453Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ru/KvvKVueHAwl943nyQ5JXHO7BPxvUwpIJlqUgYFo=;
 b=pR6RZrAwsjwxFJ1CZz5eld43/usBFI7XnJrccGSAEQSGq7hhG5KPpwWz/z6VsONBv7HfmaWZh14URFroRvZca0BRshg8nxW1Z91Eb3RZZFO+8LTJgwpDqYSQxsEJ5YMW6XflCvsqiIhHR0icsDt5dTAaV+x83ZkHnY894LPASDw9AyuYalWjdWXbyD9qho8zGevJuKuKYNxo6r+ZEULzugeIllYULJUupyv7IGJDJwm7Lw5+TFDLDvnmvtCeMrsXoATm224oG+MzFRPT11YJO8ZSHAWrwnnfpOllWs3ErZJi6V6R+l0FYN87qtViJBhE2s/4NAxAV0F90/XPYBuoag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Fri, 23 Sep
 2022 14:43:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 14:43:31 +0000
Date:   Fri, 23 Sep 2022 11:43:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
        longli@microsoft.com
Subject: Re: [PATCH -next] RDMA/mana_ib: change mana_ib_dev_ops to static
Message-ID: <Yy3GErfUGlJcozHK@nvidia.com>
References: <20220923144809.108030-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923144809.108030-1-yangyingliang@huawei.com>
X-ClientProxiedBy: BL0PR1501CA0010.namprd15.prod.outlook.com
 (2603:10b6:207:17::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7582dba3-36d8-4b4b-9abc-08da9d71fc28
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZ4KNMssoAjVccS3fyJeThNlNQwu6hlVQYhLWINb7NoB/pHZ9SWuRy6tHZhLNqGDRb9pnrWVAh/k6PLSsFYSVyUmhuRLjcjwHEyT2EbAWaxhNyc8lfMD9XpbvzJZ2JjL9SdivzjdYS8NMARjjmihzG4HK6bguN3P4+XtkhHB2RPRwobz6mDFMdc/BrHilxuP1pv0frsFwgt9h6z07RgdzJ139xDk2uqTBWCoGAgg/QUxpte9vceGkm/S5qYT31PZ0GF7Vna5DhnzVidYsNcLu5DCAhiWzoS9VLhiKkesZk8eypt2stuVMp7dzoniod4zjzkNr7vIrH0LcJlhwRcx4HZDWk9dZ7GlbLn2FM8/ctOSPPZOcPdzE2B2QG030E3gzYUwBKn4UWOVNqD/9Fum64zyk5i9h5yaDBcV6Q6Lhi3+NVZJD/idufgGq3ImotwJC4qalYfPTZZ+AX/Rc3cxmSMYUy5NVIQ34SbYwm/iHL1XhMYR6k8Sy71ZcBZz9pYCxylJVR9dAR6vuZvdk3mTFyugGCScXxVoUWcwL53928WMR1r9Ssx0A+ghxFGYZG4l/OJl3hh1fXKbNgNL4rX+DnfxX4AlKAnZ0uqVqpVIBaihWHm8/Hrr1xUcKHzFyDJj4tlhkTk5bUi8Xryu+Spy051gD7Az+ADGCA7KJRYipWSsKYLUlXsQmJT58h7XyYJxSGgs5C2cpvjYIdgGLkAWPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(2906002)(83380400001)(38100700002)(6486002)(478600001)(45080400002)(4326008)(6506007)(186003)(36756003)(86362001)(41300700001)(8676002)(2616005)(6916009)(66946007)(66476007)(5660300002)(4744005)(26005)(8936002)(66556008)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cqdq9U3eiAE99v1HKvAinAYjZuwCes8zkkQaSKm+baymVia2WYvQJcYIlMYx?=
 =?us-ascii?Q?nXjUGoCacCuj5XEj/24g/+RxusJ8mn4Tkf7odMz752sJF+Kgl4/a+ThgRac5?=
 =?us-ascii?Q?qknIPPr+tXc5wIcKlJ2ouyTKW2OU4GDHBdrV1tnFP55z7wk24/29mskebPEI?=
 =?us-ascii?Q?okEbgagPcQWTR/RU1I2Hbibe1M7z9tzxABG5T9oZZCD+6Gd/BSiMOC+8qfa0?=
 =?us-ascii?Q?oNinwG4y2BE2z6haul0OA0EyQgGINIfDLADmc7Su9Vi6cmyQhnNeTA1up22p?=
 =?us-ascii?Q?QGFJko/n/qZgjil23xRocPviI4xvYMMi89EarO8UgXKmWwvhiDnWJgQJG7qt?=
 =?us-ascii?Q?U5rHA7cilRYL1Dynsq/tdUAiC8l8w7z+paKadwDEw6USu+uu6AmQW4KBacLx?=
 =?us-ascii?Q?AK6PanDsvIymXFT+ITbuarKPjwQ3Om0yEA3/aAaYcRnG4xHosI2DA6raAG12?=
 =?us-ascii?Q?b7lTB605bdpfVHtvFwMWmq03Mu4BtPcjx0V1gO6jqazfy9r2IhoWoWbLocAO?=
 =?us-ascii?Q?Aae88s2OEvdqeOpFEkoq8qauIGfS/87Pe+kXUgZbv196VpbTUB5R9tTi6fVN?=
 =?us-ascii?Q?SSdtAnveW05PEpJE5gCV3K9p0kqSVdgYY14Kqg8b3d1oljyJLsSY/xbmmg9n?=
 =?us-ascii?Q?TtyBQT/0ar2EqIWQKZGEQ2iOmI6kGpplqLAj+xHfmw2QY75ixyHVpYftcLX3?=
 =?us-ascii?Q?UPWoW1BBtuAgu+RFsP37Wsye0cHb8jERUr3DFKuxxc3qAIcpZvxySMpmi4vS?=
 =?us-ascii?Q?/ujqZ8HkMt15SyJsIYgYrr/nnXnBWZ4TC08qNi4uIueHX0ULMw1SrEUQZXyu?=
 =?us-ascii?Q?0wUwjyZvfyC2+BHJ3GLA5VMPAA45lIEeXjHJg7nq/oAkYsJO4c+c05P1OVdu?=
 =?us-ascii?Q?mPU/LMFtkC//RsYmL6hD3qB/xZNKkn48KH54AJe+FFDVUPLTMgpa6pAntIzO?=
 =?us-ascii?Q?8Pa/tcgjnNm409RYEd8kbWzbqZfMz6p2eOxH0a4CgYFXS04Ft0i4EmaareXd?=
 =?us-ascii?Q?RxGw9xTlxXUbsh/ZeAR923MvgnAaeV6Jkk9MZCLpru6ucMtUSoZ1CBGnLzvI?=
 =?us-ascii?Q?eIYEFpYDLF6TgUGB3riSMwOlZd5nL8kh2Nm9nGMKZo0WXYtKf0lVDJ3W24As?=
 =?us-ascii?Q?TE/iyADxhbnOQ/AaIrasKTwwjXSURbaH6RXxFrn2kuxYrwkeC9wg4CSZcygv?=
 =?us-ascii?Q?GgI6rLyon+NxBM4FBnwA/uEUCes/D0qMPE6jBCdmxPMAd0fj2ea3GzH3HsmA?=
 =?us-ascii?Q?h3piTcrM+eYsztKDglUaJLh2zQeSxUZc3ZO7jBZ9CWBAOKpwluSB9yf6LiWi?=
 =?us-ascii?Q?3deWe56/BLm/9RASWwAqJJU1sBHVcqswHZHRV25VJfUxD4uGUm4IvTOzSa5e?=
 =?us-ascii?Q?yX2316HeFkQ9yOdoeDjDEmxBUZCcatPsx+3LcdBChP6YqBxqMHBfEi3PZ8Pg?=
 =?us-ascii?Q?GDVDfcqc7Qgf/iqvs07rJ2PHDvA8K11bzLSDbr4Uvhg3Q65xhzSqawjuES8c?=
 =?us-ascii?Q?SmWeuUMA/pu935b69VMwM3GK27r5IePGqQuH4fxSh2MsseV1ZfMJVZwn5qVm?=
 =?us-ascii?Q?o9mNPGj1MA0tpkxIBEPyrXyJcdbW3HKuTwwg0SGT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7582dba3-36d8-4b4b-9abc-08da9d71fc28
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 14:43:31.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2H271QwwNPiysxu51/LwVbIISSVqrh9Cnoa71FqK1nSxUaoLNu0CAEwlyZBTtt07
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 23, 2022 at 10:48:09PM +0800, Yang Yingliang wrote:
> mana_ib_dev_ops is only used in device.c now, change it
> to static.
> 
> Fixes: 6dce3468a04c ("RDMA/mana_ib: Add a driver for Microsoft Azure Network Adapter")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/infiniband/hw/mana/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Microsoft folks, you need to squash these sorts of patches into the
next version of your series and repost it after a few weeks. You will
probably get a few

Jason
