Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D904F6F2C
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Apr 2022 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiDGA2U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Apr 2022 20:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiDGA2T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Apr 2022 20:28:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4154E398;
        Wed,  6 Apr 2022 17:26:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236KTkns024455;
        Thu, 7 Apr 2022 00:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4VBD+xTDrv7ic3fHzrAugnoyxmDzOdFCwThtcFLyfUM=;
 b=kfgCrQ3xHjIQumzQLPkl8jM4boNWtsdnergYf7u15HG02AXCYOqIXhrPftqK3PcTVVZg
 DwCFcDgLkB3biYaGSEX84Lw1z5f4JnFreu2dEnkfUneeBZe9AMDsugxQVQjKfyA+sN+C
 FPEMxbEjoTdIVjUbeQPcd8r/+9YW+41kBAwLsQ/Qhx8aWKDeYAD2vqg/nl5sTaLQizQp
 c6VxS7AC+xDYwWtoVZJEa3qNF0Eb1xqOatk7H5HMJ/adgR4GH4F4NSKBloKTchbAxaIR
 6Nz/QGtYojpun8h+5skhsAoeUu5/oGw/+r3T3E2DH/dw69jEvxruo0DubKZxNMUghHk4 /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1tajsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 00:25:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2370GwCX035353;
        Thu, 7 Apr 2022 00:25:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974dgmv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Apr 2022 00:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHUqu8wMc+5BNgLOSG5XOMsN8ev3KbNVUoIQ3Gv9x9XTBePvvYtSmol0aJBBHeN1zzPHzv6e56R7O3a0dukSuCNRkSPE0wyHEGxGf/Yhfe3n5mnCzrF0xMKowQA+Wc+7+VGuyyKGrq3gzcuMhUzKS+nL8OS+0QlDVwhNVZGcc4PzZ11UrcTfW0EXzF8oMaBvWFZrMyUq0ORfm5h+gHN3bSpbLpIXbmvUglB/xUEKXSuTHosBOjMAIx2w0MxJRKz5XGzwR6FCCGf0eM6f0KnKLF4pDNF0EM/WIyoMJrxSl2Qeh85LMWW+NV8c72dgp4jKumw5RceE+JzuFmTHRXRZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VBD+xTDrv7ic3fHzrAugnoyxmDzOdFCwThtcFLyfUM=;
 b=ASj8M2afa9KH38oyc8YA+wYn2gMFKB7/WngAY0QRBO4ssyuJTcTD3FXKtZd0HdhNoN9zWxGTguRBiEn9qbkJigrG+UvHD6BsDs6MwlDtLTaxgOBmYxA9tmI2arXhFUL+mgKBVpnzGWbZLnl5D+ZbZsMbCfmDwK5gnH7hoY59WnOXCctuwOUit38MvzFqDTPLsPBUtXQpMQoZhMONxlNlyyaIQi5Ty7J85dXAd4JlWl4RDLqO/0wmhROKpFYOY4LInMJv500hnEJDQFqtiUoq5UzCV661YedujdTC+7xszqTLKdZ16mPC3+St4tTvR+pFqNtWkO4IRNyvOF9IqwZe1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VBD+xTDrv7ic3fHzrAugnoyxmDzOdFCwThtcFLyfUM=;
 b=ZWOnuZYC2RzkWruEmhx2TXkEiRTBg1h4kCuYFZuu0a4zY6nhqgugq1flS7AsVnBe+0uDTdIGKsV7U/djKYXypWMRvT2KuaqWymoQsy7+KKsX8DsOPUonck5HnZQakW9rZeJP8qchfAA8gy0paqeP33poSCeMWjMl/ZLnSI/vZes=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by DM6PR10MB2956.namprd10.prod.outlook.com (2603:10b6:5:69::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Thu, 7 Apr
 2022 00:25:37 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::b180:d8da:faa9:f897]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::b180:d8da:faa9:f897%7]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 00:25:37 +0000
Date:   Wed, 6 Apr 2022 20:25:32 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/15] swiotlb: add a SWIOTLB_ANY flag to lift the low
 memory restriction
Message-ID: <Yk4vfAd0J5u+wUsq@char.us.oracle.com>
References: <20220404050559.132378-1-hch@lst.de>
 <20220404050559.132378-11-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404050559.132378-11-hch@lst.de>
X-ClientProxiedBy: BL0PR01CA0007.prod.exchangelabs.com (2603:10b6:208:71::20)
 To BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32cfdc6d-28c4-405c-95a6-08da182d233c
X-MS-TrafficTypeDiagnostic: DM6PR10MB2956:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB29563B03BB66A0758EDBE81389E69@DM6PR10MB2956.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVEMdlbl17J2sBucHVU49RSEesVaMFb1Clrv9I8dCMmu32Nqky5c6OzeBII5Glgtnl3qHhCV7TosVnYpNqAD1ZP0+fgZs4fAp0AsQYWiauVL/DQxRrd9uw9Zjkc+/AGktlT3mEfz6P4aPIJNGesLuJKxh+77Ql3Fys0vDG+OOS5Bt9UtRZPnOq+cxcGnGoi7u6MnvCNKBdhqA4JqLdZDDL/hWD3S6LK64ibPmM65VqwiUpdompvZwbNcQayexT5C+NEnJKE8joinWrDXDZecfCcDRBdA0ZvgYHoR3GqFI5zdsBOh5wSOf1lsaQHRPcNOU+aHNbo2l40YWMDUHkfls9Q5tvgZNC6yBBfkAdEizQHnY19BfPzj4BDttjpYq+Ig4CcnqQSy2O8c2t+oYZA13bnbf9wDUQVTci4f8eSjq3r5lwjtbJb3m8pVvyrQ36SA1gNRTyX/BIqa/gFHOTBASChu0gH5SjbSp3c8uKZHma+iO6EyIsUUM2ZFfELUr9QodFTCExDly4oHkK3XxZHkH8n3lMt9uwO6yB0V7AkfKt+dtv9STsV0XBp662ij56m97co7BCGtAYPkXPR/u/KqQx9IoTp5G1iE/CJZOTHLhJrD2VfiXKPTlWKKtKe9h1qHrJDBJluDetb3YIefxI4U6C1vtOa/lgCm7k5fLGsi59zQa+RCWC0bOmjqPXXA8rTwAJgUHe/gLV51EkEAhKMb8iVDyrD2fAkKIHSNy5tOCYE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(54906003)(6486002)(508600001)(4744005)(6916009)(6666004)(7416002)(52116002)(316002)(5660300002)(6506007)(6512007)(2906002)(8936002)(186003)(86362001)(4326008)(26005)(66946007)(66476007)(66556008)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SsskQz4wBvmzjo+shgAHYZrhtqz967Ls1yCu2hR1EII5QJUuEec9hZddsl5h?=
 =?us-ascii?Q?jMoCVVZxvxTf7I9l7XKvCSPGizfpw0zpoEuVsmcUjIu/ajbD2mwj8XbQtmE2?=
 =?us-ascii?Q?zym0dXyHX43WXd2VP6mCBamJKcyIf/PRQO2kt99Xq+ETKb5wC73x+sGHYGg+?=
 =?us-ascii?Q?y05QNUGxB6c6RjDHJz97PXdW2QelMC39x1yHGIOuVMVeRe4hw2jmJ5h42Xrd?=
 =?us-ascii?Q?CNL6skUarjAgpNTl4Q3CN2lPFPd+7ctQ65MZPoeTlVyK0t1hjfJatFC8eWPz?=
 =?us-ascii?Q?2uJwwzv+H3lwKq+vGNdtVuVygEd7Gz7cpBWxpCLpyF+jSyLj4Tp9mMnUKep1?=
 =?us-ascii?Q?/NBbGDF6GCmabUrkaqx3vgaNC+7hy7jzDUCAgezrIIWd9YghYJXkjNXRA5/O?=
 =?us-ascii?Q?xvwmIcoxcyZysoyPUOAhkqWjgmZuyQJqhNKaI2ST3x8LwhgDboA/DvRlOrSm?=
 =?us-ascii?Q?waE759qCrFsxS3Zgwjg8+uZadvfU9Wo8L6qPM9QA4m/QG14NL/fUEHV3zVUb?=
 =?us-ascii?Q?pz3VwACZJ1YKGVHDLioBcgs2us4LXjNFru+q/lOeAsuG9tCYBEErS1aMTFQu?=
 =?us-ascii?Q?4E9UHRy8pQDjmlxZWAX4mhd73u6oAsj2UYz6sCJm65sHMueUwo5noHBNjCLe?=
 =?us-ascii?Q?uVjbnA0jfwQI1Gmeq+tFL8oM3LV+iOfp4NmxrsJHyY4xZVgm7hBso1eAixcO?=
 =?us-ascii?Q?2tjFAWHI6vwAmm9v4uufBqyj2pNm+9xQ9dEFaU1ci8+tBg7rXAUL/jol6xy3?=
 =?us-ascii?Q?SlyVUDUFSfY82ZuZ40u5L4z+Edcw0IEu1o89wJShpzjGlQ7Y5Pc42is9oKyq?=
 =?us-ascii?Q?qkbnKzSpn5BjqpJbrqv3+Flt4SdHcaNgZl9PdlNn05LmMPl3n0uEUIhVgMJW?=
 =?us-ascii?Q?sNkVEIHICTQwt4DYDUlYawUy8Z7xShGcCDcZLNpg84JW0eWGpR1Pjst9b/D9?=
 =?us-ascii?Q?BBmest2UYuvA8Vx0oETCm8gVNJG/b1+VYwhp7Uu1N9RAGzTHoC6MdPSYMRVf?=
 =?us-ascii?Q?0brAzOHH6NiQ1W+3PPGdXwwB7kLnTTneyG4d1I4sbOuthffendrfrn2Y0acL?=
 =?us-ascii?Q?GZoVfqk3gOZcAW/KCRxGglN/b2Xq26Z2FaE4TPV7tpvD3bTWmj7kkybeezs1?=
 =?us-ascii?Q?X5L6xqVLj0Y6cWjmKnQFMthW2mWT0T2LflecntqaMMrprapQmd09mbGv4jyt?=
 =?us-ascii?Q?iHo+g+6PFXTZSDoMqI6oRKK5ypbmv27xdLm164NJ1xLIaHRukE/UpIxWNqVs?=
 =?us-ascii?Q?6X6g3EneVh0MFVHUzPv548h9It+Mar2CTslPF2/5/nwmDTUaxw7oPGaA8h/J?=
 =?us-ascii?Q?wHAHyG3dixVYsXhyBnRbYtIgvdzkkDdl3lSZ39QZFMs9X+I9u+7fLrwsLPEy?=
 =?us-ascii?Q?JjodFzo/uKJlJ56vwd96sFyoWsNVm/o79+9V2a+R1yNR8Ecz3/fQYa+j+ksp?=
 =?us-ascii?Q?iauV9U/Sl5FGzrX7v0tsjMJGgZiQ5x10tOI04ClFlWG61BvB+u6Gavw3RBdg?=
 =?us-ascii?Q?NGTrtTFKAYOogAnxI8dmcE4SvJCtry1oN98pe6++HECrPe+7XFmKcGOZVC2V?=
 =?us-ascii?Q?r5I+LqZXY1TB+br61jHgeMsBZ8f1RUA3Al5csZx0DGwLLkfnovyWv1lHSCCy?=
 =?us-ascii?Q?Kz8VdwmmJ3QRBsjNWKf2b5ofBQRH1OyX81+YMl0V7qNNE20xhxEKVp4Usc2R?=
 =?us-ascii?Q?f0aF5xVNSeKwkPQ19jA9QBnCCn8C9tyr/jkV8c7m257I4bXEu9ozoYUEZOs1?=
 =?us-ascii?Q?7ykTvASgx1RNyUd7FAR7mVJM7jGa7C8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cfdc6d-28c4-405c-95a6-08da182d233c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 00:25:37.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SC6Cwvi3WVhap1WOl4F8s7qNrjaf+C5t4kAYIbVDvnAKVg4tA6BPF3thxGGRhp3sZu9Vwxer3sRzuF8b42s1nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2956
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_13:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204070000
X-Proofpoint-ORIG-GUID: FVZwPHdQkifKkRd3Ow_-czKd7bqyzmzK
X-Proofpoint-GUID: FVZwPHdQkifKkRd3Ow_-czKd7bqyzmzK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index c5228f4969eb2..3b4045d508ec8 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -28,7 +28,7 @@ static int __init init_svm(void)
>  	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
>  	 * otherwise.
>  	 */
> -	swiotlb_force = SWIOTLB_FORCE;
> +	ppc_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_FORCE;

This is the only place you set the ppc_swiotlb_flags.. so I wonder why
the '|=' instead of just '=' ?

Either way:
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
