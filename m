Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19ED554A5E
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Jun 2022 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237361AbiFVM4q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Jun 2022 08:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiFVM4o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Jun 2022 08:56:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0243F192BB;
        Wed, 22 Jun 2022 05:56:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MCY8gv017786;
        Wed, 22 Jun 2022 12:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ziGtOo8HmwKB//tD3v8KOzmNdZqA/UWEBqEfpBo/3zM=;
 b=el5bmH6TulpirOtG8SmrwgdkT0PWlp5gV9cHvAAy78Dm/I8ktEG0p3nkxZgCbL9UcJ0L
 qCsuwQpTbCZ8E/0U/zN6sgeAOkPWvIt7cJfYQiuwd4vYZ0DiVHWBLl5gufDqSSlQDgEs
 KRPy7GzJESBBbyLDP+E3biaQrTlS6fhaAayWx36aKWP+SBZs4DYlX37jQ2taYiXHo2TO
 zDX7AgUAz8ViI5y/GrjKgLZ/sKT80aZYF/7na0MhC/NBE1YEJRwmMZiF76tnBARDXx6V
 9dBKOhpQO2PtJZDcCm6rwag/XfXO2DJHapQTYSyjYNWPkBCeBQ6ndN0oHv92VsAij5wh 6w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0gdh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 12:55:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MCklhp008549;
        Wed, 22 Jun 2022 12:55:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtg5vf4rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 12:55:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vqpq/4dpnZjGUtqTBQqLhFfS5uBzgabzoG25YldaO7BvqfYn6t6qwBBb3qBM4Tkij1DAJNX6mvnUgBfD76O9PoCIe8kML29A7w7Nq6+wJSMTVXCFmtlR+dcb8HqV2T9Td/eQwLZJJXfmMr6stcLyFTjih2o01uoogEX8Cl3ehDEnxtIRJjwPdrzo548PIgG/XX/ym28pUelRKOBJFoknvAZRKpeFmY6uR7dzUsDd3MQ95jEvQexJWywQ8uD9CpKFQY0qH/Eed6JOqH9YWHPvD7KzqR5hs28OxMxW/ZKpfOR0KA5Gi471yt01jbh3xQk3tw7d4dg4EGtH1tSnordjAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziGtOo8HmwKB//tD3v8KOzmNdZqA/UWEBqEfpBo/3zM=;
 b=OU9gfNMQfG492NFgKkEzSKgPL9885S+UE+18utadzneAp8nwZ26CzlO+hYT+5QdBOVOUnIpjcFcUMOZgrkVq2kxnP6wkIWBMca089E7/C+1EPB1i7k8lN2Z6PEkErFfp1g1XTpR1a+xRdT8kHRxl1Jx2gf8ePHFWKG4Y9ySRw6pxpQmJoNBgzOQAXRJ0cGRB3moRT/BFh8QjhWJkc2j1WYca21TnBFHKbX8IHV0vZDFxbF3OAg9pLPwSchDjm7t6rvXmiNEnhRHP2/554Vb3CVBg/0Tq36mXkqVNFH3VZ+6ECnAEs44ITeA8ig/rnuac5FuZbn0nmn7ha9zV+Xegxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziGtOo8HmwKB//tD3v8KOzmNdZqA/UWEBqEfpBo/3zM=;
 b=ILexMdkmzqVMrE/nOdO8uUHPxtO00/6E8+O3Rim5jKBCkV1X6h5X4ktZnGBSX91hst5ZQylAOQq2mxY2mWke42blbbc8mxefjDxk0N+SMNYcstIw/mWZgydvskP9k+8tNITf97hJKl7dpvQwKetLN8gKHlun5fPZkvFu6Pc9Yk4=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by MWHPR10MB1904.namprd10.prod.outlook.com (2603:10b6:300:10a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 12:55:50 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 12:55:50 +0000
Subject: Re: [RFC PATCH V4 1/1] swiotlb: Split up single swiotlb lock
To:     Christoph Hellwig <hch@infradead.org>,
        Tianyu Lan <ltykernel@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        kys@microsoft.com, wei.liu@kernel.org,
        Andi Kleen <ak@linux.intel.com>, corbet@lwn.net,
        damien.lemoal@opensource.wdc.com, michael.h.kelley@microsoft.com,
        andi.kleen@intel.com, bp@suse.de, parri.andrea@gmail.com,
        thomas.lendacky@amd.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
        paulmck@kernel.org, kirill.shutemov@intel.com,
        songmuchun@bytedance.com, tglx@linutronix.de,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        vkuznets@redhat.com, robin.murphy@arm.com
References: <20220617144741.921308-1-ltykernel@gmail.com>
 <YrL02y/fYxDkDRlA@infradead.org>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <09751b9b-0912-d2f2-5636-cde6db6afaa3@oracle.com>
Date:   Wed, 22 Jun 2022 05:55:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YrL02y/fYxDkDRlA@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:806:22::6) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fee81c1f-3733-49dd-3e48-08da544e8873
X-MS-TrafficTypeDiagnostic: MWHPR10MB1904:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1904C7C43DA50BFF558BDF37F0B29@MWHPR10MB1904.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ZRF/ITst22dPLspCGUIIuP8LpxHznTuRj6JDahl/1txd+PAApH7Qqm37lBsKvtw4KdBe3KRv7+SXCSEs0uchOI69xl8C6IIBoPkc0ZCjSdA2feKzc73857+MerPl0BuFzVHAPJ8T8Lcd+IHudhANWn2//1eZjymBQxMF6She4Hw0i/bdMu25zU4pLKSOiekV/rmaXwyzdnBeA552L+nFV5WVRhjzNT7ig1hrCoSLY68EeeWLz/Pgrzk6Epdkhil5792Ccdc9f5oGFDizqb7KnpqnZl0EKJdIhhlV3anMnYHXft5EcUa6jfhGwRi1zxUkEHa2qGVnaCQ32SqC8ha8YN2vj8MhFsyoBy2jJnw9vflm1BAaNvRQ03x9ezwMyo3OcHrH3R+/Kb+r2jnlxDfx+G8TbMy002qzg2kmlYn51RxXhldDKW7iRBDovjcP8WiMCtb6Ui63L2syrEFHhmDKJsIAjhnR4p3vz6RIGfQdUgTJY5/u31Wa0WiXdlsQ+Izi0PQgwCVwaAwiW5QFZy6ChjBt7l5Nf16F3LG17wvRQLiy02KTAxtART7f4g4TpzcS0k5ycv8GIXf/1qpm9qHodStq36T3fswzsOETondq2iMTwuDi+AFZql8czYSPsCEhYSx7oS5ovrGQFNXVMRfaAY8A3R/wgOC24j61Ah2ywkMO+Gf4tmJV1wmkgoEmRlJKPdYbFFSLjG+Z/3BP8XtsXWXMpOMu8Jxx0LqcISqKmS7g15U29oooDOV/jN21wn1cBIcNFAgph+p9CLOe/UjzD8CxxwwS3JVmvFV81vPeNF4tjUWhr0riJqXGZCmCtSD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(136003)(376002)(366004)(6506007)(36756003)(53546011)(31686004)(44832011)(38100700002)(54906003)(316002)(110136005)(6666004)(86362001)(4326008)(6486002)(66946007)(2906002)(186003)(8936002)(7416002)(478600001)(2616005)(41300700001)(5660300002)(6512007)(83380400001)(8676002)(966005)(66556008)(31696002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmo4TEQ1ODM0empKcTc0MmJ4WDQ5aDNzOVk3bkdVeDkzU0VOMlZ0YUJ1bXp1?=
 =?utf-8?B?Y3RZYUdNLzJZaHdXK0RTWWlxL0lCaTFaTTRIOVMrdFFLR3JlZVlGOXNINXBl?=
 =?utf-8?B?M2d4UUlJWEdDUWplVEF6OHdJaFRIYi9KODZiZ2puSVo1YkpBL2lSdm56OUIz?=
 =?utf-8?B?ZDhBL3lIdHo4MEVqanJld09MSnFPaW9URFU4dTFYaE9MWTIxL1VPaUZZUTQ0?=
 =?utf-8?B?VEcvcWMxM0xhNThsU0FQUFloaWgvcytjRWUvMFVHUElTS3J6azVscUVLU1li?=
 =?utf-8?B?cHpQTDQwMzhTYVU2R2dDeGJsTzgxSENZaVg2bStQZTI3WGVncGlmRXpyaFBK?=
 =?utf-8?B?RTBJbFZvbFYwVEo5RFpMNXhXZk8reGFBNFdzUlUrTVJPUzlscGllVUlCVS8x?=
 =?utf-8?B?akRvZEpHcmkrejl2cDdWbHplYnR3WDBLOGVLQ0NxU1VuUmVVbk1Wc0txT215?=
 =?utf-8?B?bTgrRjhtSmhzS1RZUGRFRU8wZGRGYnE3TW82SmdvdW5CS0QvelF0YjJBQmM3?=
 =?utf-8?B?amFXdldlNXJwKzRvLytMUHBhSUdiZ1VGU2t5RnFqUm5MWitTTDBNeHpVb1JG?=
 =?utf-8?B?T21RTHlCQTAxU28yNUF1NFhKUiswN2F3ZmxRUWRZV0haaXJRRUV4TEtORDhE?=
 =?utf-8?B?OTBBTEdQaXpNYkVYT21mMWg0ZkV5NHJqNU8rYW9hTjJubDQ5OGVUK1g5MWhC?=
 =?utf-8?B?TWx1aTE4a0lBM2hhbnRkYmlkUm1nQmZQY2NXT3N6enI5NzJEVUtjMXduREF1?=
 =?utf-8?B?UXRjSG1FQzBYUmxRdXJnMmU1bGpFZzB2OWd0ZTN3RTYwYlJyNFdYOEhtVndC?=
 =?utf-8?B?cDVZa1lTWm5wSUk2QXl4cUJVSGNZNG9vWXB6dDhNcnhVcm0vdCttVER5Zjho?=
 =?utf-8?B?am5vdTVIM09UMWZIeW5WRXE1NHo0MndiUFU1RENqUVZ5S1EvUlJ1VjJUYUc0?=
 =?utf-8?B?c3F5a1NoNmIrMFI3R0hZbVpjN2hwS0h6bXp6clVCVWpSNkR0WkVRRVJGZnR3?=
 =?utf-8?B?NG56b2VuUUZrNnRPY2NFM1I4UWJMZWhMaW9zalZCQmZIV0dEREpVakI2TVNm?=
 =?utf-8?B?aSt4cXNYeXF4d3dibWtHRE9LQ0N3U2V5ejJRZDcwT014VWZzalYrMUs1Um9x?=
 =?utf-8?B?ZUJPVnAyYzBlTmpQWEc3ZzFpNnRuMElCdkwxMmR5RWNxUlR3QjBOL2E5WW80?=
 =?utf-8?B?bllERjg4dWg0VlVia2ZiU0lodWhNVnBrQ2JGcWppYzdnVmh4RlZzRXZnY1FU?=
 =?utf-8?B?WUZsNmZUdStYQ282RzhqQU04TTNRMzFjNDV0bWFsRUkvNTBhdDNrSU42M29n?=
 =?utf-8?B?bDVoREtzTmVJdkRXeW1nUkp4c1Q0V1JjWkRyR0RBamk5dTZSRTRrdlcxcWFQ?=
 =?utf-8?B?emNnWWdPOUJKVWlmZVVXeFVPSmpGL0ttVUplbWQ2amlTTE42RGNaOEt3WEJH?=
 =?utf-8?B?SEpyN21hcE90ckNJUzVYTFl6alJWYmdIQlRMN25sdGo3ZUt4djA0RHRlOWFL?=
 =?utf-8?B?MklMMUUzbVFkL25NZk9FcWI2S3dEMnV3T3BrSzVXdUFTdUx4aGpaTC9rTzRG?=
 =?utf-8?B?b281ZUtZSEQraldNUVIwUGwzMVlVSzFadDFJOGZHTmV0bGpkMEM0Y2lhZkdX?=
 =?utf-8?B?MXdydVZYdHhERHhJY1BlcGEvaDl0YmxNWXByaU9waXRjdk1GWC9EMkRhVVVG?=
 =?utf-8?B?K3I2YkJTSmFYaytVZ1dRSG1YMnBnUUI1Z1hXakRYRmdCT2hwNnVuV3FYNXd1?=
 =?utf-8?B?aHFiUU5XMnE4Z1FrZkp5c1ZnNXd5L2hNOHZEM0cxNjlidVM3c080MGVtWFdk?=
 =?utf-8?B?bXM3Z240NEdDYjB2MzdEOC8zcXJRLzFnUW1uek9RMmliWEZzL2Nyd2FVRU4z?=
 =?utf-8?B?cHRRWnBYcFliV0V0aGVNUWoxdDN1ci9VdTg4QldhM2F4QTIvQThGSktmQzlY?=
 =?utf-8?B?ekFrTldKWU13aEExSVk4bnZQSmE4ZzY1b2x1TDFNNWxaVWhWZ2h4L3NEQlBz?=
 =?utf-8?B?ZkhyNWVIVGZaakpQcVc3aGVIRDFwdU9uK2xvYnpSRWxXS1cySmw0d0c1bU5I?=
 =?utf-8?B?Z05SaEV5KzhpTDdacFFPdklZNjhkZzVLMk5CQTFzNnpiUEZFSHpIWHM5U2Qz?=
 =?utf-8?B?NWQySVhLa201RkM3ZTRvWW1vdWZ1enFudno2Q3c0QjhRUDlDbUN1STdzMllI?=
 =?utf-8?B?dm1kLzRkSENLWFI5OU9NK0hiZjE5WHRMaHNoMnNVeVdoUUtSQjczcWxPRnZy?=
 =?utf-8?B?QjJOTkREVnFJeWJ4YzF4ZW1uOGhjc0hsSmRaM0ViRVdpZDl1ZnVxSXdEakkx?=
 =?utf-8?B?cjdFcU9ob2lYeDJ4ZllHMk9JY3o0RlYrVmNwUGw2Vm5FZzBFbGN4dkU4bXB2?=
 =?utf-8?Q?qEYLwafDuW00nIBeH1CPoCJoUEEvetBcSD3h6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee81c1f-3733-49dd-3e48-08da544e8873
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 12:55:50.2282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Wba1HkEjHJoQlBA6txZye+DMjkmURtAXaw7pkjTNTOscloJK6B7QPWsr52cItbb3C6VZcwftjC5bdO1khrxKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1904
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_04:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220065
X-Proofpoint-ORIG-GUID: 5DPas44K3qQ-tXRRPgCUl4ZQ02hHVW7I
X-Proofpoint-GUID: 5DPas44K3qQ-tXRRPgCUl4ZQ02hHVW7I
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I will build the next RFC version of 64-bit swiotlb on top of this patch (or
next version of this patch), so that it will render a more finalized view of
32-bt/64-bit plus multiple area.

Thank you very much!

Dongli Zhang

On 6/22/22 3:54 AM, Christoph Hellwig wrote:
> Thanks,
> 
> this looks pretty good to me.  A few comments below:
> 
> On Fri, Jun 17, 2022 at 10:47:41AM -0400, Tianyu Lan wrote:
>> +/**
>> + * struct io_tlb_area - IO TLB memory area descriptor
>> + *
>> + * This is a single area with a single lock.
>> + *
>> + * @used:	The number of used IO TLB block.
>> + * @index:	The slot index to start searching in this area for next round.
>> + * @lock:	The lock to protect the above data structures in the map and
>> + *		unmap calls.
>> + */
>> +struct io_tlb_area {
>> +	unsigned long used;
>> +	unsigned int index;
>> +	spinlock_t lock;
>> +};
> 
> This can go into swiotlb.c.
> 
>> +void __init swiotlb_adjust_nareas(unsigned int nareas);
> 
> And this should be marked static.
> 
>> +#define DEFAULT_NUM_AREAS 1
> 
> I'd drop this define, the magic 1 and a > 1 comparism seems to
> convey how it is used much better as the checks aren't about default
> or not, but about larger than one.
> 
> I also think that we want some good way to size the default, e.g.
> by number of CPUs or memory size.
> 
>> +void __init swiotlb_adjust_nareas(unsigned int nareas)
>> +{
>> +	if (!is_power_of_2(nareas)) {
>> +		pr_err("swiotlb: Invalid areas parameter %d.\n", nareas);
>> +		return;
>> +	}
>> +
>> +	default_nareas = nareas;
>> +
>> +	pr_info("area num %d.\n", nareas);
>> +	/* Round up number of slabs to the next power of 2.
>> +	 * The last area is going be smaller than the rest if
>> +	 * default_nslabs is not power of two.
>> +	 */
> 
> Please follow the normal kernel comment style with a /* on its own line.
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://urldefense.com/v3/__https://lists.linuxfoundation.org/mailman/listinfo/iommu__;!!ACWV5N9M2RV99hQ!Jd_DYgd6_uOF8IPr8h1tratEG51zFXtwVpaPa_OW3AEJlWe8gOnmA_fGOdaFUfsVcj1sT5oYw2j4vacY$ 
> 
