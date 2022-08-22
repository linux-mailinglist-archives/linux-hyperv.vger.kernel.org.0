Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D630759CB76
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Aug 2022 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237893AbiHVWaM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 18:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHVWaL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 18:30:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF850701;
        Mon, 22 Aug 2022 15:30:10 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MMEE4p014908;
        Mon, 22 Aug 2022 22:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=JVdQQ7bLVnzLFYaro7ZgwKDAmNipaqNmYsWcxPyJbCs=;
 b=tk6z9Etml16fj0nlwltedkXHxYWXc+66NPQLcf2t8AFS8u0dAwCjt/nilvi48uTmzvAP
 R/3yo1NgGnZ2E+sN7PixdC3SWmw/A82ZDcED6hD8dhNbTH+FkiWA/u8AnrGRybB/XGnZ
 24FK7Sb8biNVmb6lpwBWyF6P5kxFBq3CjRfhC6F042NvlIaTR85iJs7NmUMT7P6/G4Bv
 5E3r4zl4swbT2mTFpmLAWjug1F713PdLSDEYP0sWWNuA+dilmnyr/AXNnBIZ3VIQ2zgM
 dnhpwHBxn74gcHQmNxVo9IvSK9MyhtXL9NGGtP+e8TP5AnwGgRMX5I69cmMnJ1+Vv3EV 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ewe8hrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 22:28:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MKwmcd037883;
        Mon, 22 Aug 2022 22:28:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkgg63u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 22:28:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7EDkDiBlKghMf5i5xP4P2QzvCU3snV+PcaXujdmgmKJ/6fQAb4OnqyRYeVqBTt5ZpkytALFCAi/9OwT+HI5B7HoDh3BxL868vISIZaXkorTLX4v8MQKXvZivYtW39nBAEmm1FuJCfWX3CNU9Cuew1sZ3lV2d8L7tHEaV830xKg3D5CO6NN+1KFJngUbzhQKWImq6TLjG25bBuneqkvCWwgIz2AJFj0ANMZhB5etFD7LkNNAcQurpJSovOjV/dWYs+2fotcRhGnKqfqAtFS+2MhUexgJMw50BgThKeu3dy8FnA3GjWrl/3LyokuJ4rnaFIWLcmDdTzOqZm4GUx3EoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVdQQ7bLVnzLFYaro7ZgwKDAmNipaqNmYsWcxPyJbCs=;
 b=Ii2jNPHZyXnIX+3GZ6IcefFzhSQCskMMkWP1qwTvgfvQpgC0NGyRl/9fcb+EhYI+ZDa+NVqHvaitcJspHaiSxE/9BwcDyqGaCVjK4lqcnF1LxSzZCafFDrQR/klN/xHrXxtIoOZpSxfbcMdNqhWXsCLT3i7EoiDD6PH7oPagPn34QJ48c7+rrtMhCsFHvB0oQd+TfzXZ3kdh1oXc281kjjqMb2GDHAjbl+Kvp0XqmDv2XUEggy+IUZ3nuk1wsQe1BFqtQqFPbDjHyA0wrJ+liJMFu5if9aFI924Ly0Vb1eJ1i7yscFrZ8HtB7BDDNE0ygXGkdGL2zfv4aVpTKRwePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVdQQ7bLVnzLFYaro7ZgwKDAmNipaqNmYsWcxPyJbCs=;
 b=fW/H9uMAjmKzuXdF04J7PZClwL41Sg1vuE0HiV5epzJoYVD4WSxWAnO9hJReZv+ndES/oZZQBLD9bVhGfPnH5TGzR4gmz1FeM+i33KDzkB/RpdhYoVhgQ+XKlLOPfLwdrI1QQYe+/NH6J6S/lSDw2PR3jkSozVjIPBvZmeDEdEo=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BN0PR10MB4822.namprd10.prod.outlook.com (2603:10b6:408:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 22:27:58 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 22:27:57 +0000
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yu Zhao <yuzhao@google.com>
Cc:     ak@linux.intel.com, akpm@linux-foundation.org,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com, bp@alien8.de,
        bp@suse.de, cminyard@mvista.com, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, dave.hansen@linux.intel.com,
        iommu@lists.linux-foundation.org, joe.jin@oracle.com,
        joe@perches.com, keescook@chromium.org, kirill.shutemov@intel.com,
        kys@microsoft.com, linux-doc@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, ltykernel@gmail.com,
        michael.h.kelley@microsoft.com, mingo@redhat.com,
        m.szyprowski@samsung.com, parri.andrea@gmail.com,
        paulmck@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org, x86@kernel.org
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
 <20220820012031.1285979-1-yuzhao@google.com>
 <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
 <YwNn92WP3rP4ylZu@infradead.org>
 <d5016c1e-55d9-4224-278a-50377d4c6454@arm.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <82d5b78d-e027-316a-87de-f76f4383d736@oracle.com>
Date:   Mon, 22 Aug 2022 15:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <d5016c1e-55d9-4224-278a-50377d4c6454@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:5:3b3::29) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2d83002-0db5-4032-3150-08da848d907a
X-MS-TrafficTypeDiagnostic: BN0PR10MB4822:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AgJ7rn4IPJ0Ab1Em/O168OHHqJvkYDHALrBSccwpiUetqUGKF+doanHnQraezHYn4xVJnCc4H2ujUQpLVRSpfojfGG0I3s3pfT+kuw7qXnoBN/375yw4bTwFFkvHHiSHbScSaeRR5Q9lVSC9CsblHQ8pUoeVeeIjA209bP4Tn0P3D9lj5fCi2AodHPVCP1Y6CtXZou8qW7eMgisbvsEeUrU+V+kRAu/DBYMehaeBk/gCnjgEWLp8qI5VVTZpYex/44hYU6c1WivY6w/pGEHggmeSmuduEnTCXIUYivdUvydrLXX1LHMGtjC6jukltqSK7hRk+Tpo9VID3SrJvldxLgqB7JNBJz4tGbYk1+wLJqviuLMP3y+b1kyjQypc82WaZHzb0MjoieeielxRrOETvWqzRNi+m+hkVoF+jcR4f2603V7SP2SqCa4o9IzbscYSiLeNFfZ7jez0dEkc73EZ5dO56BCJqaSNs+mBFxd4pn5+RLyqVhK0//aijVuJYflRjseLRf23EReIWAFzQttaulsgtatK+aveYSbOP0NJf7Br+kB5agwKIunGWxXHjABq/jSkUGJIOHOZWnveA2GJmFX3J/UdcVMEoMLRWcfjgXLOkCcEw6ijCBdy37MlpI6/Zu6moDiHMp6OQmsQs+fy2t3JzuC0t6AJNZvsAqizEpyplF8FPTiM6ybHNuhxtuCD0TrXh0wo/1FmPaWSs7ilYeKu9Afp+Av1pwwTsFlyw/cGGTPUGc2tBHS9MUvTdFQuwiQnGXW/tsJCKxg1s6bzuRJIJeFTNY84a0NaDXcmjjcWnaz45tYgAr/z2b4qE2YnpvbSPTdIv5SjrkwP6DJX+qwxlSwDdJx//xHTmRm23Cs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(366004)(376002)(39860400002)(5660300002)(53546011)(2906002)(86362001)(6506007)(31696002)(6512007)(6666004)(6486002)(44832011)(478600001)(7406005)(8936002)(7416002)(186003)(41300700001)(83380400001)(38100700002)(2616005)(66476007)(316002)(4326008)(66556008)(66946007)(8676002)(36756003)(110136005)(31686004)(160913001)(15963001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em83bENJNHphSDM5UE5SNjFNQk9zUmQ3VGUydSthZjYxTE1Nb1ErRkk1WUJT?=
 =?utf-8?B?ZDNMd1ZmMlRiemljRlZXTUN0b3JmY3JXSitxSFhlQW5tald1bnRyU2ZBSDFS?=
 =?utf-8?B?S2IxeG5uUW9CNHNEbHZLZnFZRkRzcGRDSzZJMks0QjhJQjZnVlBlN2kzZEdy?=
 =?utf-8?B?RWE5ZGtRTjNtZGlNRDlwSXB6WjZ4RjZaL2ZoQ1ZrU0laVjhsNW5vVUFxSUgw?=
 =?utf-8?B?bEtyVldHUHo4UXJUSzRrd1FGb2tvN1k5My9FL2JHMmlROFFjS3JTb1UrMlZH?=
 =?utf-8?B?WFZqR0dYWW9TQTczZ3FoTUExNFlucVVzbEpocGE1T2Jtb2I3L1pxV2dSU2p0?=
 =?utf-8?B?NW5iZHY1S0MramFvM3RJOHY4ajlJSCtPWU9nNjNQOGFza3BiNUZQTGhzaXJM?=
 =?utf-8?B?VDA0Z1dWSVNqc21pSVcvUjAwL2VrVitsK3RkTGc4YktWVkRhQU1BeFU2SE5v?=
 =?utf-8?B?V2hoZG92bUtsdzJNSXd4aEFRdG1PR0hYazRUNFdhYjc3YWo4cGxLNFBzc1RV?=
 =?utf-8?B?Umkvbldlczc5c2U3Q1orVU84YmhDaHVUQktYMjNxRTJXWFkzZmdMRVVtSmpP?=
 =?utf-8?B?T2VEVmo3UkhtNHZBRlNURThmZmdBcW5FaXhOc2tXMVlKUHljTEZGV05JMHJl?=
 =?utf-8?B?VWx1TFJLVk9wc2JPdmlxWkFyZkF1MG56dlpBLzFQZnZvVitXeTU1MnJPTEtY?=
 =?utf-8?B?YnFBZDRHQzBoaGhvMDFxaUZJcGNMZXlkR2dHTGhpOG5MUmwzdE1KS0lJa1hk?=
 =?utf-8?B?bWQ1ekdqaFJ0VTkyOWZQMU5FTE5nQldhL3hhekJJSDBQMmhPeVJPa1E0KzNR?=
 =?utf-8?B?MHBoS0xpZ3RvbExFK0dtRXZ0TWFVSkt3Y1FyblR2cTI0YlJnRW9aTnFFa1Ns?=
 =?utf-8?B?b0RWU2RTbHY0YzVNM0hZZ0haanJLQVJwYW9OQjRYZXNuUklITGNuSEdFaVV5?=
 =?utf-8?B?c0VrSWI4R0lheG55UDNTU3k1aTViQXFmUUxkL3hjM282a2JkTG1HRE1IaHBv?=
 =?utf-8?B?MzQzenVCTkJsblFjYjc5dHRndTArTnZoU1grTExMUlFhamVTQ3ZGS1VaQm90?=
 =?utf-8?B?NUdNTlB5S0t1S20yc2xKZ200Q2xBZnJJay9mOUpqdzlUOTdtWkhnTG5OUjZR?=
 =?utf-8?B?YzIyb3d0WDlDQ1ZLeTFLZFVud2huT0NnT00xeFpHZ01NUjkzWldrNGxRa0I2?=
 =?utf-8?B?VHRzZjJ1OXl4bDFHSzhpMW1XWVk4T01KU1ZZaS9Tcndkb1pUZ093WjlNcTU5?=
 =?utf-8?B?ZlBxSnBHd0twNTl2UERwL3dsYjJWeTM2Qm9XaFo0QUt1QU4xdUszSmZGdXQy?=
 =?utf-8?B?VTdXbndZZ3l3cEtnTHRFa2g0RTUxa1B6TUI0UXN0b3dmOXZreWhja3UvTEh0?=
 =?utf-8?B?SmVXSE9IcHVCVkpQaU1VMDZWMWZQZU5vQ0Y5U3J0VUQ5Nk55ZDdKdjlrL284?=
 =?utf-8?B?bGMyb3pxZGFWNlN2VXRJY1F3bmlMNjhrRWlxWVhrc2dzb3RQWjJwd0g1RlBY?=
 =?utf-8?B?OURWUEVYZVJGdVlDSGJsZWlRdGl1WmE5K0RiMnNVeHp1U0VrQ21aZXFjcHc3?=
 =?utf-8?B?ZUFhVkNZR1dJR212Z1RrS0FOVXc2WUxPRTlhWnEyb2ZMWW9RMVg5RHJNdlRQ?=
 =?utf-8?B?SjhjZ1ZORU9WYitGVWJkUWs2eFRMNURtdnVRdmNUMkIyMDVhdFBRbjNiK0hJ?=
 =?utf-8?B?T2lFU1dWR0Z5SndVNE5XU3labjNKYlBsZkNhZDJTRXA1Lzc1Y2ZCSC9yVmpa?=
 =?utf-8?B?dFFQZnZGWUdXK3NWTXA2MG5UWHBtaFZmY2p1Wk9SNVlMR2ZhT2NrdUJucjA4?=
 =?utf-8?B?TUxsdVl6OW8zc1dRcW5FR2dEak1aaXJsVmhtZVFmb1hIUndDbU9uSk1TRkYw?=
 =?utf-8?B?c0tkRnhOWmNKcEwzakMrbHJ4WXVuWEwxQmpycTYzamxFU0EzSFZaU3Rrc21M?=
 =?utf-8?B?MHlnbUF6N0ROMmlzRHNXR0Y1V1phdkQ3c1piVEVpd0V6UkhsL3dKbEZWemFo?=
 =?utf-8?B?L3lRWVFuVjZwYjEvVWpUQnVoYXM4aCtpZVVDNXJqOEU5dG1yQS85eUZsOGFN?=
 =?utf-8?B?enlDR2xOU3Z6aklIWHBxalhIbkV6bmNVWmt5ZTBZWW9nNHBMYURBOXNEWEpj?=
 =?utf-8?B?L0tlYUozQ1B0S2FVS2JOMXFtQjVVZ2F2ZTVoOExOQkE3NnZtWjIrbzlmL0Fs?=
 =?utf-8?Q?32cyi4heAdkD5HJ/8haer70=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d83002-0db5-4032-3150-08da848d907a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 22:27:57.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPUL5oK5am5JPsPAm492RW0JdT6cLRQjrlTrS9SYTEuJGtpVdut1SEKhV1fvHMjS/7FwCtzQxOZ3WrHV+YBwdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_14,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220092
X-Proofpoint-ORIG-GUID: B1cui8Hg7tqS0iBlxKsKP-DKlUEbICDo
X-Proofpoint-GUID: B1cui8Hg7tqS0iBlxKsKP-DKlUEbICDo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Yu, Robin and Christoph,

The mips kernel panic because the SWIOTLB buffer is adjusted to a very small
value (< 1MB, or < 512-slot), so that the swiotlb panic on purpose.

software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
software IO TLB: area num 1.
Kernel panic - not syncing: swiotlb_init_remap: nslabs = 128 too small


From mips code, the 'swiotlbsize' is set to PAGE_SIZE initially. It is always
PAGE_SIZE unless it is used by CONFIG_PCI or CONFIG_USB_OHCI_HCD_PLATFORM.

Finally, the swiotlb panic on purpose.

189 void __init plat_swiotlb_setup(void)
190 {
... ...
211         swiotlbsize = PAGE_SIZE;
212
213 #ifdef CONFIG_PCI
214         /*
215          * For OCTEON_DMA_BAR_TYPE_SMALL, size the iotlb at 1/4 memory
216          * size to a maximum of 64MB
217          */
218         if (OCTEON_IS_MODEL(OCTEON_CN31XX)
219             || OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2)) {
220                 swiotlbsize = addr_size / 4;
221                 if (swiotlbsize > 64 * (1<<20))
222                         swiotlbsize = 64 * (1<<20);
223         } else if (max_addr > 0xf0000000ul) {
224                 /*
225                  * Otherwise only allocate a big iotlb if there is
226                  * memory past the BAR1 hole.
227                  */
228                 swiotlbsize = 64 * (1<<20);
229         }
230 #endif
231 #ifdef CONFIG_USB_OHCI_HCD_PLATFORM
232         /* OCTEON II ohci is only 32-bit. */
233         if (OCTEON_IS_OCTEON2() && max_addr >= 0x100000000ul)
234                 swiotlbsize = 64 * (1<<20);
235 #endif
236
237         swiotlb_adjust_size(swiotlbsize);
238         swiotlb_init(true, SWIOTLB_VERBOSE);
239 }


Here are some thoughts. Would you mind suggesting which is the right way to go?

1. Will the PAGE_SIZE swiotlb be used by mips when it is only PAGE_SIZE? If it
is not used, why not disable swiotlb completely in the code?

2. The swiotlb panic on purpose when it is less then 1MB. Should we remove that
limitation?

3. ... or explicitly declare the limitation that: "swiotlb should be at least
1MB, otherwise please do not use it"?


The reason I add the panic on purpose is for below case:

The user's kernel is configured with very small swiotlb buffer. As a result, the
device driver may work abnormally. As a result, the issue is reported to a
specific driver's developers, who spend some time to confirm it is swiotlb
issue. Suppose those developers are not familiar with IOMMU/swiotlb, it takes
times until the root cause is identified.

If we panic earlier, the issue will be reported to IOMMU/swiotlb developer. This
is also to sync with the remap failure logic in swiotlb (used by xen).


Thank you very much!

Dongli Zhang

On 8/22/22 5:32 AM, Robin Murphy wrote:
> On 2022-08-22 12:26, Christoph Hellwig wrote:
>> On Mon, Aug 22, 2022 at 10:49:09AM +0100, Robin Murphy wrote:
>>> Hmm, it's possible this might be quietly fixed by 20347fca71a3, but either
>>> way I'm not sure why we would need to panic *before* we've even tried to
>>> allocate anything, when we could simply return with no harm done? If we've
>>> ended up calculating (or being told) a buffer size which is too small to be
>>> usable, that should be no different to disabling SWIOTLB entirely.
>>
>> Hmm.  I think this might be a philosophical question, but I think
>> failing the boot with a clear error report for a configuration that is
>> supposed to work but can't is way better than just panicing later on.
> 
> Depends which context of "supposed to work" you mean there. The most logical
> reason to end up with a tiny SWIOTLB size is because you don't expect to need
> SWIOTLB, therefore if there's now a functional minimum size limit, failing
> gracefully such that the system keeps working as before is correct in that
> context. Even if we assume the expectation goes the other way, then it should be
> on SWIOTLB to adjust the initial allocation size to whatever minimum it now
> needs, which as I say it looks like 20347fca71a3 might do anyway. Creating new
> breakage by panicking instead of making a decision one way or the other was
> never the right answer.
> 
>>> Historically, passing "swiotlb=1" on the command line has been used to save
>>> memory when the user knows SWIOTLB isn't needed. That should definitely not
>>> be allowed to start panicking.
>>
>> I've never seen swiotlb=1 advertized as a way to disable swiotlb.
>> That's always been swiotlb=noforce, which cleanly disables it.
> 
> No, it's probably not been advertised as such, but it's what clearly fell out of
> the available options before "noforce" was added (which was considerably more
> recently than "always"), and the fact is that people *are* still using it even
> today (presumably copy-pasted through Android BSPs since before 4.10).
> 
> Thanks,
> Robin.
