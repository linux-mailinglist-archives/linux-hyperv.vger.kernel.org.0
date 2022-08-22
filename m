Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09DD59CC77
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Aug 2022 01:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbiHVXtQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Aug 2022 19:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiHVXtP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Aug 2022 19:49:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDF4AD74;
        Mon, 22 Aug 2022 16:49:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNkv17025024;
        Mon, 22 Aug 2022 23:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1zHrjBcFu2JKhG4FQwrHG5x6UYrqTM3Tf8r+diErRDk=;
 b=ZxsuUXT8zgjqiBMyWjyk1i4oYr2B/lZeB4L1KVK71ZaXd+a///Edm+3WkatYvL7XjcWi
 G/rFooLER1djiOkZ7MYW7TrolTOBTpYX9RrqnxnzpXPHqr8vBg60IdXA9hjQT1Y/DUS0
 GAouwnxB6TrKukL2pfZ5+kfI5vzVh7LqWEuMdPUHPS4QxXY7LRO2AozPIYemn3mnXvVe
 6XifqYIF7Nb4REOtUi2xQPYFSueKy+S/9PDYtul2YnK8d9X4DD953BXSIlhXeSIrX2+C
 zNYUnubKYiomzBhRgnMfA/c1kJFoZNr/hb+N6XF6rd9kE632YLIVnIUnwKjY6sEkiHQJ EQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8crr7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 23:48:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MLeJom035442;
        Mon, 22 Aug 2022 23:48:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq29dmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 23:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a66DwhMR1MUOVEYcw/F/ultwowHyphNKAtK0ovE9N6whaCvizku+De02a8cEbi/SGIoYqvUZKCa9g2uvyDdzpKE2LK8hwEMeB0Wnz+V+vjj25Pzc8+s7nMBnfFgbH0TVkw0oXQ2+ESQLdWUYDIOqlteaQv7t7TYyHJHcv53YqV64R2HqoFTKIBsChaGnvwy/4P3wrEZP7di5E2Di0HlnsztELBe1ABKfhHu6qGKNZ/eV/Cz1Cee/v6tgKOYzBaGkzAvLQO+rdqVgb3YpbxO82ViXh/UYI0bs2TWC7qtU/G9HGwL7Roqokqn85mYI63ZSTg0fiPFKj6ZY0lrlL7GGRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zHrjBcFu2JKhG4FQwrHG5x6UYrqTM3Tf8r+diErRDk=;
 b=khIFsUtEyYf+W7Rw+Mvup2pDBbpfiYEMIMADl9ycxZLUaDaTPrudG0hXseH2p7Xz2QRqx9KV/k9dpGm8JbdS9gcaTONnUSJnyHns50GRw2b5IluEYj94WSLRnzkFs8SNIXfohk+Kt9xOGGYEQYEBjD8VciImcKhGAmXTlScscotg0lJvabtvJx7mAa+Di2svS9bjR8NBDY/v5bpuu5uqtA3+4gtwocLCEpfFBFmGrI8HQuYQIrZ2h4RqFoVGgMNvZV+6HzscTerv005WBQtSdqZS00BU0wxStOVSAdufDksglJ/BfSNdGK+Q5Ba5kYyQphpqsIgGmjv/BvdFbMgm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zHrjBcFu2JKhG4FQwrHG5x6UYrqTM3Tf8r+diErRDk=;
 b=BmTu+q54U0Q4Kg7oSFF6bZ2Z4a8v2eff4/quHS4tbTKrz2NxKAh83gLVLb7zvXLA7rMFbNhPgsDuwq+SohBt+RK00rrAvLvUsB9WL0bmzPEbAzyWZY6Ynanq/KF4ZmfBIjlqUztlQz+knyqdDXaxrKNerhXtCD+rGDH9CilAXUY=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CH2PR10MB4215.namprd10.prod.outlook.com (2603:10b6:610:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 23:47:58 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 23:47:58 +0000
Subject: Re: [PATCH v1 4/4] swiotlb: panic if nslabs is too small
To:     Yu Zhao <yuzhao@google.com>, Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        alexander.sverdlin@nokia.com, andi.kleen@intel.com,
        Borislav Petkov <bp@alien8.de>, bp@suse.de,
        cminyard@mvista.com, Jonathan Corbet <corbet@lwn.net>,
        damien.lemoal@opensource.wdc.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        iommu@lists.linux-foundation.org, joe.jin@oracle.com,
        joe@perches.com, Kees Cook <keescook@chromium.org>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>, kys@microsoft.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, ltykernel@gmail.com,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        parri.andrea@gmail.com, "Paul E . McKenney" <paulmck@kernel.org>,
        pmladek@suse.com, Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, thomas.lendacky@amd.com,
        Tianyu.Lan@microsoft.com, tsbogend@alpha.franken.de,
        vkuznets@redhat.com, wei.liu@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>
References: <20220611082514.37112-5-dongli.zhang@oracle.com>
 <20220820012031.1285979-1-yuzhao@google.com>
 <f8c743d8-fcbe-4ef7-5f86-d63086552ffd@arm.com>
 <YwNn92WP3rP4ylZu@infradead.org>
 <d5016c1e-55d9-4224-278a-50377d4c6454@arm.com>
 <82d5b78d-e027-316a-87de-f76f4383d736@oracle.com>
 <CAOUHufYnFCqfZES1XF=nCbxTevGMVMqhNY-XOqR2xo_WWTwQbw@mail.gmail.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <cd967b5a-6ff9-e07f-ac02-5870ce8ed5a0@oracle.com>
Date:   Mon, 22 Aug 2022 16:47:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <CAOUHufYnFCqfZES1XF=nCbxTevGMVMqhNY-XOqR2xo_WWTwQbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 311e92dd-63f5-4641-4393-08da8498be15
X-MS-TrafficTypeDiagnostic: CH2PR10MB4215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3/IPsOVwcXQ2LGz0Zq/t++eBP0KI8/ZyhY+HcQDd5xGeLTxQubAaqiRouK2BmI9Z+gFwpXxd5y+XEsHmxMu3SbIMhhonolhw8m2ls1JOoUYGEpxEY0vHxg+RqyFWO6YgYhYl2DEQ0kypRyDxWsFulyRbVoH57qR3bxNTpWOaN1MveLyRhfz6QvwnJs0OxIZmGE0y+1zys0l8El3utw3c3KWVeOMDuEFSTdegR13P/A9+ko6P+Hh9gT6pc+Yfz0GqfkGVck+kPwHdq4JZ9n/ahp5XgbRP63/QWtmXhIJlsaj8WbgE8qnSGaUmxrXaBiGHPLIOnW/FSTsUSl8ibaXiu3B4+tP1iCGB7Q9zmV2/TNtulwssYFZ/r8FfC9r44Sz/qL/4bEUjmUgVGUzDnPo1qfEpW8s3eHKQKDGgBQaLUpvwquBhZyvcCxPaHnxH4OcGXWcjZFoZv7iofmDrTt7c33o0BW8gJtushO3msCpt1kA4AomQ3EuBKj2pp2SJQ8/W1973HlfEZpBuKuu8647dW/75N/ttpF5ZWUCONd1gW6iBbJjYDXRb6dPenS2ZHEqCqFxaS/6EzqVTI8CInpoYJZRfo7/Hpajtb4CdppURuBG2C962mEI0ZYVP564l62WDu7/kXLdbI5AyUTUqxi4WyTPvBXvsyoTk3oEWB0imA81J5nCTuJTmoUDpYRWPo0tbjpftw/6nR9dFaxo2/43cQ149zd8vuKSZHDdUNP8Af8CcvyPmkJg8FYhJm5AQ6zZz+ldZ/JGMGf0sQV1W/p8/vTnGsHYjGFfz/Lt/5Ab6lkVSufVAQMP9izBXI5jFDoMn8FBC9iqVdhDRe6VTuUosoiz8om9ImaVdiRB10jiIcfLNtjDvfAof6YTapvtlZQw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(41300700001)(6506007)(86362001)(31696002)(38100700002)(8936002)(5660300002)(6666004)(7416002)(44832011)(31686004)(7406005)(54906003)(6486002)(4326008)(66946007)(66556008)(8676002)(66476007)(110136005)(316002)(186003)(2616005)(36756003)(966005)(83380400001)(53546011)(6512007)(478600001)(2906002)(160913001)(15963001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHpwRzlYcFJKWXdBMXNBckhtOGVjMnFWaDhhaGFPZnFBaHNBVTJIS01lVEVX?=
 =?utf-8?B?c3ZhRER2YkVnOEhha1EydzRqSjVLb1pIMnNIRHNoU1F3YlhCa2loTkx5VzYy?=
 =?utf-8?B?QmFqcWFvUU93UmdtWEVZWC9lMzhKWFQ2TFZmZ3pVbUdENmU5eDFKZkNMaWhx?=
 =?utf-8?B?QkN5aHczR3dqMFNRaWZ1NWMxamkyTjdJeVBKTW1ZbXR5ZUl6anRRdjRhcmM4?=
 =?utf-8?B?NVJocmlXeWZiSmVGOCtjVHo2aUxTMmZFeTg3cGhreEN5dWc1V0hhZTBIN0hE?=
 =?utf-8?B?S1kwTWxwdzZmYzhSeUJnUWRPaTMrOHo5MU1vWE1MYzhKTzVRbDJzNGk1dGtt?=
 =?utf-8?B?eExuSkx0NHkwa3Y5TXM0ckVydWdXaDF4Sm0wRklJNFhlY25oUHd1aDFMM2Y1?=
 =?utf-8?B?U01URTBkeXd1Z3JBQ0gwdGtlNktzZFRpb1JkTFhQcnd5TnQrZ2FiNlJYRUpG?=
 =?utf-8?B?SUhoWlBIWUxhWm5xV3RVSEN6MHR0MllndXRPSU4vMXMyZHR4dWgwSW1kVUhV?=
 =?utf-8?B?ME1WQUEyMWQrTzVxbVFsWXEweEtRcjVMN2tCd3haUVhTUkVEK3MzOGpjTjAx?=
 =?utf-8?B?Q0IxWWpjSVFaWHlqT2tyanZBaEZSYUg5emZ0dzQ2Y2djT3RmSmJBbGdmdXhk?=
 =?utf-8?B?RVhGTW4xTUFMWXBTYWJDbWk5R1pETzhnV2VVQ3Jyd001N0dIWnJVd1VKTGNH?=
 =?utf-8?B?Q0JiSE4rVVFRR21RbWZ1djVXZ2ZzTVhUeXgyKzJVVEdBNWR0bzFMSVM2eGJC?=
 =?utf-8?B?SnRMT2dOTkhJNUpPc0pteGpHNFMrSWZiNnpSSW9YM2hCNXJSL1l2a3RUYWtz?=
 =?utf-8?B?QTJFL3NWUy9odnBKYUtsQVRVUXVFQnZxaGRiemorSm56cWZjWGlvS0JiTlZ3?=
 =?utf-8?B?SFpaNWxXUVFZemNnMWwxa0ZqbEtTbFArd3QvTDdNWTFBOGVoWEdvTmlrRjFr?=
 =?utf-8?B?S0s0czl5bXN5bEdPUEVLMVBQM0ZmOUxMNXU4TVJOMWJjTGplNVRkY1I4NHdP?=
 =?utf-8?B?b0RxdXZnZkNsMFVpUHBPdEdOUDZ3bVhjUDFpMFNwYUJJaWZOQVR4WE1WQm9k?=
 =?utf-8?B?Z1l4TVh5N0JwSVpmVXdwNHY3THk5dCtDWllmcG00VzArMWNVUjlRcWQ2N2Rs?=
 =?utf-8?B?eCtOQ2FxK2NQZlhqWGNJSWtad3c1TnNBY0l0ZVNpZFFkSVVYbXE4ZUtXS3Vi?=
 =?utf-8?B?eUVkR0w2c2RWbjhtMmFhY0dnRGZTNE03M01LelVkT0FFVUN2YnFucGlPT1FZ?=
 =?utf-8?B?akEzY3Fqb0o0MUdYOE9RZi9reEdHK1dIU3FySGdjd0wrSWlIYk14ZWdRaXpS?=
 =?utf-8?B?Y0dQeC9BaXhRajN0bHArZGFLakR5UXdQb2dsU2FIQk10djNRbjJFV2dTTHp6?=
 =?utf-8?B?YWpFQTVmL1pjZVovMDRxeUtMdXJlWTg4elNKMUluUENMRDM3M3htcFQrMmRr?=
 =?utf-8?B?ajFJYUhZTUx3Wk5QNEpHNEN3RmtrL3FZOC93bmd1dTdTNWpncXZBZEp5UUp1?=
 =?utf-8?B?SFQ5U1VCRFhPbFpabDhYek9yVSsrYWhsTEVJVENrNndqbzR2bmRJQjVURUVR?=
 =?utf-8?B?Vm1CZFBKNHI3SmhPclFDdTkvc21JYWczR2lQVmtaLzAzdS9ZN2RBSUFLaXJk?=
 =?utf-8?B?ckFrdnNkV2g4WmprK2UremtuY2ExRUE1RHI2ZW1BOTJJUlNxUmZvMXlnMUlz?=
 =?utf-8?B?YVBsUVRJRXJrUEQzbkcwaFVJNUtkSWZxMy9DVW4reDQ1OU1WQmFKcFpnNnpT?=
 =?utf-8?B?bXlRRWtPa3IxeFkxYVU3VzBnb2NvNCsxblpkbnNGYVNCdFBySU9XS1ZlbG1D?=
 =?utf-8?B?UE5qTDR6OER3UVpQS0txaUx1bVlwdk1STXJDOTBWaWVzRzNrazdVcGZhTGZD?=
 =?utf-8?B?NmZKU0tqeXN5K3B5TGxSMHJVVEJVNDZOaUlFQURUb3F0NHEySGVmdjZMSXNY?=
 =?utf-8?B?cWN4SERUR0hxOEJMNjdDVHJGSDhIb2JudG96aUdqQkE1VG02YUFobmR2dGp3?=
 =?utf-8?B?NS9kbjhVaHNrMSt0SHlEc0RtWitrSWhGQ2VWYng3UTFGZEpvNWlnenh6NFRG?=
 =?utf-8?B?cjB4d3ZBNTBlcjZXL1JiUU5RQU5TMkdlVE8wRlh6M1dlMFRRb1FKSStoV3pQ?=
 =?utf-8?B?NmVOL0lacXVOaC9tUWJLUzJpd09yRFpXbUdGZVAxWHgyN1c1c0FMWlVmTGRv?=
 =?utf-8?Q?heQt4N9d6MRTJMARrGMypDE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311e92dd-63f5-4641-4393-08da8498be15
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 23:47:58.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SiYWRH6/J9qPI1a0+0fdIR5vIoJtXFxo5p3ufqlK1SfSO/oZav8aRYP2pNw7ia2iB4gQ3f+droVRi1MuwPveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_14,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220097
X-Proofpoint-GUID: 8OyzZ3NbNis_BhgJIdtXdIruIzFoKCZR
X-Proofpoint-ORIG-GUID: 8OyzZ3NbNis_BhgJIdtXdIruIzFoKCZR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Yu,

On 8/22/22 4:10 PM, Yu Zhao wrote:
> On Mon, Aug 22, 2022 at 4:28 PM Dongli Zhang <dongli.zhang@oracle.com> wrote:
>>
>> Hi Yu, Robin and Christoph,
>>
>> The mips kernel panic because the SWIOTLB buffer is adjusted to a very small
>> value (< 1MB, or < 512-slot), so that the swiotlb panic on purpose.
>>
>> software IO TLB: SWIOTLB bounce buffer size adjusted to 0MB
>> software IO TLB: area num 1.
>> Kernel panic - not syncing: swiotlb_init_remap: nslabs = 128 too small
>>
>>
>> From mips code, the 'swiotlbsize' is set to PAGE_SIZE initially. It is always
>> PAGE_SIZE unless it is used by CONFIG_PCI or CONFIG_USB_OHCI_HCD_PLATFORM.
>>
>> Finally, the swiotlb panic on purpose.
>>
>> 189 void __init plat_swiotlb_setup(void)
>> 190 {
>> ... ...
>> 211         swiotlbsize = PAGE_SIZE;
>> 212
>> 213 #ifdef CONFIG_PCI
>> 214         /*
>> 215          * For OCTEON_DMA_BAR_TYPE_SMALL, size the iotlb at 1/4 memory
>> 216          * size to a maximum of 64MB
>> 217          */
>> 218         if (OCTEON_IS_MODEL(OCTEON_CN31XX)
>> 219             || OCTEON_IS_MODEL(OCTEON_CN38XX_PASS2)) {
>> 220                 swiotlbsize = addr_size / 4;
>> 221                 if (swiotlbsize > 64 * (1<<20))
>> 222                         swiotlbsize = 64 * (1<<20);
>> 223         } else if (max_addr > 0xf0000000ul) {
>> 224                 /*
>> 225                  * Otherwise only allocate a big iotlb if there is
>> 226                  * memory past the BAR1 hole.
>> 227                  */
>> 228                 swiotlbsize = 64 * (1<<20);
>> 229         }
>> 230 #endif
>> 231 #ifdef CONFIG_USB_OHCI_HCD_PLATFORM
>> 232         /* OCTEON II ohci is only 32-bit. */
>> 233         if (OCTEON_IS_OCTEON2() && max_addr >= 0x100000000ul)
>> 234                 swiotlbsize = 64 * (1<<20);
>> 235 #endif
>> 236
>> 237         swiotlb_adjust_size(swiotlbsize);
>> 238         swiotlb_init(true, SWIOTLB_VERBOSE);
>> 239 }
>>
>>
>> Here are some thoughts. Would you mind suggesting which is the right way to go?
>>
>> 1. Will the PAGE_SIZE swiotlb be used by mips when it is only PAGE_SIZE? If it
>> is not used, why not disable swiotlb completely in the code?
>>
>> 2. The swiotlb panic on purpose when it is less then 1MB. Should we remove that
>> limitation?
>>
>> 3. ... or explicitly declare the limitation that: "swiotlb should be at least
>> 1MB, otherwise please do not use it"?
>>
>>
>> The reason I add the panic on purpose is for below case:
>>
>> The user's kernel is configured with very small swiotlb buffer. As a result, the
>> device driver may work abnormally.
> 
> Which driver? This sounds like that driver is broken, and we should
> fix that driver.

Any components that may use swiotlb. The driver is not broken.

The kernel is configured with very few swiotlb slots and obviously many drivers
will not be happy with it.

In the mips case, it is equivalent to swiotlb=2.

> 
>> As a result, the issue is reported to a
>> specific driver's developers, who spend some time to confirm it is swiotlb
>> issue.
> 
> Is this a fact or a hypothetical proposition?

I never encounter this in reality myself.

I always encounter the case that "swiotlb: No low mem" so that many drivers
cannot work well (because swiotlb is even not allocated). The OS hangs (and
reasons unknown to bug filer), e.g., the below:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1983625

> 
>> Suppose those developers are not familiar with IOMMU/swiotlb, it takes
>> times until the root cause is identified.
> 
> Sorry but you are making quite a few assumptions in a series claimed
> to be "swiotlb: some cleanup" -- I personally expect cleanup patches
> not to have any runtime side effects.

I regarded this as cleanup because swiotlb may panic on purpose in the same
function in a different case (if statement) when the remap function is not able
to map > 1MB memory.

This patch is to sync with that part: line 353-354.

 349         if (remap && remap(tlb, nslabs) < 0) {
 350                 memblock_free(tlb, PAGE_ALIGN(bytes));
 351
 352                 nslabs = ALIGN(nslabs >> 1, IO_TLB_SEGSIZE);
 353                 if (nslabs < IO_TLB_MIN_SLABS)
 354                         panic("%s: Failed to remap %zu bytes\n",
 355                               __func__, bytes);
 356                 goto retry;
 357         }

> 
>> If we panic earlier, the issue will be reported to IOMMU/swiotlb developer.
> 
> Ok, I think we should at least revert this patch, if not the entire series.
> 
>> This
>> is also to sync with the remap failure logic in swiotlb (used by xen).
> 
> We can have it back in after we have better understood how it
> interacts with different archs/drivers, or better yet when the needs
> arise, if they arise at all.

We have already understood everything related to swiotlb. It is good to me to
revert the patch.

The questions are:

1. Is there any case that the OS may use < 1MB swiotlb buffer? E.g., the mips
only needs PAGE_SIZE buffer for DMA?

According to git log, the arch/mips/cavium-octeon/dma-octeon.c uses "swiotlb=2"
(e.g., 4KB PAGE_SIZE) dating back to 2010.

2. Should we panic pro-actively if the swiotlb user is allocating < 1MB buffer
and no one may use < 1MB buffer.

It is good to me to revert the patch. I will leave the decision to Christoph
whether to revert this patch.

Thank you very much!

Dongli Zhang
