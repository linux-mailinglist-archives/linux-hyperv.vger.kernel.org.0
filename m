Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E18553216A
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 May 2022 05:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiEXC6T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 May 2022 22:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiEXC6S (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 May 2022 22:58:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E49CC8B;
        Mon, 23 May 2022 19:58:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NMi4uN032519;
        Tue, 24 May 2022 02:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=oTaFs0x1GEjS1MpfWP4eXNcaVaj3jo4qwOOaE3hOjXldv7VMtZvJsNxNebguCIMNyrrq
 /IxEcTH3DB1SO4fOGARnJApYGACeDCrWzM8QZm30h/AkT0rF+O+AVGn+Go3UxSpS0GFa
 zVPiQSScd5YJp7hOxr2d6cHKsO1A2E0RJ2rIYw0r5DehEwwRO5qM+gXOUdvVRZyQrKyM
 FLVXu2kIZLO8UeT8q+3VL5a9917DfZT0HgiayGMO4/yx6o1TLMqNlvSj/RmCmHkJTKZ6
 9Rz4RkLon1GAL57jOERKtPvhukJS/dQkQipX/rvpbrfR9x+fQ1zThBB3wS1UvV5Q8Cb3 Yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g6rmtw1dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24O2u1of034426;
        Tue, 24 May 2022 02:58:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g6ph1xcvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 02:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F19gpaNkZELec8blkjmHrREvufQVh8F2gwAU7CvGUeBgyFHmEwfJqUcNorsffbasdYme/yBLdFGpKU7bueb115NAdpjkhG34sanNaoF5C4aOppF0h0LV2+J4CRMxYEIfQ1y8isXBlt0GH0tFbBmXONMT4ZOev3Rc5BEbXoWeUR1quMyUsKZHeWiP0zsEUeZYr9yV2X8ldP+WNOXHz2SRscLmF9fbU5dDewTB8Nv00tfLH/wTKmJqcu91bVuGhYylAGCzUOUKlf+aZsKuxkkkRJp2n2as4B+cj2cFfM86duq6XS6tj4zU1VLnQwKHYjAwPYWu/EKcdkt55mQOgeh04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=PEcroiBzjeHmBvW8DOk+G0uRdwZOI4H4+oTuCPHi/87r8t69qUKQxQFDIVD4O7Re08BmvvIYHb4OEn8sxRQQY7MopFUrk2FcFwwE4Wjp6fFIBSIgnEjZOMZF3LehwIlv8s06OcGFx4OaAt2ZVJjyx6Vqr/pysRZZPmDQ20kWp1f7jIIYlGkk0lfjFT4+W00BOHGtjBDHfq0wUG5uo1zHlsouzLu19vtChVEkqVowMifnPPCN8IXfOq9PT18+EV4sQ9JmPDdqC5qc5Pd8KFElOrZES1fAQGAHz8QyMyCR+6ad+7KmLB+lxP3AULYd3qx8GWvDzEUYoac7LD5uaKxQug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCwmoTdrJdTxr+lDv04Zlj6RSj5+92JKNmS3/lwNZvY=;
 b=AAweyF2QdQboBWp7i/k1Hr65o0kAVDLuzHoRxyF5hiEcWeRQ5FMwj9AetfjaP7dU2G0/2Q1OdV5tifWZ4PPUF1nlUTig/0D68UL6lJMrrT1/Uzj/2T/MbkfNc9YvIUoLJ4EnSj068aR1jkeQ5gITn5kt2bimf5WkP4d/mrftAAc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 02:57:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 02:57:58 +0000
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        kernel-janitors@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: storvsc: fix typo in comment
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1mtf7iqmq.fsf@ca-mkp.ca.oracle.com>
References: <20220521111145.81697-12-Julia.Lawall@inria.fr>
Date:   Mon, 23 May 2022 22:57:56 -0400
In-Reply-To: <20220521111145.81697-12-Julia.Lawall@inria.fr> (Julia Lawall's
        message of "Sat, 21 May 2022 13:10:22 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:805:de::35) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2611fd5-f36c-43f5-e1f5-08da3d313546
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4685:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46852CC320AE7603F951B28A8ED79@SJ0PR10MB4685.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syN8PcYnuF082C524rfU3YCu3ALEzG+XaIL3BzjJdBQ4n4FbB8ZNiGs+xsPoAZKSA6yOrCLqZEsLI6yL9M6Fia+lMybnZh9Ye30HbBhfwl5LDQGbC2/tWWnytJTuXCH3wqcT39eZWxcgbltwimKAD/Qibbv8AObzzU/RCe9StTjGAaKoSvsFq2AeVvkds0YOgoMCySekk+C7oGhiNac7Kl3gTTsCm/X9Ic02x9ZtkOOGsyzYTH4FkZw55aQy1zb+ghgP1e+I1NFmYZoTfPO+zt3PGTJj7wyfdzc13pyOLYRrMmkftUpkO/ztXfdufngs5TD97xuN025ulVaDk2uDxDwWhR13X8sD+cArhqJ/b52neJ66/f9wFxGi+6rjglvzRMfPPciFeTyDMKoTsYuts3dIidRrchw/wxeahi4zDYH0ZYxGgr+Z8SAT97Ds0aJgd/j7ZXGvEK/JcxBFjMKyYaMj4a57ysPG2rBT7eQsTLZGw9Xq595Tp6B2Z2+cKYNPbbTSwhzqP4xdLn5/ezb5pJxl3b3tOUv+G2LohiwZG01mpKC0E9553muYQMy1E5z2pCkSIrTpHxndR6KsIMGLD1Q6nc+VJtZlT1Ejr+FiOBJH0ElEKjznYQ4JJD2W/h/N/VZNb8M39vanobFob3A6/SY0d/o/TJF6KUO8kfokcdpg/TPmcoqihp+f47nSsZYSil5kpmEFjDVp9pfSUp5Dow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(36916002)(38100700002)(52116002)(38350700002)(6916009)(5660300002)(2906002)(558084003)(54906003)(6506007)(26005)(8936002)(316002)(4326008)(8676002)(66556008)(66476007)(66946007)(186003)(86362001)(508600001)(83380400001)(7416002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cB2GqDnM/6GeIFHUdUhUe5t2b/55GYurYlL8X40obOvJgEqa/ICf78lA6IRX?=
 =?us-ascii?Q?i+6uqIXqrp2ioE4JZV5roB3kB5ePC1tesFJkL8KWE8oEdSzqPZkz9l+qSTQr?=
 =?us-ascii?Q?gz2M2TrlqoXfpSSOTBwHpiJpRDJourvmEeqBTty+9mCB5oTSWUlKv8R+vlPX?=
 =?us-ascii?Q?GCIQybaQrxsxEZ1nv5zh3fTqdxOX56NWKMKESjq35+1y7p8Si1w/QyJ4enDQ?=
 =?us-ascii?Q?2qPAAyGxJx7ykbdaBdtJ8eiT95RmFu4gn//bF51bAE4rHH4BVH5FrsjyExsS?=
 =?us-ascii?Q?6miRTKnZKd2kQPcG1EuuZAQSbMYBuD9aQVYv8DeeR1X1kXAZqzciGZh52hlX?=
 =?us-ascii?Q?SezPbPgk5n0mfvWbm/QO580/d9U7KhTjGuskkuYEzA0S0FOgrxuF25jseiPk?=
 =?us-ascii?Q?gGI6ujmrHiNCiftgOK6l3u29YQv9xYtMarGZCvHdTH8ZLz28Op90QU1r03+0?=
 =?us-ascii?Q?jJzhGX8ewTci8Mfke6elqZdibQDZDd/H80Bd/BzcXvlXiJ9kJPR27HWnDh1G?=
 =?us-ascii?Q?r6GxS2AHrkohRr3Y3sYplpZYZX3rB4bhqN42js0jR2nU2eDs9lFHfuSYcqzg?=
 =?us-ascii?Q?xElx1x+FQm3Ip8RxNsld0Jg83p7YXndfSxHKwayppF9uq9C91PCLxHUfJNxG?=
 =?us-ascii?Q?jCTYHsw5BrWhSw9EwXGFqyikUXIixTt2qvlMlGzaUFH5TQSKGaPjyxG/iszG?=
 =?us-ascii?Q?lTm+QpW4a7uiAS1hc9saUBZtjDqJZgdzE8VE+3nlp0KjcBehcuSJP0EtRNpd?=
 =?us-ascii?Q?c+TC4ZB+RmTZPTVyQGaf33bgTpy+fMZL4HoO8N8xb9Xr44TW7NE54EWF3pXu?=
 =?us-ascii?Q?81SLxPy9ukzBQfLYGLVM2XsOYU7ZSFZo0LR3OTk+Nt74swYXjQVg7xy7mxyN?=
 =?us-ascii?Q?0QySUWut8SYMMRcEPpN2R+u5E25CQknk61VMWJ+FqHk8p9V8WdRfzfEG6eQT?=
 =?us-ascii?Q?O/EclIUtiilscPiYV7Ge4/fX6g7IClQo7bAEag9cQqtCBqPhrj1a/nGGG7OO?=
 =?us-ascii?Q?yTpKqoXHg+fm94oKxgkN5IsJdMc8i5Fvh2p84LS1xcMlKeT3S3yv/jJ5y1FG?=
 =?us-ascii?Q?fvJO/EuEzT0VtlaXjGwRbjUVkGQUy3b6CZnOtOYOMbfErPjcIDxy2Et96EIf?=
 =?us-ascii?Q?6w7sahvF2+XgxvNRjCqOSRsQMD9GEzRhl5KcoYKZklCuJ+LPuX0Fqj/J8lUj?=
 =?us-ascii?Q?1QhVQ0idGoOM5flOE/8wd9TDkRq43BnzoTLs9WoUSLFvD+SZQwFqWuynuf+t?=
 =?us-ascii?Q?yBUVtI7LZHckMo056xWDRfIj/cR8UxX+JAyhzbaH5V2o7f3A+aB1CxDKyffR?=
 =?us-ascii?Q?Vlry+uenMhcYO3Pek5yMnpV+bw1EqjAg85A+ohkJMqf2jK7KgBrwboaA11R2?=
 =?us-ascii?Q?C4GVaepniODeU5ynVnPb1H1n5H/sS1uqarqhNg9Xn19Bqt5iYrfO5uudZo7o?=
 =?us-ascii?Q?EcvsCedVHbmFefKHntAko72zbk+MxmNHWnRU9rw8jBfBMJm3K96DNl4/kTPQ?=
 =?us-ascii?Q?xnIHET1x+8A2iUTXfnXchJ6TVob305gcy+G2U/ux+e/nK0CX74hhlyEUerT3?=
 =?us-ascii?Q?pxC3MCFi2aa0jK0cy8N7+s72DUliq/pCAcSU71zZH4NKU1lxbWIMkl+ZEsiT?=
 =?us-ascii?Q?zVQqcBuAQEIn6CRVeAnbWEkaGesxnhokZMF8Y66Hzysd8zPxbHswKlyiD2hp?=
 =?us-ascii?Q?QGJ4JGSwDalkJwC9H8DBzU4qARL6hBTkQ5vdn78da4pZD4ixdV9afVaHkW2p?=
 =?us-ascii?Q?gfibKx1XTaYQtW9bg3GP25Caiz9KGlI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2611fd5-f36c-43f5-e1f5-08da3d313546
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 02:57:58.4281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJYZOazdvTn1QM+wnAYFzgHMOjkqxFHrReSq9lDsN4cKmwhXA0XMgF9r+BurtsZgP5UW8GIeS+IACMR4/So34W+L0jV2KZFPf3SYD6p0Rec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-23_10:2022-05-23,2022-05-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=916 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205240014
X-Proofpoint-GUID: zTQv9xZ-UAqT-S3fDxjYUOCgA3BdlW9-
X-Proofpoint-ORIG-GUID: zTQv9xZ-UAqT-S3fDxjYUOCgA3BdlW9-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Julia,

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
