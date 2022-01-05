Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F503484DB4
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jan 2022 06:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236277AbiAEFlr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jan 2022 00:41:47 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:14056 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236153AbiAEFlq (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jan 2022 00:41:46 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204NiYFh007074;
        Wed, 5 Jan 2022 05:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LPNiKjvlJtmJ5SGw+NjYKYUyuK8drLQTKYMW7PmOUe0=;
 b=S1vtk66j5zdntbJzJ6b0+yRH7rbFc6EonerTsZBfilIygMZ8w9SLOVBkoerLIHhPEN99
 TYjAsYnAQgNTRi/DxctzmOYezkBoNNaoQB3vDBgbeDm5TB/eBG8Rw6atLPmXcRfJN4Nq
 CmIYNM4hWYs/wqOsW6fZc2Tj/o6R8bKHC9/IYhaaCck8PmyIa4H5ezmZi4xpOVlSyqCG
 tZQzMthhq0M6wX59I30UTBiv1o9pHnDDyL79E4jV7WjHwF0bangrbvub/9fR3qxsja0O
 grGNBFPyCQvMuUEULL444UtLVA+dlMaAy2IOhAtEf3VGJX7QJguYIf88ThxGHrYsh1IN UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7u9td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 05:41:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2055fG7n001627;
        Wed, 5 Jan 2022 05:41:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3dagdpteq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 05:41:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrnBVIMjSCnXZMSU+KLHFqCxCZUHG/t4XKTzRdLkkJJIwY25hafWGws/YBG1KK6cKwCmRQwDSVs0T609iACd5ALJcbnYO1CuEr1rvh/Zo5xX/5QpntoQocNOzH3XlaK2gGtloE+KcNrteBMGnuK//D8MrFDNvtDSgx7UEwG5AZ8i5vgAMz+aPto7jay7eZJChcUeX3+0mBJGIvx2UeDb8IcY/9qUFhOwNEqOSC8pnCDfexMa0+zaVIi6IM2LvSKf3cXLWAz6Z/pnxtjLhQwLnJD38QVaXndB2WfAVj5RB3JpSfXfdhATobJtzfWPenDzOcVNcaKmfP143VtkY+NS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPNiKjvlJtmJ5SGw+NjYKYUyuK8drLQTKYMW7PmOUe0=;
 b=PlVooMDeIlE9HTh5VsFBLaoEejrIXLHViDX0wV/P0iI7F5WmSwapaLQA+jkAbEYq/M6ANIKji6bEgF33Y0SWPNjrgOkfnfni26DmjGrnkD6KvbFApRTBymzaFUq4N9+xSCmrvqwqrkP3Klinh8z7qIaPxDr9V7SdJ4xETLcCBec+A2VtWrYWBBMhAo0aKKsJKfmA4mKiSN1DwAX/OoY2x9mUG847tgteig7tEzjzPM2rP/Z8fbGR5iFYEGG1R1KFtFRJtCfcSDMkhz6eNoW4wGE6zFINP1+5zdHA2FBcASwXMyv62uzmb4y4DGLao9SBWgGDgY4mxNiE6WmESsq/xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPNiKjvlJtmJ5SGw+NjYKYUyuK8drLQTKYMW7PmOUe0=;
 b=Wxkq5bLQOFyTMbjBXgPCvT49eywOfaSFN4SnMx7atZuRgZYnCrJkIPH2W6IRFGMYkmSTAw1n2Yh9aFmDUxrkLJNoitZiRg7DiFrZQ37tlCocO3owHiD1uD/F/sCSro1jN/MryUvv/xm/AoDk5zLKtPl8tQaXTgYOD/9rF8MdzLE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5596.namprd10.prod.outlook.com (2603:10b6:510:f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.16; Wed, 5 Jan
 2022 05:41:33 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 05:41:33 +0000
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <kys@microsoft.com>, <haiyangz@microsoft.com>,
        <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <decui@microsoft.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <mikelley@microsoft.com>,
        <Tianyu.Lan@microsoft.com>, <longli@microsoft.com>,
        <linux-hyperv@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] scsi: storvsc: Fix unsigned comparison to zero
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135m2zqw1.fsf@ca-mkp.ca.oracle.com>
References: <20211227040311.54584-1-yuehaibing@huawei.com>
Date:   Wed, 05 Jan 2022 00:41:31 -0500
In-Reply-To: <20211227040311.54584-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Mon, 27 Dec 2021 12:03:11 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01a719d-e146-441a-2591-08d9d00e0804
X-MS-TrafficTypeDiagnostic: PH0PR10MB5596:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB55968F793426F4EA73669EE58E4B9@PH0PR10MB5596.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNZ0FNcAr2AKPedlJU3yQtpQ9PfgGW0Bw84yM4x3aYEP2rpC1k55M//kChU8Hl/aGeydZtARhl+tZpbXGMReMaSlo5JdEvtV8sUUoo8F6a7Q9xctJQY0Jy65BFLxDRlpT9E4BOkrQnr2m7ml7+OZ82C6zUGE7B4RUOBCyaJWyxd/WObgzXo3TsvRlArln6t5jz1pT7VUQjsWM/V/AF5veiEP5FmyoiwMsXfpZMue620GADXgj0brh0mpVzSgA3Uputu3c1HsOncq0yRb5NoMt8S67xLlAI+8zC4TiAGRaPBI3S5yICktqkNBbXQhTuxGRsj/IYJ2uJqIOkerqkVBIa2c0QydpF8Gq4hTOpR96WV7JdtHvnJvbL0ighoYZEO6sCnduHTWGNQvLfBBl5dn/9FRvGV+zYsgvTvMr4hsWu1bsFvoq8VzkyS60ZWoDx0f2imBQlUCYxW0/CKekCcQ2ZJx7y4sUSCpALx3v5NYvcqIY9DBYVOqYk7uWXD3soYLFGMtSd32/9CFBKuJUT0VANbuKGjdfiyktJU8Sl/vPCEsPnSSn2EUf6jcH7oqVOy0w20bf3HDhllOSVntqwJh4oQlIHpjhjJGjcuoaouSM21lai7sV/MR6lkKgNJj4hDjIHqJFNk3ccR6hUeqPFbv2TWZYcvrGJEJX7Av0d2in1IzFaw70LKtaG6k1wlcyRU/mOfSemn9zv5gu2yAfLaNjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(8676002)(6506007)(26005)(66556008)(54906003)(8936002)(66476007)(66946007)(6916009)(186003)(86362001)(4326008)(508600001)(36916002)(5660300002)(2906002)(38350700002)(6486002)(52116002)(38100700002)(316002)(7416002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iNk+KMgvCGxjLs9GaYwg2LhKo4RA0ljmSUemjoqUuQ/k2GoU42/Lxsp6qMv6?=
 =?us-ascii?Q?lBDAyPPUGkXT8zM/NBBhMgF3ObD+UrqVv0sulCa4gb/aNXXw8ahMR1VSgGEy?=
 =?us-ascii?Q?VPEwCnesWbk/30yW9Yoyv6oRsNQK2Z24TaYJ8sNxhE5L7btgYlxYks8Hr6DB?=
 =?us-ascii?Q?7dZSNAaQixcRY+WMesGZwKhSMm159s3J4S00/DZun9thdaeyiXqrN5ccIr7j?=
 =?us-ascii?Q?WdB6fWsrRHWlQmGPwSKIS+YrDwo2nuuLOYitGJPNifKw87OWELDx73IxLLL4?=
 =?us-ascii?Q?8gacIdNqGdjEIkGFJ+6z6MEZsW6Z8n/jJCrxn3s6HksPkNF/fwOVT2IKEGlM?=
 =?us-ascii?Q?T/HNrav+SX9E+pLuHRMimbtRl1VTy2bBFs6keQW6a0yhjzQMLzMbCwq94z9k?=
 =?us-ascii?Q?fuJbGBoEn1EnWEMu/IalMTPfktFyOvgg2txEg6iGUprLoTkJkc42XSOWsWuc?=
 =?us-ascii?Q?VDicGmszuq/ey00sSlSYjHb9cevNwZEg+iZDxir7SsOKbmQWpAJ4xcxedWJJ?=
 =?us-ascii?Q?KcJdhlqISgbj+st6PyhkVZQ814Zx1/JjthxyjYTzqrxFoGGGLkvF6Lg6VGQd?=
 =?us-ascii?Q?kKkW/E/ALvevuidBuqQbVFD+wl5RHDsYj8mmVNyv9H9zMSwLF9hYexpz+35X?=
 =?us-ascii?Q?j//127aPSF33vUq7WgHJyNvY31Gn6la88OOFMNfxtibXPh+lmPYsS96KoWB2?=
 =?us-ascii?Q?8iltoAU7PaIK9mtkC3i7nR0KO5SKLERh1YmIpxxugf3IrsOocErd5QY/lo/h?=
 =?us-ascii?Q?0xxmPyiALrHVTGnAyJCbYddD3OjdEbJA6MwCrQKjKhhjoVsV1LAqgOmSvgWT?=
 =?us-ascii?Q?PrJbMWzKhxo9mv8kOu9C/NQffolvY4wd2qd6zgnTR293XPjCQwL+AwxyzEYm?=
 =?us-ascii?Q?eom+dozYOFDWg+3vyaMx3kF3UAQ7rEQL8TNO+e0E8WTj9C6dsI9JkcY2F2rP?=
 =?us-ascii?Q?hVG54VIHxUESo1SsDs/OVWIDxsllXnPWu6/HFrkMSwaymlchdDgJaEfWHalB?=
 =?us-ascii?Q?TNPujQSerrcQAQUZ3BOQQeUsntFPCV7oqn+URAxiURxzYCkndOFq0UMg8daB?=
 =?us-ascii?Q?wC5wc8ugmnLWW9VauzXMGZzOi9CYW2F0tGiJS8vbXYcb+KW2cblE/HyP99mC?=
 =?us-ascii?Q?DYPyG9X6I1MjY4zhlJdtmrQeeH22YnAHxkR1T7x2ci0rMc9lVK8D2igQ4Hcd?=
 =?us-ascii?Q?GTwP9iUUaJ+vhJ4pwi3K59CkYHif/ON5s78DuBn6q3ROBO9qvJKEu1j5wCqu?=
 =?us-ascii?Q?ZUnh55F35obXTs4HA28tvUKShvGTubo9WfmfIq+avFwgcKIMVtlg1/mtwD9o?=
 =?us-ascii?Q?p+qHoUFEwZJtcaiwNoFNMAMpzCRvXtCZxE2WFsuP5MaHOcZGGLGa4HhlMPpl?=
 =?us-ascii?Q?JatMMx3eDN1h361mIt1mcxCJDw/zMW/P0srhMJgyJ1CxzjPXt2U8wsxqfiEf?=
 =?us-ascii?Q?5AtrP2dZfCQ4ueosEKt3x7727wT/fYNMPEvX5BDQWUhQwH7xYWi0eaz4oWi9?=
 =?us-ascii?Q?vFxjJ3M1TRQk5Q/dtFJVm12SEHoVLrjNVEmw1mSI8ydyqFEnTZLkbG6Em0Rw?=
 =?us-ascii?Q?3zLsgb5obwsH5wrKPOzMytXx8wdnt1skPaGFzEk7D8iadPCmqLFZIapZNtzl?=
 =?us-ascii?Q?mrexfF6BGnDFMXj43yluFbizHcaG5dn/CXfG2Dh0Ghu7xWNjTcvlGsZaQdpL?=
 =?us-ascii?Q?n6JozA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01a719d-e146-441a-2591-08d9d00e0804
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 05:41:33.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vY/x9PA5LklA16ajszVzCY+1cXOFtcDp3FBpiirNLxrK6cin2h6b9HKzBJHMcjLmsHtnkC2VFOJ7FSWZLaaW8WbXg4NK2nyNO7UbIXGU7gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5596
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=890 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050038
X-Proofpoint-GUID: 0lUw-6uJcJl5YgnvR3zWaYMc5ua8u99x
X-Proofpoint-ORIG-GUID: 0lUw-6uJcJl5YgnvR3zWaYMc5ua8u99x
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


YueHaibing,

> The unsigned variable sg_count is being assigned a return value
> from the call to scsi_dma_map() that can return -ENOMEM.
>
> Fixes: 743b237c3a7b ("scsi: storvsc: Add Isolation VM support for
> storvsc driver")

This should probably go through the Hyper-V tree - I presume that's
where the offending commit is sitting?

Otherwise I can take this after -rc1 is out.

-- 
Martin K. Petersen	Oracle Linux Engineering
