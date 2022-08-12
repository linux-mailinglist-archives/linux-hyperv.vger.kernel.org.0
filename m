Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCEC590A42
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Aug 2022 04:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiHLC0H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 11 Aug 2022 22:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiHLC0F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 11 Aug 2022 22:26:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6C471BC9;
        Thu, 11 Aug 2022 19:26:04 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27BN6hZL023126;
        Fri, 12 Aug 2022 02:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=VIfyt/cdY/yYnyWt/McrrmML0h6wMz9JMvStT3BiJOY=;
 b=shHuplHi8FkXepUJonGNakfEKHCdZlu8FmIIt2xYFYY8kLHVl/gJY8Pqz7rMiEZ16BcQ
 Mjj4NvaHrQw4e3HWSdwpLthnPIqhz+esFJH3PKAfMXgpwJ0maefNNGV5+S8/G5pwJNLg
 UT8chXRAu0DKWHVek6owAyUrPCvxkCvXZ10UeMuopwpspo9D61VvebegJZC8+bxtGNxb
 snsYTcj65xVmmQJcFI12MabMXDPN7XEPfHOS8JFOUtuj06F2N+dxGWIb43tyHebglGr2
 HHj7Ny82hK955EN5D4kHxCjzMBDP0OM7akVCDH0TGuBjl9mZ0b0r20HaD2uJeUQF4xBI LA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj6849-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 02:25:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27C08Xu6035233;
        Fri, 12 Aug 2022 02:25:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3huwqkrav2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 02:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zi0QfAvgC/bi6ousSKJ7UtgmHNpGoHMBMFkzv5sNAVAvvD6u3uIuOo+75jjtSo/TV6nf/XTMLQbw0YTk40v0BkZ/sszYNZksmWTz7bgO/B8f/ziAtSsE8MIjmG3jc6ehQqkZExWLSTbrD+xDajywyV66zVDtej1K8PTzaY1Z7U2rwY+FD7GX4XuvtC7KbJDiDHe8lFqM6KQjxAA0wEMxw6/0r/2RZYpdlI6DpJKH5y1LeNzaMrQEo1QUB41Ch/+qfkWu79hlJJb72cl/cP3IUN3jYxRd/yzwAi0jnG5XN7mpH5c1Pak6vmeCG5zB7kZcL1jwCnvpm1moqUajlrcB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIfyt/cdY/yYnyWt/McrrmML0h6wMz9JMvStT3BiJOY=;
 b=dst7m/cr6ch4S8D3fImIAtiy+x96ShxWWy77hRmfK0Ng64oWKMuooV6eSf0Dkg9mlg4EhJDwQGbndHmjA04O+bFvNIOxwQwU1xJkROPS5SPzXDaWbrl+E8EB+ow+BTeuV4SVXZeWp1OXMvpgp35UWoSEYlR7ja7ANzBfnpJ+/9UoFAAIQ4DsIZy4qqL5Q5aSGFafBdjNgld28VIZCjWxefgyh+ZF023um/3oph6lvrp1bVT16eIW0UBw+VZE3CxVO2HAcMSl43ERJYUQxGPq8BcaTEcZWiHfsXfTf5mP3tmUzXLB9EuyeynX0ZmkDqgcWSjZOLJiy7wvyICCRrvbXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIfyt/cdY/yYnyWt/McrrmML0h6wMz9JMvStT3BiJOY=;
 b=Z8Xeqgz4Lp/vmoLNwlvNaYjmvAbBYncROoJLdsUVstQMw1askqtHSqOn/LY+gElAyM5LcNng+etIkprvJdJf9yMvLTpukHlpCC8i5UQ7/Fvd+/HTLkYi4fWpCbwkIFochMFAc9WAMx/5L0KHpr5KOhOZEYY626haaMvDeIvoxfA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BLAPR10MB5331.namprd10.prod.outlook.com (2603:10b6:208:334::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 02:25:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5525.010; Fri, 12 Aug 2022
 02:25:54 +0000
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ssengar@microsoft.com, mikelley@microsoft.com
Subject: Re: [PATCH v2] scsi: storvsc: Remove WQ_MEM_RECLAIM from
 storvsc_error_wq
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1lerukxjs.fsf@ca-mkp.ca.oracle.com>
References: <1659628534-17539-1-git-send-email-ssengar@linux.microsoft.com>
Date:   Thu, 11 Aug 2022 22:25:52 -0400
In-Reply-To: <1659628534-17539-1-git-send-email-ssengar@linux.microsoft.com>
        (Saurabh Sengar's message of "Thu, 4 Aug 2022 08:55:34 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:806:a7::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ff356a-7737-4304-26fa-08da7c09fb6b
X-MS-TrafficTypeDiagnostic: BLAPR10MB5331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGpQ4CWK6ahJLhCnUMEM/l2I8hgErBe/NuAi1fEmr+4mcoa4l4al8YI4i5Pme9fruB9SXEGHXkdFIhNZ09eSnkiqdCfUhUGLchuT7j5STjL8zQ4oyv8SBpws6AGqV43Vb5jwd836PwFSlBc/KcxoaruQjqa43SAugWnVEsPgJnHqReNdd6K0qtzQ/v1XukcchbGEWQxGiTdOOxXk2KOapdz+mLjAknsb2nOBnXEggmiKGBVsNUwZepl9A4K+PTF3qOJNm3Zdqwu6y44WzKJuYZsg/594kw8jPOrCbjnoSntOb+ib6kFP/bbxwZxZycGH/uNZhczY0fvlFq4D6P/u2jrYWENSojQ72I7ONPK+fATp6thxJ3sur95U/aqL5rUYvBiLIzvzCusRmvS7kAsDg/6q5tScEEfLiExo/XCj6vCEUBTHGrldISUHXTsRumczthocVeFGqVGLXV8UqGZyhKWTpMn/b8MshFg05OOZukJB2Z00opet/SJww4O7lhUoAx2ubs12ledgVRTqlMuQAWWcHtlZN2qNAUhCmkGlYfqnJP8Eivdv193i26Zz3AybsMEZc+ujv+5Y9z47ICMNc/x617Rt7KRmn0q/BpdIpLjZXQtIVT7TQZ4vgry18p2ANe7HR/AJRaGYW7AvFyECwerC4l7jxG1mlvs66o6aDW8lGxKeuXwEKSXuu1EvpFCDdVKO+C0qrdk1i0TUNR5v35ODnHYP/nl09Amf8DPgdoV6M9w4sCPWAI8G6ZrbWBNIqb/dXnbnHB6Qi8W3WtGI1snbXG+9ECPIhvyl7ZT51JA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(7416002)(5660300002)(4744005)(316002)(6916009)(66556008)(41300700001)(66476007)(4326008)(86362001)(6506007)(8936002)(36916002)(6512007)(52116002)(2906002)(66946007)(8676002)(26005)(83380400001)(186003)(38350700002)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v0X3HT9ithrdH2rEFPyvUqPw2XvPlEIuVjq3qiA3umO5DcJC3u0/Dqo4bLHC?=
 =?us-ascii?Q?J9eH0U7RD9Ql2iMndbiy62Jg2rveWKf2Bm+gnwMMQ7kdHMTLvJ4QU8uV0FSK?=
 =?us-ascii?Q?AyFQ1DAC5rSPIUOWQd0IJqYHPgTyb2lzbhUoAe0btprsCJjnpoA+9bSNQAyH?=
 =?us-ascii?Q?zzeMAPtDuGqnnEjpI+6xlC8Jgsmzr16rXkFMNBhLqE5zy2ZaxvYtoJLAQqpR?=
 =?us-ascii?Q?DlXGQNS8dIj4bobiIWASqBWEMuZIlmymIHlgDtp64Et1ZD/lI3JW4vOkoHbd?=
 =?us-ascii?Q?R1nJtS0xfNACWfD097WLO81ufHfDNF8O+BysZ5UMnvdIodqrjSab1a7A1Akg?=
 =?us-ascii?Q?ed+wDEQPXYOtOzzBNxOG+NUK5OCUHJA4jNo86+ng8LcdwScm1s1MZucovmkn?=
 =?us-ascii?Q?xL28NrOqQo9oSBhjtCHIY64q/GScI7J3oAqg5Eo41gasQzU0iR7X2He+Ms5Z?=
 =?us-ascii?Q?6yEcuL28Vtl1+zrYCI1GrFaqtcq6obaiXq8hbu6I0onn9sw9iS1n1Q6y2CkI?=
 =?us-ascii?Q?hrxQ8JznI8eT0Nm4wzeNH/to285a1FuD4zz+T3Jr1vaLa85hdvlEr/54Ii3v?=
 =?us-ascii?Q?fSEMXF+3LWzxcZfhP+m9NINaNiO/nO5okRB/VYsFPtLPgPVM+pMoJyhXTBAD?=
 =?us-ascii?Q?b7YEU+F9nFHOYlSu7Z4P5MIioOizIeWTkrWrEpORgnx44JvAZtVh3bNkpaD3?=
 =?us-ascii?Q?dnARCQPQGVuSfjZ9vGFUyvUYEwhpOKZ5YnFFS6yJvYUkyxboYbpHg0+g6XB2?=
 =?us-ascii?Q?5O4wqWRDAQcxOQPq23iny217mESdIbl643DteUSMrzinTcfFTIU8yrtOB9zD?=
 =?us-ascii?Q?Oz+fI8uS/q8zefnbuLSo09jDzOESJdvI7Jx+BEL3a+HgotnBexyZeGQBYX1o?=
 =?us-ascii?Q?Me3zmeS2lVy8nZUz2fYULrwkyMcAx2iBE/xEQuZNmFCpt6b0xo7YR6DiKbiz?=
 =?us-ascii?Q?68hrT/FDJWsJM5b8ZPYdOlTjRbunxD8dMTqnumsjeaHqjhuoUYph6wleffiS?=
 =?us-ascii?Q?tn2Yo4Jjlt/q1wD9eAiTWDpCiZ2SRjcIF1l8ORKnSHTdnpkx5k/vHaKrOaVR?=
 =?us-ascii?Q?TV/LcqvLoX60XMw+iSPhy6RHNDMPXuxV/Cce5S75QzxKrCU0U3xCE5nbQG3r?=
 =?us-ascii?Q?Hi98tWVBii4XdtoxectZmd3nIoKHnh+y9JokDs1G5Ma5puCTfsMw4yVH5drR?=
 =?us-ascii?Q?QdkFxJ93yysTaLJKC1oUmNudEyyjBiOpl0+v6tKyoHRNzMu/060SM3Pwztn8?=
 =?us-ascii?Q?AhJBykRU/43T9wN9kJAH3ORUCdblFFk0+79pI4jWFakiHxluEWBGifnHiPoU?=
 =?us-ascii?Q?ryZZrWexIjOAgIRjcl3/q5fiiV85Cih4eEcQlDRRIYzPBl26jj8nycjUZwX8?=
 =?us-ascii?Q?T2hQwRDMI0Ly+RGOaLEuIXQjSA/v/n1k3V/KbvnYTGn7LDFSYOsPf0Ohqv3F?=
 =?us-ascii?Q?1i6ok5ysZ6QRCUURthHCzgHoBsK0ckEJZIRikvqpB6NEVtfzS9hdnMbq4AJK?=
 =?us-ascii?Q?OwGL8L8cOUTQDQduEXH/ugnC1F7QP//ljim7XeTFX3ntDeKhnB7mSYsJQ/q+?=
 =?us-ascii?Q?CmHC3FKvu3TcLhjGXA/huwfPoToiNEDn1+L8MS4OeNrCZu/xfttRxSTWtkXF?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7BWlqQ5J0c3AMWO6eJ201jQffeX8+bfea17RZmbDxV1tS6VyU1ZVKnoQ+Ksa?=
 =?us-ascii?Q?8kpvBjBnu2wTfRtjAy0S2JI7sb5OaCcU2F4LeJpMRlPlsGjC/MZyFysJLTUC?=
 =?us-ascii?Q?nlE9XfYGakDkeybVFLnacRBEWgpazypYbsI6JBnvW8auKfCVNgrglqbqjBoS?=
 =?us-ascii?Q?abFp4DRmu3bf+Qq/kLpc7CQ+iKRU5cfq5y9+GM6NGslu7hX+H1qHoyhNmxJz?=
 =?us-ascii?Q?+j6hqKlo2sSsYp6C218npBMOu5L7Hird52b9FaLVNuvc5C4RnpV/ESuOuCaG?=
 =?us-ascii?Q?PVPBb57ufCTcfPb54PUecXZbn59iE5jKINyUZkr9Qug/d/zijPtPUOuG+zyy?=
 =?us-ascii?Q?hBVRL8d7B7E1JqIzcOPX3VcJ8vNRcb8Cd40plEccmtZaCsNtMHT9k4oFhYR/?=
 =?us-ascii?Q?uOSMyWW7PZK2quqxHbXIJJpQczYyOM4mq8DP3fvde3PD7zPGabV/IYsxXjUv?=
 =?us-ascii?Q?OrWPGfqGtKNhdNr73cRLgIThJ07AaOpakjN2paxgl5l/uu0QrDH77+RtPRIq?=
 =?us-ascii?Q?oDZsxy1KV/mJQ2p4xc/pMLFuNssvHwlxifpe1H380QYDnvhzwQyHHuXAGe+v?=
 =?us-ascii?Q?21eHsETEXcfrYOGcGx+dLuYbCYjEViWOVwrNgpQF1opOMLuZzifMbKblc2g8?=
 =?us-ascii?Q?6mHpYqR5H8MSW6lL1ULiE39ytvZh2djwr2rIom1Y5WDHObQDSxo3ysgYgvs0?=
 =?us-ascii?Q?kWe7hzQNbYfP2kgDxjHaD1csD32atxpkn1QrYf5qRgVeGeqTBRNNUOfKdHcM?=
 =?us-ascii?Q?ocNMYsuUrbdEnkjPRfe1G7MD7F0JRAFNSJzOcqnqgCl8OGuKddmfNGStvRRk?=
 =?us-ascii?Q?GL0Lv+K0jeMSW2qnyQ7uq+pE+V5yJpB/qwR9aIQXnMoAH8id2tk/gZ3KTE9D?=
 =?us-ascii?Q?mSayw0VUPWJ1zHyCucQ57CEugo1m1M7ajN4um65mZFioVhBPwSOzMYR5zwhp?=
 =?us-ascii?Q?rjk4AMFKpGBlKmEmGQOJXIqDhZAG7pSrzhL50FEv+FrN9CbEG2oq90gyKHS4?=
 =?us-ascii?Q?j7uU+ksFwUoEvWefFXmfp1F1JKR44WQ9Usi2huHff1XLa+lgcm9OFmXa9iOV?=
 =?us-ascii?Q?kUho7Rs4hlbiey0AbFaMyn2Nv4ypNBjnva49GcxUXG9ImOTlLPEGSKmA28TP?=
 =?us-ascii?Q?AtkX2UTb9e334bS6TvIc4BtpUKupVjkYVPlCX4V2QkdFv4tZSd3y11doB1Aj?=
 =?us-ascii?Q?I0Xl0v9xq0YT13KbrhArRblCc8KXZV4bUOe6E3WwTSMRHlYPeakyJIslxOqc?=
 =?us-ascii?Q?Ad8WCOm2urE4jo2+ctZjYG4JOVk3AYlxATNGpl7uexcd4E1lv5knjYjRtozx?=
 =?us-ascii?Q?sHobAZvNIGpYhEMqVfDa/Jy0cuaG7bLiYBqrI9/a2AbiYaW76PXbFl7Rm4vw?=
 =?us-ascii?Q?Ze0aGOYOXpMvhei/pykN9i6Ji9rL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ff356a-7737-4304-26fa-08da7c09fb6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 02:25:54.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF5To2rC5pZ1tox/XOMe3/wvsGyoaalHsHdliZpqY09S7SF4MonUBVFbRbo3WqZ2+ZGXM4a4/C9DsT7X6xQjbIxhSEG3/9hKuxktOFbbikU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_02,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120006
X-Proofpoint-ORIG-GUID: trOPErb-LagYgEAVjID2YO8Jtwn_OYAy
X-Proofpoint-GUID: trOPErb-LagYgEAVjID2YO8Jtwn_OYAy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Saurabh,

> storvsc_error_wq workqueue should not be marked as WQ_MEM_RECLAIM
> as it doesn't need to make forward progress under memory pressure.
> Marking this workqueue as WQ_MEM_RECLAIM may cause deadlock while
> flushing a non-WQ_MEM_RECLAIM workqueue.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
