Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838074F86D
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Jul 2023 21:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjGKTfG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 11 Jul 2023 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGKTfF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 11 Jul 2023 15:35:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2E10C2;
        Tue, 11 Jul 2023 12:35:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIDBb3010943;
        Tue, 11 Jul 2023 19:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=E0HiOdtxqR8lX9Gr8ywk4PndmMilgpy3rTX7xAWtCys=;
 b=N+DyDp2sZF3HzY5kAHHTBTCiWU+Mqo0rJwblbPrPayUF48+YUaLqlGWOEaLd+dM6niyH
 curjA8GYpc+j+RxxLexOdleDHd0qGpL8wm/73ZkruAonPdjD3TMpn+eSpuk0O7gFVQju
 7nciJoUE/Veyxk45SdfruXsv2xxfL7IiKj1ZppikmCfk8nne714IaCFIEmwtzxf4ebPy
 3FE75NnNg5rBaC4ai2pNK3CWNrUnq5kRvdoXh9mdfZxrCpKfi/03OobukBGz2pM9YAAx
 uLgljpJXjqVzbUL9nrCObJqs+nq+8rau9HaZy7a3meKC20D3+HU5oAYzoomZAKnJ7DSs EA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrfj63mdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 19:34:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BIAAc5033227;
        Tue, 11 Jul 2023 19:34:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx85uy5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 19:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxq23FPVrxi/PY3mC+jTCXjCG3NAtNntZO28NC28GVes4cs7L3iQrwTJSpnfjHVdXmEGulqGP5nOmwkcWTnKRnI0lYd1j/jGs7qjtX4ci91bKL5+NNWpIGW3z0HDJXQ6bDx/p/Fd+ULrgFiu/Cn4rNsmfgD7BJAhoWfD2TDOCdsw8krT99PngJldHorehsOJCvSkagftOVsKKsA8Dyk4/dFiuNK6i7MsWnRL6XCPBBlt9EMcnZNWeHhKKAdqdKG0fb/55KrgWbMfm/hn3aiOp0j7cdOfFZVLtccMw/8FaEhAzFA5ka3XP3y0U0eDCHd866RQGpgsw0P8FyItTk3n1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0HiOdtxqR8lX9Gr8ywk4PndmMilgpy3rTX7xAWtCys=;
 b=YafYNJWoT/inO9GJWU05LyDfk5fOmorsPa7ibZkj0qhlg0e4x5UDcs/RrQvpJZOtDEWGlbl7Yn4toc2+AFVpIhEVqjw+zoJO8Gk9hp8jO8fW/9uov/+aj2ch3liCaFhNRYlWzu/xXeuTowDwzbkJ17hr/ctq5nzlpGlEAHFdKJ140M9M+RT23ppDpc10yY5ZTTrn0/trzUU2CBj+m21pnup9QZd7lfgfBG5ZONFuG5ahIniDoVqhT03lF0PJaeWO0IzEzkZXPmlfZGM6TRSG0NBIr4oKlhSETLarLXvB4/e2+CHqqRb7CDNGeyxoP9ov5JQuJSkpo/9Iv7dmQd+l7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0HiOdtxqR8lX9Gr8ywk4PndmMilgpy3rTX7xAWtCys=;
 b=lTIYBhX1iSC6Rj8ximIAj1n2cXKnLSOD9t1+E/8ZFbx1B82DTRR3lYmOee6sbvVLS60nyBED4wdud0Lnq6uTYtNQvLQPt1LKTSvJ0LlhFQlL+BE4q+blIDtR3qRBzEcXPnwEp92O4MTC0AxVnh/vzUFsSswq61Nf5txkcPAatzE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 19:34:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::101f:466f:718:4375]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::101f:466f:718:4375%6]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 19:34:55 +0000
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Handle SRB status value 0x30
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1jmdyyd.fsf@ca-mkp.ca.oracle.com>
References: <1688788886-94279-1-git-send-email-mikelley@microsoft.com>
Date:   Tue, 11 Jul 2023 15:34:53 -0400
In-Reply-To: <1688788886-94279-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Fri, 7 Jul 2023 21:01:26 -0700")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:5:40::40) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7fdf77-7696-4955-fefc-08db8245e793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4EaYjQZXwToW69ic52fkCABRK7lxp8rswrXYMVcD5LwPO4kgQ/T2J6voRww6ITmCWydeEY1/Em1RoLPTm5e0z78+X6M9qoj2YuuAWORAeZlx/g33DjfpBe1tj3MJpD2R0TQYqsQONr9QcXzp5kIpdG85/u73aLVoXeNmfP4/IbygCknbwqbrhbSyEaciB+9wM3c83nejdXXmxmt3t2drpRW9Dss6i83zJ6DnrwrW/VfvNIBB+04ogCb+6rv77Z1CJmK2toNnz3sZzHnvMgFtrRgJJ85beciPeqsqd2uOquqj2aNYR6rZBm2og+ALTNCldVBzaFRKg4/jygoz68ZyGKll3dM/sDgUgFUQ3C9mYWcwJChZuj1Fe9gHft2WwrIujIxsCieSA/pHCEqVAe9+SmxEYsbhIppWPdWqLclI0+yHUl1MxccGLpFjPHadWvCkpfqA9XwmU6ggYhkJAXgZu2RLuVs70191NxI/XFI5VmOVlc7pUfYDPpSskKYgk7WLja9ykFX8SQ7uwByvbd56JPG2kcd/GPLg1gD+DRcPZsHY/ZA42ejezKUaKT5WrtC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(478600001)(83380400001)(6506007)(186003)(26005)(6512007)(36916002)(6486002)(2906002)(316002)(41300700001)(4744005)(38100700002)(66946007)(66556008)(66476007)(6916009)(4326008)(86362001)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iQFMOq1NC0eDw6mHkJXbG0t3YfsCTgoXukYM0/7s7ro4l9QKsUK+xF05ARXi?=
 =?us-ascii?Q?StqB91AKSAnEhV21GnEkUgzTvc8t8BxACkp9AehY7QXHHWsFmNxoO3gKhQel?=
 =?us-ascii?Q?QYNdtC7fTarwB5vZD1woXGrPXhmJxqoi7LZ+5oOMQW5zrP8BeGtmphwrU90L?=
 =?us-ascii?Q?1fclagPTEt9Tru4hkA/b6cGEoVT9CR/cmaUOBg3R3JectUbm9PBuJLgvV2Zs?=
 =?us-ascii?Q?qoE9ZHKVrn66GqecakWp/nDwjohtrsJPiFITLvHdtoIHv/15SLSk5PxmIqgo?=
 =?us-ascii?Q?dBsy98kL87Nmz8ZeFwBuda6BXseRqg++AcuohYe4nf6GFQsZqClDOeHahl9C?=
 =?us-ascii?Q?j+xByDRRJFdh2kks3YS4G9/qQb9VEmtBuNi/huQ7rMbc1Pv8ShlkRooUoMk3?=
 =?us-ascii?Q?jtcfFajttT4wE+BRAZOnNSFokm0Ppbd6fhsM+QAlCKTJhBab+LE/xK2T05Fg?=
 =?us-ascii?Q?EF+t1vKOnjElhIKg++l9n95LMpjiIKf0S3yXZtm29VqA60uiX+B0BrTdTiGH?=
 =?us-ascii?Q?0NQndKyC9s7hQ744bcdYGC0lT37JpBXpFNxSwuxwNQxp5CT/I95BIDxBvJN0?=
 =?us-ascii?Q?T36Re3cnmInT2MhxhDMrRKXe29rZ4+7r+ORo7sna9BQD7ufprzynNA75c6ye?=
 =?us-ascii?Q?35K13HiOXBtNrP0xe1MqgBzXkFoXohRYchviZEUAxie7dZ48sYlgcgm4VVBF?=
 =?us-ascii?Q?sQo/q958eKOTzWYAEeEN9uxyytONIF5/esSYyVz7ShxRBh3SuwXE3xOvcAHq?=
 =?us-ascii?Q?P27HR1xgzDPwDZlf0fjd0Djnr5lEzp6laQ+AbWJaXA+4483ORUP+MsbFvsph?=
 =?us-ascii?Q?UjYqdw8lwpQMbhWL9pmBIylhe1G65IyiZsPz4rMvdCLSV8klSC8L2QskjTAY?=
 =?us-ascii?Q?jhadjqhJlZPYM+wifJ3ebvcNKhQN/CyZqkxoBEIrpKsLaDBdw+1+F7LJAP0z?=
 =?us-ascii?Q?NrfL62FTuvpHjtRl7WrYrwRt53WGUDl0IqGR/jLvd8jzjZDUKDSiuZa4Qxwp?=
 =?us-ascii?Q?tthPZ0JAvqfVzUTPYH4x4AH8r898QfD9zXMt3QusHc5C/i5J8RuMjO0efLE5?=
 =?us-ascii?Q?SS52o3+mlNCcr1rxMP7PDSE5Gf319aJhzse7DezawBvQQIF3pJ82AIg9icHR?=
 =?us-ascii?Q?G+iRwym0GHtKa2rdprdfFtNy9u6VjPSyFJikOvEoPa5t25O9j4VkMHM42L3l?=
 =?us-ascii?Q?TwTjE/fmI9b55ocQNSA1atsCRPd72I4KAd8preveY9v1RGbcRWGhVUbi63JB?=
 =?us-ascii?Q?PUNmxl0MbbQPhV9XcaQIjvKrBYtB4yv+BDh7wxy7wHjSmiiq2Gx4JzjIm2hC?=
 =?us-ascii?Q?eXVcvTKyK8AYhB8MnPAFzZx4A6gs1APiRA4uLK8khSMLQNzgwlVoygQE94d4?=
 =?us-ascii?Q?eVxDUQiFm07lbFTPzpk8wYet6wTmOjpbc2oq7rk966633vGJ5Uy7ip++kM/S?=
 =?us-ascii?Q?JuPcVfZxiK08359gQNH62yRu6UVvQDehTxws8l2PfDrJjSoL54IUJjho9QFA?=
 =?us-ascii?Q?PJq0ZfBnxxHcmNjDGOWfaI8IEqVcX2nIWKQBNtGQa9jAfHqwKKbXuexggX4c?=
 =?us-ascii?Q?m9vPRwHaXCSmG9VqUNc9FXbyB3EFadc2qQhmzU2ex7swG5DJ46n4Bx/VmNrh?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T9dgxinDeRIO+0iDX/Vy0Bp4VcNdxPkJWJ3xidcYgd/BEvNi4d9OI7eqBHPw2SWPMwRDKCxjkCvglDmnPX9EqcieFoyJnk2jdDTgtgBWU2EAGGZ81oii36bXNaj/Fv1Z4epd99B2hnTXFULrpbitWS7Rnxnc8KuhUSJL8x/vwD6g3yN3gAdSJLMVAuHQHGZIeCxjGfvHLGxlwFZ70Wt9ij0LmTFOJisFcvlnS/vc4NJvtWc0L8C9H92JCZ/OEbdW07uwX/zusnBpBEXpWnLv5o/5kS1vDvU2yEkbv5npq8BocKwpAajTUag0d2JmFijzCzZsAfr5zyBmfjH/SnQeyAsqyYTphcmUDDr0DxW4jHrpVYNVYfu5s/mB0QsHM9z63t/q0smYq9vyChB7lrS1Xgnw2OBHff7ExOHVnHKsYqvBHlzIe2jAvCslmubVFkLP2PSnma25Hux7MbLCMp82IGdHY5eitBZ7sbLg4nut3v+Birmq+HMvIyWnHPRX1kXYMAA+1LPSzj2m+DTuJIvMiRfYaHxSE5DRQSsp2oxbzy/S/Rii7xgVl8yclrJe0twASAoIPoL05HxhNOGx5WdkMjRL3zy9HJev5I0DdqGcRrrmEKYjS/1JDewP1X7Pk/pi//0mNHh7+nX4DCEZ59fxNnMIcrQbMZNi9Vo8saiZOeYBQ/OY1UZ2bs3oOrHP+DNj9wICv7e2aYrrUn4PVs3j1clcDqcYizxlLXnIxUcoDd7txEKIHLH6ONLRb0AZGQKK0dVz1Ic1GswP2/RhuDAmVNEUttUTDZCxnuxK2wcBrsw6nmHKszpvjWnwrNR4muhZeZh8j89nCF2ihdc/EymNfc8x3tQd75tnC8lDOe7NZSs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7fdf77-7696-4955-fefc-08db8245e793
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 19:34:55.3872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6koJsoj+4/PWzPkFnrt4NC7OmAXGSIOc1YfLozrvLQPujMmrh4nKRq7YI3EFZIp992D6jFmIpAq61X+eMJF/wL+YRI3ikdqrWbzsQn/AsO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_12,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=506
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110177
X-Proofpoint-GUID: V1tcWzvtbkJzJAbvU6WTvvlIlznyy861
X-Proofpoint-ORIG-GUID: V1tcWzvtbkJzJAbvU6WTvvlIlznyy861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Michael,

> In response to a disk I/O request, Hyper-V has been observed to return
> SRB status value 0x30. This indicates the request was not processed by
> Hyper-V because low memory conditions on the host caused an internal
> error. The 0x30 status is not recognized by storvsc, so the I/O
> operation is not flagged as an error. The request is treated as if it
> completed normally but with zero data transferred, causing a flood of
> retries.

Applied to 6.5/scsi-fixes, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
